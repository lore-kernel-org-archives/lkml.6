Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81CEC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973422098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="0cztzO9z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 973422098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbeJCWhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:37:48 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41938 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbeJCWhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 18:37:48 -0400
Received: by mail-lj1-f196.google.com with SMTP id u21-v6so5572697lja.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 08:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MqrEoL9P77W/yDNE/ZMmtbOcSF9/OKoyNNgpORsvIe4=;
        b=0cztzO9z0QfGYwx3yolFybXrSYzLAlg1F15gLf8BrnikDP8leUl+d9ziIHlAnDzD7f
         bTtl/88HjGbbar3YcyDplhw6qjnrzRAOUAzdiIHf9DdOgPpLLRicKT7Jt1FIs3eaoKiG
         0Ni066t/RiE87JMckGAYZ5/LQOPr5hjZDZTdPrGdxQ0xJir3UPANY/4UjmwjqG6JrYtL
         YsIzG807i/omm/LBVunqS7d0TsJJ6abm04WxdW2ScjRULYMa2tnlRpnxwgSyEZu4nVoj
         I7phr0MJk4N5hSFj/iPEyopB0QVhcWt+nncx3mYepR98X1YrOotn4rB15AoNLwE90br+
         tBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=MqrEoL9P77W/yDNE/ZMmtbOcSF9/OKoyNNgpORsvIe4=;
        b=bPoU60PByk5sCaNwXc6vhXJW3Uq7lFcOkuwfodWWhP0JCdNUPBuVU4YDuYUd7tMl82
         HGuK88Oe8wydN9+X9P36BQ29pg4b7mWSdjVj+HYI0y8G7kIGgLlIYO9vjm6DPIroER5s
         vgTwvvXN9UC78hOBDRXu0gNpWaxAbp89XcbCAIJ3mTPH1w0kMcOaTVpIuflxSDI08+aB
         rA7jIsOlLvw1liZUcsuLOmBbwy6O/Z1d09IKpgQhz3grw3GCp2uOcMnylCNBL3Bn3bBY
         hPPiLUePM2IjzQTYkTqOP4TcM4IwJ/Q24Q5tKx8csQHbBILJW78cJT41b1H7dL4RQ0/t
         TCHA==
X-Gm-Message-State: ABuFfogF8S0vU0/vATLgEKuFj/CCiCb5mXHhRDbqqO/+8RKj7WCQQ3cO
        1o35jzkbe0kmYxPFNBWL4sHejIpTEsQ=
X-Google-Smtp-Source: ACcGV63IBvkbkoEFkvP/ifAyQ+6VeFU1cAqUJvCBC+CXY1hxX+7dSUd9WzF/f81XjWJSBtnOi1k7YA==
X-Received: by 2002:a2e:884e:: with SMTP id z14-v6mr1519288ljj.98.1538581730674;
        Wed, 03 Oct 2018 08:48:50 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.83.173])
        by smtp.gmail.com with ESMTPSA id x19-v6sm388707lfg.61.2018.10.03.08.48.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 08:48:49 -0700 (PDT)
Subject: Re: [PATCH] mmc: renesas_sdhi: rename DTRAN_MODE_BUS_WID_TH to
 DTRAN_MODE_BUS_WIDTH
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1538566780-30794-1-git-send-email-yamada.masahiro@socionext.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <c45bd9f9-23da-4802-8918-fec5efebc6d6@cogentembedded.com>
Date:   Wed, 3 Oct 2018 18:48:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1538566780-30794-1-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2018 02:39 PM, Masahiro Yamada wrote:

> Socionext UniPhier SoCs use the almost the same internal DMAC.
> My datasheet says 'BUS_WIDTH' instead of 'BUS_WID_TH'.  I suspect
> this is a typo.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

   Already fixed, see:

https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git/commit/?h=devel&id=652c517c6828a830b71db4b1439a0229c98d9b9e

MBR, Sergei
