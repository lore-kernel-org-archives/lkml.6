Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2AEC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05BAB21709
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05BAB21709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=torlan.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732124AbeHCQAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 12:00:15 -0400
Received: from forward104p.mail.yandex.net ([77.88.28.107]:57521 "EHLO
        forward104p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731083AbeHCQAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 12:00:14 -0400
X-Greylist: delayed 456 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Aug 2018 12:00:13 EDT
Received: from mxback3g.mail.yandex.net (mxback3g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:164])
        by forward104p.mail.yandex.net (Yandex) with ESMTP id 3168F182B53;
        Fri,  3 Aug 2018 16:55:48 +0300 (MSK)
Received: from smtp4p.mail.yandex.net (smtp4p.mail.yandex.net [2a02:6b8:0:1402::15:6])
        by mxback3g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id vTeMuC6ksX-tj80sWT5;
        Fri, 03 Aug 2018 16:55:48 +0300
Received: by smtp4p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id PAgvabKeM9-tiRS6BKM;
        Fri, 03 Aug 2018 16:55:44 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
To:     maarten.lankhorst@linux.intel.com, daniel.vetter@intel.com,
        jani.nikula@linux.intel.com, gustavo@padovan.org,
        seanpaul@chromium.org, airlied@linux.ie
Cc:     dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   WGH <wgh@torlan.ru>
Openpgp: preference=signencrypt
Subject: xrand --output ... --off no longer turns the screen off on Linux
 >=4.15
Message-ID: <74964b4d-b5e0-a544-c8cb-de43bfd9e599@torlan.ru>
Date:   Fri, 3 Aug 2018 16:55:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Linux 4.14 and earlier, running `xrandr --output ${MONITOR} --off`
will result in screen turning off (the monitor will say "no signal" or so).

Since 4.15, however, the screen will remain black, but turned on
(backlight and everything).

I'm running xrandr 1.5.0 and X.Org Server 1.20.0.

This is caused by kernel change introduced here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=846c7dfc1193eb2f9866fe2fa0ae7d45c72f95b9

I've reported this a bug to X.Org as well. 
https://bugs.freedesktop.org/show_bug.cgi?id=107472

