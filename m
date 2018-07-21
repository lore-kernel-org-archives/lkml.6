Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC32ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 22:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F1F420856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 22:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="OBKbCs6l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F1F420856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbeGUXTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 19:19:07 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33957 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbeGUXTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 19:19:06 -0400
Received: by mail-lj1-f195.google.com with SMTP id f8-v6so13902220ljk.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 15:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DnfkLAPnlu5Dl3dclAhYeXRqwCpFEyH6Vm+vuVvyDa4=;
        b=OBKbCs6l6zw/737UuUHd1v4DTamAj1Lz5i5VajpfNGkcV6iOcpxQbm7cNC4GuxLMJd
         UbEBSe798DwEcfZWLTf++ap2vytlUKdRHW6MIzM6/p1xLF0cVjgbSUqUudMQFyVP0xJN
         zEsforiyymhwoQ3DW3ttH5cpUFpSJ5lQamUXO2UxLAkAlOId0kc4IsqAagwbe4Okv2wb
         5WxDla1u5X7Gtj6Pd387NUSEsbdBJBe17wdkrcGeMKjTv6tkQAXAn06/DiDszubVu0z5
         lREEDqBOeyCDHNYjxIneCdeQDktB2KNx4DmMu90IoyT3T8jrBRNu2OMXKTnP/LMuYMll
         IiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DnfkLAPnlu5Dl3dclAhYeXRqwCpFEyH6Vm+vuVvyDa4=;
        b=tR6Rt2FkW+FWkUCELIqunC1uTVc0SbOUUohQ7vJaHSewvKTqieQh7M01R4E5VRXK1a
         ml2QkODubJ0tAFjQVqSiJLR2VRofshRmFFEAeKtylYx3Bha1u43imuUx9lSnUY8dBHps
         O/Jcn//NW98a6rZkc7+xHvKEXQFJd2sIRjLePQhDiiKbFXzF2wRXo9BtP203nJNPXItk
         tH4u2oBT6t+OoQX6lVauDZNkMmtxVDwUNWugtsRYwed3HVYdaKXHua1gNoYSfnShtmCw
         UFgkVnyHd6naqJXr3i6eG+YfnTGt+tXJF0h/vKBFLOM26dtw06rbuIZHwX5PP5wbcEBl
         Xh7Q==
X-Gm-Message-State: AOUpUlG1qLJPEg47PcjaeOxIaUx+01eY8AA4iwaaD7Qv+9ib4Q1kcv8V
        w+VBvFg1vaV54fRCslaamqVAlgCG5eYZJQ==
X-Google-Smtp-Source: AAOMgpesmpBoekCEzvw09ScKFXJy/OU2Rd4c54kRLwgSgyoc68zOxmV/AZnM7Et0Pw5x6IXZI0onsQ==
X-Received: by 2002:a2e:118f:: with SMTP id 15-v6mr4960549ljr.38.1532211886652;
        Sat, 21 Jul 2018 15:24:46 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id h40-v6sm805424lfi.84.2018.07.21.15.24.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 15:24:45 -0700 (PDT)
Date:   Sat, 21 Jul 2018 14:26:57 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     arm-soc <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL 2/3] arm64: dts: uniphier: UniPhier DT updates for
 v4.19
Message-ID: <20180721212657.74zgh3apktnu4vqi@localhost>
References: <CAK7LNAStvWBsimKG2uBe9ROAU8dAV2Zi6F=6VrOS4pFnQgNhAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAStvWBsimKG2uBe9ROAU8dAV2Zi6F=6VrOS4pFnQgNhAg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 08:01:44AM +0900, Masahiro Yamada wrote:
> Hi Arnd, Olof,
> 
> Please pull UniPhier DT (64bit) updates for the v4.19 MW.
> 
> Thanks!
> 
> 
> 
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
> 
>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
> tags/uniphier-dt64-v4.19
> 
> for you to fetch changes up to 1470075d5e354da8f46f5aa2e6956de794eb406a:
> 
>   arm64: dts: uniphier: add headphone detect gpio for LD11 global
> board (2018-07-19 06:43:12 +0900)

Merged, thanks!


-Olof

