Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111D0C6783B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B5020851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544646374;
	bh=tJdD70Iv59FFgTbDgLZ2y75NOxl8Hveziz4ZzwXBue0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Eyu+oRQS/u12Fg139yJm7dAiN2UBpCxStrjg4n216I3ds/JwkkWBBsh6LSI25187s
	 gsxK9dPbxPtKP9mcg1cMATggmtrohEOLAuLgwGSJ+YkpWLEETsStuvkubDZStP/y2d
	 6XMthqL95KHIraHkeI929tXn32ORwc0CELaJdYCM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B5020851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbeLLU0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 15:26:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:51886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbeLLU0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 15:26:13 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 470EA20811;
        Wed, 12 Dec 2018 20:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544646372;
        bh=tJdD70Iv59FFgTbDgLZ2y75NOxl8Hveziz4ZzwXBue0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sotxte3Dzf8+b3WvrI5litfcWZbSc9oQgzLXz7Q6j75h+7CBWAcOkMl8rCkyD9Kun
         SeB4zji2F2W73TTfmUuwJ0VdTFRALToqBKkNSuEGetlz3qFIaeg9nPuzfeVhUQyKtf
         KVlTvQd0KW0Y0nyT2+9glm7U0q4Sg1YxgP/zyb18=
Date:   Wed, 12 Dec 2018 12:26:10 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 01/12] fs-verity: add a documentation file
Message-ID: <20181212202609.GA193967@gmail.com>
References: <20181101225230.88058-1-ebiggers@kernel.org>
 <20181101225230.88058-2-ebiggers@kernel.org>
 <20181212091406.GA31723@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212091406.GA31723@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Wed, Dec 12, 2018 at 01:14:06AM -0800, Christoph Hellwig wrote:
> As this apparently got merged despite no proper reviews from VFS
> level persons:

fs-verity has been out for review since August, and Cc'ed to all relevant
mailing lists including linux-fsdevel, linux-ext4, linux-f2fs-devel,
linux-fscrypt, linux-integrity, and linux-kernel.  There are tests,
documentation (since v2), and a userspace tool.  It's also been presented at
multiple conferences, and has been covered by LWN multiple times.  If more
people want to review it, then they should do so; there's nothing stopping them.

> 
> NAK - the ioctl format that expects the verifycation hash in the file
> data data with padding after the real data is simply not acceptable,
> we can't just transform the data in the file itself based on a magic
> calls like this.
> 

Can you elaborate on the actual problems you think the current solution has, and
exactly what solution you'd prefer instead?  Keep in mind that (1) for large
files the Merkle tree can be gigabytes long, (2) Linux doesn't have an API for
file streams, and (3) when fs-verity is combined with fscrypt, it's important
that the hashes be encrypted, so as to not leak information about the plaintext.

> Also the core code should not depend on this as a storage format,
> which is a rather bad idea.  In any modern file system you can
> store data like this out of line in something like the attr fork
> in XFS, or the attr items in btrfs.

As explained in the documentation, the core code uses the "metadata after EOF"
format for the API, but not necessarily the on-disk format.  I.e.,
FS_IOC_ENABLE_VERITY requires it, but during the ioctl the filesystem can choose
to move the metadata into a different location, such as a file stream.

We'd just need to update fsverity_read_metadata_page() and
compute_tree_depth_and_offsets() to call out to the filesystem's
fsverity_operations to read a metadata page and get the offset of the first
metadata page, respectively.  The rest of fs/verity/ will still work.  I'd be
glad to add those two fsverity_operations now, though they're not needed for
ext4 and f2fs, if it would help clarify things further.

Thanks,

- Eric
