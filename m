Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8857C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFE420666
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="USMnp2Td"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CFE420666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbeIZT2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:28:21 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:35870 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbeIZT2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:28:21 -0400
Received: by mail-lf1-f53.google.com with SMTP id v17-v6so19299831lfe.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 06:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2rdtpnvnZhQTlRNK2uMJAgDOv9kElXJUKD1fhZii/RA=;
        b=USMnp2TdDcTUgrkdG0nqPnMyCEj97IOD2gHVvLjT00B7V8mpmgj+QrLAdBeXgXP0WR
         Lj8gr4MELvCPEnB0J2ZK6F8jQ1MCwPsE7MDPFAIRx/CakeOmweXxGbLtFvidF5pR8Cqx
         RvHCmYu1HqH/4TwmosdzU+eqGiFNlUrclAkaZXH9l4Ob1atwizr0z/ia5BRMCvpgMVxN
         Bwr0zyA7mXQlOqfwQXoeYom1MJXWV5Ey0pJK2QupHITrPeSbU9PlmnHxxipnDE6kyblF
         EO9H0YXV01cu8xXdctnbdnkW5Ll4+GWnbFI9nhLxvN3h9iooSu0ROeZjwmnfou9C7tMe
         FAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2rdtpnvnZhQTlRNK2uMJAgDOv9kElXJUKD1fhZii/RA=;
        b=s+DYZGEr21XWSnobTQ6kTKLhUbcwFAJutHB5Rpjrra87+6+Mq8CBpe0tzjw0nr0zma
         YRpuL+57nPm0lKw4BoQKEDikThhL8v2oSbQ7adeVANqkLZAgWyKLUswF77LZENLisiJL
         L2vaMjPoJBit++wokf79ARFafr/MuDDIDScQaSWPi2qR+HkHukYT3nWMMikQ2UwTvSwK
         BAqJeRtbRU7jno9mFcI1tfBU3EiBhDmLcjwkdv/JHgunVVCL5dx6SEdPUKhWO0U75t9o
         Eh+63qpQNkd3utlqjokGESQDaqqySzUX7rgmmXAlcNeDYbLySlgprLVSrRaeRKRbUcm8
         01nQ==
X-Gm-Message-State: ABuFfoiMpk7eZ3e5fVYW0gLWwwI15dLiDk7B9wQ3YBZO4wR9PEl8k6ni
        2HClMgfgoMYagYT9E1sy6ARu7QgMaF9pItw0ng0utw==
X-Google-Smtp-Source: ACcGV63d3VQz6YzHgWSlCLAtuiJyANssBHsy2Xkj+o0gV0ImnchSxnaWDh18O04wc/gZma7i+rd+lVuayK/jMPGbF7Y=
X-Received: by 2002:a19:735d:: with SMTP id o90-v6mr4122644lfc.45.1537967725354;
 Wed, 26 Sep 2018 06:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180924221954.30473-1-leoyang.li@nxp.com> <20180925194757.pp3jiltu36ih2wfo@localhost>
 <AMSPR04MB503EAF5EF985E25D87190AA8F160@AMSPR04MB503.eurprd04.prod.outlook.com>
In-Reply-To: <AMSPR04MB503EAF5EF985E25D87190AA8F160@AMSPR04MB503.eurprd04.prod.outlook.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Wed, 26 Sep 2018 06:15:12 -0700
Message-ID: <CAOesGMiLdhq+o-q2itJgEbMG6NyJNeLpEMTHtmLdqVcsFwV35Q@mail.gmail.com>
Subject: Re: [GIT PULL] fixes for soc/fsl drivers for v4.19
To:     Li Yang <leoyang.li@nxp.com>
Cc:     ARM-SoC Maintainers <arm@kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 10:19 PM Leo Li <leoyang.li@nxp.com> wrote:

>
> Thanks for the review.  Please help to cherry-pick the other two.  I will work with the patch author for an update for the first one.

Done, thanks!


-Olof
