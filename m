Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B35C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF1D2064D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:33:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AF1D2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933432AbeGDJd3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:33:29 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:49593 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753046AbeGDJd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:33:27 -0400
Received: from [IPv6:2001:983:e9a7:1:75ac:e53c:37ce:c627] ([IPv6:2001:983:e9a7:1:75ac:e53c:37ce:c627])
        by smtp-cloud7.xs4all.net with ESMTPA
        id aeA9f2b4f6brUaeAAfnzGj; Wed, 04 Jul 2018 11:33:26 +0200
Subject: Re: [PATCH v7 0/6] [media] Add analog mode support for Medion MD95700
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Michael Krufky <mkrufky@linuxtv.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Andy Walls <awalls@md.metrocast.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-media@vger.kernel.org
References: <cover.1530565770.git.mail@maciej.szmigiero.name>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <15b7ffbc-6215-0a7b-a8cc-1803c149e493@xs4all.nl>
Date:   Wed, 4 Jul 2018 11:33:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <cover.1530565770.git.mail@maciej.szmigiero.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNmwZ+CEwq7OaX0PK4zqcwtGfQGkmRjiWyvDGXw0BrNXsh+/QtPm0IThaBMG/5cnfCXSIiklJkEmMBWJSOYLZTnDxTbKBHyvXGzPzzGl69C6MqO1Ucd0
 v057ZD5hyN9yHGA+reU/SJji6ey/2MZza90f7+JmR06kkrnTIUhW5KxvpmCeTNqyLYZCRREIikMcz8F8WCn4QKsf9DYQJ/Kxivu7elzZ7QwEKuclIpVd7Hsk
 65RjZJz994XYGDT1Fg+AkuYcJ75tCUH/iCjnIb5SNgexIAC5CUKmCG7EsvsFYuQGXe3+raBp0N6PO1X2cxbXCvZtfo8uRc10leVVc6BQ2o1P5T1uKa5izE3h
 UnOSapFnQ3+QQcepsIPqb3105K+Kf/Tl067VYzifS00rFX/9GKuvECdHiDgY9jN6ZFcgfxWPKlS/CLsWsBbGhuMnTO1gnvAwrsrLN6CRUEZtA7UKQuNOb/Wg
 IO/MafqteW4tqeXd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej,

First my apologies for the long delay in reviewing, I'll try to do better
next time.

Anyway, I'll take patches 1, 2 and 4 now. I commented on patch 3, that definitely
can be improved. Same for patch 6: that can be made a lot more generic.

Regards,

	Hans

On 02/07/18 23:23, Maciej S. Szmigiero wrote:
> This series adds support for analog part of Medion 95700 in the cxusb
> driver.
> 
> What works:
> * Video capture at various sizes with sequential fields,
> * Input switching (TV Tuner, Composite, S-Video),
> * TV and radio tuning,
> * Video standard switching and auto detection,
> * Radio mode switching (stereo / mono),
> * Unplugging while capturing,
> * DVB / analog coexistence,
> * Raw BT.656 stream support.
> 
> What does not work yet:
> * Audio,
> * VBI,
> * Picture controls.
> 
> This series (as a one patch) was submitted for inclusion few years ago,
> then waited few months in a patch queue.
> Unfortunately, by the time it was supposed to be merged there
> were enough changes in media that it was no longer mergeable.
> 
> I thought at that time that I will be able to rebase and retest it soon
> but unfortunately up till now I was never able to find enough time to do
> so.
> Also, with the passing of time the implementation diverged more and
> more from the current kernel code, necessitating even more reworking.
> 
> That last iteration can be found here:
> https://patchwork.linuxtv.org/patch/8048/
> 
> Since that version there had been the following changes:
> * Adaptation to changes in V4L2 / DVB core,
> 
> * Radio device was added, with a possibility to tune to a FM radio
> station and switch between stereo and mono modes (tested by taping
> audio signal directly at tuner output pin),
> 
> * DVB / analog coexistence was improved - resolved a few cases where
> DVB core would switch off power or reset the tuner when the device
> was still being used but in the analog mode,
> 
> * Fixed issues reported by v4l2-compliance,
> 
> * Switching to raw BT.656 mode is now done by a custom streaming
> parameter set via VIDIOC_S_PARM ioctl instead of using a
> V4L2_BUF_TYPE_PRIVATE buffer (which was removed from V4L2),
> 
> * General small code cleanups (like using BIT() or ARRAY_SIZE() macros
> instead of open coding them, code formatting improvements, etc.).
> 
> Changes from v1:
> * Only support configuration of cx25840 pins that the cxusb driver is
> actually using so there is no need for an ugly CX25840_PIN() macro,
> 
> * Split cxusb changes into two patches: first one implementing
> digital / analog coexistence in this driver, second one adding the
> actual implementation of the analog mode,
> 
> * Fix a warning reported by kbuild test robot.
> 
> Changes from v2:
> * Split out ivtv cx25840 platform data zero-initialization to a separate
> commit,
> 
> * Add kernel-doc description of struct cx25840_state,
> 
> * Make sure that all variables used in CX25840_VCONFIG_OPTION() and
> CX25840_VCONFIG_SET_BIT() macros are their explicit parameters,
> 
> * Split out some code from cxusb_medion_copy_field() and
> cxusb_medion_v_complete_work() functions to separate ones to increase
> their readability,
> 
> * Generate masks using GENMASK() and BIT() macros in cx25840.h and
> cxusb.h.
> 
> Changes from v3:
> Add SPDX tag to a newly added "cxusb-analog.c" file.
> 
> Changes from v4:
> * Make analog support conditional on a new DVB_USB_CXUSB_ANALOG Kconfig
> option,
> 
> * Use '//' comments in the header of a newly added "cxusb-analog.c"
> file,
> 
> * Don't print errors on memory allocation failures,
> 
> * Get rid of the driver MODULE_VERSION(),
> 
> * Small formating fix of a one line.
> 
> Changes from v5:
> Rebase onto current media_tree/master.
> 
> Changes from v6:
> Adapt to commit 4eb2f55728abbe changing V4L2_SUBDEV_IO_PIN_* from bit
> masks to bit numbers.
> Thanks to Dan Carpenter's kbuild bot for catching this.
> 
>  drivers/media/i2c/cx25840/cx25840-core.c |  396 ++++-
>  drivers/media/i2c/cx25840/cx25840-core.h |   46 +-
>  drivers/media/i2c/cx25840/cx25840-vbi.c  |    3 +
>  drivers/media/pci/ivtv/ivtv-i2c.c        |    1 +
>  drivers/media/tuners/tuner-simple.c      |    5 +-
>  drivers/media/usb/dvb-usb/Kconfig        |   16 +-
>  drivers/media/usb/dvb-usb/Makefile       |    3 +
>  drivers/media/usb/dvb-usb/cxusb-analog.c | 1914 ++++++++++++++++++++++
>  drivers/media/usb/dvb-usb/cxusb.c        |  452 ++++-
>  drivers/media/usb/dvb-usb/cxusb.h        |  154 ++
>  drivers/media/usb/dvb-usb/dvb-usb-dvb.c  |   20 +-
>  drivers/media/usb/dvb-usb/dvb-usb-init.c |   13 +
>  drivers/media/usb/dvb-usb/dvb-usb.h      |    8 +
>  include/media/drv-intf/cx25840.h         |   74 +-
>  14 files changed, 3042 insertions(+), 63 deletions(-)
>  create mode 100644 drivers/media/usb/dvb-usb/cxusb-analog.c
> 

