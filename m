Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C751CC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 02:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EAFE20847
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 02:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="1srtefVM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EAFE20847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbeIBGt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 02:49:59 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44752 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbeIBGt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 02:49:59 -0400
Received: by mail-lf1-f66.google.com with SMTP id g6-v6so12660369lfb.11
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 19:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=p8w4jSbjkZqEagZMMJ/CTLchE9OB8JVUasc6oXa5qrc=;
        b=1srtefVMW8bZTt/A4PrF8enodAiK/l/7PqxXvQPpRWpMXFH8WWgU+zd0bHfRTDb/Dk
         LQssGBjuhAExlBkaT8qeu58eNaO1BwnC1mp8gOfIQHF6u65LxIsXYRrwqHrReR+CkNcz
         ER7BGbBfIKugZsQoGHlJoqG9EToX5wD8qHjCLjePzyvVJ8h0xgkQjkMVfZHWfmeK5EQO
         KEmoLSzJXTJw+RLKhUMJPXTIbZEZdBHfwG4PPdJYWaV3cwEzd7aGmiBqgDuuszAL6h28
         rlD8TZYbSTm4RwmOfP9lZkdC6TUcWyGWKUk/42JV6mUr90u1h3Pml23OCePezA4lb5cV
         T3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=p8w4jSbjkZqEagZMMJ/CTLchE9OB8JVUasc6oXa5qrc=;
        b=QIa+YUC7PQif2Vhxwx6aACoehW85FobRNJZGiqn79TWwYjQ8EQAZiO2kcdsmM6AQlr
         UTIZ/d99LvhCvcyuKvwx5ZefVYe+z0k6M/GJLuIF2t8XETaR17YgglZcDQI28FXbBeey
         cEug65pjxAgIPdytQH/PHBmuDoN6Gq47UmKh52sINZyaBNhfV04aEN145VmHDkgYy+Q6
         DnfT9NZicY95u9J3Cem4lq3oq9SPz2tLtJ7bWMSeQ0URZxYCfPwH6cxrILUs/2It8/Gl
         6z+wdlBHpJfgD7A1Dq8Ub7kGuLr1Kt+mHElX69c9tIk8sJfLepDrToYymihfxcl1kWqT
         52fg==
X-Gm-Message-State: APzg51APAzWscJs6EUaHC2qohDjl5vO2LMn+nuP7G9b7LRyODLP+yqab
        yGVDGtxaWwDXRV0UkKUA+ez3YOt/jE/yL7ymaoXp4A==
X-Google-Smtp-Source: ANB0VdYhE4p5JErtZ61mBExfX2rlWWQlRw6Ng3zd/LTd07gSudjA0UPnMJ+Fw6eijPJWKV6U94wW04s7WnTxrbVsACk=
X-Received: by 2002:a19:5f54:: with SMTP id a20-v6mr2323153lfj.42.1535855755136;
 Sat, 01 Sep 2018 19:35:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:cc08:0:0:0:0:0 with HTTP; Sat, 1 Sep 2018 19:35:53 -0700 (PDT)
X-Originating-IP: [99.152.116.91]
In-Reply-To: <20180825041647.GA726@sol.localdomain>
References: <20180824161642.1144-1-ebiggers@kernel.org> <20180824161642.1144-3-ebiggers@kernel.org>
 <2f2382c3-e5e9-f0da-dc89-42dfc7b2b636@huawei.com> <20180825041647.GA726@sol.localdomain>
From:   Olof Johansson <olof@lixom.net>
Date:   Sat, 1 Sep 2018 19:35:53 -0700
Message-ID: <CAOesGMhGfesVQHHMpqW5r7gMOZccX4RsZZex6y-kfkmuA6K0ow@mail.gmail.com>
Subject: Re: [RFC PATCH 02/10] fs-verity: add data verification hooks for ->readpages()
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Gao Xiang <gaoxiang25@huawei.com>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Michael Halcrow <mhalcrow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Victor Hsieh <victorhsieh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 24, 2018 at 9:16 PM, Eric Biggers <ebiggers@kernel.org> wrote:
> Hi Gao,
>
> On Sat, Aug 25, 2018 at 10:29:26AM +0800, Gao Xiang wrote:
>> Hi,
>>
>> At last, I hope filesystems could select the on-disk position of hash tree and 'struct fsverity_descriptor'
>> rather than fixed in the end of verity files...I think if fs-verity preparing such support and interfaces could be better.....hmmm... :(
>
> In theory it would be a much cleaner design to store verity metadata separately
> from the data.  But the Merkle tree can be very large.  For example, a 1 GB file
> using SHA-512 would have a 16.6 MB Merkle tree.  So the Merkle tree can't be an
> extended attribute, since the xattrs API requires xattrs to be small (<= 64 KB),
> and most filesystems further limit xattr sizes in their on-disk format to as
> little as 4 KB.  Furthermore, even if both of these limits were to be increased,
> the xattrs functions (both the syscalls, and the internal functions that
> filesystems have) are all based around getting/setting the entire xattr value.
>
> Also when used with fscrypt, we want the Merkle tree and fsverity_descriptor to
> be encrypted, so they doesn't leak plaintext hashes.  And we want the Merkle
> tree to be paged into memory, just like the file contents, to take advantage of
> the usual Linux memory management.
>
> What we really need is *streams*, like NTFS has.  But the filesystems we're
> targetting don't support streams, nor does the Linux syscall interface have any
> API for accessing streams, nor does the VFS support them.
>
> Adding streams support to all those things would be a huge multi-year effort,
> controversial, and almost certainly not worth it just for fs-verity.
>
> So simply storing the verity metadata past i_size seems like the best solution
> for now.
>
> That being said, in the future we could pretty easily swap out the calls to
> read_mapping_page() with something else if a particular filesystem wanted to
> store the metadata somewhere else.  We actually even originally had a function
> ->read_metadata_page() in the filesystem's fsverity_operations, but it turned
> out to be unnecessary and I replaced it with directly calling
> read_mapping_page(), but it could be changed back at any time.

What about an xattr not to hold the Merkle tree, but to contain a
suitable reference to a file/inode+offset that contains it (+ toplevel
hash for said tree/file or the descriptor/struct)?

If you also expose said file in the directory structure, things such
as backups might be easier to handle. For where the tree is appended
to the file, you could self-reference.


-Olof
