Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46025C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF212150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF212150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732579AbeISWuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 18:50:00 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36887 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbeISWuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 18:50:00 -0400
Received: by mail-ed1-f68.google.com with SMTP id a20-v6so5539846edd.4;
        Wed, 19 Sep 2018 10:11:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8Vy5a0cQUVJt44ph453iMTVOz6thFqHgH9fTdR2Dcxg=;
        b=L0J8tUA32zRH/bqQe0D42KGwZ61BRrzIAfTlluD3U+ExyWW1CWbi9pdn22I+tyyE2X
         lAWNyiSurn2vnu6yT3Q10CTh6ZmHclNoczGKbTY/wsnhwIfOJXd9yJMqhhH+uJ98heBA
         OOq9P0d+7EiAd15K/sm7tpOKBSYua1TgNV10y2wG/2vb4Kw3BAtZxKUF7P2EoyPpC9Es
         HV2w0yQPH5LATGODINbCO8w0wGdoCzApivQxUHXR5mAlumKOahv6uyAc2hrJIIOd6vKg
         88QolYGVFRVKDrNHHSFnmKIP+XygFFE6dOSVzqX91vNQMt756hswlIm+P2NIC+dUGegY
         jyEA==
X-Gm-Message-State: APzg51CeStKeJj+7enoPtt5CXna0YaczwyfUxe/28I56pe4GXUjB7w1O
        SJ3DETJCGmQYJg/pM4QIZew=
X-Google-Smtp-Source: ANB0VdYW9M+gw9dk8pw5JYWYrcAPu/gkpxQpzd2TPEgQClLW9Xgq3E6R9f5I83N4wEdQwnTCXrdYeA==
X-Received: by 2002:a50:b37a:: with SMTP id r55-v6mr60420109edd.145.1537377068397;
        Wed, 19 Sep 2018 10:11:08 -0700 (PDT)
Received: from kozik-lap ([178.38.103.27])
        by smtp.googlemail.com with ESMTPSA id f7-v6sm4170817edd.6.2018.09.19.10.11.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 10:11:07 -0700 (PDT)
Date:   Wed, 19 Sep 2018 19:11:05 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Cedric Roux <sed@free.fr>
Cc:     kgene@kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: s3c24xx: fix usage of pr_info/pr_cont
Message-ID: <20180919171105.GA10129@kozik-lap>
References: <20180917204350.15192-1-sed@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180917204350.15192-1-sed@free.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 10:43:50PM +0200, Cedric Roux wrote:
> This commit fixes the wrong usage of pr_info introduced by the
> commit e728e4f20100 ("ARM: s3c24xx: formatting cleanup in
> mach-mini2440.c").
> 
> Since the idea is to print on a single line, pr_cont has to be used.
> 
> Signed-off-by: Cedric Roux <sed@free.fr>
> ---
>  arch/arm/mach-s3c24xx/mach-mini2440.c | 6 +++---

Thanks, applied.

Best regards,
Krzysztof

