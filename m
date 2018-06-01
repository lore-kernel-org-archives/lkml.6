Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2793556-1527839303-2-14591798289828366772
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527839303; b=IxUc/LgwhgDhG6iOxc3ocwFTYoP3ix2xy4TpaSY7q7AGVJGw3s
    /KARzGoIkdrqecEaLHr7YGLrOE21Npj7Tw5uHqP5ndyP1W+Pwp45/dlno0rOJcMs
    BND6glg5Zbf+ESOYLNITlk27GnVZCdMvy/JVTHPuZDQIy+P3vMYR9Cek0SZbZZx/
    HT0TAEszCmb7KzA9cAtwFDFNi19kHQ3Xm72t+Bs0nrOasH044Gkbv3yepewCL54Z
    lU+h4DbKhy5qtKBVWK30tVm4cz59FQ2fYHyT+Bj52L7Y+IPfqyl5ey9yyUmWGCWx
    smoMDmrG8YdSZpwxtxbch1bY24QsYcSi15fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527839303; bh=aLZXZ5oQ7z5g48fCVcqUoQ2b6QHVkDi5J5gvnIHNCK
    Q=; b=I2Qwom+qpj9at74wPp/lJwpCpcVzmSL4VTf4Q7YsIiA8exMhatBZn9hUAn
    eEgw0z8aNTC4wMPSTdLz+LS1AxkI/NWEseuEtZ7G5xCM9oGcifRdD77U/3i3No9x
    HRkQffS134iHG2FcevCIskMj2g+tRTxSL/o5ixj4x2+r2KVBk/PDlfgOYzWIUiHe
    ZSUhsTrkY7jSVckUjk0k4ojMrPNMgZMNnGXVmJWrzunZEqvrOPDpaLnGrxKQKBbT
    1ufFzZRvR8h8yc9fXKNjDvXnEItOwcz3A+lUEaFTonnyI6PuwagVv5/LyACHrnID
    mwLCXEIoHYSLiwlExXCAO0fUFnzg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=ZZpl6XNJ header.a=rsa-sha256
    header.s=20161025 x-bits=2048;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=laNpsoGL;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=ZZpl6XNJ header.a=rsa-sha256
      header.s=20161025 x-bits=2048;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=laNpsoGL;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJDGsQrkX9Wl96kLsbr/5vFVh3IwGPrkR7AIg2ruYQykHATigoBcCoK3NEiC7Tc4yehX7m3+pOjcZ8eJ2H8D9ym4db6N5wG4hV9E2nA5UMd3zd+4f3ul
    HP+JTBfKCCSRWoiP990ArD7wA2NNSY00+z0edhh55/w/pOxbRveKyIu/L4/u4by/t/MD9TOwJXtu7CWAZ/z1J1a/PyujZfH/w0+eXF+KSMtww86DF4Z75eAU
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=wisxUXl2lvMA:10 a=7mUfYlMuFuIA:10 a=i0EeH86SAAAA:8 a=QrBSeL7iHqT1qkQW5_kA:9
    a=f8839G3f4eGzWzhv:21 a=J_nu45gNfbZ4DrQF:21 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750816AbeFAHsT (ORCPT <rfc822;linux@kroah.com>);
        Fri, 1 Jun 2018 03:48:19 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:40454 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750991AbeFAHsO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jun 2018 03:48:14 -0400
X-Google-Smtp-Source: ADUXVKLdQqq3vmoPwNlbTGzOFJ2OqKfl4fI7x/nizFDsLOUpzWeCo0zK+oTbGS6xH19mE692cUt8Nw79AKAvWY4Szfw=
MIME-Version: 1.0
In-Reply-To: <1527764767-22190-1-git-send-email-gaoxiang25@huawei.com>
References: <1527764767-22190-1-git-send-email-gaoxiang25@huawei.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Fri, 1 Jun 2018 09:48:12 +0200
Message-ID: <CAFLxGvw5PXBLKuaaK5xipiwTOXohtdeenD0XQHgX6+r4rS=GqQ@mail.gmail.com>
Subject: Re: [NOMERGE] [RFC PATCH 00/12] erofs: introduce erofs file system
To: Gao Xiang <gaoxiang25@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        miaoxie@huawei.com, yuchao0@huawei.com, sunqiuyang@huawei.com,
        fangwei1@huawei.com, liguifu2@huawei.com, weidu.du@huawei.com,
        chen.chun.yen@huawei.com, brooke.wangzhigang@hisilicon.com,
        dongjinguang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 31, 2018 at 1:06 PM, Gao Xiang <gaoxiang25@huawei.com> wrote:
> Hi all,
>
> Read-only file systems are used in many cases, such as read-only storage media.
> We are now focusing on the Android device which several read-only partitions exist.
> Due to limited read-only solutions, a new read-only file system EROFS
> (Extendable Read-Only File System) is introduced.

In which sense is it extendable?

