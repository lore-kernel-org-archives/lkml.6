Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60830C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31EF12173B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sONi+1UF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbfAKGWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 01:22:18 -0500
Received: from mail-pg1-f175.google.com ([209.85.215.175]:46283 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbfAKGWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 01:22:18 -0500
Received: by mail-pg1-f175.google.com with SMTP id w7so5871364pgp.13;
        Thu, 10 Jan 2019 22:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TKxVymDvE3pjjKsVAivh8YgRlXQsX0wpxyRd8qrL6mw=;
        b=sONi+1UFwMDH3xgW8OH+0iZ0ZU/hZ0xKJ3XK5n3ca+eJehhBTnMaefT44T+TqdlcUx
         +9e0RVlsJ3KWuJGZlWioQS+pjLQ0q7n9kywMQZWGbQCQFK128pRO3EaRFo3yLaZe8PQU
         RDCLZcDwYfMA01NSecjGl6c5r0VAnrhaKDNAJBAtqk91Z92bFUdTwv+Ge8juuM+uoLsD
         6EtMUYnlHkRu2/+LxbO3gVEPowPyqAUfztyxgMvgaQPq8ImUD51GtbGG+a14pAiejNKu
         06PJAyy2af3iRVXyUxG4pMTuXKrqK7+rZmUv75u99BjsAeJOHYf6bep7HelBKhXaVgFm
         WaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TKxVymDvE3pjjKsVAivh8YgRlXQsX0wpxyRd8qrL6mw=;
        b=qhmiAT0flJmooOlnO/LyXhhIMm0B+SH+VTwtzritlXxVyqCJTyEnUZnJLJQCzYAf90
         X1Fp/bEPbQjUSxVTp2ExZ3dew5SyfVn2p86O4f9og4ZrOIJwV5OtyH1wmLl3DeH4EVJr
         87WC63raoJn3lYIa7ATAhox3ofdJ/JBVZtLpsLaiCbX8UdJ2ykxlPdo9n9lFktUYfqlx
         KsZW1kdB9otalar+/xvz+KkKA4gaxSsUuTW6bdgvuN/jKZwnUEz8f2iafvs6krG+1tE4
         LvLdSRzSNkeUvjJ/oXLhuQHLJzk8FOMJUwnkXLIQOGqyJrY4I6Gvtj2ntgejwCYU6q4R
         PQyA==
X-Gm-Message-State: AJcUuke/egcvuugiUNCEXuqj2RtGpZPczVOSY5G/NOZIZjpJNMRXk65A
        55E23fVCnfGI6vI8jL2SJxN6GBKY7WzdXFT7rbQ=
X-Google-Smtp-Source: ALg8bN4zthmqwngElNQd6jLVnlpNEN5ke2ivE1JtfOxUiySTFOrBZfQ9hew9YyCE9kLn5T5ZiiWOa+cLJnOW2r2Z+zs=
X-Received: by 2002:a63:61c8:: with SMTP id v191mr12354036pgb.242.1547187736849;
 Thu, 10 Jan 2019 22:22:16 -0800 (PST)
MIME-Version: 1.0
References: <1547159098-19011-1-git-send-email-pshilov@microsoft.com>
In-Reply-To: <1547159098-19011-1-git-send-email-pshilov@microsoft.com>
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 11 Jan 2019 00:22:05 -0600
Message-ID: <CAH2r5msHUUrOjOek5dLePs_NKRQ3NYGyYNvMPOt8_DD68Qpeaw@mail.gmail.com>
Subject: Fwd: [PATCH 0/7] SMB3 credit flow control handling and writeback fixes
To:     bfoster@redhat.com, Jeff Layton <jlayton@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Pavel Shilovsky <piastryyy@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an important series, addressing various problems with
crediting (flow control) but more importantly patches 4 and 7 deal
with error cases in writeback, in writepages and writepage which may
be of more general interest.     Brian and Jeff have changed loosely
related code in the VFS and may have insight into whether additional
changes would be helpful beyond what Pavel has done in patches 4 and 7
in this series.

---------- Forwarded message ---------
From: Pavel Shilovsky <piastryyy@gmail.com>
Date: Thu, Jan 10, 2019 at 4:25 PM
Subject: [PATCH 0/7] SMB3 credit flow control handling and writeback fixes
To: <linux-cifs@vger.kernel.org>
Cc: Steve French <smfrench@gmail.com>, Ronnie Sahlberg <lsahlber@redhat.com>


This is the series of patches that address few problems with the current code.

Patch #1 adjusts credits properly for MTU credits if we didn't use all the
credits taken for an operation. This prevents loosing credits in error paths.

Patch #2 removes resetting credit number to 1 if server didn't grant us
any credits for the compounding chain. The current code didn't follow
the protocol correctly.

Patch #3 fixes credits handling for compounded requests by taking
one credit per part of the chain. All error paths that return credits
back are fixed accordingly.

Patch #4 fixes hiding EINTR error code returned after an interrupted attemp
to send SMB packet through the network.

Patch #5 removes wrong assumption that the server grants us one credit
for a cancelled request and parse the actual response to get the credit
number.

Patch #6 moves process credits granted by the server in the demultiplex
thread in order to avoid races with reconnects.

Patch #7 addresses few problems in writeback code, in particular related
to interrupted error code returned by the transport layer.

Patches #1-4 as marked for stable. Reviews are welcome.

Pavel Shilovsky (7):
  CIFS: Fix adjustment of credits for MTU requests
  CIFS: Do not set credits to 1 if the server didn't grant anything
  CIFS: Fix credit computation for compounded requests
  CIFS: Do not hide EINTR while sending network packets
  CIFS: Fix credits calculation for cancelled requests
  CIFS: Move credit processing to mid callbacks for SMB3
  CIFS: Fix error paths in writeback code

 fs/cifs/cifsglob.h  |  20 +++++++++
 fs/cifs/cifssmb.c   |   7 +--
 fs/cifs/file.c      |  29 ++++++++++---
 fs/cifs/inode.c     |  10 +++++
 fs/cifs/smb2pdu.c   |   8 +++-
 fs/cifs/transport.c | 122 +++++++++++++++++++++++++++++++++++++++-------------
 6 files changed, 155 insertions(+), 41 deletions(-)

--
2.7.4



-- 
Thanks,

Steve
