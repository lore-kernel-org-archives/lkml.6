Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942B8C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B9D52064D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VFm5rigX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B9D52064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbeLJRbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:31:16 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53746 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbeLJRbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:31:16 -0500
Received: by mail-wm1-f68.google.com with SMTP id y1so11769541wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 09:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VLGXbMLXFoz/PeOjsLaNCCdrhPWO4x+DiFmgKwzM058=;
        b=VFm5rigXvN3QPpqKHgw/nfdsz4FKzlME9/ua0rt/+kg/XlhoOGAoggeRWfDJa4GiiR
         /l3CcJQcQweWN1zLcrVkxG3i5k5ci8CBaN2GKtkPUNie3PQMyLUkcdtrfErgjrRFnAv4
         xW+cEnaFAUUB5yFfYFn7gqG3C7Na6+1+cXKws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VLGXbMLXFoz/PeOjsLaNCCdrhPWO4x+DiFmgKwzM058=;
        b=CKsYgbiEuaGr4IS64N2Bc/tZBm8bWalY+GYf+mJCM16YqaKBgUPCNEEuGxUXXXgzA+
         O0wBQ+iEEKarCexBRQ+L9Eju1L2pb42LCLEomCNm1i8rwv1meMPciHo/WMsQYW88XUsJ
         5zk46CHnzM2JQqt/jFHhiGhc5CHOoPDFZqbYgT/+8I+XWFhI+3Mw1H0U0CW0DefBVx5d
         gB/og+HDNjWn3GGB+wBAs4LZdYkUE5MGciDc11/8ZfBsDHcFb+dJXYp6LKT3qN21MtNi
         EPBJavDpKVgu+1d0WOzaaCZAx7Gw8dfPAHBDbqVkCoHwG8k8hNSu6/SdzVqE1KSxxXxa
         cmFQ==
X-Gm-Message-State: AA+aEWa1ZBakt7Y0Q20kghKwJ0Wlz80GO9+uvFuBiObH8EPKtlSF39YT
        /Q1VXEs6s+TqxHbSuZbFpIr0AQ==
X-Google-Smtp-Source: AFSGD/UVafmELIMKcDHu855jPQmLDGhws0NDWyvZ4I5XDc4UG3b8La94WzTRZDIS5OqpqZX0I0Voug==
X-Received: by 2002:a7b:c1d7:: with SMTP id a23mr10792177wmj.48.1544463073980;
        Mon, 10 Dec 2018 09:31:13 -0800 (PST)
Received: from dell (host109-155-202-221.range109-155.btcentralplus.com. [109.155.202.221])
        by smtp.gmail.com with ESMTPSA id w8sm11704230wrv.7.2018.12.10.09.31.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 09:31:13 -0800 (PST)
Date:   Mon, 10 Dec 2018 17:31:11 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: fix small typo
Message-ID: <20181210173111.GC4497@dell>
References: <20181101154153.23042-1-tiny.windzz@gmail.com>
 <CAEExFWuoVpKmaGKCUVcORXirBLKwA-z+sHuWVMY4Hc8ptpdPTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEExFWuoVpKmaGKCUVcORXirBLKwA-z+sHuWVMY4Hc8ptpdPTQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2018, Frank Lee wrote:

> ping.......

Please don't do that.

If you think your patch has been missed, then please send it again as
a [RESEND].  In this case you will need to fix the $SUBJECT line too.
To see what it should look like do the following:

  `git log --oneline -- drivers/mfd`

Once fixed, s/[PATCH]/[RESEND/ and resubmit it.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
