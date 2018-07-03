Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6F2C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 04:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9F424E26
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 04:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WuWXMHu/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE9F424E26
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753964AbeGCEnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 00:43:17 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:28750 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753912AbeGCEnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 00:43:11 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20180703044309epoutp034fd7be5eb96c113ff2ed535dfc4f8e69~9wjbsSH8M2691226912epoutp03H
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jul 2018 04:43:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180703044309epoutp034fd7be5eb96c113ff2ed535dfc4f8e69~9wjbsSH8M2691226912epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1530592989;
        bh=YkNfrRwqoIUt0E5WTV2wK+wsXFGESe0khJhKbpHdH9Y=;
        h=Date:From:Reply-To:To:CC:Subject:In-Reply-To:References:From;
        b=WuWXMHu/ykS4ooMJTfaGwYo+mkysE8fKgaJRYXQFiYYZ+EDL3Ae71FdVOGcSfqeg5
         9lWlWbpBBV+CTzK7sEMVtbNipNK89YnFeixUp145MHZyolch4yPt9ALCyzHvw2wpz8
         a+9U+g79hUITsiswunUO416Z7sy7MdCkYTyh4UNk=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.155]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180703044302epcas1p2e5dd139a43a6ec09e179ffba004fa070~9wjVeP25q0485504855epcas1p25;
        Tue,  3 Jul 2018 04:43:02 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        12.45.04343.6DEFA3B5; Tue,  3 Jul 2018 13:43:02 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20180703044302epcas1p4ff5961129c010a2df3548cf678b6274c~9wjUy-vFW2959129591epcas1p4p;
        Tue,  3 Jul 2018 04:43:02 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180703044302epsmtrp2066d6db05d499d6cf8723af952f430b9~9wjUxwO6W1302113021epsmtrp2y;
        Tue,  3 Jul 2018 04:43:02 +0000 (GMT)
X-AuditID: b6c32a38-773ff700000010f7-13-5b3afed61dac
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F3.56.03632.5DEFA3B5; Tue,  3 Jul 2018 13:43:01 +0900 (KST)
Received: from [10.113.63.222] (unknown [10.113.63.222]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180703044301epsmtip225522de9b9b6122d36ca888a92a5733e~9wjUfrj6e2510025100epsmtip2y;
        Tue,  3 Jul 2018 04:43:01 +0000 (GMT)
Date:   Tue, 03 Jul 2018 13:43:06 +0900
From:   Seung-Woo Kim <sw0312.kim@samsung.com>
Reply-To: sw0312.kim@samsung.com
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:16.0) Gecko/20121011
        Thunderbird/16.0.1
MIME-Version: 1.0
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        Jiri Slaby <jslaby@suse.cz>,
        Seung-Woo Kim <sw0312.kim@samsung.com>
