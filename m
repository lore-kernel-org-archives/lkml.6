Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7E0C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 05:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A525E2083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 05:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="Ny4z/5wI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A525E2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbeJBMjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 08:39:46 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:53178 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbeJBMjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 08:39:45 -0400
Received: by mail-it1-f193.google.com with SMTP id 134-v6so1970679itz.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 22:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IXSzoiFc4EYwwmP67Mk0DvqyZS6v6kxo/n1ckYzbsNA=;
        b=Ny4z/5wIE4WSFhXpcx1cNWE22AFFa37Ua+2VZm/1PiPlUggD5XxEjEgJBUDUnUj5PK
         9mwfMEWnlbDlW6s+v2Al0YcrTlNNYsK5Z8jQE1z8xPihr1FUqLyTcwu9K7pYszI85UhA
         JJSthmeNUgF28uvsycWxZPtSVtNhnuaFv9yezlPZOmh4W5lrTodrXoH4H4FicxEKjp9v
         QO3eeOaSB10jJZWihiLZyChRACsmPIFA6IcLDPoiB5G/3n+iJ7aV9ivNmalLh4/1kmmd
         tURxEjNmdirrKpOS+syWM44m8kAPXmBQD0S5JEIbqdGyu01t6c16xXFik5OuBaNqkaW5
         lgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IXSzoiFc4EYwwmP67Mk0DvqyZS6v6kxo/n1ckYzbsNA=;
        b=qyGNYGjrwZsV2Jdo+xkrMX9wnG91ClusyzukDmx1vfA9ktFJZBU0y8sQQ9lzIHBWET
         B2/taYFu7EBilDXnCOhzF2FZQ3gZxTOUdDJYqfpFAoz7xm1SBOwQ8knrxvsx+89kPfh2
         cWl4w34vSYdCkfEl3rIulOA1CSmUw6hehI3TebaO9XTRP8zV6mQNubSCL6B9HvupcC+z
         IWZJcA8H/gL3s7rYF+1MCnlOlJTFtfB+948RbbJkbrOa1JSJn9thToSu6BXntBJUThfV
         HoReUziXMqMr5JApvfwrI0LH/l78OMOzf2L3CW1voMN1Dk6OJav5QdI5jrqyELdR7CHK
         gWbw==
X-Gm-Message-State: ABuFfog1K6LRqQhdhO1MV5LXwimnTFscGogBBe0xfgY2gcE5kJ3PUDz+
        0D12zmUw+EebZC+W677WBmTw2XB7lj2ruvFvy9kTLQ==
X-Google-Smtp-Source: ACcGV60A5RzYKGgYfSiZQxtvys5qR4bIIBXPkri5L0hVeYUvZA5ydfALG5oYpHuUJgym1JA2S1CK2CmwWgNwDa2vUH0=
X-Received: by 2002:a02:b14a:: with SMTP id s10-v6mr10407881jah.38.1538459896762;
 Mon, 01 Oct 2018 22:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180927040948.11891-1-jian-hong@endlessm.com> <20181001.225140.1939583158282424865.davem@davemloft.net>
In-Reply-To: <20181001.225140.1939583158282424865.davem@davemloft.net>
From:   Jian-Hong Pan <jian-hong@endlessm.com>
Date:   Tue, 2 Oct 2018 13:57:40 +0800
Message-ID: <CAPpJ_eduPv5RDNgUOw3K+XprZBfUVn_sSOLbDWjNtaGRssUgLA@mail.gmail.com>
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

David Miller <davem@davemloft.net> =E6=96=BC 2018=E5=B9=B410=E6=9C=882=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=881:51=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Jian-Hong Pan <jian-hong@endlessm.com>
> Date: Thu, 27 Sep 2018 12:09:48 +0800
>
> > However, there is a commit which resolves the drivers getting nothing i=
n
> > PCI BAR=3D4 after system resumes.  It is 04cb3ae895d7 "PCI: Reprogram
> > bridge prefetch registers on resume" by Daniel Drake.
>
> I don't see this upstream yet.

It is in linux-next repository:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/=
?id=3D04cb3ae895d7efdc60f0fe17182b200a3da20f09

Regrads,
Jian-Hong Pan
