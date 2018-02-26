Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3220889-1519660154-2-16972916999361432377
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519660154; b=IeoKMrhCVXX8Pe/jpWKThcoAfaz36nf6dOLjwOogLi1BD/8
    aXSP4eTtVW/L7TxbuOv46WCIadQbt2oYV6kPBw2QH4vsfG5xtevge2PMXesAyBX8
    a90DK3FVTGXzn2Kq1jz9+olFgscvec48OevFG7j6JqawFel43+VzsbDU9wXjoC3R
    ht9jZWjvZItP5oiIleY9QsciG+7QxQcuFKZbw5YtDfyvn6+h2fnn6eLcncAK2nZ3
    j4wjAzXQz7LtNURmK4Vh44NbYx8QU7gwzOXT/ixV5WBbL7l6Z2w5bz1jhoOa8r0W
    mBalIibLK55nZvPxDmK+n7/VlloPLWdXrRmjV+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519660154; bh=0HH46sivTIdgogHhYG7wCaN5qSC3c4Vot/3MS1
    h3BeI=; b=gjDPUY7TyNocrGBe4SaoBkBVFqXreGMHb/t7dMiUCcHTYLXr9LXqSr
    bQa/gIHYCnSHHTFdqSWpfFrGpv5BlL39Y7kRdgx+EtK6Y+gewdscUVhxStuHVDc5
    FP4v89dOLFzsbJKh5dAD2J3mKleP3W4R4M9j6dNhRaZ6DS7qO8oJOMMm0x3mcLP8
    47eeL3G6bbVavMEIjnB6pIbYPmo+bN9sP9qyPGu6UgbwGKqqZtpXyeoGmJaDA9Kf
    9W7MsEL1+XdMwRtp9YsPvAQDHHWj1xhxNe4ULWpRQhdbfrn1VJVv2lQSfbYr+GRq
    +X2X8DRAdZrsGpve5Pe55wRhGxGD8R0Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b=f0v9TgGR x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dZe9wI/R;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b=f0v9TgGR x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dZe9wI/R;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752027AbeBZPsK (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 10:48:10 -0500
Received: from mail-oi0-f65.google.com ([209.85.218.65]:46526 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751746AbeBZPsI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 10:48:08 -0500
X-Google-Smtp-Source: AG47ELvcx5uHfqBU3t7HFm8KNPaIBL0bzh8/EAPtN2g9AuKkcTp2NXeqiiji1FHr63Sb2iaDVEvSJgU0wsHsPURWVWE=
MIME-Version: 1.0
In-Reply-To: <20180226100611.sgw2rucvv6yhzn5y@quack2.suse.cz>
References: <151943298533.29249.14597996053028346159.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151943300713.29249.545330864711927648.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180226100611.sgw2rucvv6yhzn5y@quack2.suse.cz>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 26 Feb 2018 07:48:07 -0800
Message-ID: <CAPcyv4jDNW=9dNPtmX2oiHhp9S7wr+w7DPONZsx-LnLhcLPesg@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] xfs, dax: introduce IS_FSDAX()
To: Jan Kara <jack@suse.cz>
Cc: linux-nvdimm@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kbuild test robot <fengguang.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 26, 2018 at 2:06 AM, Jan Kara <jack@suse.cz> wrote:
> On Fri 23-02-18 16:43:27, Dan Williams wrote:
>> Given that S_DAX is non-zero in the FS_DAX=n + DEV_DAX=y case, another
>> mechanism besides the plain IS_DAX() check to compile out dead
>> filesystem-dax code paths. Without IS_FSDAX() xfs will fail at link time
>> with:
>>
>>     ERROR: "dax_finish_sync_fault" [fs/xfs/xfs.ko] undefined!
>>     ERROR: "dax_iomap_fault" [fs/xfs/xfs.ko] undefined!
>>     ERROR: "dax_iomap_rw" [fs/xfs/xfs.ko] undefined!
>>
>> This compile failure was previously hidden by the fact that S_DAX was
>> erroneously defined to '0' in the FS_DAX=n + DEV_DAX=y case.
>>
>> Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
>> Cc: linux-xfs@vger.kernel.org
>> Cc: <stable@vger.kernel.org>
>> Reported-by: kbuild test robot <fengguang.wu@intel.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> As much as I appreciate that relying on compiler to optimize out dead
> branches results in nicer looking code this is an example where it
> backfires. Also having IS_DAX() and IS_FSDAX() doing almost the same, just
> not exactly the same, is IMHO a recipe for confusion (e.g. a casual reader
> could think why does ext4 get away with using IS_DAX while XFS has to use
> IS_FSDAX?). So I'd just prefer to handle this as is usual in other kernel
> areas - define empty stubs for all exported functions when CONFIG_FS_DAX is
> not enabled. That way code can stay without ugly ifdefs and we don't have
> to bother with IS_FSDAX vs IS_DAX distinction in filesystem code. Thoughts?
>

I think my patch is incomplete either way, because the current
IS_DAX() usages handle more than just compiling out calls to fs/dax.c
symbols. I.e. even if there were stubs for all fs/dax.c call outs call
there are still local usages of the helper. Lets kill IS_DAX() and
only have IS_FSDAX() and IS_DEVDAX() with the S_ISCHR() check. Any
issues with that?
