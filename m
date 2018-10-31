Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8640C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC5A20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LC43Zfug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC5A20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbeKABn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 21:43:29 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60108 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729341AbeKABn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 21:43:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9VGhtJG075712;
        Wed, 31 Oct 2018 16:44:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=qyLJSbiAN97FEQ2UQvo2FZq9eQcid2zxRs+GFHKcaNI=;
 b=LC43ZfugiC8ZqsB/VF/2ZTHJ/GD0EMFsFLLVEhINi9qj6J+ryeJDB20bIPNp6xDvg9VY
 NqxzHh4eOQQsWmFsgmgf6D7yx1NOyizJy/LmKOX+3c2YK39YMM15jKbQlzGBY/gjtcvQ
 dtLxQzJOVNeSVq6uv2FJ18dcZ8YbqehQvES1lYgZZ6N1tcNY/Bi8qO6O4Fl/pxUZ6QVz
 tb9Ibq3krR7NG5fdxFuokG0NNj6Qq/lIbI54utkjPz+/Z8F8OL7qOOtwi2P7gASEZimJ
 bnIgyaIGa8O8R4cKBcML7ZUgo8SP2g7HjjnGSCh+OruEdZlfi7S5SmM9YYsomdaHHb+Q Vg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2ncfyq4a9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Oct 2018 16:44:36 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9VGiZ5j015885
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Oct 2018 16:44:35 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9VGiYV9005160;
        Wed, 31 Oct 2018 16:44:34 GMT
Received: from [10.209.243.127] (/10.209.243.127)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 31 Oct 2018 09:44:34 -0700
Subject: Re: WARNING in rds_message_alloc_sgs
To:     Leon Romanovsky <leon@kernel.org>
Cc:     syzbot <syzbot+26de17458aeda9d305d8@syzkaller.appspotmail.com>,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        rds-devel@oss.oracle.com, syzkaller-bugs@googlegroups.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org
References: <0000000000003c6b7b0579772ff3@google.com>
 <a7a834e0-c300-b5b9-67b5-78fa3eba8ebb@oracle.com>
 <20181031064220.GN3974@mtr-leonro.mtl.com>
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <1537ebeb-2c03-0068-58f1-6c348a2f718e@oracle.com>
Date:   Wed, 31 Oct 2018 09:44:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181031064220.GN3974@mtr-leonro.mtl.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9063 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810310139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/2018 11:42 PM, Leon Romanovsky wrote:
> On Tue, Oct 30, 2018 at 12:38:02PM -0700, Santosh Shilimkar wrote:
>> On 10/30/2018 12:28 PM, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following crash on:
>>>
>>> HEAD commit:    6201f31a39f8 Add linux-next specific files for 20181030
>>> git tree:       linux-next
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=1397d06d400000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=2a22859d870756c1
>>> dashboard link:
>>> https://syzkaller.appspot.com/bug?extid=26de17458aeda9d305d8
>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10bb52eb400000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=118bdfc5400000
>>>
>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>> Reported-by: syzbot+26de17458aeda9d305d8@syzkaller.appspotmail.com
>>>
>>> WARNING: CPU: 0 PID: 19789 at net/rds/message.c:316
>>> rds_message_alloc_sgs+0x10c/0x160 net/rds/message.c:316
>>> Kernel panic - not syncing: panic_on_warn set ...
>> Looks like this kernel build has panic on warn enabled which
>> triggers panic for " WARN_ON(!nr_pages)" case. Will look into
>> it. Thanks !!
> 
> Please don't forget to remove user triggered WARN_ON.
> https://lwn.net/Articles/769365/
> "Greg Kroah-Hartman raised the problem of core kernel API code that will
> use WARN_ON_ONCE() to complain about bad usage; that will not generate
> the desired result if WARN_ON_ONCE() is configured to crash the machine.
> He was told that the code should just call pr_warn() instead, and that
> the called function should return an error in such situations. It was
> generally agreed that any WARN_ON() or WARN_ON_ONCE() calls that can be
> triggered from user space need to be fixed."
> 
OK. Thanks for the note !!
