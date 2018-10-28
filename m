Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33880ECDE46
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 08:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B799220831
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 08:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B799220831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbeJ1RQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 13:16:16 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:57893 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbeJ1RQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 13:16:15 -0400
Received: from null ([172.19.249.148]) by mrelayeu.kundenserver.de (mreue012
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MxYT3-1fNTGa2QZ7-00xuIi; Sun, 28
 Oct 2018 09:31:37 +0100
Received: from null ([172.19.249.148]) by mrelayeu.kundenserver.de (mreue012
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MxYT3-1fNTGa2QZ7-00xuIi; Sun, 28
 Oct 2018 09:31:37 +0100
Date:   Sun, 28 Oct 2018 09:31:34 +0100 (CET)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Dave Stevenson <dave.stevenson@raspberrypi.org>
Cc:     Peter Robinson <pbrobinson@gmail.com>, devel@driverdev.osuosl.org,
        tuomas.tynkkynen@iki.fi, Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        nsaenzjulienne@suse.de
Message-ID: <1503865704.281328.1540715494361@email.1und1.de>
In-Reply-To: <CAAoAYcMjr7ZgyNPCjrTuJwJ9DzJUex7DBmU4pR4gajZ3W+LiHg@mail.gmail.com>
References: <20181004093747.21750-1-tuomas.tynkkynen@iki.fi>
 <1715113043.52878.1538821118324@email.1und1.de>
 <20181017101831.b5kvh5jw3sqqhbat@mwanda> <87bm7stwhv.fsf@anholt.net>
 <CALeDE9ORBiWh0aLqv17DGZaWW5BM4Var5C-hO5P-u2OYyqU7HQ@mail.gmail.com>
 <CAAoAYcPyB-Xjh+BfSsUgbmRGP+M3LmHcjxshnDDqB8=JvMrjCg@mail.gmail.com>
 <f358db9f-1b7f-d0c6-ace5-64b908f08b63@i2se.com>
 <CAAoAYcMjr7ZgyNPCjrTuJwJ9DzJUex7DBmU4pR4gajZ3W+LiHg@mail.gmail.com>
Subject: Re: [PATCH 0/7] staging: vc04_services: Some dead code removal
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev39
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:Cr/wsPqIxgKkErsnemtWhgMZINyScu7imBtuttO6+yGPBbVEfzV
 9CsmMpzWTpaZNvNQxS1SXPS+ISPLrNgeiU47hBt9E/lQuTmF0MUy/DN7gjDPxv0/4UBuc2B
 y9HUyp4EMTfYeG9jrexl5hyZMoPnFLePrNcp6ENV9lWTIVios7CSLibBuEjW5TcctwQSbhc
 FtfEcQgdGQrIcrwUss/tA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tCX2BTZXhn0=:k6RHYTJohjKc3PZZKGoVfE
 zqucO8dVI+TBwAHIozjY0xnA4nbPFIKEB+JXuG/sE8dxuFY+VySBudbaNHp4M1/l1QhEz+0On
 i2gat/iSugwNwH2knXLMaylrUZPtQOcgWYnpGeM/IOmsv8gtapGTWv9s6VXSWlLFct5PEEV09
 lHYZ5CymCZlDHK5yPuAqIjiDU+0tU1ZkJcEf7C0mM6yZstGDojwGURsfPaVXgibDNbNox2V3c
 IJ8c120QiSOcsibCQwos5UO+0W8Kg7vOfc4BwVaiFkQwHZiN+39c3ZzVc7P4QJZito9j9E02f
 tlLapetQE+DhqiZNqI9znpnEZNSGJAZxzuN/VB4KbMDZh3kGrSr3ArzuESq5tFMdsJaa6KF3p
 HTHuNJsP1zlVVo/3wqKmHaUqpXfsjavHZBpjrS369l8vOj6V66PUQB+cdlv1HSsZ3T+fcwcgt
 0OlBtKShJUW+ExUSwYxRYZ6PA81D0PaqMpHrkvnnq4GA5hkQSGqyFrhOzWYBdl9zYik/G27mb
 yzIdz3RwJ3MH9kZ5LUPZDj25UnB1rv211kn3/akzDtmeLJ9XMNeJGeEe0C8jQsZYiXjg/NmW8
 Tvs2yj+/AkKa9ZUcm4hfLWHKI74g/MQfghw+lMm0wFlPOe5SrDgGKXQjpi1TWOA2DuihCNvc6
 FmW5qDIwBCAn0tC5rhUhRZuNKTXJhZxwCTPhDrPg/YEFn33DYINwPKa+fUSKRNX6CZzTAql3P
 zqVV1qkAV8aw+V81
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

> Dave Stevenson <dave.stevenson@raspberrypi.org> hat am 26. Oktober 2018 um 19:15 geschrieben:
> 
> 
> Thanks Stefan.
> I've picked up your latest patches which mean I can get the driver
> loaded via the (almost) approved method.
> I do seem to still have issues with not getting the expected address
> ranges, so the driver/VPU was trying to map cached alias memory. As
> your patches only came through yesterday I haven't had a chance to dig
> through why yet. I've done a temporary hack to ensure we always map
> the uncached alias, but that can't persist.

does it mean with DT probing it worked before and with platform change it's broken?
Or anything else cause this regression in 4.19?

> The networking issue has been resolved :-)
> 
> I've pushed where I've got to to
> https://github.com/6by9/linux/tree/rpi-4.14.y-codecs-push-pt2b
> It's a touch messy due to integrating in your patches in the last 24
> hours. It needs a full rebase so that my changes are on top of yours
> rather than haphazard.
> As we're moving to 4.19 fairly soon I may well abandon my 4.14 tree
> and jump to either that or directly on staging. I'll see where I get
> to early next week.

Sorry, but there is no need for a quick shot against a downstream 4.14. I assumed you make your changes against upstream linux-next + Phil's and my patches.

You can use https://github.com/anholt/linux/commits/bcm2835-audio until 4.20-rc1 is out.
Using 4.14 or 4.19 doesn't make any sense to me.

Regards
Stefan

> 
>   Dave
