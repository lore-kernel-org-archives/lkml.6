Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E332C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 535AB2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 535AB2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbeIJWSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 18:18:06 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34953 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbeIJWSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 18:18:05 -0400
Received: by mail-ed1-f66.google.com with SMTP id y20-v6so17146606edq.2;
        Mon, 10 Sep 2018 10:22:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/S8eh6nbUdBmX22WpVCsOjA71p1izO3dP3PmAS42w04=;
        b=Ob0KSSBD+NlnzSoBBnOIn2Mnki0L4H+eMfq6M9HbluBaqFJS2evOdKE7hK+WHVHu4/
         uc61hShEsYCriajKsydOFrfayWyOanoH4oO4+e+4jmCmxyDbB/0koSR3+tpCp5xJMA3X
         wwFh/zQ62VjbiRAX5jNFe53Acrk/7CTJiIO5ipzmue9ASpgs1qYuK7YWJWi5huDEFi6o
         X1Jc5wEIzbnqJ5aNseoNdewSSWGhYh5iovr8S0VJ9JQVTZITPQ6oMe3CRTTsC/QUkXpL
         hPsNdrfzr6t6j/DLXN8B57IpG3h/pSblvLGgBp/OhYO+EPBLnY6hTnpvKVFnZ43dbJWN
         sQxg==
X-Gm-Message-State: APzg51D3NjE2Oh4aHAf+hiPCz4GbhfjGCJBiS0esoS6DCxre3guzncYu
        2tOUBPxeyL2h6aqjG9MZrVc=
X-Google-Smtp-Source: ANB0VdYXdK7YLPJsH6EBfuqAeDsBdgczPrkYFrAoWt2M/j6RzK1mETHsDMM0B2TbojrizvIybysOTQ==
X-Received: by 2002:a50:a0a6:: with SMTP id 35-v6mr24751850edo.280.1536600177900;
        Mon, 10 Sep 2018 10:22:57 -0700 (PDT)
Received: from kozik-lap (xdsl-188-155-58-14.adslplus.ch. [188.155.58.14])
        by smtp.googlemail.com with ESMTPSA id s6-v6sm9989578edm.38.2018.09.10.10.22.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 10:22:57 -0700 (PDT)
Date:   Mon, 10 Sep 2018 19:22:55 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Cedric Roux <sed@free.fr>
Cc:     kgene@kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] ARM: s3c24xx: Correct SD card write protect
 detection on Mini2440
Message-ID: <20180910172255.yeqe4d263vj7n6ge@kozik-lap>
References: <20180907215446.15160-1-sed@free.fr>
 <20180907215446.15160-2-sed@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180907215446.15160-2-sed@free.fr>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 11:54:46PM +0200, Cedric Roux wrote:
> The mini2440 computer uses "active high" to signal that the "write protect"
> of the inserted MMC is set. The current code uses the opposite, leading to
> a wrong detection of write protection. The solution is simply to use
> ".wprotect_invert = 1" in the description of the MMC.
> 
> Signed-off-by: Cedric Roux <sed@free.fr>
> ---
>  arch/arm/mach-s3c24xx/mach-mini2440.c | 9 +++++----

Thanks, applied.

Best regards,
Krzysztof