Subject: Re: Linux 3.18.111
In-Reply-To: <20180703043655.GA9793@kroah.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTYRTn825319nqa2od1sNxycjI5d2jbpIRFTVQyjCCHGUXvWziXuxu
        Zhm9UbNamUlzWtgLygx7OUoyy15mFoIlvaCwECySzDJMrO52i/rr+53fOef3O+f7PopQHyc1
        VL7Ty3ucnJ0mlbLQnaTk5J6fqZaUwTI9W9vYQLK7TzWS7NBos5ztbq4l2bN3jsrYuku9iA1U
        9pNsr/+TYjFlbg+MysytxxoU5lP+SrnZf7UemTvr7irMQ5enZ5LZ/EIbz+XxHi3vzHXl5Tut
        aXR6Vs7SHNO8FCaZWcDOp7VOzsGn0csyMpOX59vFgWhtIWf3iVQmJwj03EULPS6fl9faXII3
        jbYwjF7HpMzX6fXiaVifqjeJJRt525GODrn7/NSi0PuPaAe6NbkcRVOAjfC5dq+iHCkpNb6G
        4O3jfaQUfEHwcmQQScEwgs5vnehvS1tNh1xKtCAo2/UwSgo+IahqfycPV8lwIpzs7lWEMYnn
        QOvp0QivxlroagqQYRyP10Lg9sGIqgpPhIfV72VhHIdnQf+9l7KwKIFfI7j5/EkkEYunwNPO
        KxHRaKyDyvafkWYCJ8Duphoi3AD4Owljz36IbpSoWgilB0AaexkMvjskk3AsfHhwVSFhDQwN
        tJASLkVwu3qbpHMEQc/Ylz9FBug7UR4V1iRwEjQ2z5V8x8PAt/0RK8AqKCtRS9Uz4Pq9w6RE
        ayB4MUuizVDS1UJId1UZBbX+VuIQ0gb/Wz/43zbBf2Z1iKhHk3i34LDyAuM26gTOIficVl2u
        y3EZRf7mbPYauvEkow1hCtHjVEUJqRa1nCsUNjvaEFAEHacKJYqUKo/bvIX3uHI8PjsvtCGT
        +FIVhCY+1yX+dKc3hzHpDQYDa2TmmRiGnqwqeoEtamzlvHwBz7t5z9++KCpaswPtrNCccySO
        OdO7Z75ZkjuS3pS9vn/qyDnL/SX+H/CqZ5py65rYQKF7+MzqDFfChOKqR+rmFYnk/oKCVXGf
        VwZDRmtD8ceVb/fU2Ers1aXFXduTQof7KjKzU389Pzi866tRGaqPmXZ/oDzrF6M0xPirfDFj
        BVtXr+ubUrNuw/n4C5sUtEywccxswiNwvwH+Uy0NsQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkkeLIzCtJLcpLzFFi42LZdlhJXvfqP6tog66tNhZz1q9hs2hevJ7N
        4vPvXawWl3fNYbNYcXg6i8WCjY8YLWZMfslm8ajvLbsDh8eJGb9ZPPbPXcPusbhvMqtH35ZV
        jB5nFhxh9/i8SS6ALYrLJiU1J7MstUjfLoErY8qpU6wFq2Uqtj15zdjAeEC8i5GTQ0LAROLQ
        7FOsXYxcHEICuxkltv37wAKRkJKY+207YxcjB5AtLHH4cDFEzWtGiZufXzOD1PAKaEl86r/J
        BGKzCKhKLLr8iB3EZhPQkdi/5DcriC0koCBxYesMNhBbVCBE4tfHK6wQvYISJ2c+AdslIqAh
        8fLoLRaQBcwC9xglFh/aBlYkLCAtceXMZnaIzb1MEm0bDoBt5hTQk5h84h/YdcwC6hLr5wmB
        hJkF5CWat85mnsAoNAvJjlkIVbOQVC1gZF7FKJlaUJybnltsWGCYl1quV5yYW1yal66XnJ+7
        iREcMVqaOxgvL4k/xCjAwajEw3tB0SpaiDWxrLgy9xCjBAezkgjvNlWgEG9KYmVValF+fFFp
        TmrxIUZpDhYlcd6neccihQTSE0tSs1NTC1KLYLJMHJxSDYxxa2/ryEfNnRh/fQaj2MyNerXT
        4/78EKq9ws6qsPhL85w7nTc6BDntAkTyriTWRXrPUW4/3Fd1YtPHFcvtBC96/rg77cixAj8e
        zemT5bxOlLmUNTnGRB2clcotPqu67LbnrtRjEil1HEVfD3V/ebX43Ns7Kon/4yZxWt9/K2nI
        w/qf+4hd3lwlluKMREMt5qLiRABa5YwSlAIAAA==
Message-Id: <20180703044302epcas1p4ff5961129c010a2df3548cf678b6274c~9wjUy-vFW2959129591epcas1p4p@epcas1p4.samsung.com>
X-CMS-MailID: 20180703044302epcas1p4ff5961129c010a2df3548cf678b6274c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180530073304epcas3p4967df82d2d086fd08fd354781df61861
References: <CGME20180530073304epcas3p4967df82d2d086fd08fd354781df61861@epcas3p4.samsung.com>
        <20180530073211.GA22422@kroah.com>
        <20180703032456epcas1p29c4570ae3f6bb3f8d7c2d475e1ba4658~9vfIpgNT51989519895epcas1p2d@epcas1p2.samsung.com>
        <20180703043655.GA9793@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018년 07월 03일 13:36, Greg KH wrote:
