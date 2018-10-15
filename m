Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C8AC28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ADDA20644
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="zwb0Lx1D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ADDA20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbeJOQgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 12:36:12 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:52742 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbeJOQgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 12:36:12 -0400
Received: by mail-it1-f193.google.com with SMTP id 134-v6so27574213itz.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 01:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Pvt+ZRHbeCT11x8+PeJiwM6cHUKb0KvV6/BQAJZ4+ec=;
        b=zwb0Lx1DwFkHBVeEIAN6arkA8xrGTglqImGCTKC3olj1i8yQqr3xKJ+q+BplJsvq5Z
         AW/iw+dvHuH+hQPbb5f28WDHzrBKcAISf93mubJ+l7Sw2Z6p3Ftnl6uwtniiT0p7FUlP
         hsxfu8rKTi37uyNWsf2LyavcQxCIGV7wFrptczxICwK9jEFoRqTLG3wfKv5qW/PZQIGB
         xU2aJTkU2J7Q9tMFHmyN02jsiPQ1X1tFeyzYabdk6z5aCo7QAHD306au8Y68/hEUbLeP
         WDkhNcjmFQpdO6ndYnbgSVikWMsqzRFXo9yCFv822OzOviBg18Y/XyZ/AZcDLdNhN3Du
         OhWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Pvt+ZRHbeCT11x8+PeJiwM6cHUKb0KvV6/BQAJZ4+ec=;
        b=jzgW7irXs+BCWBSfe/avvLo39VK7XRtaL7cY2n/tUNtOq/pE0vQjEOQq24azzwkU7/
         KKd78qcIWTeL1qEy/dlyXRKS+5sqYcNNvNp6gAVHh34eddgxYzCUXre+jgKHXsacTaM2
         DsGq+mZW/B6lhiFUaEbSjnaHxxZtlp4dmwdPhC3vkMXvMEgynoFxAJFqsRDujBki/Kvy
         qCYLpuNN5wV6siXax2gd2iuVrVAKAMvLDJPm6hEsyeY7MXyTjZHlBaXyFipFoLNPaPSd
         /maPESHAm/BZL9A1w+JB7rDAgMCQvhY4h95yOyExgZiBERgly6ln63ILvaqJ/AVZuTLk
         Z54A==
X-Gm-Message-State: ABuFfohWkUTao0I88ajqkoP0cJPjBLxanivj2BIqJve+cf1zrdTSuljm
        2DlCVoBRz+5NYo8vzoVQEM0ZlmLucSudM4sYbqtQ2A==
X-Google-Smtp-Source: ACcGV61vuHg0K9e2IIBckEf2Kn6IcGW1dpmFHWzDkUjgRMrH9OOGjYaOAEe7p7s5kx6OCfmG2PeDFmEErG2lZpvwAD0=
X-Received: by 2002:a24:e187:: with SMTP id n129-v6mr11896876ith.47.1539593512844;
 Mon, 15 Oct 2018 01:51:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:d1b1:0:0:0:0:0 with HTTP; Mon, 15 Oct 2018 01:51:12
 -0700 (PDT)
In-Reply-To: <CAPpJ_eduPv5RDNgUOw3K+XprZBfUVn_sSOLbDWjNtaGRssUgLA@mail.gmail.com>
References: <20180927040948.11891-1-jian-hong@endlessm.com>
 <20181001.225140.1939583158282424865.davem@davemloft.net> <CAPpJ_eduPv5RDNgUOw3K+XprZBfUVn_sSOLbDWjNtaGRssUgLA@mail.gmail.com>
From:   Jian-Hong Pan <jian-hong@endlessm.com>
Date:   Mon, 15 Oct 2018 16:51:12 +0800
Message-ID: <CAPpJ_ecr-tMNcpe=--MYyK3OWJiYEAoX7AnDBN63XO1OGZ4v_w@mail.gmail.com>
Subject: Re: [PATCH net] r8169: Enable MSI-X on RTL8106e
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        Linux Netdev List <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-10-02 13:57 GMT+08:00 Jian-Hong Pan <jian-hong@endlessm.com>:
> David Miller <davem@davemloft.net> =E6=96=BC 2018=E5=B9=B410=E6=9C=882=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=881:51=E5=AF=AB=E9=81=93=EF=BC=9A
>>
>> From: Jian-Hong Pan <jian-hong@endlessm.com>
>> Date: Thu, 27 Sep 2018 12:09:48 +0800
>>
>> > However, there is a commit which resolves the drivers getting nothing =
in
>> > PCI BAR=3D4 after system resumes.  It is 04cb3ae895d7 "PCI: Reprogram
>> > bridge prefetch registers on resume" by Daniel Drake.
>>
>> I don't see this upstream yet.
>
> It is in linux-next repository:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commi=
t/?id=3D04cb3ae895d7efdc60f0fe17182b200a3da20f09

The commit is also back ported into Linux kernel 4.19-rc7 now.
https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git/commit/?id=3D=
083874549fdfefa629dfa752785e20427dde1511

Regrads,
Jian-Hong Pan
