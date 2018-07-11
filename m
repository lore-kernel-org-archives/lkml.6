Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D36DC468C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 23:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5688F213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 23:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5688F213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390729AbeGKXMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 19:12:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46590 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388096AbeGKXMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 19:12:24 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AB0FBE33;
        Wed, 11 Jul 2018 23:05:48 +0000 (UTC)
Date:   Wed, 11 Jul 2018 16:05:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     NeilBrown <neilb@suse.com>, LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wei Wang <wvw@google.com>, Stefan Agner <stefan@agner.ch>,
        Andrei Vagin <avagin@openvz.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yisheng Xie <ysxie@foxmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH] kernel.h: Add for_each_if()
Message-Id: <20180711160547.59f086a587c7f3c8d3c40f0f@linux-foundation.org>
In-Reply-To: <CAKMK7uFEYyD2ChWnO_0PS_rkK180dDoQ1g4J0UWRfchnYQxOTA@mail.gmail.com>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
        <20180709162509.29343-1-daniel.vetter@ffwll.ch>
        <20180709163001.8fb8148223a57bc46a13fbda@linux-foundation.org>
        <20180710075328.GG3008@phenom.ffwll.local>
        <871scbwfd4.fsf@notabene.neil.brown.name>
        <CAKMK7uFEYyD2ChWnO_0PS_rkK180dDoQ1g4J0UWRfchnYQxOTA@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018 13:51:08 +0200 Daniel Vetter <daniel@ffwll.ch> wrote:

> But I still have the situation that a bunch of maintainers acked this
> and Andrew Morton defacto nacked it, which I guess means I'll keep the
> macro in drm? The common way to go about this seems to be to just push
> the patch series with the ack in some pull request to Linus and ignore
> the people who raised questions, but not really my thing.

Heh.

But, am I wrong?  Code which uses regular kernel style doesn't have
these issues.  We shouldn't be enabling irregular style - we should be
making such sites more regular.  The fact that the compiler generates a
nice warning in some cases simply helps us with that.



