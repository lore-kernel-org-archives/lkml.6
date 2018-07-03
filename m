Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B33BC3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 03:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42BF20C48
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 03:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qH6EewAL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B42BF20C48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932577AbeGCDZG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 23:25:06 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:37822 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932198AbeGCDZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 23:25:03 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20180703032502epoutp02ff5e1fded8cb5a7f3d80a0c2ff6a9a0c~9vfOO1clV2294622946epoutp02w
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jul 2018 03:25:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180703032502epoutp02ff5e1fded8cb5a7f3d80a0c2ff6a9a0c~9vfOO1clV2294622946epoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1530588302;
        bh=HzcEqNVGG7+Fa8CtWbUbu4wgPYnLAw/MDeCUUaVBa+w=;
        h=Date:From:Reply-To:To:CC:Subject:In-Reply-To:References:From;
        b=qH6EewAL9qdL3tBHY8lwdT5/xSm/V9C5KwYOrF9hn2LhTTLLLY6tzqmTST7Qeg7dN
         gtnR11NtSx2Au9HykJNJVrlR+vEQPQlDwN2xj1xzzcG/GgUk6ntmq3wJVYcEqDry/D
         rD8TEGrNJUGnzqx2QVWbad3LM5Q1CbBJYHDm5zwQ=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.155]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180703032456epcas1p1daec1e5754520b1c5468ae9526f2efde~9vfJHOG3a1828818288epcas1p1R;
        Tue,  3 Jul 2018 03:24:56 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        1F.00.04076.88CEA3B5; Tue,  3 Jul 2018 12:24:56 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180703032456epcas1p29c4570ae3f6bb3f8d7c2d475e1ba4658~9vfIpgNT51989519895epcas1p2d;
        Tue,  3 Jul 2018 03:24:56 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180703032456epsmtrp1f3bb6d0db817e6243d6d9b44bb98c5f2~9vfIlvlHY1671716717epsmtrp1C;
        Tue,  3 Jul 2018 03:24:56 +0000 (GMT)
