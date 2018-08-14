Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A8BC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 401962171F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Q6zBm5mm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 401962171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbeHNXee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 19:34:34 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46937 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbeHNXed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 19:34:33 -0400
Received: by mail-lf1-f67.google.com with SMTP id l16-v6so14761107lfc.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 13:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=f/0JMfFT+vqrP3647F0HUaPBFsK0U+sbwCtRApDcoV8=;
        b=Q6zBm5mmWpv2yZxtw4x30UUQg7wLXilslfDxsydadgjF7gs8a5Nvwyy5rb1ZNWCxG7
         Z6C6rUYUSwzv4YnEawx3xDyAQcEssiuJ5HN8B9T0Vh9DkgjxbetkS8TB2h1uB2bPlG8/
         C+iO3wVgQlbPQgyFl3yNyO1tQR25HJp0Q5DLCfj22Af5YL0sgpAWSPDZp2MAQYSouXJe
         HSh9I/nxV61GtmfMW/TxNrfILIONnFGBDoFwMKjXi942KBEG1tISEC65EHmy0R1Tc5ra
         oRGiNUC5zjkkkUXObLx5fWr22jEA22k1xAZmFA5B/u+yP3O8ecemDRzwnqFTTsl5ipvV
         TPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=f/0JMfFT+vqrP3647F0HUaPBFsK0U+sbwCtRApDcoV8=;
        b=BpfS9B2rJIENr7M/dkDZGP3j6W2F4S3UNyUqhglGtA+2W6kONznFhGgp1n1rskKEAu
         YOW+E7S/z+fgMMfjrlBnFHvHPXpzBILcFSULquKqdE+cMd4vx5CQfjjxvuFcu8qNUwxZ
         Za3XAF7+/wC/KRSjIq1ya4EwlE5filPls2CwZx2ghHVMO4gpX4TjF7JX7LChI/mG1Y4y
         XjaXZvaGeD/f3bxfcaFcOONhJ97m43am5KQIFhqMNQjls41lI7Cyc3mTN8o4xc+vi93O
         qXcjiFzOsWvjhy7h1Rh5Hn+9tkGxEmwJWvnQGy77YXfyk0MRniXTnOBRHBhOU7uhtg1k
         a2HA==
X-Gm-Message-State: AOUpUlEmpAZabrVGrFLWmg421vAcXVyaxYVXwEhTp3oHhqsnv4mpH7UO
        aY2rvnifMjEGK4rDXDUI9YtCxeHoINAYx5f2WhPh
X-Google-Smtp-Source: AA+uWPynw+wQsW4y4Lek9QyatPXSWGoLpMowtX0aiJ/2k/YBOVJcTAVkrTxQhO2LVwzIcKPYWkw52FaRQ64f9Qs8x1Q=
X-Received: by 2002:ac2:4308:: with SMTP id l8-v6mr15221663lfh.35.1534279535830;
 Tue, 14 Aug 2018 13:45:35 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 14 Aug 2018 16:45:24 -0400
Message-ID: <CAHC9VhT9X+OQEjE38iesRKtZm9w6V0qo=Cyf6kwQf3MnPP_NDw@mail.gmail.com>
Subject: [GIT PULL] SELinux patches for v4.19
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

There are 16 patches in the SELinux PR for v4.19 but really only one
that is of any significance.  That one patch is by nixiaoming and
fixes a few places where we were not properly cleaning up dentry and
inode objects in the selinuxfs error handling code.  The rest are
either printk->pr_* conversions, constification tweaks, and a minor
tweak to MAINTAINERS.

Everything passes the selinux-testsuite and looks to merge cleanly
against your master branch.

Please pull, thanks.
-Paul
--
The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

 Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20180814

for you to fetch changes up to 7e4237faa7213c1cc1d0aa65a44c67ba4729ce9f:

 selinux: cleanup dentry and inodes on error in selinuxfs
   (2018-08-07 17:26:25 -0400)

----------------------------------------------------------------
selinux/stable-4.18 PR 20180814

----------------------------------------------------------------
Eric Biggers (1):
     selinux: constify write_op[]

Paul Moore (1):
     MAINTAINERS: update the LSM and SELinux subsystems

nixiaoming (1):
     selinux: cleanup dentry and inodes on error in selinuxfs

peter enderborg (13):
     selinux: Cleanup printk logging in conditional
     selinux: Cleanup printk logging in ebitmap
     selinux: Cleanup printk logging in policydb
     selinux: Cleanup printk logging in hooks
     selinux: Cleanup printk logging in avtab
     selinux: Cleanup printk logging in services
     selinux: Cleanup printk logging in selinuxfs
     selinux: Cleanup printk logging in netlink
     selinux: Cleanup printk logging in sidtab
     selinux: Cleanup printk logging in netport
     selinux: Cleanup printk logging in netif
     selinux: Cleanup printk logging in avc
     selinux: Cleanup printk logging in netnode

MAINTAINERS                       |  1 +
security/selinux/avc.c            |  2 +-
security/selinux/hooks.c          | 68 ++++++++++++++---------------
security/selinux/netif.c          | 11 ++---
security/selinux/netlink.c        |  2 +-
security/selinux/netnode.c        |  5 +--
security/selinux/netport.c        |  5 +--
security/selinux/selinuxfs.c      | 45 +++++++++++++------
security/selinux/ss/avtab.c       | 51 +++++++++++-----------
security/selinux/ss/conditional.c | 16 +++----
security/selinux/ss/ebitmap.c     | 15 +++----
security/selinux/ss/policydb.c    | 91 ++++++++++++++++++-----------------
security/selinux/ss/services.c    | 71 +++++++++++++++---------------
security/selinux/ss/sidtab.c      |  5 +--
14 files changed, 199 insertions(+), 189 deletions(-)

--
paul moore
www.paul-moore.com
