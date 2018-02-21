Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1900590-1519230931-2-16957902881430319803
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519230931; b=JHqyJ2O+UFAWxtsk9Wh54O3ir04G+xKZjwXWHDfjB/Igtvs
    2FLWHV6vSJPXGV7HBzHL1CQroARgUiKBkOra/xs4AZkY8iIiW8gqlQIp3wiou5VG
    mJZIa4NFGBkbfZAoX7YcIREYlj637ZmqqEJt0DtaxLlVYliSk6MVDTI+qVAEMFzG
    RmeEWrNdSATQXsZBBy8N6bkjwi+at3v+mHoYLmCRRe+o4tbvZ7G6vfewVe44/EZz
    CYh46q4KP8ZgnesHs3I3P4xOGoR7+ecjfIZhAe/48U0LfBF3yCbV0KhNMu67yI2a
    vHsuuoYzN2SxBNUY0c5DHGZgqh9+i+J76LmLFEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519230931; bh=zRU9s/rNQZXBgglZ1A2ARk3n/8W9s/QiDRwU7K
    NQ5II=; b=njRHowM29Cdlr9cCxauGAX+e3FAB/L0eYF/IJEn0Oom/rRHRJfXIdT
    0A9qUFIJbS/tBp3jf3RabdpjaWdDgi9UHMYyNjvBUQ/NhyFC9uHrXO7nEranTrMo
    U7Q10pAx5cBsEBeNPinHwxcO5mqDsneZAxgX6f8EVzeeBuFNBEjzSS8scbxukMVC
    qopOiq9/axLt/pvcvQLeEYi5/bfl4GIEoaZ1BA6qwhAGsf1rW9lnjSeJgrL9hpnh
    jTbjeyiJQGP+AhqVrN53XmlmbJS2Dp5ha7M9Lq1Dd+THFwaVC3KAKtkn5kV0Xoct
    m6CNEdXmeyZ9VZoLg+Cj/bI41na4qjoA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ulmH+Ri0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Aq22vD27;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ulmH+Ri0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Aq22vD27;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753322AbeBUQf2 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 11:35:28 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:44744 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752712AbeBUQf1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 11:35:27 -0500
X-Google-Smtp-Source: AH8x226mUP7NhntGexB4wISiQpyxy4s6e0szJNliTLTSMTkMff0X0wFNy+kWMbRnetQ2qXlm3Lbqu1c+dujnS/ri9i8=
MIME-Version: 1.0
In-Reply-To: <5a8d9447.0bbf630a.b5452.267e@mx.google.com>
References: <5a8d9447.0bbf630a.b5452.267e@mx.google.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 21 Feb 2018 17:35:26 +0100
X-Google-Sender-Auth: _EguBUkCJTuJoguSmKRFIkEjfZs
Message-ID: <CAK8P3a3tQ8_tcuMgDxT9KwqZsOSzSAw31-b5os35GuPYTRK61g@mail.gmail.com>
Subject: Re: stable-rc build: 13 warnings 0 failures (stable-rc/v4.15.4-164-g0cbdf96)
To: "Olof's autobuilder" <build@lixom.net>
Cc: Olof Johansson <olof@lixom.net>,
        Kernel Build Reports Mailman List
        <kernel-build-reports@lists.linaro.org>,
        stable <stable@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 4:46 PM, Olof's autobuilder <build@lixom.net> wrote:
> Warnings:

Hi Greg,

It's much better already, thanks for picking up all the patches so
far. Looking at the
remaining warnings:

>         arm64.allmodconfig:
> arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: Warning (cooling_device_property): Missing property '#cooling-cells' in node /cpus/cpu@0 or bad phandle (referred from /thermal-zones/cpu_thermal/cooling-maps/map@0:cooling-device[0])
> arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: Warning (cooling_device_property): Missing property '#cooling-cells' in node /cpus/cpu@100 or bad phandle (referred from /thermal-zones/cpu_thermal/cooling-maps/map@1:cooling-device[0])

Send a patch for this now, backported from mainline.

> WARNING: modpost: missing MODULE_LICENSE() in drivers/phy/qualcomm/phy-qcom-ufs.o

This is coming to a future mainline kernel.

> WARNING: modpost: missing MODULE_LICENSE() in drivers/soc/qcom/rmtfs_mem.o

It seems I missed a couple of MODULE_LICENSE backports in the previous list.

3b229bdb54cc ("soc: qcom: rmtfs_mem: add missing
MODULE_DESCRIPTION/AUTHOR/LICENSE")

>         arm.allmodconfig:
> /tmp/cctgVBy5.s:18153: Warning: using r15 results in unpredictable behaviour
> /tmp/cctgVBy5.s:18225: Warning: using r15 results in unpredictable behaviour

Still got this on my radar, no fix is upstream yet.

> WARNING: modpost: missing MODULE_LICENSE() in sound/soc/ux500/snd-soc-ux500-plat-dma.o
> WARNING: modpost: missing MODULE_LICENSE() in sound/soc/ux500/snd-soc-ux500-mach-mop500.o

1783c9d7cb7b ("ASoC: ux500: add MODULE_LICENSE tag")

> WARNING: modpost: missing MODULE_LICENSE() in drivers/video/fbdev/mmp/mmp_disp.o

c1530ac5a3ce ("video: fbdev/mmp: add MODULE_LICENSE")

> WARNING: modpost: missing MODULE_LICENSE() in arch/arm/common/bL_switcher_dummy_if.o

a21b4c10c7bf ARM: 8743/1: bL_switcher: add MODULE_LICENSE tag

> WARNING: modpost: missing MODULE_LICENSE() in drivers/soc/qcom/rmtfs_mem.o

3b229bdb54cc soc: qcom: rmtfs_mem: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE

           Arnd
