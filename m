Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72DBECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 00:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6616E20671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 00:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOAkzOKv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6616E20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbeGSA5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 20:57:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46844 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729861AbeGSA5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 20:57:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id s11-v6so6268135wra.13;
        Wed, 18 Jul 2018 17:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8hLxVPXBuVfQzQIv334x51FBc/hl263UzHmn8fwN4RA=;
        b=FOAkzOKvM69JDSkTPrMRSahpW8LkwySPKMKlMj46ejFdQr37pIU15IJrkszAupl8/O
         imA1a36WJVkTB21fzOcZk8iap1Qs4f0rjx4/CyNFbvvEluM0ZiJiwYLVSyWxVhHtC++6
         OB5G47Rb9i/rs4TUsgKzMbQYEX0H8Wh6dmfPT3BuSGbCpOmA7jCvIIbk8xgpmsWaVZVh
         D40pJnUWDLtSs5sDkZyWAaEtGqH4bbti0aG6ZydYhNItiCiy0qu8IRvJVDA7pL+CX2+r
         vgp5N3nJvWD4TyfMKxDO9fPIc1Cq7NxFJQXiMXP174NrLNaEuiTklnOHmtg8y7fkPTB8
         17DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8hLxVPXBuVfQzQIv334x51FBc/hl263UzHmn8fwN4RA=;
        b=QFVORe7TXUZekRevPbAZR7DvjJgYmwDuahZb9hsSKigocMY8uVLEvPUVyOJaeDOluF
         YVStQ/y9tvnl2flitWPjmQ6JhQWVR4c+TlwXQAbEVX8CG0dqjS+77mFlKlVNCKw8PE6d
         JMxhBYw1cSOyF5eZFsmdlqjfjzsEiXpmHmuLDWOixGwZGku/G1jnJ5MPYDIP0A8fLQ7R
         ZDXRhnF3OQak/Q9bVMKS53mBEmwtXb9L/6MgMvHxIvMf1qSrWPCikeCKumTNfPNYwAxb
         bq4EgttSykWegfQKELAJ+BgPyIsvkNnW+1BEUjKodsHaCLVjXo2W/gEYuXQk9etBKrSL
         i+6g==
X-Gm-Message-State: AOUpUlGzKnn8b910n/buvWDSKguBXIjXVRgxfH+L5Pc4cdvIcYR0R9zu
        bsXSoaGoEPihRtXYitc9N+E=
X-Google-Smtp-Source: AAOMgpc906I0jyw6dq0ymb2LwXQ9roijaEMWtD13JmRG2xswk+ZkaqJvZKeJevBMnnaOOd9F7xzshw==
X-Received: by 2002:adf:c08c:: with SMTP id d12-v6mr5583392wrf.268.1531959403998;
        Wed, 18 Jul 2018 17:16:43 -0700 (PDT)
Received: from gandalf.schnuecks.de (p5B2E20D8.dip0.t-ipconnect.de. [91.46.32.216])
        by smtp.gmail.com with ESMTPSA id c7-v6sm4611147wma.26.2018.07.18.17.16.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 17:16:43 -0700 (PDT)
Received: by gandalf.schnuecks.de (Postfix, from userid 500)
        id B359B5C21C2; Thu, 19 Jul 2018 02:16:42 +0200 (CEST)
Date:   Thu, 19 Jul 2018 02:16:42 +0200
From:   Simon Baatz <gmbnomis@gmail.com>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     hdegoede@redhat.com, linux@armlinux.org.uk, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, robh+dt@kernel.org,
        tj@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        thierry.reding@gmail.com, icenowy@aosc.io
Subject: Re: [PATCH v3 0/9] ata: ahci_platform: support allwinner R40 AHCI
Message-ID: <20180719001642.GA29105@gandalf>
References: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Corentin,

On Fri, Jul 13, 2018 at 11:02:57AM +0000, Corentin Labbe wrote:
> Hello
> 
> This patchset add support for allwinner R40 AHCI controller.
> 
> This controller need two regulator and one reset which is unsupported
> for the moment on ahci_platform.
> 
> So this patchset add support for reset and regulator for AHCI
> controller.
> It add also support for non-target regulator per SATA port.
> 
> The whole patchset is tested on sun8i-r40-bananapi-m2-ultra and
> on sun7i-a20-cubieboard2 which doesnt have any of the ressources added
> by this serie, so no regression should come with it.

I tested on sun8i-v40-bananapi-m2-berry (with an adapted device
tree).  I got it to work, but only if the U-Boot has support for AHCI
already (from the Banana Pi M2 Ultra support).  With an U-Boot that
hasn't, the system hangs at boot (probably when probing ahci-sunxi). 

Did you test this case on the M2 Ultra board?  (I think SATA should
work the same on both boards, but there may be subtle differences)

Perhaps I did not apply all necessary patches. I took this series and
your minor fixes series for ahci_platform. 
