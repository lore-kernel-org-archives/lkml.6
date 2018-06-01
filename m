Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2925718-1527844328-2-11786477700126615301
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527844327; b=J3sabI6NolFImwvh79Y/+fRJ4sEiIsTQM+aQ9V43XDhp1XLFBF
    8001Pv8+JDkFBVDCbVaSa6vcBhUQ4gDc89SbeQOrb/2FXL/xF8p/wYUouBknvbyk
    2Sc7s3qmx/yQLBSfWsI//CrnBCkFO0rOKaSM4ocCbo7nfSwFFrx5lBxifvXYIvxb
    JJNQgnNH8GmcvvFQz7LLfUV22QH2Pit4omfAcvDS3rQ6lvKmf2PTbUie/7UDBO8E
    LAcn1KTikwU82rDzFb31aoepWErO7X6JKj+5uG1bLQOYL/PPsT21ojle61ccGO6E
    1mz8ES1RksEQkGbFa+gAWwM0EAvytssxJ5bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527844327;
    bh=342Xx/pYQ61k+8RMI5xiy7BzcMRbWB88BTxEvcgcCXE=; b=VQ/5TsJVFoQa
    3dwXwupvZ2KvNO9F+MdvtYw0haxPSbkrAS7BQ6TiFGzSwjmu35bw8ERS0zy4xMk0
    1wkrI2C2Z/REcB3dqDVRD4lpENganmCscKHtz/cmo/SyDludxQrDTQHhpCsWIUFt
    2A2n6JbDQ/lEHGZTMZA8WFkCcyShibXjKysCbCUJk2ybhnSV3IckB3aw6PnAt8sh
    yhK1hbfaxOPQ4GWXT96ICmpPmSocZTvpYlVLl+zH0+CBQsP2w4Nh4k7Cf2jGfHrH
    tZ/4MIHuN9uv+TFYh9jqSnnrxw37K13aep0Z5LUPENB0hW9D7M48J3lw0m2mMso5
    wuqLc2mBmw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGxwTth2yADpunyfpqCmc3jBwh5wX0Ym0abVN8Akgy0KRK1UqueuvMgEM7TJQQOnSbq6iUedKR7VZ2c0HB48Cher2/3P/pCyTm3/f+XpVi86iXDCh4ni
    OOdJBQVTveONyXGYlPzgo+B8mRWojT9tE9b6kixkz2HBsnslFMW0vjl763kCIM/4+XnEHy06XESnOO/eDMxs0MFZR+Ibi3RwYV89JPhavUgIqY+hhAGdT6Ck
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=mVABwdYUS3QA:10 a=IkcTkHD0fZMA:10
    a=7mUfYlMuFuIA:10 a=i0EeH86SAAAA:8 a=62bl_fOWsgy5biFOjLwA:9
    a=M25pkB8HmCiDxFTI:21 a=WX9PMdQBEMfSnGvM:21 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750816AbeFAJMD (ORCPT <rfc822;linux@kroah.com>);
        Fri, 1 Jun 2018 05:12:03 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8620 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750732AbeFAJL6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jun 2018 05:11:58 -0400
Subject: Re: [NOMERGE] [RFC PATCH 00/12] erofs: introduce erofs file system
To: Richard Weinberger <richard.weinberger@gmail.com>
CC: LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        <miaoxie@huawei.com>, <yuchao0@huawei.com>,
        <sunqiuyang@huawei.com>, <fangwei1@huawei.com>,
        <liguifu2@huawei.com>, <weidu.du@huawei.com>,
        <chen.chun.yen@huawei.com>, <brooke.wangzhigang@hisilicon.com>,
        <dongjinguang@huawei.com>
References: <1527764767-22190-1-git-send-email-gaoxiang25@huawei.com>
 <CAFLxGvw5PXBLKuaaK5xipiwTOXohtdeenD0XQHgX6+r4rS=GqQ@mail.gmail.com>
