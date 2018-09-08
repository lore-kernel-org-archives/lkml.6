Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71EDC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 13:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9442075A
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 13:18:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E9442075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbeIHSEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 14:04:21 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:33847 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbeIHSEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 14:04:21 -0400
Received: from null ([172.19.249.150]) by mrelayeu.kundenserver.de (mreue001
 [212.227.15.167]) with ESMTPSA (Nemesis) id 0LpkNL-1fLBdU2IQJ-00fgVr; Sat, 08
 Sep 2018 15:18:11 +0200
Date:   Sat, 8 Sep 2018 15:18:10 +0200 (CEST)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Eric Anholt <eric@anholt.net>,
        linux-rpi-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Message-ID: <2050605805.39126.1536412690563@email.1und1.de>
In-Reply-To: <20180904155858.8001-1-tiwai@suse.de>
References: <20180904155858.8001-1-tiwai@suse.de>
Subject: Re: [PATCH 00/29] staging: bcm2835-audio: Cleanups and fixes
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev39
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:A0xKTVXw2cgmrIuAq+97jSTM5gRKMibWlh3FtUDrPO3Wudmzmql
 hFj7ufvSm9hrgTyOFmiHqhTi3WfOk5rlERMJxFc/Q8gKhN6juUv9zPOIowdq6Z5V3EpI/53
 HRdYW3q9JE5wEBfJpsnL/u5JzdltADDN5wb+1lizNjHpJb9CJInLxIWyszamfCjmf0zB+GU
 mSGF/Wl8qnLV4gudVL7Kw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SeY+r0hkc9s=:fFZyk8Og2mvfs0c42j4VK/
 zEb+r1eLQZ6cRv9rzGcVRlxfnZOKTIcwl+9I6EbTkxBltoi2KpnIeoD38IDVQCypVwR54yStD
 /kLki5cMFSr+mGO4L4OjgMXNQI4/60/TGAsC93yTv+YINDLtWYwaCiC/UZaWyeLNtJWCnAPxX
 uRloTne0ncki6Xe0MD2lK8L5LRJannUlfSAhWicMVMXKhwWkBangWqMTIyZ7UaXJb20M4VMs9
 zRER3RKq6HP+FJrfBn+7Hm2uDDFtyZyi26BNSNvARS8jHOLN4exZSVOBkzD04jHaJ4x9EVhaA
 EKM35LxVc1D03aUDptE8NxZYmCvxdhxH0uRL+qIUMF0Lm/g390AAtoe5qoqbsoJ7Y9DvHiiS0
 kdB8aJ83axnawU4MhGKlUiWnbIbJLfEj/miF6VAH0Uiq2iDXX8WIqSHs4WWG47w2w2ElPLyNk
 W3Aw06DNDiIfpPNebXQ6xH/SOsI/oxQ01C/chZ3hHGcskofY9fMbE6cwpNGhcAwKCeu9Lh2yl
 LHLiH4U1wAAc4s85EZlQQXw/+1MB+e1TUBMZ1oxOZbkLjlJHpLAuDXx62y4BIkk5eyi7YwIlz
 s11lt57ElZZuLxMRM+ZkbFN3mbSO56++Si/TmyQ1kNX+6BMwUdZ1G7sqcqc/9I2NHMDqOswS8
 sgEziO3bnpnQTasdsYe/D8xAAdPQVk4bDrDiVH2JWvNx5p+H/Lq8fzSEbpTYXO6T8MxZDIhpt
 HX85juW8DW6Efza3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi,

> Takashi Iwai <tiwai@suse.de> hat am 4. September 2018 um 17:58 geschrieben:
> 
> 
> Hi,
> 
> since I had an opportunity to play with RPi3B+ recently, I took a look
> at the existing bcm2835-audio driver code and was amused very much :)
> 
> So here is the result, a cleanup and fix patch series.
> 
> Most of the patches are trivial cleanups, just brushing up, removing
> many redundant and buggy codes, as well as code simplifications.
> 
> A big functional change is that now it uses non-atomic PCM ops, so
> that we can kill the ugly workqueue usages.  Also, the resource
> management was simplified.

first of all, thank you very much for this series.

Eric has no time as maintainer, so i will try to give you some feedback (beware of very little audio driver knowledge).

I functionally tested your patch series on a Raspberry Pi 1 B (bcm2835_defconfig), so this whole series is at least:

Tested-by: Stefan Wahren <stefan.wahren@i2se.com>

Unfortunately there is still an corruption issue with underlying vchiq and multi_v7_defconfig, so no wider tests.

I don't know if you tested this series on a Raspberry Pi. Maybe you have some specific scenarios, which should be tested.

As a reviewer i have some suggestions, but only trivia. I don't know if it's a problem that this series hasn't been send to devel@driverdev.osuosl.org

Stefan