> As the other read-only file systems, several meta regions in generic file systems
> such as free space bitmap are omitted. But the difference is that EROFS focuses
> more on performance than purely on saving storage space as much as possible.
>
> Furthermore, we also add the compression support called z_erofs.
>
> Traditional file systems with the compression support use the fixed-sized input
> compression, the output compressed units could be arbitrary lengths.
> However, data is accessed in the block unit for block devices, which means
> (A) if the accessed compressed data is not buffered, some data read from
> the physical block cannot be further utilized, which is illustrated as follows:
>
>    ++-----------++-----------++         ++-----------++-----------++
> ...||           ||           ||   ...   ||           ||           ||  ... original data
>    ++-----------++-----------++         ++-----------++-----------++
>     \                         /          \                         /
>        \                   /                \                    /
>           \             /                      \               /
>       ++---|-------++--|--------++       ++-----|----++--------|--++
>       ||xxx|       ||  |xxxxxxxx||  ...  ||xxxxx|    ||        |xx||  compressed data
>       ++---|-------++--|--------++       ++-----|----++--------|--++
>
> The shadow regions read from the block device but cannot be used for decompression.
>
> (B) If the compressed data is also buffered, it will increase the memory overhead.
> Because these are compressed data, it cannot be directly used, and we don't know
> when the corresponding compressed blocks are accessed, which is not friendly to
> the random read.
>
> In order to reduce the proportion of the data which cannot be directly decompressed,
> larger compressed sizes are preferred to be selected, which is also not friendly to
> the random read.
>
> Erofs implements the compression in a different approach, the details of which will
> be discussed in the next section.
>
> In brief, the following points summarize our design at a high level:
>
> 1) Use page-sized blocks so that there are no buffer heads.
>
> 2) By introducing a more general inline data / xattr, metadata and small data have
> the opportunity to be read with the inode metadata at the same time.
>
> 3) Introduce another shared xattr region in order to store the common xattrs (eg.
> selinux labels) or xattrs too large to be suitable for meta inline.
>
> 4) Metadata and data could be mixed by design, so it could be more flexible for mkfs
> to organize files and data.
>
> 5) instead of using the fixed-sized input compression, we put forward a new fixed
> output compression to make the full use of IO (which means all data from IO can be
> decompressed), reduce the read amplification, improve random read and keep the
> relatively lower compression ratios, illustrated as follows:
>
>
>         |---- varient-length extent ----|------ VLE ------|---  VLE ---|
>          /> clusterofs                  /> clusterofs     /> clusterofs /> clusterofs
>    ++---|-------++-----------++---------|-++-----------++-|---------++-|
> ...||   |       ||           ||         | ||           || |         || | ... original data
>    ++---|-------++-----------++---------|-++-----------++-|---------++-|
>    ++->cluster<-++->cluster<-++->cluster<-++->cluster<-++->cluster<-++
>         size         size         size         size         size
>          \                             /                 /            /
>           \                      /              /            /
>            \               /            /            /
>             ++-----------++-----------++-----------++
>         ... ||           ||           ||           || ... compressed clusters
>             ++-----------++-----------++-----------++
>             ++->cluster<-++->cluster<-++->cluster<-++
>                  size         size         size
>
>    A cluster could have more than one blocks by design, but currently we only have the
> page-sized cluster implementation (page-sized fixed output compression can also have
> better compression ratio than fixed input compression).
>
>    All compressed clusters have a fixed size but could be decompressed into extents with
> arbitrary lengths.
>
>    In addition, if a buffered IO reads the following shadow region (x), we could make a more
>    customized path (to replace generic_file_buffered_read) which only reads one compressed
>    cluster and makes the partial page available.
>          /> clusterofs
>    ++---|-------++
> ...||   | xxxx  || ...
>    ||---|-------||
>
> Some numbers using fixed output compression (VLE, cluster size = block size = 4k) on
> the server and Android phone (kirin970 platform):
>
> Server (magnetic disk):
>
> compression  EROFS seq read  EXT4 seq read        EROFS random read  EXT4 random read
> ratio           bw[MB/s]       bw[MB/s]             bw[MB/s] (20%)    bw[MB/s] (20%)
>
>   4              480.3          502.5                   69.8               11.1
>  10              472.3          503.3                   56.4               10.0
>  15              457.6          495.3                   47.0               10.9
>  26              401.5          511.2                   34.7               11.1
>  35              389.1          512.5                   28.0               11.0
>  48              375.4          496.5                   23.2               10.6
>  53              370.2          512.0                   21.8               11.0
>  66              349.2          512.0                   19.0               11.4
>  76              310.5          497.3                   17.3               11.6
>  85              301.2          512.0                   16.0               11.0
>  94              292.7          496.5                   14.6               11.1
> 100              538.9          512.0                   11.4               10.8
>
> Kirin970 (A73 Big-core 2361Mhz, A53 little-core 0Mhz, DDR 1866Mhz):

What storage was used? An eMMC?

> compression  EROFS seq read  EXT4 seq read        EROFS random read  EXT4 random read
> ratio           bw[MB/s]       bw[MB/s]             bw[MB/s] (20%)    bw[MB/s] (20%)
>
>   4              546.7          544.3                    157.7              57.9
>  10              535.7          521.0                    152.7              62.0
>  15              529.0          520.3                    125.0              65.0
>  26              418.0          526.3                     97.6              63.7
>  35              367.7          511.7                     89.0              63.7
>  48              415.7          500.7                     78.2              61.2
>  53              423.0          566.7                     72.8              62.9
>  66              334.3          537.3                     69.8              58.3
>  76              387.3          546.0                     65.2              56.0
>  85              306.3          546.0                     63.8              57.7
>  94              345.0          589.7                     59.2              49.9
> 100              579.7          556.7                     62.1              57.7

How does it compare to existing read only filesystems, such as squashfs?

-- 
Thanks,
//richard