From: Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <aae078b7-c364-106a-dd56-91abc945d7bb@huawei.com>
Date: Fri, 1 Jun 2018 17:11:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAFLxGvw5PXBLKuaaK5xipiwTOXohtdeenD0XQHgX6+r4rS=GqQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Richard,

On 2018/6/1 15:48, Richard Weinberger wrote:
> On Thu, May 31, 2018 at 1:06 PM, Gao Xiang <gaoxiang25@huawei.com> wrote:
>> Hi all,
>>
>> Read-only file systems are used in many cases, such as read-only storage media.
>> We are now focusing on the Android device which several read-only partitions exist.
>> Due to limited read-only solutions, a new read-only file system EROFS
>> (Extendable Read-Only File System) is introduced.
> 
> In which sense is it extendable?

Actually, the meaning of an enhanced (means not just read-only, but with the scalable
on-disk layout, compression, or fs-verify in the future) read-only file system is emphasized.

We also think of other candidate full names, such as
Enhanced / Extented Read-only File System, all the names short for "erofs" are okay.

> 
>> As the other read-only file systems, several meta regions in generic file systems
>> such as free space bitmap are omitted. But the difference is that EROFS focuses
>> more on performance than purely on saving storage space as much as possible.
>>
>> Furthermore, we also add the compression support called z_erofs.
>>
>> Traditional file systems with the compression support use the fixed-sized input
>> compression, the output compressed units could be arbitrary lengths.
>> However, data is accessed in the block unit for block devices, which means
>> (A) if the accessed compressed data is not buffered, some data read from
>> the physical block cannot be further utilized, which is illustrated as follows:
>>
>>    ++-----------++-----------++         ++-----------++-----------++
>> ...||           ||           ||   ...   ||           ||           ||  ... original data
>>    ++-----------++-----------++         ++-----------++-----------++
>>     \                         /          \                         /
>>        \                   /                \                    /
>>           \             /                      \               /
>>       ++---|-------++--|--------++       ++-----|----++--------|--++
>>       ||xxx|       ||  |xxxxxxxx||  ...  ||xxxxx|    ||        |xx||  compressed data
>>       ++---|-------++--|--------++       ++-----|----++--------|--++
>>
>> The shadow regions read from the block device but cannot be used for decompression.
>>
>> (B) If the compressed data is also buffered, it will increase the memory overhead.
>> Because these are compressed data, it cannot be directly used, and we don't know
>> when the corresponding compressed blocks are accessed, which is not friendly to
>> the random read.
>>
>> In order to reduce the proportion of the data which cannot be directly decompressed,
>> larger compressed sizes are preferred to be selected, which is also not friendly to
>> the random read.
>>
>> Erofs implements the compression in a different approach, the details of which will
>> be discussed in the next section.
>>
>> In brief, the following points summarize our design at a high level:
>>
>> 1) Use page-sized blocks so that there are no buffer heads.
>>
>> 2) By introducing a more general inline data / xattr, metadata and small data have
>> the opportunity to be read with the inode metadata at the same time.
>>
>> 3) Introduce another shared xattr region in order to store the common xattrs (eg.
>> selinux labels) or xattrs too large to be suitable for meta inline.
>>
>> 4) Metadata and data could be mixed by design, so it could be more flexible for mkfs
>> to organize files and data.
>>
>> 5) instead of using the fixed-sized input compression, we put forward a new fixed
>> output compression to make the full use of IO (which means all data from IO can be
>> decompressed), reduce the read amplification, improve random read and keep the
>> relatively lower compression ratios, illustrated as follows:
>>
>>
>>         |---- varient-length extent ----|------ VLE ------|---  VLE ---|
>>          /> clusterofs                  /> clusterofs     /> clusterofs /> clusterofs
>>    ++---|-------++-----------++---------|-++-----------++-|---------++-|
>> ...||   |       ||           ||         | ||           || |         || | ... original data
>>    ++---|-------++-----------++---------|-++-----------++-|---------++-|
>>    ++->cluster<-++->cluster<-++->cluster<-++->cluster<-++->cluster<-++
>>         size         size         size         size         size
>>          \                             /                 /            /
>>           \                      /              /            /
>>            \               /            /            /
>>             ++-----------++-----------++-----------++
>>         ... ||           ||           ||           || ... compressed clusters
>>             ++-----------++-----------++-----------++
>>             ++->cluster<-++->cluster<-++->cluster<-++
>>                  size         size         size
>>
>>    A cluster could have more than one blocks by design, but currently we only have the
>> page-sized cluster implementation (page-sized fixed output compression can also have
>> better compression ratio than fixed input compression).
>>
>>    All compressed clusters have a fixed size but could be decompressed into extents with
>> arbitrary lengths.
>>
>>    In addition, if a buffered IO reads the following shadow region (x), we could make a more
>>    customized path (to replace generic_file_buffered_read) which only reads one compressed
>>    cluster and makes the partial page available.
>>          /> clusterofs
>>    ++---|-------++
>> ...||   | xxxx  || ...
>>    ||---|-------||
>>
>> Some numbers using fixed output compression (VLE, cluster size = block size = 4k) on
>> the server and Android phone (kirin970 platform):
>>
>> Server (magnetic disk):
>>
>> compression  EROFS seq read  EXT4 seq read        EROFS random read  EXT4 random read
>> ratio           bw[MB/s]       bw[MB/s]             bw[MB/s] (20%)    bw[MB/s] (20%)
>>
>>   4              480.3          502.5                   69.8               11.1
>>  10              472.3          503.3                   56.4               10.0
>>  15              457.6          495.3                   47.0               10.9
>>  26              401.5          511.2                   34.7               11.1
>>  35              389.1          512.5                   28.0               11.0
>>  48              375.4          496.5                   23.2               10.6
>>  53              370.2          512.0                   21.8               11.0
>>  66              349.2          512.0                   19.0               11.4
>>  76              310.5          497.3                   17.3               11.6
>>  85              301.2          512.0                   16.0               11.0
>>  94              292.7          496.5                   14.6               11.1
>> 100              538.9          512.0                   11.4               10.8
>>
>> Kirin970 (A73 Big-core 2361Mhz, A53 little-core 0Mhz, DDR 1866Mhz):
> 
> What storage was used? An eMMC?

