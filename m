Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8673EC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A99208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QBB3CABK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36A99208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756254AbeFOQ6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 12:58:15 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:39564 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754672AbeFOQ6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 12:58:13 -0400
Received: by mail-ot0-f196.google.com with SMTP id l15-v6so11715317oth.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 09:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bmsVLiVIIp4+5TD+qD7SiY+piAjmxRyd4E0p+EzmzmM=;
        b=QBB3CABKqqQpJcQN7ztjzkrzn8LOdSzIuIABj2BTWbkERf1/69UXTkrzaAdeCfjjK5
         lHCeRoGXJBwhrPDQvosEADliBHRb2cMohVezhaBaLr2MXXyUIMCSZ0tibv2SBxFOyOej
         gxdLrVCxwJw7IA1zMS3gJAQIxcrMH+zqGCnarvB+9/xIqFfxOQ1leJIqVTJcXJH1/0e0
         2ESI3uG3zVuDqcXYxiQCXockVQhC51ErhSPjvhZPL2195s+XEYbeca+cDwqLxxmF782F
         gofYtXhWFruoR0v6BPWObw/VMWpVoGqV5Sj8i60KLF0RP+aKBrZjGIqO4WIcmMrhkPhx
         JZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bmsVLiVIIp4+5TD+qD7SiY+piAjmxRyd4E0p+EzmzmM=;
        b=awkG+HAiMYzHFvRvkw0pj74yVCt34lkoIJxWkfgUN4dlWUvwWxhB6Drj/6FSA2jpfc
         jPUD7D8f2lpN2EJoLpWRWKqlg76usCJoCxzTmgrD68OSROqkv8ToCyAG2uRp9uxeYwZ4
         C7CnYZKPV4Se2mBB4lr3jdkdTz/m8nHk7KqWGgpW9PUuZMqbaLON9Ng+MR/qrv3yXYPK
         3aG2Ps7WYyTlIbWwF4G+tlKQlw5y/ym2aZWAttT8vv6oMXxUjcuoZHA4NU2Ijk9vjur5
         yztnEc8tLqvF9YqtFuN8qRXQrxT/CPCPVKqvKdUy4Y/wDwm+ongf/30VOjj2XUNMeZPx
         /E+Q==
X-Gm-Message-State: APt69E1TaMDaSw00bcYOxlnvn/7skWmRSQGtGApDyg28O5Mmp5rQp9lO
        /if9EfjItmp+a/vBt99lO6oE2EvtTuS0RLjf70Qkfg==
X-Google-Smtp-Source: ADUXVKL8Mzk//Qnm28s0Na4o5m/W+sNNA7LS+JTreEfoymKpsgDBkRekjcApy8bmIsgrBVdNM/lja0UlDuKaEjBZLs8=
X-Received: by 2002:a9d:59c8:: with SMTP id u8-v6mr1589333otg.216.1529081892817;
 Fri, 15 Jun 2018 09:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180615152335.208202-1-jannh@google.com> <20180615164930.GE30522@ZenIV.linux.org.uk>
In-Reply-To: <20180615164930.GE30522@ZenIV.linux.org.uk>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 15 Jun 2018 18:58:01 +0200
Message-ID: <CAG48ez0x+d78yUc3FxHcQOtJRCF1j3Af+iR=UojnDrqqYzzTcg@mail.gmail.com>
Subject: Re: [PATCH] sg, bsg: mitigate read/write abuse, block uaccess in release
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     axboe@kernel.dk, fujita.tomonori@lab.ntt.co.jp,
        dgilbert@interlog.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 6:49 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Fri, Jun 15, 2018 at 05:23:35PM +0200, Jann Horn wrote:
> > As Al Viro noted in commit 128394eff343 ("sg_write()/bsg_write() is not fit
> > to be called under KERNEL_DS"), sg and bsg improperly access userspace
> > memory outside the provided buffer, permitting kernel memory corruption via
> > splice().
> > But they don't just do it on ->write(), also on ->read() and (in the case
> > of bsg) even on ->release().
> >
> > As a band-aid, make sure that the ->read() and ->write() handlers can not
> > be called in weird contexts (kernel context or credentials different from
> > file opener), like for ib_safe_file_access().
> > Also, completely prevent user memory accesses from ->release().
>
> Band-aid it is, and a bloody awful one, at that.  What the hell is going on
> in bsg_put_device() and can it _ever_ hit that call chain?  I.e.
>         bsg_release()
>                 bsg_put_device()
>                         blk_complete_sgv4_hdr_rq()
>                                 ->complete_rq()
>                                         copy_to_user()
> If it can, the whole thing is FUBAR by design - ->release() may bloody well
> be called in a context that has no userspace at all.
>
> This is completely insane; what's going on there?

Perhaps I should have split my patch into two parts; it consists of
two somewhat related changes.

The first change is that ->read() and ->write() violate the normal
contract and, as a band-aid, should not be called in uaccess_kernel()
context or with changed creds.

The second change is an actual fix: AFAICS ->release() accidentally
accessed userspace, which I've fixed using the added "cleaning_up"
parameter.
