Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5F6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58F922081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58F922081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbeK1VKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 16:10:15 -0500
Received: from [195.159.176.226] ([195.159.176.226]:58718 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbeK1VKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 16:10:15 -0500
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <glk-linux-kernel-4@m.gmane.org>)
        id 1gRwkB-0005mI-Cm
        for linux-kernel@vger.kernel.org; Wed, 28 Nov 2018 11:06:55 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   "Andrey Jr. Melnikov" <temnota.am@gmail.com>
Subject: Re: ext4 file system corruption with v4.19.3 / v4.19.4
Date:   Wed, 28 Nov 2018 13:02:56 +0300
Message-ID: <en52df-5dh.ln1@banana.localnet>
References: <065643a0-f9aa-a361-715a-03ca978d9228@roeck-us.net> <b43fb902-9b64-22d9-25ca-c970b3842a43@roeck-us.net> <vb31df-25g.ln1@banana.localnet> <20181128041555.GE31885@thunk.org>
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: tin/2.2.1-20140504 ("Tober an Righ") (UNIX) (Linux/4.3.3-bananian (armv7l))
Cc:     linux-ext4@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In gmane.comp.file-systems.ext4 Theodore Y. Ts'o <tytso@mit.edu> wrote:
> On Wed, Nov 28, 2018 at 03:16:33AM +0300, Andrey Jr. Melnikov wrote:
> > Corrupted inodes - always directory, not touched at least year or
> > more for writing. Something wrong when updating atime?

> We're not sure.  The frustrating thing is that it's not reproducing
> for me.  I run extensive regression tests, and I'm using 4.19 on my
> development laptop without notcing any problems.  If I could reproduce
> it, I could debug it, but since I can't, I need to rely on those who
> are seeing the problem to help pinpoint the problem.

My workstation hit this bug every time after boot. If you have an idea - I
may test it.

> I'm trying to figure out common factors from those people who are
> reporting problems.

> (a) What distribution are you running (it appears that many people
> reporting problems are running Ubuntu, but this may be a sampling
> issue; lots of people run Ubuntu)?  (For the record, I'm using Debian
> Testing.)
Debian sid but self-build kernel from ubuntu mainline-ppa.

> (b) What hardware are you using?  (SSD?  SATA-attached?
> NVMe-attached?)
SATA HDD WDC WD20EZRZ-00Z5HB0.

> (c) Are you using LVM?  LUKS (e.g., disk encrypted)?
No and no. Plain ext4.
-- cut --
debugfs:  features 
Filesystem features: has_journal ext_attr resize_inode dir_index filetype
needs_recovery extent 64bit flex_bg sparse_super large_file huge_file
dir_nlink extra_isize metadata_csum
-- cut --

> (d) are you using discard?  One theory is a recent discard change may
> be in play.   How do you use discard?   (mount option, fstrim, etc.)

no

