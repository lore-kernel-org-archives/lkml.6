Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C7EC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 16:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAAAC217F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 16:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbeLWQt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 11:49:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:47510 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725308AbeLWQt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 11:49:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EE46DAEEA;
        Sun, 23 Dec 2018 16:49:54 +0000 (UTC)
Date:   Sun, 23 Dec 2018 17:49:54 +0100
From:   Marcus Meissner <meissner@suse.de>
To:     linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        gregkh@linuxfoundation.org
Subject: FYI: Userland breakage caused by udev bind commit
Message-ID: <20181223164954.hib4lbchftspidsd@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: SUSE Linux GmbH, GF: =?iso-8859-1?Q?Felix_?=
 =?iso-8859-1?Q?Imend=F6rffer=2C_Jane_Smithard=2C_Graham_Norton=2C_HRB_212?=
 =?iso-8859-1?Q?84_=28AG_N=FCrnberg=29?=
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am the maintainer of libmtp and libgphoto2

Some months ago I was made aware of this bug:
	https://bugs.kde.org/show_bug.cgi?id=387454

This was fallout identified to come from this kernel commit:

	commit 1455cf8dbfd06aa7651dcfccbadb7a093944ca65
	Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
	Date:   Wed Jul 19 17:24:30 2017 -0700

If distributions would be using libmtp and libgphoto2 udev rules
that just triggered on "add" events, and not the new "bind" events,
the missing "attribute tagging" of the "bind" events would confused the
KDE Solid device detection and make the devices no longer detected.

This did not affect distributions that rely on the newer "hwdb"
device detection method.

I have released fixed libmtp and libgphoto2 versions in November, so
this is under control, but wanted to bring this up as a "kernel caused
userland breakage".

Ciao, Marcus
