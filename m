Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709D1C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A9E20882
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Pvh+EDq6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25A9E20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731007AbeKHC7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:59:47 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44513 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbeKHC7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:59:46 -0500
Received: by mail-lj1-f193.google.com with SMTP id k19-v6so15453064lji.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 09:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9ISKQpqfFPEbdelvqtDI5zwAM3QFY3eZu2pPJjaUU8k=;
        b=Pvh+EDq66fMxTPgpclzXHT4KbLaen5Gk1AoB8MMBQ81HRC001iic2sDYunuAU5UIV1
         nfPX4DnfYob0+MwnxXelZSqc0TMyrr43gCUIkdH6vwesX6fqGSWeFm8i2wSUKOMzcOdE
         A4onGaFapjub4n4J7JHuNIpSr8/TMksCRtZDieFaPRm3JOMlyImTv3/y3PvYat2hHCj7
         dW6+ZSY2Pu+LhfCNPIxujuakkPqRG8OUcw4cusQC+Z/JTc741/ff14kIHYJAc1SOlUJS
         XVV3SlxgGRwKDpjUzyzaCBX9wYaSEFYlDMTfHLIYs106Z2SEBVI7oVgU8GqrmR1eYc+A
         si1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ISKQpqfFPEbdelvqtDI5zwAM3QFY3eZu2pPJjaUU8k=;
        b=kXzK66ErboPwbA/Gi5t8zc8tV1eg/CVmBX/XHF09rPmf75c1MVLOhVuXyy/yetplCx
         yCaLH04KA+vME6VYmp0UegBdCdXCCUhTxXtCUQVX6aDY8qdxrKJVspS3dmDldd5/qGX2
         g9iCK4z6pOVqDrwDMyYGO5GXbQx6JTh4OfVmPgnngNx+AzdmPjzzY3B9uTsh84pnwm6k
         TR7xSMGm70avE3jtolr3883NuoHeof9Dz2VBAkDN5q6h/IxSzbakAWdQyr5HkvJ4bCqF
         RpYSWZjzea2A6wKrXxYwtE3HgDjuTfKKvLtgKjHjHwKEnOLuQQY/0BQyWd4uqVSHtAN1
         u7YQ==
X-Gm-Message-State: AGRZ1gKx/3klwf7sUsUR60sGpazQfcFy6Md/ezi1SMTSNH7X9GgliqA9
        e3gGJ+gAlO4SzHJ6BraMX9DMKiECxMDpuRvTRH3MzE1krS8=
X-Google-Smtp-Source: AJdET5fG82NHPos/uyC3RkEiZuGCVw2VcXT0CTtm+1uWCk/peccYxKCphrYOEGt7+EImftWrNeYNp+uMlUUsW1Xs+Bo=
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr684843ljh.59.1541611703995;
 Wed, 07 Nov 2018 09:28:23 -0800 (PST)
MIME-Version: 1.0
References: <20181107171023.zoo6qox5eewy3pmk@localhost> <CAHk-=whF7kBo49-BFTUc-by+HB_0qNw_=+d24TydO2mYwwsWMQ@mail.gmail.com>
In-Reply-To: <CAHk-=whF7kBo49-BFTUc-by+HB_0qNw_=+d24TydO2mYwwsWMQ@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Wed, 7 Nov 2018 09:28:11 -0800
Message-ID: <CAOesGMg3uHJ7YB95skjcVK39kudAGGjKo6909d--LDZmqeE1HA@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: SoC fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ARM-SoC Maintainers <arm@kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        guillaume.tucker@collabora.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 9:17 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Nov 7, 2018 at 9:10 AM Olof Johansson <olof@lixom.net> wrote:
> >
> > ARM: SoC fixes
>
> Pulled.
>
> > I was a bit too trigger happy to enable PREEMPT on multi_v7_defconfig,
> > and it ended up regressing at least BeagleBone XM boards.
>
> Odd. Did it hit some "may_sleep()" test in a driver that is hidden by
> preempt being off? Otherwise I don't see how/why preempt should fail
> in a board-specific manner..

The board hangs early during boot and the usual way of collecting
early console doesn't seem to work when attempted (I haven't tried
personally).

It's one of the major non-SMP platforms covered by tests. I'd be
surprised if it turns out to be truly _board_ specific (and rather
specific to OMAP3), but we don't have enough data yet. Chances are it
either shuffles some timing around or indeed hits a may_sleep() test
somewhere.

(I just realized I might have missed to attribute Guillaume in the
revert patch. Sorry about that).


-Olof


-Olof
