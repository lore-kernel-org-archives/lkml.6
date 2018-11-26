Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8348C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7481720663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="AdOlgUu4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7481720663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbeK0D3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:29:36 -0500
Received: from sonic315-26.consmr.mail.ne1.yahoo.com ([66.163.190.152]:36524
        "EHLO sonic315-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726167AbeK0D3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 22:29:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543250098; bh=a3m1eFlsSM3SrVWRsMILtkAXDYkdsQYxiEQo5LLz7g4=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=AdOlgUu4iXOQJZR7eHGk20VdY9/nh6GSygi8bEH9V68n6/+dDP4SlK9w6Yv7AIc6y4ov+KN2FSEGi2jLUYSOL1vIziqwXZCDvkqX1UfAyX+qv8sUqCAiFHKPyjI295e7ET7DcfOYqs8wugPhr3ED5u54srWmLPqo3doU3N2U5LaVxz0GKETVp64RqD0OgWuWygbiWOT6LgyBukD/JxndVjKIh9cNkAgLxfQ8bh+qOv2uOPht3wD3Mf/t+6TajZFmtXsfVeLb8Lmn+m/8v36vHpITgph4cTxAoQqOR/nFJPwLu4o2itN/rcROh6UjloLOEh2yqb06TKFE3XwIdKeO0g==
X-YMail-OSG: MJCUdzwVM1niKdp4DdLZKXMeRj4NjLn.accY_KXf7JoMno20DdHgM94N.AJW0Fg
 NnresUH2TCDgqkFkSGCYv35FbFtavloTIUQKBQq46SwKcVaBz.ocq37oK3yuWQ79xsgZPx2oH086
 F0WPmYNj07jvzsnTwITiFmf1uTPEKicxzd864ngyMyM9vIaIt9I9Xou7AtRsYuyML7tXwoFtIU7c
 JZGdxVQ73.OzOGZIK_cPgcUl6J.W.8tuv1XGZrlTdNfY1V_c7Lw43i9VUijJZz8q7HmI0DzupDaf
 0DMJ8ClDSOK1Ao4v42npun8grFdnvWGutJkpOTJu6D2GCcBHQLD6eksqgp26PeaRSL0oz20gSUcf
 mYzOlpJdUGjXsUAsi48il_lF1Acagi_cPIFi5uLnohpxw0PqdLvuKc9DR8KOrA7pz2EloqmA6uGI
 TbgxdrxBEasKnHTZkgkUF8gtFNjDcMj5cLiPAo.AhauT8D9MRWWUO1hoeBROq9p1mmEi3H0JTEGA
 qcJEjPUYmr3ueQWvOvi9qaUF9T5x2NDgNrSEJi4ryMBprt9wiWcL4ZnPUayl5THXTw62Df2T9UzM
 lAXlVB7_kZr7PgtFmmfRt5dCSeCjL.WKihh_83uHxpBrrPcNTHYU7g0E27VEfI93pXLT3h4LLVn1
 dKPcQhUW6x4mYPLp14bAcXKRsO3n9x.d0y3sHklY9dGPOQls9CG4q130AQJh6eXa7aLDRhnV4dS2
 DdsKf5x5o9eZNllyhzskc3cW0QtgXT.Ox_Cpc0zQ_TgdSOd8Ho2WlyzURxi_PvJSS_erSl4aG5MP
 j6.zCcMmsiw0mFfvNydUQ5OeIbMPpqShvR9yac19DvOOGqcNos87uBf8E7pYy7G50jjOvbBIu3T8
 wiNbM2oL3IuyF38Ij38ZX2AXo4ySR3_AP17RPN.bMUzDET55Im_9IypTxY2Agu2RfW1sYepcQGjo
 L9ezChsc3YyOdmljfpyl9wZOiYNcoaFBvUn3im4DxaemidpUZxK5M8EJ4wjFHxXHHZ2Nyex0I9Zy
 mITTqxAlYpNf3ZYw.45Xls..c5LvLiOLDH1GokWU1G1jR2RxsfduZWf7pUJtv.lJhp1kjVJyMR3I
 OUUdH
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Mon, 26 Nov 2018 16:34:58 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp411.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 878996b26d439be5fb769f591f7a9b16;
          Mon, 26 Nov 2018 16:34:57 +0000 (UTC)
Subject: Re: [RFC][PATCH] fs: set xattrs in initramfs from regular files
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        Rob Landley <rob@landley.net>, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, initramfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com,
        takondra@cisco.com, kamensky@cisco.com, hpa@zytor.com,
        arnd@arndb.de, james.w.mcmechan@gmail.com
References: <20181122154942.18262-1-roberto.sassu@huawei.com>
 <7f2b0288-a173-e2bb-70ee-d552610bfc1e@landley.net>
 <b907b5ca-1515-1ed4-d50d-28c1736c0eb8@huawei.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <f2886ac7-aff9-94bc-5f65-b3b2e946a6ff@schaufler-ca.com>
Date:   Mon, 26 Nov 2018 08:34:54 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b907b5ca-1515-1ed4-d50d-28c1736c0eb8@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/2018 4:56 AM, Roberto Sassu wrote:
> On 11/23/2018 9:21 PM, Rob Landley wrote:
>> On 11/22/18 9:49 AM, Roberto Sassu wrote:
>>> Although rootfs (tmpfs) supports xattrs, they are not set due to the
>>> limitation of the cpio format. A new format called 'newcx' was proposed to
>>> overcome this limitation.
>>
>> I got email about that format the day before you posted this, by the way.
>>
>>> However, it looks like that adding a new format is not simple: 15 kernel
>>> patches; user space tools must support the new format; mistakes made in the
>>> past should be avoided; it is unclear whether the kernel should switch from
>>> cpio to tar.
>>
>> The kernel _can't_ switch from cpio to tar without breaking backwards
>> compatability, it could only add tar as a second format it supported (remember
>> cpio images can be sideloaded so a new rootfs can be used with an existing
>> initramfs, plus existing build systems generate them and would still need to if
>> they wanted to keep supporting older kernels), and then once you've got two
>> formats somebody will propose zip support, and let's just not go there please.
>>
>> The changes to the userspace tools are trivial (I say that as the maintainer of
>> toybox, which has a cpio). The argument was about things like 64 bit timestamps
>> (y2038 problem), nanosecond support, sparse files, etc. And I think the argument
>> had largely died down?
>>
>> Keep in mind the squashfs guy spent 5 years trying to get his filesystem merged
>> (https://lwn.net/Articles/563578/), I spent several years trying to get my perl
>> removal patch merged (and only work up the enthusiasm to resubmit
>> http://lists.busybox.net/pipermail/buildroot/2015-March/123385.html
>> https://patchwork.kernel.org/patch/9193529/ https://lkml.org/lkml/2017/9/13/651
>> about once a year because dealing with linux-kernel is just no fun for hobbyists
>> anymore).
>>
>>> The aim of this patch is to provide the same functionality without
>>> introducing a new format. The value of xattrs is placed in regular files
>>> having the same file name as the files xattrs are added to, plus a
>>> separator and the xattr name (<filename>.xattr-<xattr name>).
>>
>> I think you're solving the wrong problem, but that's just my opinion.
>
> Instead of iterating over rootfs, would it be better to detect files
> with extended attributes (from the file name) when the cpio image is
> parsed by the kernel, and call sys_lsetxattr() in do_copy()? This part
> can be turned on by introducing a new type in the existing format (if
> possible).

A very similar approach was used in at least one MLS Unix
system back in the day. It used tar, but would have worked
just as well with CPIO. Any file with a specific name
was assumed to contain the security attributes for the
preceding file, and tar invoked a helper program to set
them. No change to the tar format was required, and if
you read an archive with a generic tar you just got multiple
entries for the special name. No format or special types
required.

>
> The impact of this alternative is very low, and LSMs/IMA would be able,
> with minimum effort, to enforce policies on files in the initial ram
> disk.

True. And it worked. But it was still a kludge.

