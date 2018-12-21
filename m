Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093D4C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54EB2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731940AbeLUPwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 10:52:24 -0500
Received: from dmz-mailsec-scanner-7.mit.edu ([18.7.68.36]:42984 "EHLO
        dmz-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725845AbeLUPwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 10:52:23 -0500
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Dec 2018 10:52:21 EST
X-AuditID: 12074424-9cbff70000003214-b3-5c1d0b06a3a0
Received: from mailhub-auth-3.mit.edu ( [18.9.21.43])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by dmz-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 03.FC.12820.70B0D1C5; Fri, 21 Dec 2018 10:47:19 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH-1.MIT.EDU [18.9.28.11])
        by mailhub-auth-3.mit.edu (8.14.7/8.9.2) with ESMTP id wBLFlH4k014317;
        Fri, 21 Dec 2018 10:47:18 -0500
Received: from callcc.thunk.org (THE-HIMMER.bear1.Boston1.Level3.net [4.30.124.170])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id wBLFlGF1031627
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Dec 2018 10:47:16 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D3F2E7A41B9; Fri, 21 Dec 2018 10:47:14 -0500 (EST)
Date:   Fri, 21 Dec 2018 10:47:14 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 01/12] fs-verity: add a documentation file
Message-ID: <20181221154714.GA26547@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20181219071420.GC2628@infradead.org>
 <20181219021953.GD31274@dastard>
 <20181219193005.GB6889@mit.edu>
 <20181219213552.GO6311@dastard>
 <20181220220158.GC2360@mit.edu>
 <20181221070447.GA21687@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221070447.GA21687@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRmVeSWpSXmKPExsUixCmqrcvOLRtj8PuImkXPlIOsFnffb2e1
        2HLsHqPF2j1/mC1OT1jEZPFk/Sxmi5nz7rBZXFrkbvFq3jcWiz17T7JYnDh3jN3i8q45bBb3
        u7qYLR71vWW3OLL5CJsDv8epRRIeCzaVemxeoeWxaVUnm8eJGb9ZPB4c2szisXvBZyaPj09v
        sXi07L/G5vF5k1wAVxSXTUpqTmZZapG+XQJXxpVli5kL/vJXTLvcwdrAeIuni5GTQ0LARKLj
        /Vf2LkYuDiGBNUwSPbNmsEA4GxklJsz5zQzhXGOSaOq7yAbSIiRQJLHs5Gd2EJtFQFViz6IP
        TCA2m4CGxJqnf1lAbBEBTYlby9vBmpkFNrJIzOr4AdYsLOAosfjRO7AGXgEdiduv+tkg7PMs
        Em3v/SC2PWaU+LrqBFSRoMTJmU/ApjILaEnc+PcSKM4BZEtLLP/HARLmFDCWmLnlKytIWFRA
        ReLzAoEJjEKzkDTPQtI8C6F5ASPzKkbZlNwq3dzEzJzi1GTd4uTEvLzUIl1zvdzMEr3UlNJN
        jKAIZXdR2cHY3eN9iFGAg1GJh9fii0yMEGtiWXFl7iFGSQ4mJVHe7p9AIb6k/JTKjMTijPii
        0pzU4kOMEhzMSiK8HbZAOd6UxMqq1KJ8mJQ0B4uSOO8fkcfRQgLpiSWp2ampBalFMFkZDg4l
        CV5fLtkYIcGi1PTUirTMnBKENBMHJ8hwHqDhtiA1vMUFibnFmekQ+VOMilLivD84gRICIImM
        0jy4XlACZZGrWfWKURzoFWHeJSBVPMDkC9f9CmgwE9BgLieQq4tLEhFSUg2MCx+qH38cMyNw
        /beJRicVxTov3jGe9ktpiuFru4P/XDvda31E/979ama04UjKc8f4PbOMX+7f+17vitVGk8V3
        Pd7FBfm0O3wP+CM2Ywdb2t4rtxccaPqwTcPo9oy4l7UHputXLW3+E579vmWV/UIFldB1KydP
        Fd77Z1ruavkCFZENZ2qZah3/piqxFGckGmoxFxUnAgCaO3SKewMAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 11:04:47PM -0800, Christoph Hellwig wrote:
> Ted, I think you know yourself this isn't true.  Whenever we added
> useful interface to one of the major file systems we had other pick
> it up, and that is a good thing because the last thing we need is
> fragmentation of interfaces.  And even if that wasn't the case I don't
> think we should take short cuts, because even if an interface was just
> for a file system or two it still needs to be properly desgined.

This is why I think the interface argument is totally bogus.

If you're OK with Darrick's suggested interface, where you pass in a
file descriptor, offset and length --- that's just a superset of the
current interface, except where the file descriptor is in the file
which is going to be protected using fs-verity.  So there's if you're
OK with that interface, we can add that interface later, and it's
really no big deal; it certainly doesn't add any extra complexity for
XFS --- assuming that XFS even gets around to adding support for
fs-verity.

Adding that extra complexity is not necessary for the current users of
the interface, and as I've said multiple times before, there's no
*value* in allowing the Merkle tree to be passed in via some arbitrary
file descriptor, which might even be on a separate fhile system, as
opposed in the file which is about to be protected using fs-verity.

Linus --- we're going round and round, and I don't think this is
really a technical dispute at this point, but rather an aesthetics
one.  Will you be willing to accept my pull request for a feature
which is being shippped on millions of Android phones, has been out
for review for months, and for which, if we *really* need to add
uselessly complicated interface later, we can do that?  It's always
been the case for internal Kernel interfaces not to add code "just in
case" it's useful, but rather when a user turns up.  I argue we should
be doing the same thing for user-space visible interfaces.

Regards,

						- Ted

