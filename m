Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCA6C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 00:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930162133F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 00:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbeLSAQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 19:16:13 -0500
Received: from dmz-mailsec-scanner-3.mit.edu ([18.9.25.14]:52714 "EHLO
        dmz-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726614AbeLSAQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 19:16:12 -0500
X-AuditID: 1209190e-2ffff700000054d4-27-5c198dc92173
Received: from mailhub-auth-2.mit.edu ( [18.7.62.36])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by dmz-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 36.5B.21716.ACD891C5; Tue, 18 Dec 2018 19:16:10 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH-1.MIT.EDU [18.9.28.11])
        by mailhub-auth-2.mit.edu (8.14.7/8.9.2) with ESMTP id wBJ0G6DL006352;
        Tue, 18 Dec 2018 19:16:08 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-101.corp.google.com [104.133.0.101] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id wBJ0G4sS019597
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Dec 2018 19:16:04 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id CB4C57A51A1; Tue, 18 Dec 2018 19:16:03 -0500 (EST)
Date:   Tue, 18 Dec 2018 19:16:03 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 01/12] fs-verity: add a documentation file
Message-ID: <20181219001603.GD25775@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20181101225230.88058-1-ebiggers@kernel.org>
 <20181101225230.88058-2-ebiggers@kernel.org>
 <20181212091406.GA31723@infradead.org>
 <20181212202609.GA193967@gmail.com>
 <20181213202249.GA3797@infradead.org>
 <20181214044802.GA681@sol.localdomain>
 <20181217200039.GD8111@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217200039.GD8111@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTURzHu4/d3dmuHefKo2bksAhplhV0iZAKrEvvggwqsJs7udU2171b
        qfSHRJGKpUmRStTSMDXzsRXZC21JqNEDs9LUMtPI9ZAYWqRZ987U/vv+ft/z+R4O50sTmm5F
        GG2y2pFg5c06KoDUKOOi9C2nQvcsbhlbwuacfaBguwdvKdjr90YJ9nFeMc72VRcRbOHFLopt
        LV7Hei8Ok+y9+80k2/T0kZJ9cecCxb7LzibY3tNflWyju5FaFcg5XQ7OXRbNuSqyKK6pYITk
        ejxukrvr9OHc9/43JHe8/hXF+Vxztqp2Baw0ILPpMBIWxe0NMH7MTbDdnJGaWdxDZGA56mxM
        RUOwDA7WvyWysQBaAypx+LPvDzk+1GLQ86zq3+DFYdvt75SMaIAACwbu47ImwTz4rCbXv6fA
        AljZ/5uUtRYsglm3q3EZJsAQAR+eK/cDwWA1LOn9JmmaZsBCeKl+m3yGAeUkPF/tw8dvq8Bh
        Z6bPn8SAINhc2OfXBIiG7WMDfpgA4fDqGC1LFdDDhoJ4Wc4EUdDnBHmYpug/tug/tmiKdWJE
        BRZhsKTrLbzJLKIkvZjEW61I0C+NsZjsMcjgcGHyL6pCA+uw/IwNHgzQmE7NZM4N3aNR8IfF
        NIsHC6Vx3Uxm0CGtAvelGNKMvGhMFBxmJHowSBM6LdO6W/IYA5+WjoSUCSucJnUhzC/th90a
        kMzb0UGEbEiYcGfTtA4yaqk5miABJaPU/SazfcrGaZUcrpbC1+fI4aKNt4im5HG/BYsMC2Gi
        ZRjIhtFhnWTlVhpPTENeLER6SjDzSMbVUmcnaa8UjEvB5hu4HGznp6ywDCy27XHHgVlP3KWR
        ytKMyrtdn+tQbeLQkZ/D2kPP22FZfYh3NHFgfkPTxjPHUrVftrxsVirbqz5vTsp6333ZWXHu
        0xB3paav+WV+Qv+PYUV/R5zteeeK+O22dPRm5MRQ1PJrO0o2RZyiaxOYo/bXNpduTXwgtdK9
        E6ZFrU2e/vpCx0kdKRr52GhCEPm/Yxe/M3ADAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 12:00:39PM -0800, Darrick J. Wong wrote:
> FWIW, if I were (hypothetically) working on an xfs implementation, I
> likely would have settled on passing a reference to a merkle tree
> through a (fd, length) pair, because that allows us plenty of options
> on the back end:
> 
> b) we could remap the tree into a new inode fork for merkle trees, or
> a) remap it as posteof blocks like ext4/f2fs does, or
> c) remap the blocks into the attribute fork as an (unusually large)
> extended attribute value.

Sure, but what would be the benefit of doing different things on the
back end?  I think this is a really more of a philophical objection
than anything else.  With both fsverity and fscrypt, well over 95% of
the implementation is shared between ext4 and f2fs.  And from a
cryptographic design, that's something I consider a feature, not a
bug.  Cryptographic code is subtle in very different ways compared to
file system code.  So it's a good thing to having it done once and
audited by crypto specialists, as opposed to having each file system
doing it differently / independently.

> If the merkle_fd isn't on the same filesystem as the fd we could at
> least use generic_copy_file_range (i.e. page cache copying) to land the
> merkle tree wherever we want.
> 
> Granted, it's not like we can't do any of those three things given the
> current interface.  I gather most of the grumbling has to do with
> feeling like we're associating the on-disk format to the ioctl interface
> too closely?

Right, the current interface makes it somewhat more awkward to do
these other things --- but the question is *why* would you want to in
the first place?  Why add the extra complexity?  I'm a big believer of
the KISS principle, and if there was a reason why a file system would
want to store the Merkle tree somewhere else, we could talk about it,
but I see only downside, and no upside.

      	       		     	- Ted
