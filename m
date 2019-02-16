Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42A4C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 20:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F91F21B1C
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 20:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733020AbfBPUqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 15:46:34 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:57535 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729018AbfBPUqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 15:46:34 -0500
X-Originating-IP: 141.70.45.131
Received: from localhost (hadi-gate-vlan-851.hadiko.whka.de [141.70.45.131])
        (Authenticated sender: hle@owl.eu.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id B46A0E0002;
        Sat, 16 Feb 2019 20:46:28 +0000 (UTC)
Date:   Sat, 16 Feb 2019 21:46:27 +0100
From:   Hugo Lefeuvre <hle@owl.eu.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
        Greg Hartman <ghartman@google.com>,
        Alistair Strachan <astrachan@google.com>,
        linux-kernel@vger.kernel.org,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH] staging/android: use multiple futex wait queues
Message-ID: <20190216204627.GA2173@behemoth.owl.eu.com.local>
References: <20190214173459.GA10737@behemoth.owl.eu.com.local>
 <20190214175053.GA11103@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214175053.GA11103@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Have you tested this?

I have finally set up a cuttlefish test env and tested both my first
patch set[0] and this patch (v2).

My first patch set works fine. I have nothing to say about it.

> Noticed any performance speedups or slow downs?

This patch doesn't work.

The boot process goes well. Overall, calls to vsoc_cond_wake are executed
slightly faster. However the system freezes at some point.

The graphical interface generates many calls to vsoc_cond_wake and wait,
so I suspect an issue with the locks. I will investigate this and come back
with an updated patch.

regards,
 Hugo

[0] https://lore.kernel.org/patchwork/patch/1039712/

-- 
                Hugo Lefeuvre (hle)    |    www.owl.eu.com
RSA4096_ 360B 03B3 BF27 4F4D 7A3F D5E8 14AA 1EB8 A247 3DFD
ed25519_ 37B2 6D38 0B25 B8A2 6B9F 3A65 A36F 5357 5F2D DC4C
