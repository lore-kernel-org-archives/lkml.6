Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F5AC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 04:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95274218D9
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 04:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393161AbeLWEe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 23:34:56 -0500
Received: from dmz-mailsec-scanner-1.mit.edu ([18.9.25.12]:63482 "EHLO
        dmz-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389933AbeLWEe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 23:34:56 -0500
X-AuditID: 1209190c-7c5ff700000014b1-d2-5c1f106d88c3
Received: from mailhub-auth-2.mit.edu ( [18.7.62.36])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by dmz-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id EC.FD.05297.D601F1C5; Sat, 22 Dec 2018 23:34:54 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH-1.MIT.EDU [18.9.28.11])
        by mailhub-auth-2.mit.edu (8.14.7/8.9.2) with ESMTP id wBN4Yq6n020029;
        Sat, 22 Dec 2018 23:34:52 -0500
Received: from callcc.thunk.org (96-72-84-49-static.hfc.comcastbusiness.net [96.72.84.49] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id wBN4YnKb019905
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Dec 2018 23:34:50 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 790447A4704; Sat, 22 Dec 2018 23:34:49 -0500 (EST)
Date:   Sat, 22 Dec 2018 23:34:49 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
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
Subject: Re: [PATCH v2 01/12] fs-verity: add a documentation file
Message-ID: <20181223043449.GF26547@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>
References: <20181219071420.GC2628@infradead.org>
 <20181219021953.GD31274@dastard>
 <20181219193005.GB6889@mit.edu>
 <20181219213552.GO6311@dastard>
 <20181220220158.GC2360@mit.edu>
 <20181221070447.GA21687@infradead.org>
 <20181221154714.GA26547@mit.edu>
 <CAHk-=wgdzWgoPSuHeVcqmGE1hB3Gan72r2_AhtC14e60=z45yg@mail.gmail.com>
 <20181222041712.GC26547@mit.edu>
 <CAHk-=wgPz4dfq4sPWxHwMR3g_R3xHhWjofXTu8rV0QU2DP0JhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgPz4dfq4sPWxHwMR3g_R3xHhWjofXTu8rV0QU2DP0JhA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTURjHOffebXfDa8frzKP5QsNYWauUgvshQoPoIkQGfSgT9OZubrVN
        uXezFCQtoTIrIYucYWt9MFIpX8LKCSpmU6Mse0PSojRtVBbmC/hCO1rqt+c8v+f3PxzOQ5Ps
        gCKcNtvsomQTLDqlhmJVO2MMNhiduvXDTAhXUtam4AbGmhRcY+cg4Go9syTXU+omuKF7TpIr
        r/yg5F6593C+ykmK87R0UZz3eaeK63t8Q8l9vvRDxXU0dCgTAvluN+Jd9Q6+4U4sX3/3vJL3
        Xp+h+E/tDRTf7Bon+N/D/RQ/Xh+VrE7R7DCKFnOOKG3Zma4x/aroVWQ7V5/0lT1UFoDGoGKg
        phHchjoutoBioKFZWEOgknNT1OKhDqDm0dv/Dt8J9LHAp8IKCyXU7/b4a5qm4DpUXGjAbSVc
        j2qG5yhca2E8Gh99rcAuCV9TyNfTDTAIhono9uefBHYZuAl1XNDhGQbOUWjo7JRy8bImEo2c
        9hFYYGAQ6iofWkglYSx6P/9tQSbhGlQ1T+O2Gu5Hk2WTCtwOgTFo3AVLAetcITtXyM5l2QXI
        uyDSaM0zWAWzRRYzDHKGYLOJkiFus9Vs3ywaHfUA/6I6LOAhePY9qR1AGugCmHN1UamsQsiR
        c63tIIwmdCFMJBmdygYeyTLmmgTZlCY5LKLcDhBN6rTM9ExkKssYhdw8Ucr6j9bQlC6UmdF+
        OczCTMEuHhfFbFH6TyNoWoeY/FX+0CBJzBRPHjVb7MuYoNU4PMAfPopnGDlbsMrmzEXeDdaG
        hzKtGEAMTA7bkou3Mp0/EOcDof6nBDPTgf6pAP/OLtk+fzDhD9bsisDBdmEZhRcAbVbhA70+
        zRxxNSG65AnzIm2O5Iq8wbW7jxWdQPr8a8NfNzj+vHvrLR8b0V9Nju992t90OesRunazOtKz
        11FxkHKXBm8r/J384NPUROiVjYn3Jwaj3vy50pcyvz2+raLqZVK66t2t6lM37NbWopjJM/sO
        teZbwvWzdxzpkkuQVKd0lGwS4mJJSRb+AsIn7W5wAwAA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 02:47:22PM -0800, Linus Torvalds wrote:
> So I want to understand why this was made a filesystem operation in
> the first place. What's fs-specific about this implementation?

These are the things which are fs-specific.

*) We have to splice into the file system's readpage processing so we
   can verify the merkle tree hash before we mark the page up-to-date.
   This is most of the complexity involved in adding fs-verity
   support, and that's because both ext4 and f2fs have their own
   fs-specific readpage[s]() implementations, and both ext4 and f2fs
   also supports fscrypt, which *also* has to splice into readpage[s]().

*) The file system needs to define a file system feature bit in the
   superblock which means, "this file system uses fs-verity" --- so
   that old kernels will know that they need to refuse to mount the
   file system (f2fs) or mount the file system read-only (ext4).

*) The file system needs to define inode flag which is used to
   indicate "this is a fs-verity protected file".  This flag is not
   user-visible, so the file system just has to provide a single bit
   in the inode structure and a function which tests that bit.

*) Ext4 chose to have i_size on disk to be size of the data.  We did
   this so that the the fs-verity feature for ext4 could be a
   read-only compat feature.  (e.g., an old kernel can safely mount a
   file system with fs-verity protected files, but only for a
   read-only mount.)  This adds a bit more complexity for ext4 in that
   we need to look up in our extent tree to find the last block in the
   file (which is where the fs-verity superblock is located).

   For f2fs, it can just use the on-disk i_size to find the fs-verity
   superblock, and then from that, f2fs can find the original data
   i_size (which then gets presents to userspace when it calls
   stat(2).)

As far as the last point is concerned, ext4 could have done things the
f2fs way, which is simpler, and which would allowed us to make things
much more generic.  However, being able to support read-only mounts of
file systems with fs-verity protected files was important to me.

Everything else is generic and we tried to factor out as much common
code as possible into fs/verity.  But the model has always been that
at least *some* changes would be needed in the file system to call out
to the fs-verity code, primarily because we didn't want to make
changes to readpage()/readpages() VFS<->low-level fs interface.  That
would have required making changes in dozens of file systems, and
while that would have allowed us to factor out some duplicated code in
{ext4,f2fs}_readpage[s]() --- right now it's only those two file
systems out of 70 or so support fscrypt and fs-verity.  It's just not
worth it.

						- Ted
