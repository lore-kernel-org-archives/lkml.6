Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CFAC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4831120857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxqtEoxp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4831120857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbeIEXxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 19:53:31 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43520 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbeIEXxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 19:53:31 -0400
Received: by mail-lf1-f65.google.com with SMTP id h64-v6so6965884lfi.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 12:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=4n8GrFZZqy+guYctRT93yjjBL4PhDuOq6JcKXuLxKKc=;
        b=IxqtEoxp466ResdIU8jM6orNRSshJL/2eKRtZuPKo/xXTjDGJ53ZnP4N7NqQ+bKKqf
         wo9Cma2MrB+i1xmMT4P9KpKTx7ObWtYJ1sf/3r1n/9eG4Jb/LxVwguqZeYkjMAppnkXU
         ItFWQ+6v21tnARYSL/17lMULn58ICETxc647CnRaH/OUghXCodp5DxihpzU68WPPTFpY
         hdddXNlWOFblFKNnA/XmxwIXQImi0Aca/zyFXf53UUBNVclvTuQdLGI7IZPA9E3KoIYN
         qltbS3MMKJnh8Ju2nJtfpdxTsNa7Lzj0RWeYUwy0vpxS8ZaELRFv+IfBHZ9dTBdCEXEc
         lzhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=4n8GrFZZqy+guYctRT93yjjBL4PhDuOq6JcKXuLxKKc=;
        b=lKXVukUhWivAz7llHsM6QspQoIIHaY28rhsfdETqgGgi+0/o/wTVOzAfnnAv9PaSZn
         SEiIRn9JsGeK6MfyZF/cba4tJnck+galzdU7MuL7WwwwJbQybuu7uDuFNBgz0Iotl4Os
         FTUIhJpVXSblMDSVz+jjCfaNzAE86Y5jGeci1XOM0J9M8opOiMKCojtWfyeXcXGhEbRg
         gAzCVmctaTu3H1gMNGlHBAbcrVzHboiT5lhn4j/ODbvTBcGey+Le0qKEjZEAAcMBafCW
         vB1lFqH1lBd80ftmEjhOF58VsY2nbQoFtdjj5T7oqs84nOKtbnp6JUcJuwAz4f37Fvzs
         JWaw==
X-Gm-Message-State: APzg51CWgfaEqda0pTtbGRpwzWutCgXVMSafilGYbX06LG0Il7H1M8Rf
        WyAzyO4P4/Mnn/34J0iEuX2QBYmEqKf8vN209uklXg8v
X-Google-Smtp-Source: ANB0Vda2Sec3YVi6L5avZ7Iv1p9e3R3Dp/Nhm5/WGeU2pczN0Wxj+E8eFEISmOn/TehGdQzoGiseVMe7ee8P5mYAdx8=
X-Received: by 2002:a19:124d:: with SMTP id h74-v6mr8440355lfi.107.1536175315657;
 Wed, 05 Sep 2018 12:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004f6b5805751a8189@google.com> <20180905085545.GD24902@quack2.suse.cz>
 <CAFqt6zZtjPFdfAGxp43oqN3=z9+vAGzdOvDcgFaU+05ffCGu7A@mail.gmail.com> <20180905133459.GF23909@thunk.org>
In-Reply-To: <20180905133459.GF23909@thunk.org>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Thu, 6 Sep 2018 00:54:50 +0530
Message-ID: <CAFqt6za5OvHgONOgpmhxS+YsYZyiXUhzpmOgZYyHWPHEO34QwQ@mail.gmail.com>
Subject: Re: linux-next test error
To:     "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        syzbot+87a05ae4accd500f5242@syzkaller.appspotmail.com,
        ak@linux.intel.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        mawilcox@microsoft.com, mgorman@techsingularity.net,
        syzkaller-bugs@googlegroups.com, tim.c.chen@linux.intel.com,
        zwisler@kernel.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 7:05 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Wed, Sep 05, 2018 at 03:20:16PM +0530, Souptick Joarder wrote:
> >
> > "fs: convert return type int to vm_fault_t" is still under
> > review/discusson and not yet merge
> > into linux-next. I am not seeing it into linux-next tree.Can you
> > please share the commit id ?
>
> It's at: 83c0adddcc6ed128168e7b87eaed0c21eac908e4 in the Linux Next
> branch.
>
> Dmitry, can you try reverting this commit and see if it makes the
> problem go away?
>
> Souptick, can we just NACK this patch and completely drop it from all
> trees?

Ok, I will correct it and post v3.

>
> I think we need to be a *lot* more careful about this vm_fault_t patch
> thing.  If you can't be bothered to run xfstests, we need to introduce
> a new function which replaces block_page_mkwrite() --- and then let
> each file system try to convert over to it at their own pace, after
> they've done regression testing.
>
>                                                 - Ted

Chris has his opinion,

block_page_mkwrite is only called by ext4 and nilfs2 anyway, so
converting both callers over should not be a problem, as long as
it actually is done properly.

Matthew's opinion in other mail thread -

> +vm_fault_t block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
> +                      get_block_t get_block, int *err)

I don't like returning both the errno and the vm_fault_t.  To me that's a
sign we need to rethink this interface.

I have two suggestions.  First, we could allocate a new VM_FAULT_NOSPC
bit.  Second, we could repurpose one of the existing bits, such as
VM_FAULT_RETRY for this purpose.

> -int ext4_page_mkwrite(struct vm_fault *vmf)
> +vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)

I also think perhaps we could start by _not_ converting block_page_mkwrite().
Just convert ext4_page_mkwrite(), and save converting block_page_mkwrite()
for later.

Which approach Shall I take ??