UFS device, fio with psync, bs=4k, iodepth=1.

> 
>> compression  EROFS seq read  EXT4 seq read        EROFS random read  EXT4 random read
>> ratio           bw[MB/s]       bw[MB/s]             bw[MB/s] (20%)    bw[MB/s] (20%)
>>
>>   4              546.7          544.3                    157.7              57.9
>>  10              535.7          521.0                    152.7              62.0
>>  15              529.0          520.3                    125.0              65.0
>>  26              418.0          526.3                     97.6              63.7
>>  35              367.7          511.7                     89.0              63.7
>>  48              415.7          500.7                     78.2              61.2
>>  53              423.0          566.7                     72.8              62.9
>>  66              334.3          537.3                     69.8              58.3
>>  76              387.3          546.0                     65.2              56.0
>>  85              306.3          546.0                     63.8              57.7
>>  94              345.0          589.7                     59.2              49.9
>> 100              579.7          556.7                     62.1              57.7
> 
> How does it compare to existing read only filesystems, such as squashfs?
> 

You are quite right.

We are now focusing on improving our decompression subsystem and
these numbers will be successively added in the future non-RFC patches.

We haven't pay much attention on comparing squashfs and erofs
yet since we once tried to use squashfs on our products with
different block sizes several years ago, it behaves
unacceptable in the low free memory scenario besides its
performance.


This version patchset is mainly used for the opensource archive.


Thanks for your attention :)


Thanks,
