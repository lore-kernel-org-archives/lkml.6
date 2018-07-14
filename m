Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8363BECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 18:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3364220857
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 18:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="STjmcsjM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3364220857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbeGNTEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 15:04:06 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:45448 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbeGNTEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 15:04:06 -0400
Received: by mail-io0-f195.google.com with SMTP id l25-v6so34099868ioh.12;
        Sat, 14 Jul 2018 11:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=URaf0LRHl2qLFc5fB9szleAN3dJU49kVwj6cBmWcJVw=;
        b=STjmcsjMbxGsfqNeKYL4wQuAVlMatmyRSrt3OUrrSTfAxJAMqIfit+qv7Yu0k9vvej
         GeAryeKZ6IjdbmpIM/31nNfEb2PBv/4Jo5sNiyV4lsDRpm4kMx3qq6AgMCeXw59EqJRq
         C339U90+7DVFph2DeAzo7ScDvKgvfthDsWXSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=URaf0LRHl2qLFc5fB9szleAN3dJU49kVwj6cBmWcJVw=;
        b=qQI7Jvd4jeb2EPWLVOUFzUao4X/wEVUpJGpMsSAZRtA4faM4TFIvcwQgIMtmqunAba
         dGjklGVFaxPKo/oqWZVS8fYZzi+FIcw5kYqnSggJLxHrmKK9qnOyTfLxjShAglMtGPhz
         gRnQSgqw8rd3D2TxWtZJ6Puj/WvGl2/qajMfJkjVJfppXpzz847+ObQdMzQfv7ua/BWo
         kV4GpaXhcLDGwShGpsp8e56al/7PnwI7olSpCFlOsrSFdhRuQhamjSYWBliP+iXeV6Hz
         nF25s1R8nAb4rcOEXP6cHMT0xi+rQ05p7JHIxJ1eVsbBM954wrV6diDhBnWgE52ZtT9b
         Z9yQ==
X-Gm-Message-State: APt69E2lBeT7WNcuobho+AePIeCFt66ROZYxGMentqt61gdtUnJry+Yy
        5Dn2wHbMbgAUjJxNtgWSWdtZXz5TnIoYuV0h5RE=
X-Google-Smtp-Source: AAOMgpfPps75r6Ax700eeR0XvrByddXGAfhLZH3OsWOSwODffVfiXDWMB0izY2L4I3tJ+G7HmXU7SXqrVSs0ed7z0Ks=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr36924222iov.203.1531593848815;
 Sat, 14 Jul 2018 11:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <1530510723-24814-1-git-send-email-longman@redhat.com>
 <CA+55aFyH6dHw-7R3364dn32J4p7kxT=TqmnuozCn9_Bz-MHhxQ@mail.gmail.com>
 <20180702141811.ef027fd7d8087b7fb2ba0cce@linux-foundation.org>
 <1530570880.3179.9.camel@HansenPartnership.com> <20180702161925.1c717283dd2bd4a221bc987c@linux-foundation.org>
 <20180703091821.oiywpdxd6rhtxl4p@quack2.suse.cz> <20180714173516.uumlhs4wgfgrlc32@devuan>
 <CA+55aFw1vrsTjJyoq4Q3jBwv1nXaTkkmSbHO6vozWZuTc7_6Kg@mail.gmail.com>
 <20180714183445.GJ30522@ZenIV.linux.org.uk> <20180714183657.GK30522@ZenIV.linux.org.uk>
In-Reply-To: <20180714183657.GK30522@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 14 Jul 2018 11:43:57 -0700
Message-ID: <CA+55aFwPcoWFxgHb2TYGO3Mh2WyPfkhpwNAw7xxbar=ncb3Nuw@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] fs/dcache: Track & limit # of negative dentries
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Pavel Machek <pavel@ucw.cz>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Waiman Long <longman@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Larry Woodman <lwoodman@redhat.com>,
        "Wangkai (Kevin,C)" <wangkai86@huawei.com>,
        linux-mm <linux-mm@kvack.org>, Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2018 at 11:36 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> OK, this
>         /*
>          * No ordinary (disk based) filesystem counts links as inodes;
>          * but each new link needs a new dentry, pinning lowmem, and
>          * tmpfs dentries cannot be pruned until they are unlinked.
>          */
>         ret = shmem_reserve_inode(inode->i_sb);
>         if (ret)
>                 goto out;
> will probably help (on ramfs it won't, though).

Nobody who cares about memory use would use ramfs and then allow
random users on it.

I think you can exhaust memory more easily on ramfs by just writing a
huge file. Do we have any limits at all?

ramfs is fine for things like initramfs, but I think the comment says it all:

 * NOTE! This filesystem is probably most useful
 * not as a real filesystem, but as an example of
 * how virtual filesystems can be written.

and even that comment may have been more correct back in 2000 than it is today.

             Linus