> On Tue, Jul 03, 2018 at 12:24:59PM +0900, Seung-Woo Kim wrote:
>> Hello,
>>
>> On 2018년 05월 30일 16:32, Greg KH wrote:
>>> I'm announcing the release of the 3.18.111 kernel.
>>>
>>> All users of the 3.18 kernel series must upgrade.
>>>
>>> The updated 3.18.y git tree can be found at:
>>> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-3.18.y
>>> and can be browsed at the normal kernel.org git web browser:
>>> 	http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
>>>
>>> thanks,
>>>
>>> greg k-h
>>>
>>> ------------
>>
>> <snip.>
>>
>>>       do d_instantiate/unlock_new_inode combinations safely
>>
>> Recent my test in 3.18.113 kernel with security smack showed following
>> crash during mkdir on ext4 fs.
>>
>> Unable to handle kernel paging request at virtual address ffffffffffffff98
>> pgd = ffffffc012411000
>> [ffffffffffffff98] *pgd=0000000000000000, *pud=0000000000000000
>> ------------[ cut here ]------------
>> Kernel BUG at ffffffc0007d9430 [verbose debug info unavailable]
>> Internal error: Oops - BUG: 96000005 [#1] PREEMPT SMP
>> CPU: 0 MPIDR: 80000000 PID: 1237 Comm: mkdir Not tainted
>> 3.18.113-00083-g1bfc02f-dirty #29-Tizen
>> task: ffffffc02cbc2340 ti: ffffffc02b7fc000 task.ti: ffffffc02b7fc000
>> PC is at down_read+0x24/0x54
>> LR is at down_read+0x24/0x54
>> [...]
>> Call trace:
>> [<ffffffc0007d9430>] down_read+0x24/0x54
>> [<ffffffc00022ff64>] ext4_xattr_get+0x74/0x1f4
>> [<ffffffc000234838>] ext4_xattr_security_get+0x28/0x38
>> [<ffffffc0001ab9f0>] generic_getxattr+0x4c/0x60
>> [<ffffffc0002786a0>] smk_fetch.isra.6+0x8c/0xe0
>> [<ffffffc000278888>] smack_d_instantiate+0x194/0x324
>> [<ffffffc000273794>] security_d_instantiate+0x24/0x30
>> [<ffffffc00019edf4>] d_instantiate_new+0x34/0x94
>> [<ffffffc0002046b4>] ext4_mkdir+0x284/0x354
>> [<ffffffc0001959bc>] vfs_mkdir+0xc0/0x150
>> [<ffffffc00019a108>] SyS_mkdirat+0x88/0xb8
>> [<ffffffc00019a150>] SyS_mkdir+0x18/0x20
>> Code: aa0003f3 b00017c0 912e1000 97e38943 (c85f7e60)
>> ---[ end trace b1ad797d63dae9c5 ]---
>>
>> It is because d_instantiate_new() added from above commit calls
>> security_d_instantiate() before calling __d_instantiate() and
>> dentry->d_inode is not yet set and null. In 3.18.113 kernel,
>> inode->i_op_getxattr() of ext4 is still generic_getxattr() and it only
>> has dentry parameter without inode, so it tries to access dentry->d_inode.
>>
>> I did not test with selinux, but selinux also calls
>> inode->i_op_getxattr() from selinux_d_instantiate(), so maybe there is
>> also same issue.
> 
> So should I revert something or do you have a proposed fix for this?

I think the commit itself is required. Simple, but not reliable,
workaround fix is like below:

diff --git a/fs/dcache.c b/fs/dcache.c
index a34d401..7c751f2 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1879,6 +1879,8 @@ void d_instantiate_new(struct dentry *entry,
struct inode *inode)
        BUG_ON(!hlist_unhashed(&entry->d_u.d_alias));
        BUG_ON(!inode);
        lockdep_annotate_inode_mutex_key(inode);
+       /* WORKAROUND for calling security_d_instantiate() */
+       entry->d_inode = inode;
        security_d_instantiate(entry, inode);
        spin_lock(&inode->i_lock);
        __d_instantiate(entry, inode);
---

But I am not familiar with dentry/inode locking and there is no lock
consideration at all.

Thanks,
- Seung-Woo Kim

> 
> thanks,
> 
> greg k-h
> 
> 
> 

-- 
Seung-Woo Kim
Samsung Research
--

