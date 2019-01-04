Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288A8C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2739218D3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IttU7/pD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfADUli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 15:41:38 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35441 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfADUlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 15:41:37 -0500
Received: by mail-vs1-f66.google.com with SMTP id e7so23396364vsc.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 12:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=iYKZYw9pBbs+9M1bv1xHHmg2hwlGwpPr6KW4wutdFrE=;
        b=IttU7/pDppjWUeGDwEevTCiWMCD6at5Wn5a61ygivQcrbCUb5THZTR4M2XvuD2IAeu
         4tggkypMhz2mAe8NZCt6HYscdeddDLAwZYPvKUMxn5G1Pa/jJFlXYxmWzO+Z4Uvz048/
         IEGh8EQx8i+DDTQ3QTpGzDz4e4p3094PqmekaIedFBTwVeIj5DpZrWF2GNUAoew1S6I2
         TNkO70nI07rNN0417f6T7szhLDyI+yQbjwH1MftWjB8i/pzRpw1OkKQaX8wqGKgPZHxu
         juyAsiQ+ucSXsrYTAaUbJxPl8QvQblrDfwBvY0ltgrAtCgcLgNeqzg8iUqYQgO/o75l0
         n6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=iYKZYw9pBbs+9M1bv1xHHmg2hwlGwpPr6KW4wutdFrE=;
        b=ggze9Yq/bKYvgh4xQKvQOii9e9rAVvxj5nCEysXYwczc0O6ZqV4IkEiJXKa7cVJkLy
         3QGtYOKvqK4Xbwa3nIMjm5X9pEJoExUDaiXeVa5GyLGZAOuntUpZCSUh8dzyuJthc7hF
         VYFVuKD6if454/oY5+EVn5ESsRaIyLI84tfUY2UT6qz38AWTejDifGSP5QRPPAYULoqG
         3vVGUFeBJSRiSSwoKWuAKIgbKfW4+F/XiggU9J4ChCsg686Q9Obbyw78pw+Sr9Mj2Hmr
         dCGeD6rkY+ItrpvxyhUE5Sxfq4fBjQjcugSrxESE9mDoX8i2Ags4RB4C5z2YlnEPMke2
         yCOg==
X-Gm-Message-State: AJcUukejahuTb0d32dhF2xFdOsN+KFOaPTnVrP94Yc9TiXKmguAAY2lz
        SJfs+fAfixCpHgr0o56S/vg0SbHdV7sYwLfQr8usfw==
X-Google-Smtp-Source: AFSGD/XTLTKwTXB+LqysC0tcuESde8OSg3gWakqcaTABLBlTWgLmo71793lxt8EbbftHWLh6dIwnsy7hvwlM6dmvpRU=
X-Received: by 2002:a67:c104:: with SMTP id d4mr21961178vsj.171.1546634495753;
 Fri, 04 Jan 2019 12:41:35 -0800 (PST)
MIME-Version: 1.0
References: <20181219071420.GC2628@infradead.org> <20181219021953.GD31274@dastard>
 <20181219193005.GB6889@mit.edu> <20181219213552.GO6311@dastard>
 <20181220220158.GC2360@mit.edu> <20181221070447.GA21687@infradead.org>
 <20181221154714.GA26547@mit.edu> <CAHk-=wgdzWgoPSuHeVcqmGE1hB3Gan72r2_AhtC14e60=z45yg@mail.gmail.com>
 <20181222041712.GC26547@mit.edu> <20181223041007.GL10600@bombadil.infradead.org>
 <20181223044553.GG26547@mit.edu>
In-Reply-To: <20181223044553.GG26547@mit.edu>
From:   Daniel Colascione <dancol@google.com>
Date:   Fri, 4 Jan 2019 12:41:24 -0800
Message-ID: <CAKOZuesHHSRCzQEtGEQbm7v7j53hAjkJq-8Pgcyk+M40o-ia0g@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] fs-verity: add a documentation file
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 8:46 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Sat, Dec 22, 2018 at 08:10:07PM -0800, Matthew Wilcox wrote:
> > Pretty much every file format has the ability to put arbitrary blocks
> > of information into a file somewhere the tools which don't know about
> > it will skip it.  For example, ZIP "includes an extra field facility
> > within file headers, which can be used to store extra data not defined
> > by existing ZIP specifications, and which allow compliant archivers tha=
t
> > do not recognize the fields to safely skip them. Header IDs 0=E2=80=933=
1 are
> > reserved for use by PKWARE. The remaining IDs can be used by third-part=
y
> > vendors for proprietary usage. " (Wikipedia)
> >
> > ELF, PNG, PDF and many other formats have the ability to put data
> > _somewhere_.  It might not be at the tail of the file, but there's
> > somewhere to do it.
> >
> > (I appreciate this isn't what Linus is asking for, but I'm pointing out
> > that this is by no means as intractable as you make it sound.)
>
> That design would require the fs-verity code to know the type of eacho
> file, and where to find the in-band Merkle tree for each file type
> that we wanted to support.  And if you wanted to use fs-verity to
> protect a sudoers text configuration file (for example), we'd have to
> teach sudo how to ignore the userspace visible Merkle tree.

I'm pretty late to the game, but I just want to bring up one approach
that I'm not sure people have previously considered. You can't put the
verification blob in an xattr due to xattr size limits, but you *can*
put a filename in an xattr. What if, at open time, fs-verity looked
for a specially-named xattr attached to a file, resolved that name
like a symlink target, opened the pointed-to file, and just used
*that* as the authentication blob? It'd also be possible to teach
unlink to delete the pointed-to file when the pointer file is deleted
--- sort of like a simple and stupid kind of data fork.

For example, if you wanted to secure /usr/bin/emacs, you could set an
security.fsverify.verification_file xattr (in the system namespace
because the xattr has special semantics) to
"/.verification-blobs/@usr@bin@emacs.hashtree" or something like that.
Then, open(2) on /usr/bin/emacs would, internally to VFS, also open
/.verification-blobs/@usr@bin@emacs.hashtree and read verification
data from it, transparently to both users and the underlying
filesystem. If someone deleted /usr/bin/emacs, VFS would automatically
delete /.verification-blobs/@usr@bin@emacs.hashtree. If
/.verification-blobs/@usr@bin@emacs.hashtree didn't exist at time of
open(2) of /usr/bin/emacs, or couldn't be opened for whatever reason,
the open(2) of /usr/bin/emacs would fail.

ISTM that a scheme like this would give you some of the advantages of
jumbo xattrs, but with much less implementation complexity. If
someone's proposed something like this before, sorry for the noise.