X-AuditID: b6c32a37-a59ff70000000fec-89-5b3aec88ff55
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EB.F3.03631.78CEA3B5; Tue,  3 Jul 2018 12:24:56 +0900 (KST)
Received: from [10.113.63.222] (unknown [10.113.63.222]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180703032455epsmtip2d5943afa5d5a651bb0a1910b1ea56836~9vfIZ3v9v2357523575epsmtip2b;
        Tue,  3 Jul 2018 03:24:55 +0000 (GMT)
Date:   Tue, 03 Jul 2018 12:24:59 +0900
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
In-Reply-To: <20180530073211.GA22422@kroah.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTURzu7G5312pxmqW/FtS4JZQ0591a3iTtJTHKyAqKsrCLnqbkNtvd
        xB5EWZmMmukidT3QEnpJ9lBRe1iaPUgreydBZCVZVpQUkRTd7Rr51/l+3/ed3+OcH0Npj9I6
        JsvhJi6HkM3Sw5X1rVMNhsK++NTY7pIo/nBNNc3vPF5D8/0DTSr+UdNhmj/ZWqrkK853I77M
        30vz3b5P6jmM9XbZgNLafKRabT3u86usvtrTyNpecUNt7b8wIYVeTWZlEiGDuPTEke7MyHLY
        EthFy9Pmp1lmxHIGbiYfx+odgp0ksEnJKYYFWdlSQ6w+V8j2SFSKIIqsMXGWy+lxE32mU3Qn
        sKkcZ4rhYuNiTCbpNK+NN1kkyzqSeWnHLXXO5fC8ytcf1NvRI+xFYQzg6XDi1DvKi4YzWtyA
        oOPZNaUcfEPw7OJBJAc/EDR07Vb9u9LVU0jLwhUE7Xs7lUFBiz8huOqLDGIljoIvX8+HeBpP
        g+aqAZXs0cODujI6iMfiFVB2vQgFsQaPhjvlb0P+MXgK9LZ1hdqg8Esp5/N7ISEcj4fH7RfV
        QRyGjeDzdVJBTOGJsLPuUGgIwP009PlqVXLWXLhzs56S206Cff4XahmHw4dbtYNYB71FBYN4
        D4Lr5dvkRAcQPP39bVAwQ0+lV+FFjFRtKtQ0GeXCo+Dz972qIA1YA4UFWtk9GRrbSmiZ1kHg
        3HKZtkLBgyuDb52PoPzJK8V+pA8MmT8wZJzA/2IViDqNIkiOaLcRkcsxx4iCXfQ4bDHpTvsF
        FNrN6LgGdO5ecgvCDGJHavImxqdqVUKuuMnegoCh2DGa+iiJ0mQImzYTlzPN5ckmYguySF9V
        TOnGpjulTXe40ziLyWw289O5GRaOYyM1eS9wqhbbBDfZQEgOcf27p2DCdNtRxp+f1Bpx5fvI
        u3XJFd7mcTNLF239oRlGe+++H+3Xmbdu6xBWvpuAiTN/0rJGU0nHm9W/eiJKT41YO6J1SyJS
        nK12FLctqYoLKPj1x4zpV/1LH55pS4nundScOC9/YTnsqjJE5TdGF29cZaSL7o+rrFpBtTK2
        2cWLPZrNB+f27f/IKsVMgYumXKLwF3HOpNWxAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkkeLIzCtJLcpLzFFi42LZdlhJXrfjjVW0wZMHjBZz1q9hs2hevJ7N
        4vPvXawWl3fNYbNYcXg6i8WCjY8YLWZMfslm8ajvLbsDh8eJGb9ZPPbPXcPusbhvMqtH35ZV
        jB5nFhxh9/i8SS6ALYrLJiU1J7MstUjfLoErY3fjcfaCPcIVCx++Ym9gvCzQxcjJISFgInHr
        WQdbFyMXh5DAbkaJD38bGSESUhJzv20HsjmAbGGJw4eLIWpeM0pMPPyUFaSGV0BLYvGGt8wg
        NouAqsT7jxtZQGw2AR2J/Ut+g9UICShIXNg6gw3EFhUIkfj18QpUr6DEyZlPwOpFBDQkXh69
        xQKygFngHqPE4kPbwIqEBaQlrpzZzA6xuYFRYtGL92CTOAX0Jfr6LjKDXMcsoC6xfp4QSJhZ
        QF6ieets5gmMQrOQ7JiFUDULSdUCRuZVjJKpBcW56bnFhgVGeanlesWJucWleel6yfm5mxjB
        EaOltYPxxIn4Q4wCHIxKPLwV8lbRQqyJZcWVuYcYJTiYlUR4t6kChXhTEiurUovy44tKc1KL
        DzFKc7AoifPK5x+LFBJITyxJzU5NLUgtgskycXBKNTDqztm8SPbFTMnPc/8qv/IXmx7T+zd6
        gydLE//X/yVXjm2//VQhllVacW+LA1MHh5CYsU2/jNa1+Qr8DPx9t9UNWoSbs8z99wWefztJ
        7Ma1z+rXmZedU1G531aQlZOwtezAsYWhEzZPOVx++EGdRNN1Pl8T76WTYpIZ9n4/UXJAvW6H
        zCXHAkclluKMREMt5qLiRABGWlpIlAIAAA==
Message-Id: <20180703032456epcas1p29c4570ae3f6bb3f8d7c2d475e1ba4658~9vfIpgNT51989519895epcas1p2d@epcas1p2.samsung.com>
X-CMS-MailID: 20180703032456epcas1p29c4570ae3f6bb3f8d7c2d475e1ba4658
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180530073304epcas3p4967df82d2d086fd08fd354781df61861
References: <CGME20180530073304epcas3p4967df82d2d086fd08fd354781df61861@epcas3p4.samsung.com>
        <20180530073211.GA22422@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2018년 05월 30일 16:32, Greg KH wrote:
> I'm announcing the release of the 3.18.111 kernel.
> 
> All users of the 3.18 kernel series must upgrade.
> 
> The updated 3.18.y git tree can be found at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-3.18.y
> and can be browsed at the normal kernel.org git web browser:
> 	http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
> 
> thanks,
> 
> greg k-h
> 
> ------------

<snip.>

>       do d_instantiate/unlock_new_inode combinations safely

Recent my test in 3.18.113 kernel with security smack showed following
crash during mkdir on ext4 fs.

Unable to handle kernel paging request at virtual address ffffffffffffff98
pgd = ffffffc012411000
[ffffffffffffff98] *pgd=0000000000000000, *pud=0000000000000000
------------[ cut here ]------------
Kernel BUG at ffffffc0007d9430 [verbose debug info unavailable]
Internal error: Oops - BUG: 96000005 [#1] PREEMPT SMP
CPU: 0 MPIDR: 80000000 PID: 1237 Comm: mkdir Not tainted
3.18.113-00083-g1bfc02f-dirty #29-Tizen
task: ffffffc02cbc2340 ti: ffffffc02b7fc000 task.ti: ffffffc02b7fc000
PC is at down_read+0x24/0x54
LR is at down_read+0x24/0x54
[...]
Call trace:
[<ffffffc0007d9430>] down_read+0x24/0x54
[<ffffffc00022ff64>] ext4_xattr_get+0x74/0x1f4
[<ffffffc000234838>] ext4_xattr_security_get+0x28/0x38
[<ffffffc0001ab9f0>] generic_getxattr+0x4c/0x60
[<ffffffc0002786a0>] smk_fetch.isra.6+0x8c/0xe0
[<ffffffc000278888>] smack_d_instantiate+0x194/0x324
[<ffffffc000273794>] security_d_instantiate+0x24/0x30
[<ffffffc00019edf4>] d_instantiate_new+0x34/0x94
[<ffffffc0002046b4>] ext4_mkdir+0x284/0x354
[<ffffffc0001959bc>] vfs_mkdir+0xc0/0x150
[<ffffffc00019a108>] SyS_mkdirat+0x88/0xb8
[<ffffffc00019a150>] SyS_mkdir+0x18/0x20
Code: aa0003f3 b00017c0 912e1000 97e38943 (c85f7e60)
---[ end trace b1ad797d63dae9c5 ]---

It is because d_instantiate_new() added from above commit calls
security_d_instantiate() before calling __d_instantiate() and
dentry->d_inode is not yet set and null. In 3.18.113 kernel,
inode->i_op_getxattr() of ext4 is still generic_getxattr() and it only
has dentry parameter without inode, so it tries to access dentry->d_inode.

I did not test with selinux, but selinux also calls
inode->i_op_getxattr() from selinux_d_instantiate(), so maybe there is
also same issue.

Best Regards,
- Seung-Woo Kim

-- 
Seung-Woo Kim
Samsung Research
--

