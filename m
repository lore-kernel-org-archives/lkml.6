Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6863C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 16:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A999021A4A
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 16:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730954AbfBPQ0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 11:26:35 -0500
Received: from icebox.esperi.org.uk ([81.187.191.129]:49366 "EHLO
        mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbfBPQ0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 11:26:34 -0500
Received: from loom (nix@sidle.srvr.nix [192.168.14.8])
        by mail.esperi.org.uk (8.15.2/8.15.2) with ESMTP id x1GGJLSV017585;
        Sat, 16 Feb 2019 16:19:21 GMT
From:   Nix <nix@esperi.org.uk>
To:     johan@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 4.20.7: pl2303 not working (post-4.19 regression) (limited info so far, not yet bisected)
Emacs:  if it payed rent for disk space, you'd be rich.
Date:   Sat, 16 Feb 2019 16:26:30 +0000
Message-ID: <87o97bu2bt.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-DCC-URT-Metrics: loom 1060; Body=3 Fuz1=3 Fuz2=3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So I just tried to connect up to my ancient Soekris firewall's serial
console to try to bisect a problem where it stopped booting in 4.20, and
found I couldn't.

minicom says:

minicom: cannot open /dev/ttyUSB0: Input/output error

and in the dmesg we see

[705576.028170] pl2303 ttyUSB0: failed to submit interrupt urb: -28

Booting to 4.19, everything works fine. (A random GalliumOS Chromebook
running 4.9.4 works fine too, not that that confirmation is terribly
useful.)

This is an extremely preliminary report in case it's instantly obvious
what's going on: I'll do enough investigation to produce an actually
useful bug report, including bisecting this, after I've bisected the
*other* non-booting bug, but that might not be until next weekend. (All
this for a firewall I was trying to decommission! bah :) )
