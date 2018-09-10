Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3675C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DAC720855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PQ89iIFZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DAC720855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbeIJSxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:53:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34941 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbeIJSxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:53:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id j26-v6so22092170wre.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 06:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WeyAlcUkM+yo1lLvXMzjyLZa6s4D8sAKl0KzWDYoOWQ=;
        b=PQ89iIFZ6/3KZM+I6XE2HukSomICvNndy3AMv8uQFtXQwKOOqtnpFebG0/eLS+MmF7
         LAuNZXsaCgPX9o0YtlWUqEZPdpbaNtcWouF3qa1s3Q7qizeL32yuzdVCscyZqigCneDZ
         qRtcn1Dlnj60adsXYgOSoCIY8cXf/C3xRPHE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WeyAlcUkM+yo1lLvXMzjyLZa6s4D8sAKl0KzWDYoOWQ=;
        b=I3/wlwWHjhI3IsyUyggbdNNSZBsUXmNq8o2tW2sz3mKQQh39/YL3hmzIwgfkEZurz8
         As6IBEsPC3u2Oi82RHlqbyT17T5EfRj5WciJwVVyAHNmlTJbK3wefDXsirAYXfBqvAWB
         OKlOCj5BCjcpqTN/KtWADBqSkgiaQOGVFpQmRFGF5s8CDC3R30ViiiKujw7PAFj+GiU9
         2YChTZwSSqv064ThEq5t+uxYWEDiCgJ3inoXv+Cuy4NtLELA4FnlN4s9TY6T+4kEw8le
         tPGN3q4Bsg7HDHm6PR44mLyRr+RnSmO2q+NQm23+vJcAYA2JuYaQIO+L5LB6amDeTfIv
         txPw==
X-Gm-Message-State: APzg51Bui/ltlmtxVGN/aeJeElCqyi1Ae2ODqKqoia3l3e5i79mFe7d5
        CWdJVAgGlsvBkuY0+9x7U9QYop8cC9g9MA==
X-Google-Smtp-Source: ANB0Vda6tjAKbDOVQQC1zuuRTwt3/U/WFpFYqnw4GCOOPtL8O7jG5nf2xFXHTs+K9NlGal/rQ70VZw==
X-Received: by 2002:adf:c98d:: with SMTP id f13-v6mr15575962wrh.148.1536587931713;
        Mon, 10 Sep 2018 06:58:51 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id f18-v6sm13755318wru.51.2018.09.10.06.58.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 06:58:50 -0700 (PDT)
Date:   Mon, 10 Sep 2018 14:58:49 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     michael.hennerich@analog.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] drivers: mfd: adp5520: Update MODULE AUTHOR email
 address
Message-ID: <20180910135849.GQ28860@dell>
References: <1534246319-1113-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1534246319-1113-1-git-send-email-michael.hennerich@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2018, michael.hennerich@analog.com wrote:

> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> no functional changes
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> ---
>  drivers/mfd/adp5520.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
