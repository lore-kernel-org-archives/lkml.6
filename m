Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D13FC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 04:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18EEC21903
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 04:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393194AbeLWEqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 23:46:00 -0500
Received: from dmz-mailsec-scanner-1.mit.edu ([18.9.25.12]:63706 "EHLO
        dmz-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389933AbeLWEp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 23:45:59 -0500
X-AuditID: 1209190c-7ddff700000014b1-64-5c1f1305f46f
Received: from mailhub-auth-1.mit.edu ( [18.9.21.35])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by dmz-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 05.1E.05297.5031F1C5; Sat, 22 Dec 2018 23:45:57 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH-1.MIT.EDU [18.9.28.11])
        by mailhub-auth-1.mit.edu (8.14.7/8.9.2) with ESMTP id wBN4juCl032463;
        Sat, 22 Dec 2018 23:45:57 -0500
Received: from callcc.thunk.org (96-72-84-49-static.hfc.comcastbusiness.net [96.72.84.49] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id wBN4jr8r021991
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Dec 2018 23:45:55 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 49A077A4704; Sat, 22 Dec 2018 23:45:53 -0500 (EST)
Date:   Sat, 22 Dec 2018 23:45:53 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
Subject: Re: [PATCH v2 01/12] fs-verity: add a documentation file
Message-ID: <20181223044553.GG26547@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
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
 <20181223041007.GL10600@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181223041007.GL10600@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGc2cp08LopaXhytZYQY0Iihq9D3WPOvKgJvjgQqIDHWhjW8hM
        IUKMQcWERQ0aNypiLSpaQWQLBPHBhuCGPoAmRsUYBWMqYhRUDEucaaPwds75//87ubmHIbVj
        dBRjdTgF0cHbjCoNpVXr5yXROkP60vJ2Az5x9gGN+7+10bil+x3A9Z0TJH5a4SHwQIOLxJXV
        b1W417MF+6t/Ubjz/mMKP3reHYL7OqpU+MOpryG4q7lLhcfHqlTrZnNPPIhzN+VxzTcXcU3e
        UhX36OI4xb33NVPcPfcIwX0ffE1xI01xO9R7NCazYLPmC+KSNfs1luH6ciL3RejB0z99VBGo
        VJcBhkFwBRqYiioDGkYL6wj05uUVMtg0AnTc00oHmyECvSrpIcqAWm5ENNznppQ0BRPQUMse
        ZayCC1Hd4GRgHCHXQy3LlCgJz9Oo5UgrqXh0cD2q+TAcwLBwMXo7OalSTCy8TqOTFd6Q4DIP
        ic7+9lJBVzh6XDkQqEm4AE1U95LKBhJGo9opJjg2oGOtlwJjNTSh4m6TUuphPBpxwwqgc83g
        uGZwXNMc1wyOG1BeEGu2FybZeatNEjKTpEze4RDEpJRku9WZLJjzmkDgg+eEtYOeoVQfgAww
        hrEljXHpWprPlwrsPjCHIYx6NpY0pGtnZeSYCyy8ZNkn5tkEyQcQQxoj2LHx2HQta+YLCgUx
        558UzVDGSHY84uNeLczmncIBQcgVxH9qDMMYEdsPZWi4KGQLB7OsNue0TDBqBR4mwzeFyx5W
        yuXtkjU7qD8Bc6Mi2SxFgIpgyXP8zyoHu5/bmeIHkfJTdGyDsiJMPuf/ab8MJmSwZkOMAnby
        01JUEajZnYDp4tAzJfW7LpcaMp3DIau2HdKfe55tSjQvcMfpUtOOrS2ff5vw91nulpo2+49O
        dq1eeiuRq9heezV55E7b8ofUgyuxpZE3vmztDG3Ez9Cf1wmHX41eqL366Xh09MaMjt600eIu
        /UJ/Z/+htvjvVPHUtcU/2o0vOxwrP+d6v0YYKcnCpywiRYn/C2cnmJqLAwAA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 08:10:07PM -0800, Matthew Wilcox wrote:
> Pretty much every file format has the ability to put arbitrary blocks
> of information into a file somewhere the tools which don't know about
> it will skip it.  For example, ZIP "includes an extra field facility
> within file headers, which can be used to store extra data not defined
> by existing ZIP specifications, and which allow compliant archivers that
> do not recognize the fields to safely skip them. Header IDs 0–31 are
> reserved for use by PKWARE. The remaining IDs can be used by third-party
> vendors for proprietary usage. " (Wikipedia)
> 
> ELF, PNG, PDF and many other formats have the ability to put data
> _somewhere_.  It might not be at the tail of the file, but there's
> somewhere to do it.
> 
> (I appreciate this isn't what Linus is asking for, but I'm pointing out
> that this is by no means as intractable as you make it sound.)

That design would require the fs-verity code to know the type of eacho
file, and where to find the in-band Merkle tree for each file type
that we wanted to support.  And if you wanted to use fs-verity to
protect a sudoers text configuration file (for example), we'd have to
teach sudo how to ignore the userspace visible Merkle tree.

So I agree with you that it's *possible*.  But it's ***ugly***.  *Way*
uglier than putting the Merkle tree at the end of the file data and
then making it invisible to userspace.

Cheers,

						- Ted
