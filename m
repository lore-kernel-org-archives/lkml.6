Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DC6C43444
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 00:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 136E421872
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 00:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfALAOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 19:14:37 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:41653 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfALAOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 19:14:37 -0500
Received: from oxbsltgw58.schlund.de ([212.227.220.196]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MjSHa-1h6yRY0RDO-00kzJT; Sat, 12 Jan 2019 01:14:14 +0100
Date:   Sat, 12 Jan 2019 01:14:11 +0100 (CET)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Phil Elwell <phil@raspberrypi.org>, Eric Anholt <eric@anholt.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dominic Braun <inf.braun@fau.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Message-ID: <1446663988.387644.1547252051945@email.ionos.de>
In-Reply-To: <1547206493-105303-1-git-send-email-phil@raspberrypi.org>
References: <1547206493-105303-1-git-send-email-phil@raspberrypi.org>
Subject: Re: [PATCH] staging: vchiq: Fix local event signalling
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:rcZjS4Eorbl+bMlqUoCbNR3+99SToxrAR/V03n9zD1P11ZAj2+u
 jQyPqzHR3lspWHD6bgPkge17I0Wr0Znd6vgMv/cAgyAcsyPzY+C8BvYetFKCVeZn2E/cOOI
 wLjJqjI7toM4bP47Q2LbHxY2GAP56+E4sod8q6jy3exGUqYYHemSMlLqX7wFe4MYXGlkDpy
 xOiQozCLUikLiyIP1XK2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yDzikWdrk/o=:a3J6pRNUrsprvOukEPGxhV
 V8BqUt2iTCfF2T1ugY7yH4OimkPbGJ4JdbD2TCp2i6ANQvRSD6v75n7A0Z995GnL38dOAOLV+
 UO14ed6JaSIq/oKlEyAf4fGtvyEOvf18SR0YlCdHhCla/LgjwlkcF5bTLeNho4hPIqaaCujY0
 H4I15I1zeGgof2kCKXpoK/4OC4oHjCIT5CbdeUM+7t7+6RcFSxLFAkg0glIcJ3qmrYSTdN+vc
 QtPzD9ucVijv4th56fGBgM/KA752mrdyVOta1NQIyYTp0t45ev/XWHr+smn1HeDGf+IjA8ht8
 dMBdMpPeWxoELFhOT5xCKFQOjj0GsEP7raQNoZU37LsY2ipDPvZ5Qg7ybXneun8i0uvDpcVy4
 Ke7ueQ1flrGJnwWWgD0K/s1lyyQ8d/MsXHZOdf0svcVRDBpDRJbznolr719A/2R9nsq2mLSbJ
 w+nu25BNcrHEEeiMhgA7Z6CJIPpWPoKDGfTiwCuDYXzOOUE/A7Nha9IOJnLyyo180n185kpvS
 I4JFGKug5MR4FxEvogCoIQAorjdkhwXwPU5KsqqDVKpxFZB72Gd/nxisYDYzvecclDYKHTDT5
 SbFa/jVTvAKwjXRKJi/CCEbY/sRPbeNqrzdy7q72HZyEmOLFKREWR+sl31P0QMhbVWRNSyWJw
 FQgwD3cDNbqQuKCvJEJoYcZmhjxdnae00rFTv6+yEBztQVIRn30ZsnzN0p2xqt3IavSz+hiC5
 p2eRn8x0hRFc16U50sRNzfGskJgMtpT6+t9FG/Bd6PhanIXQ9agesAKocNQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Phil Elwell <phil@raspberrypi.org> hat am 11. Januar 2019 um 12:34 geschrieben:
> 
> 
> Prior to the recent event reworking (see Fixes), thread synchronisation
> was implemented using completions, the worker thread being woken with
> a call to complete(). The replacement uses waitqueues, which are more
> like condition variables in that the waiting thread is only woken if
> the condition is true.
> 
> When the VPU signals the ARM, it first sets the event's fired flag to
> indicate which event is being signalled, but the places in the
> ARM-side code where the worker thread is being woken -
> remote_event_signal_local via request_poll - did not do so as it
> wasn't previously necessary, and since the armed flag was being
> cleared this lead to a deadlock.
> 
> Fixes: 852b2876a8a8 ("staging: vchiq: rework remove_event handling")
> Signed-off-by: Phil Elwell <phil@raspberrypi.org>

Tested-by: Stefan Wahren <stefan.wahren@i2se.com>

Thanks
