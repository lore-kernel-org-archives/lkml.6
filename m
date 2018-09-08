Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB43FC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 17:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 598A52064D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 17:01:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 598A52064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeIHVrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 17:47:22 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:50861 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbeIHVrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 17:47:22 -0400
Received: from null ([172.19.249.18]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N5W4y-1foVQc1Rda-016zVV; Sat, 08
 Sep 2018 19:00:36 +0200
Date:   Sat, 8 Sep 2018 19:00:34 +0200 (CEST)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Eric Anholt <eric@anholt.net>,
        linux-rpi-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Message-ID: <1199025412.60278.1536426034839@email.1und1.de>
In-Reply-To: <s5hd0to5598.wl-tiwai@suse.de>
References: <20180904155858.8001-1-tiwai@suse.de>
 <2050605805.39126.1536412690563@email.1und1.de>
 <s5hd0to5598.wl-tiwai@suse.de>
Subject: Re: [PATCH 00/29] staging: bcm2835-audio: Cleanups and fixes
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev39
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:QWDAYi2lMkTJDrzYalC2ImMsS52yV+rb0W5oLwN3Nx59YrYv5Ni
 ovIgTjkrLxJl/FBGr4jmd6IJ+JEPti/sTR69cl5Xq5oaJkpHV7Bo2uShrhQ9H0xpA8WP4XL
 4k2O/RA0opdz0ZIzIL9uwfBCFKxs9e5AyRxZk1urwbOpsCUgqxZdgtNbI+QVkL0e3sTdJEX
 Uki4D1fCojFmORiGy9MFw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:p17z8WOkFXo=:aZgeXxwG6g5fkxgqHFxH/f
 svLzhyw7dFFoP6PtXNVXhons+mx9xtNoLQ1To7pR4poJq+ElQ9SN0Heg9xtFYmnsjC1lrfH1Y
 v9cMhaRynp2l9316qdvseXXDcIho8idtxIugxEV9Fq2ke749mBccKCX19ScBFono4MAFmMEsr
 TKNyMLyaa31aM5W6LgYTmO4XsS5pMgho4ssWAzIxUSPswWmNovzni2FiaMdWKn3lCdeJ47NK8
 CJSZ+HWZy6fJU2JURl4+mCADoLOws5Pu+AI1ovhawqmKVT9y7B3uPExCDWSMH3LdKQHGmzrFC
 ipzvWX4GVpl2EiRpHOvzlvfUtpV/1CfkO1kA3b1FOEecfvON0IG/CvsY1KB9P9ba96y39mVZm
 b9wvxYZMweMzjJVf0Ybp0Kj6W7IYHQPVpCVJk9OAU4eU5RLpDvjo5Gz3NkPEtNvwH9FONXmwJ
 kO21sy/nKbLO8QIR05lz6Ie5KE9YrhHH+IPy9YtLQdjDsJMLFcw2XCEvvmz27KQlRTGBpuNC4
 vvvsx7e67aj1/IOo8590juZJFXh9DeodRSliUUsgIBg++LDoJQLmIuHBuk0rjgrmeo5zRkp4N
 YbtDY7p+B1m11RQOS2sC6etfngF5RCL1LL90Z3dldrfc1tdy5fRfh0u8hna9OZ8DKrGCXlYpD
 WVojxUl2GCWwDM6Y/1jBQ/E+IbcJblKbGH8CCujq5LutT1J/AeNzOufTrpGRpKJBrJDrmsXZ7
 2AGFx1j57aTOSbk4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Takashi Iwai <tiwai@suse.de> hat am 8. September 2018 um 18:21 geschrieben:
> 
> 
> On Sat, 08 Sep 2018 15:18:10 +0200,
> Stefan Wahren wrote:
> > 
> > Hi Takashi,
> > 
> > > Takashi Iwai <tiwai@suse.de> hat am 4. September 2018 um 17:58 geschrieben:
> > > 
> > > 
> > > Hi,
> > > 
> > > since I had an opportunity to play with RPi3B+ recently, I took a look
> > > at the existing bcm2835-audio driver code and was amused very much :)
> > > 
> > > So here is the result, a cleanup and fix patch series.
> > > 
> > > Most of the patches are trivial cleanups, just brushing up, removing
> > > many redundant and buggy codes, as well as code simplifications.
> > > 
> > > A big functional change is that now it uses non-atomic PCM ops, so
> > > that we can kill the ugly workqueue usages.  Also, the resource
> > > management was simplified.
> > 
> > first of all, thank you very much for this series.
> > 
> > Eric has no time as maintainer, so i will try to give you some feedback (beware of very little audio driver knowledge).
> > 
> > I functionally tested your patch series on a Raspberry Pi 1 B (bcm2835_defconfig), so this whole series is at least:
> > 
> > Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
> 
> OK, thanks, I'll put to my series in case of resubmission.
> Meanwhile I'll keep the series in topic/vc04 branch of sound.git
> tree.

does it mean this series should go through your tree instead of Greg's?

> 
> > Unfortunately there is still an corruption issue with underlying vchiq and multi_v7_defconfig, so no wider tests.
> 
> What is this corruption issue?

Actual there are two of them.

First one are incompatibilities of older VC4 firmware with commit 14dd37fc7b65 ("staging: vc04_services: Remove cache-line-size property (v3)"). There is a pull request for the Foundation kernel which hasn't been upstreamed yet [1].

The second is documented here [2].

[1] - https://github.com/raspberrypi/linux/pull/2666
[2] - https://github.com/lategoodbye/rpi-zero/issues/23

> 
> > I don't know if you tested this series on a Raspberry Pi. Maybe you have some specific scenarios, which should be tested.
> 
> I have only a RPi3B+, and that's all what I've tested.

Great, just of curiosity which config did you use?

> It'd be great if the patch series could be tested in a wider range of
> models, of course.
> 
> The patches are only about cleanups.  They corrected the bad usages of
> audio APIs and its design, but basically I haven't touched the basic
> functionality intentionally at all.  So the behavior should be kept as
> before.
> 
> (Actually it'd be better to revisit the design later, especially about
> the multi-cards option and the PCM route mixer control, but I left as
> is for compatibility reason for now.)
> 
> > As a reviewer i have some suggestions, but only trivia. I don't know if it's a problem that this series hasn't been send to devel@driverdev.osuosl.org
> 
> No, it's just because that address isn't found in MAINTAINERS file.
> If it should go through it, please correct the entry at first :)

No, this is the mailing list for all staging driver. It is reported by get_maintainers.pl

Stefan

> 
> 
> Thanks!
> 
> Takashi
