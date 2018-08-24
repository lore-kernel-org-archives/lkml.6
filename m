Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A8DC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 17:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E23821477
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 17:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kFP39eXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E23821477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbeHXVSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 17:18:08 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39109 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726279AbeHXVSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 17:18:08 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id D348220DB5;
        Fri, 24 Aug 2018 13:42:29 -0400 (EDT)
Received: from web3 ([10.202.2.213])
  by compute3.internal (MEProxy); Fri, 24 Aug 2018 13:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=hMyDuG
        sUGsOndGgHXyEPC5oxHKFKpIY8s4la6F2H0Gk=; b=kFP39eXING/nWEGwRt/ZmL
        cuYXYC98no843Nm9lPJXALTWD5yAwLYOXVA0VX3N6wpvUjO7jDbRLm9BIlNQ7D3q
        V0ILdQqPNVL3Enm8aA0OlXuXhOB5DAJLS0VYHJfojUIItcDn/bW4wfODnGreSir6
        os5wCykPLnuo7/M2FQtWOsAXfRBB0jSgYuGsrUq4Ekoh8CG2lzusUciygGzL8gYt
        1krhYpabPSowYKumTHQb5lYERD33okgybfSJKOiJDbU4RdzRKAHreRkyNzMKDoS3
        chPjxre4CwZ7hi2I1hNeQdPcj3CoHpPYp60GRhvaIGI3HvpPNA2DO5LO7aSnzDow
        ==
X-ME-Proxy: <xmx:hUOAW-rPKoYJ28OlnPu8CQR2KB3z3sT8m39fSGPEMOxkzY6DeFpUsA>
    <xmx:hUOAW7nH6cKu4-HgdYhvRaG7CpPh4i7QzaxJiCoY7sSO1myafUGpOg>
    <xmx:hUOAW_SyMMemRIeJP6C_Kr0P-tL6F0dzk_SSDrZe4J3qyvzUzcq6kg>
    <xmx:hUOAWxbaVoLhGrU5ccRrIEzNzMcy2Pe-ONUw2YRYRzhSKG8nhn93fA>
    <xmx:hUOAW_9uxP1M9XzFeZad_w3KTg9d0eFlVx12-ggmeFAtWqIMd-ORQQ>
    <xmx:hUOAWy4cNWv44a5A-NBBCtwXmspfODoe7vU5YGhjMMtv6AoT_TvRwA>
X-ME-Sender: <xms:hUOAW3ps0ubP8j1Y0CFowiQWmVYgpvrqwh_r__GTTTaSch9UfnPiLA>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id 408E79E508; Fri, 24 Aug 2018 13:42:29 -0400 (EDT)
Message-Id: <1535132549.2855027.1485213752.129E3334@webmail.messagingengine.com>
From:   Colin Walters <walters@verbum.org>
To:     Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-integrity@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Michael Halcrow <mhalcrow@google.com>,
        Victor Hsieh <victorhsieh@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-7b72137a
In-Reply-To: <20180824161642.1144-2-ebiggers@kernel.org>
References: <20180824161642.1144-1-ebiggers@kernel.org>
 <20180824161642.1144-2-ebiggers@kernel.org>
Subject: Re: [RFC PATCH 01/10] fs-verity: add setup code, UAPI, and Kconfig
Date:   Fri, 24 Aug 2018 13:42:29 -0400
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, Aug 24, 2018, at 12:16 PM, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> fs-verity is a filesystem feature that provides efficient, transparent
> integrity verification and authentication of read-only files.  It uses a
> dm-verity like mechanism at the file level: a Merkle tree hidden past
> the end of the file is used to verify any block in the file in
> log(filesize) time.  It is implemented mainly by helper functions in
> fs/verity/ that will be shared by multiple filesystems.
> 
> Essentially, fs-verity reports a file's hash in constant time, but reads
> that would violate that hash fail at runtime.  This is useful when only
> a portion of the file is actually accessed, as only the accessed portion
> has to be hashed, and the latency to the first read is much reduced over
> a full file hash.  On top of this hashing mechanism, auditing or
> authentication policies can be implemented to log or verify file hashes.
> 
> Note that in general, fs-verity is *not* a replacement for IMA.
> fs-verity is a lower-level feature, primarily a way to hash a file;
> whereas IMA deals more with higher-level policy logic, like defining
> which files are "measured" and what to do with those measurements.  We
> plan for IMA to support fs-verity measurements as an alternative to the
> traditional full file hash.  Still, some users find fs-verity useful by
> itself, so it's also usable without IMA in simple cases, e.g. in cases
> where just retrieving the file measurement via an ioctl is enough.
> 
> A structure containing the properties of the Merkle tree -- such as the
> hash algorithm used, the block size, and the root hash -- is also stored
> on-disk, following the Merkle tree.  The actual file measurement hash
> that fs-verity reports is the hash of this structure.
> 
> All fs-verity metadata is written by userspace; the kernel only reads
> it.  Extended attributes aren't used because the Merkle tree may be much
> larger than XATTR_SIZE_MAX, we want the hash pages to be cached in the
> page cache as usual, and in the case of fs-verity combined with fscrypt
> we want the metadata to be encrypted to avoid leaking plaintext hashes.
> The fs-verity metadata is hidden from userspace by overriding the i_size
> of the in-memory VFS inode; ext4 additionally will override the on-disk
> i_size in order to make verity a RO_COMPAT filesystem feature.
> 
> This initial patch only adds the fs-verity Kconfig option, UAPI, and
> setup code, e.g. the ->open() hook that parses the fs-verity descriptor.

This first patch also adds a bit of core logic in the
simple fsverity_prepare_setattr() which ends up being called
by ext4 later.

While I'm not too familiar with the vfs, as far as I can
tell  from inspection of Linus' git master is that pretty much any change (timestamp, hardlinks) ends up
calling notify_change() which calls the fs-specific one, and in
the verity case basically denies everything, right?

Previously I brought up many uses for "content immutable" files:
https://marc.info/?l=linux-fsdevel&m=151698481512084&w=2

The discussion sort of died out but...did you have any opinion
on e.g. my proposal to use the Unix mode bits as a way to describe
levels of mutablility?

Let's say that your new _VERITY inode flag becomes "_WRITEPROT"
or something a bit more generic.

Do you have any thoughts on my proposal to reuse the Unix mode
bits to control levels of inode mutability?

For example, it seems to me we could define u+w as "hardlinks are OK".
There shouldn't be any reason ext4/f2fs couldn't hardlink a verity-protected
inode right?  Or if for some reason that is hard, we could disallow that to
start, but at least have the core VFS support _WRITEPROT inodes?

