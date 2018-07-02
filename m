Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168C6C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C51E925DDE
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cp0ceE44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C51E925DDE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752342AbeGBN52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:57:28 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:41120 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751535AbeGBN50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:57:26 -0400
Received: by mail-oi0-f67.google.com with SMTP id k12-v6so2771981oiw.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 06:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iRmzmjgHNHK7Q3hcXhXWZuiHT81sGl3I5E8b3/aAkBc=;
        b=cp0ceE44rbtmefEYe72/TvsmvZJaNVx4vp4lsUctCW/XrkbUtsfS/22BBExB2DrPTx
         2hPGYCYuFV/pM1dQObp1ON8h0GEM7DuLTJvJ+9uVvD068KFG8P/fuWvOhdMEe+tskMGq
         Cuf2QoZ6fFnRmc+NtDdLvuCGdmYDnE31PyfQGSBq5E4E0rXT5nadP/pE4wRkVe6ZEMsg
         HLCWxBNeccOL6j35YM2cNS+ZowBz+RGCzChjxP+EDnlAHWaUtokzk3r3ISCtPP4o44F/
         DwzkOFN43T/V3RIgWltQRdj7/KhjcApqKjOEuqXnFv05d8Y04XbespCzOchByUcQfZQo
         FHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iRmzmjgHNHK7Q3hcXhXWZuiHT81sGl3I5E8b3/aAkBc=;
        b=bSGkEFaOBjkg2m8p3sIoAgYDsJAtEU6VbJL8ZkEfbufYzO+Sgxw4xDwobYhqkNP4kF
         8e5wCIqD2ljCq7Hj3jDJZ1CT1RgJyfxujS/vKvCDK6jsL5rBiZr8zy+GrEmKcJJJYyGG
         8Ou30Y+7Z8/VnvbZbr61FEqkxEoflO6pXNTFOkmYWistW6USkfdP9avKJ9vHlE7DaQVE
         scVcISUJUD0ferua9LFAwS0dAWVGarGVVBCyuDjra7Lv51iSG7t9+3hf99VTCRUsKadW
         MHSIT/zjff7uM5vgQKV+3IxHVMQAOAgmfxlihiqPaUjGtqx+2QC4VwAvaJu3S+EFsad+
         P8dg==
X-Gm-Message-State: APt69E0+NzpGXTA5jlO0ckXQzmrQP8Zxsx3lVZHzI6kpaJSw1DBEtl++
        0VOGnt+S2tcBf0e+CZkIQzkzwRH1b8vPzszFdWjEbw==
X-Google-Smtp-Source: AAOMgpciLzEy3hQQKjxwa7tS5bVJ4ioqkJUEKhyeavyWhR2P2JQ+BeSrEvE1zb4hHpMtZATqWymw/B7ir9ZfTO5L9HU=
X-Received: by 2002:aca:3002:: with SMTP id w2-v6mr14824120oiw.29.1530539845931;
 Mon, 02 Jul 2018 06:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180625163425.216965-1-jannh@google.com> <9d5d0cb7-5875-0814-835b-097db650b6a1@tycho.nsa.gov>
 <CAHC9VhQ7ep3HSw8iqWBsiW0hhZ-drVtk7bW1rA1uAyUrbm3PqA@mail.gmail.com> <CAHC9VhTcncUn3CgAgG-FiXyyoNiq5DdHF1cSYJeWpu8PvRXucw@mail.gmail.com>
In-Reply-To: <CAHC9VhTcncUn3CgAgG-FiXyyoNiq5DdHF1cSYJeWpu8PvRXucw@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 2 Jul 2018 15:57:14 +0200
Message-ID: <CAG48ez0GDpuFO1-uMv0GGoPjo08QSCv0sL5du2b7_mi0QFcE8Q@mail.gmail.com>
Subject: Re: [PATCH] selinux: move user accesses in selinuxfs out of locked regions
To:     Paul Moore <paul@paul-moore.com>
Cc:     Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        security@kernel.org, kernel list <linux-kernel@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 2:38 AM Paul Moore <paul@paul-moore.com> wrote:
>
> On Thu, Jun 28, 2018 at 8:23 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Tue, Jun 26, 2018 at 8:15 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > > On 06/25/2018 12:34 PM, Jann Horn wrote:
> > > > If a user is accessing a file in selinuxfs with a pointer to a userspace
> > > > buffer that is backed by e.g. a userfaultfd, the userspace access can
> > > > stall indefinitely, which can block fsi->mutex if it is held.
> > > >
> > > > For sel_read_policy(), remove the locking, since this method doesn't seem
> > > > to access anything that requires locking.
> > > >
> > > > For sel_read_bool(), move the user access below the locked region.
> > > >
> > > > For sel_write_bool() and sel_commit_bools_write(), move the user access
> > > > up above the locked region.
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > > Signed-off-by: Jann Horn <jannh@google.com>
> > >
> > > Only question I have is wrt the Fixes line, i.e. was this an issue until userfaultfd was introduced, and if not,
> > > do we need it to be back-ported any further than the commit which introduced it.
> >
> > Considering we are talking about v2.6.12 I have to wonder if anyone is
> > bothering with backports for kernels that old.  Even the RHEL-5.x
> > based systems are at least on v2.6.18.
> >
> > Regardless, I think this is fine to merge as-is; thanks everyone.
>
> FYI, I did have to remove the "fsi" variable from sel_read_policy() to
> keep the compiler happy.  Please double check to make sure your code
> compiles cleanly in the future.

Oof, don't know how I missed that. Sorry, I'll be more careful.
