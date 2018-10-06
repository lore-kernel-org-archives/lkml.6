Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9665BC67871
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 19:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47112208E7
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 19:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mch1gRRh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47112208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeJGCOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 22:14:10 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45774 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbeJGCOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 22:14:10 -0400
Received: by mail-pg1-f196.google.com with SMTP id t70-v6so6099283pgd.12;
        Sat, 06 Oct 2018 12:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xwO9Z1ujbh5aK0GlU/IP+KmXoCeb7rpEI22ixYR8poY=;
        b=mch1gRRhyb9okOyRoTu5tcLhyDELwMDHDHMlxNsnQZY8z12aDZ+u2aIx64bK8qcnIm
         agbKTQklO6qXNCjiUe/sQ58sw/WxoxLjcHtbsC9I4pqmfORAdPn7WcsFI0lCgqnv/TMG
         74DgrX0Wi0f3nBJnXsIz5A6A/S5v9YUBLqf+vcVaRnNEJtkHbYKaoYJDObeDdKMep+MH
         I3zPPI6ax6rsHSGTXRYpR89UOvKbkoC7km/HROOSv7WGY9/QIZ6jYjP6mnEpcJ/XBph+
         0zhhVmZKTowVKMS/ydUjFLWHulCS++pPIGF33i27qfgXE3Bz+q0URXK3yNmPgRfr6KV7
         Xv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xwO9Z1ujbh5aK0GlU/IP+KmXoCeb7rpEI22ixYR8poY=;
        b=WwSl/0CAXcWUOoaOSCRaPl5AcGYF6SHw4HrKtFdqH5jOXp1av/lXgBxQKOSne8oKWL
         zlPrsNApi/zGbBZuh0yO2BKRo5NsZpEqN0O37bfHXDVZSzNaYY38iCEkC+eNSiTS09pU
         1KZpwRcpTyjdDm/HHWGUE+noz43OV0ODhQlmWAFABUCgsjDl95atKuLwlO779tu30lnQ
         IChUspFonz9xhvkQDAn5MFSXnaSiq8F1i+J7likrjgDypRR25VpiiypEFuNvBzPeQ3BJ
         fK/tWlgX2VspGiuQVunDko/KPYxaoLwJj5vITeGOzB2HufAGYoypitnzWSMp56iaBHKd
         +lxQ==
X-Gm-Message-State: ABuFfoi4d566cPztFo5Z13EHSoa+UTV+qdFppqJLJvvr2VYkl6wjIJ6m
        vCPWcxPhLX+eug3mzYU5Ik/Po0gmSUbRDheEq2M=
X-Google-Smtp-Source: ACcGV63t4riU/cEmPgOdfbj/M84YDCRDg3MlwvjuCm2I4QsXBnLCfQbaX71rbCltGfUa0ilMGC2txQ2kAvF5vjHEkyA=
X-Received: by 2002:a62:9402:: with SMTP id m2-v6mr17952526pfe.255.1538852982526;
 Sat, 06 Oct 2018 12:09:42 -0700 (PDT)
MIME-Version: 1.0
References: <ad6b338c900a17c4ecb1655a42b954221f242be2.1538480816.git.rfreire@redhat.com>
 <CAH2r5mtu9XbQfR=QevDqu36ZRYah1hrRGSQyynCfr82PRyunwQ@mail.gmail.com>
 <194690850.32402710.1538508513975.JavaMail.zimbra@redhat.com>
 <CAH2r5ms814MUNWVZNfCTuSO2LQZsmCs5N1nwgdVuhxtMctRE3Q@mail.gmail.com>
 <697659653.32427271.1538515234390.JavaMail.zimbra@redhat.com>
 <CAH2r5muV-vC6twZbNQQ3DHoXJTdaUwhzZi7YH+rhxr0BiMseJQ@mail.gmail.com> <633521295.32428133.1538517226400.JavaMail.zimbra@redhat.com>
In-Reply-To: <633521295.32428133.1538517226400.JavaMail.zimbra@redhat.com>
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 6 Oct 2018 14:09:30 -0500
Message-ID: <CAH2r5mvXVDfYdJxPKLRJ0QAb_6mUHo4cfhxmkA7c19_GOR0p_Q@mail.gmail.com>
Subject: Re: [PATCH v2] CIFS: Print message when attempting a mount
To:     rfreire@redhat.com
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        Pavel Shilovsky <piastryyy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 2, 2018 at 4:53 PM Rodrigo Freire <rfreire@redhat.com> wrote:
>
> Hi hi again Steve \o
>
> I do see potential for a ftrace rewrite for the cifs_dbg messages.

Was looking at this on current kernels and debugging mount is probably
fine for developers (or users) - plenty of debug messages get printed
via the dynamic ftrace points.  In practice some would prefer less
noisy trace logs so the minimum set for some would be something like
this (which already works with current cifs).  If we want to add some
default log messages on mount to dmesg instead of the trace-cmd log,
maybe we should log them at a slightly less noisy level (as we see
with xfs and btrfs) so they will be more log friendly


root@smf-Thinkpad~/# trace-cmd record -e smb3_enter* -e smb3_exit*
Hit Ctrl^C to stop recording


root@smf-Thinkpad:~/# trace-cmd show
# tracer: nop
#
#                              _-----=> irqs-off
#                             / _----=> need-resched
#                            | / _---=> hardirq/softirq
#                            || / _--=> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |
      mount.cifs-14199 [002] .... 97642.728411: smb3_enter:
cifs_mount: xid=20
      mount.cifs-14199 [002] .... 97642.728669: smb3_enter:
cifs_get_smb_ses: xid=21
      mount.cifs-14199 [003] .... 97642.742336: smb3_exit_done:
cifs_get_smb_ses: xid=21
      mount.cifs-14199 [003] .... 97642.742343: smb3_enter:
cifs_setup_ipc: xid=22
      mount.cifs-14199 [003] .... 97642.742530: smb3_exit_done:
cifs_setup_ipc: xid=22
      mount.cifs-14199 [003] .... 97642.742532: smb3_enter:
cifs_get_tcon: xid=23
      mount.cifs-14199 [003] .... 97642.742674: smb3_exit_done:
cifs_get_tcon: xid=23
      mount.cifs-14199 [003] .... 97642.743267: smb3_exit_done:
cifs_mount: xid=20
      mount.cifs-14199 [003] .... 97642.743311: smb3_enter:
cifs_root_iget: xid=24
      mount.cifs-14199 [003] .... 97642.743471: smb3_exit_done:
cifs_root_iget: xid=24




-- 
Thanks,

Steve
