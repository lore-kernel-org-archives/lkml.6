Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE56C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C89842087F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C89842087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbeIJWBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 18:01:24 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37554 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbeIJWBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 18:01:24 -0400
Received: by mail-ed1-f66.google.com with SMTP id a20-v6so17090707edd.4;
        Mon, 10 Sep 2018 10:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d4dzIVPAEJqZvQc2GF96Emo43DyBvUi1liGLk642tiA=;
        b=cLJN9z04Wjj5eBoF8EtYFVDIS4cI0ZTss+lH/bFnPnheMUkee699ZzSyLoD/hAGnYe
         MyTenblDhdmoYKpq6inFKHwoI5B7CWalmX/whGRY9r1WZgtMgH/rs+uQ1rTWe7sZS4Nk
         KTCrPgRx3kdASLDvzzMhs2zKLJybdsEwLV85lyWo2cdSB15Vjk4tMpLLmysEtK95rIda
         A9DyMSdcbRb0K0Scq/PLFWbqaQ79iyDp6JTRj9K9O6WB/btlurV3SeVo/QIFL/zqDWJp
         Qm1KaZJh8G+zhQde6HQ/2oXLrGk3gEXn5Kl/reCTY+gONodPdn5GCRfgo7Q3QFdYcgVP
         merQ==
X-Gm-Message-State: APzg51AYEOCMGz5Y/bgGXsqEpBcougFfDvU2976DWcoRRUPrZ2aRSYHT
        OkpOL9OyltCqhen9WmgnphU=
X-Google-Smtp-Source: ANB0VdaYthmhAKsN9tsYeZMFMvPn2nobJC7KtoCpRxT6+Szc+7ycW4Q9lvLaGfsvCYrxHJGaHsP1Iw==
X-Received: by 2002:a50:d1c7:: with SMTP id i7-v6mr24789009edg.169.1536599181285;
        Mon, 10 Sep 2018 10:06:21 -0700 (PDT)
Received: from kozik-lap (xdsl-188-155-58-14.adslplus.ch. [188.155.58.14])
        by smtp.googlemail.com with ESMTPSA id f19-v6sm8620886eda.49.2018.09.10.10.06.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 10:06:20 -0700 (PDT)
Date:   Mon, 10 Sep 2018 19:06:18 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Cedric Roux <sed@free.fr>
Cc:     kgene@kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] ARM: s3c24xx: formatting cleanup in
 mach-mini2440.c
Message-ID: <20180910170618.dfe6uxngz72vodr2@kozik-lap>
References: <20180907215446.15160-1-sed@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180907215446.15160-1-sed@free.fr>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 11:54:45PM +0200, Cedric Roux wrote:
> Running:
>     scripts/checkpatch.pl -f arch/arm/mach-s3c24xx/mach-mini2440.c
> revealed several errors and warnings.
> 
> They were all removed, except one which is an #if 0 around the declaration
> of a gpio pin. This needs some more investigation and I prefer to let it
> here. This is not some dead code.
> 
> 'printk' was replaced by 'pr_info'.
> 
> Signed-off-by: Cedric Roux <sed@free.fr>
> ---
>  arch/arm/mach-s3c24xx/mach-mini2440.c | 80 ++++++++++++++-------------

Thanks, applied.

Best regards,
Krzysztof

