Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D66ECDE44
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 19:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ECAB21473
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 19:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ECAB21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbeJGChV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 22:37:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60992 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbeJGChV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 22:37:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 25E2B308212A;
        Sat,  6 Oct 2018 19:32:50 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DFFD85DA60;
        Sat,  6 Oct 2018 19:32:49 +0000 (UTC)
Received: from zmail19.collab.prod.int.phx2.redhat.com (zmail19.collab.prod.int.phx2.redhat.com [10.5.83.22])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id A1FA11809545;
        Sat,  6 Oct 2018 19:32:49 +0000 (UTC)
Date:   Sat, 6 Oct 2018 15:32:48 -0400 (EDT)
From:   Rodrigo Freire <rfreire@redhat.com>
To:     Steve French <smfrench@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        Pavel Shilovsky <piastryyy@gmail.com>
Message-ID: <390397598.33123368.1538854368976.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAH2r5mvXVDfYdJxPKLRJ0QAb_6mUHo4cfhxmkA7c19_GOR0p_Q@mail.gmail.com>
References: <ad6b338c900a17c4ecb1655a42b954221f242be2.1538480816.git.rfreire@redhat.com> <CAH2r5mtu9XbQfR=QevDqu36ZRYah1hrRGSQyynCfr82PRyunwQ@mail.gmail.com> <194690850.32402710.1538508513975.JavaMail.zimbra@redhat.com> <CAH2r5ms814MUNWVZNfCTuSO2LQZsmCs5N1nwgdVuhxtMctRE3Q@mail.gmail.com> <697659653.32427271.1538515234390.JavaMail.zimbra@redhat.com> <CAH2r5muV-vC6twZbNQQ3DHoXJTdaUwhzZi7YH+rhxr0BiMseJQ@mail.gmail.com> <633521295.32428133.1538517226400.JavaMail.zimbra@redhat.com> <CAH2r5mvXVDfYdJxPKLRJ0QAb_6mUHo4cfhxmkA7c19_GOR0p_Q@mail.gmail.com>
Subject: Re: [PATCH v2] CIFS: Print message when attempting a mount
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.97.116.29, 10.4.195.25]
Thread-Topic: CIFS: Print message when attempting a mount
Thread-Index: 789N7b2sfdeiFTzgkcrcPU7Ia3zNlg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Sat, 06 Oct 2018 19:32:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve! o/ 

Appreciate your time and review. 

For a v3, what would you like more: a pr_info() straight away in the code
for the message, or, writing a new cifs_info() function wrapping
over pr_info, like we have in cifs_dbg (which translates to pr_debug or pr_err)?

Waiting for your comments. Thanks!

---
Rodrigo Freire - Principal Technical Account Manager
GLOBAL CUSTOMER SUCCESS - Partnering with you to help achieve your business goals
redhat.com | TRIED. TESTED. TRUSTED. | redhat.com/trusted 

----- Original Message ----- 

> From: "Steve French" <smfrench@gmail.com>
> To: rfreire@redhat.com
> Cc: "LKML" <linux-kernel@vger.kernel.org>, "Steve French"
> <sfrench@samba.org>, "CIFS" <linux-cifs@vger.kernel.org>, "Pavel Shilovsky"
> <piastryyy@gmail.com>
> Sent: Saturday, October 6, 2018 4:09:30 PM
> Subject: Re: [PATCH v2] CIFS: Print message when attempting a mount

> On Tue, Oct 2, 2018 at 4:53 PM Rodrigo Freire <rfreire@redhat.com> wrote:
> >
> > Hi hi again Steve \o
> >
> > I do see potential for a ftrace rewrite for the cifs_dbg messages.

> Was looking at this on current kernels and debugging mount is probably
> fine for developers (or users) - plenty of debug messages get printed
> via the dynamic ftrace points. In practice some would prefer less
> noisy trace logs so the minimum set for some would be something like
> this (which already works with current cifs). If we want to add some
> default log messages on mount to dmesg instead of the trace-cmd log,
> maybe we should log them at a slightly less noisy level (as we see
> with xfs and btrfs) so they will be more log friendly

> root@smf-Thinkpad~/# trace-cmd record -e smb3_enter* -e smb3_exit*
> Hit Ctrl^C to stop recording

> root@smf-Thinkpad:~/# trace-cmd show
> # tracer: nop
> #
> # _-----=> irqs-off
> # / _----=> need-resched
> # | / _---=> hardirq/softirq
> # || / _--=> preempt-depth
> # ||| / delay
> # TASK-PID CPU# |||| TIMESTAMP FUNCTION
> # | | | |||| | |
> mount.cifs-14199 [002] .... 97642.728411: smb3_enter:
> cifs_mount: xid=20
> mount.cifs-14199 [002] .... 97642.728669: smb3_enter:
> cifs_get_smb_ses: xid=21
> mount.cifs-14199 [003] .... 97642.742336: smb3_exit_done:
> cifs_get_smb_ses: xid=21
> mount.cifs-14199 [003] .... 97642.742343: smb3_enter:
> cifs_setup_ipc: xid=22
> mount.cifs-14199 [003] .... 97642.742530: smb3_exit_done:
> cifs_setup_ipc: xid=22
> mount.cifs-14199 [003] .... 97642.742532: smb3_enter:
> cifs_get_tcon: xid=23
> mount.cifs-14199 [003] .... 97642.742674: smb3_exit_done:
> cifs_get_tcon: xid=23
> mount.cifs-14199 [003] .... 97642.743267: smb3_exit_done:
> cifs_mount: xid=20
> mount.cifs-14199 [003] .... 97642.743311: smb3_enter:
> cifs_root_iget: xid=24
> mount.cifs-14199 [003] .... 97642.743471: smb3_exit_done:
> cifs_root_iget: xid=24

> --
> Thanks,

> Steve
