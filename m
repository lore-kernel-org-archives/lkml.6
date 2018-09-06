Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCF1C4321E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2698A20844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="feOt0DAj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2698A20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbeIGCOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 22:14:47 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33750 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbeIGCOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 22:14:47 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w86LXu4O076812;
        Thu, 6 Sep 2018 21:36:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Och9rxEGmTEvoV4ajxvU5ranLDtkUFEtfNtIQhSVlQs=;
 b=feOt0DAj/7/E570KZ5bGVR4MMwBJk1qsY+RJ+9z5rxQyCyauZjqPq+kiuaZ+aEyKkD5P
 SXai5DnzdyDwHNLqhDeYqwsXCFSg83sHyYuoolQjGGuv/68HHCH8mlWNxtXRZ3H4q+kS
 SloeVpiAYW7i5DcZ9xsnBJu3XJH51B9JZ/rISfFTG9f0BpQz+0rl+tezn+uL6ZmWRTbO
 maAHh3hafbJ3GjdwmGv7BZspTAjUzPKPQXQJ6th5YJhhihlW56y5EZzrxa+2OoyJb4bj
 hilm1lm+t9Gyzx8CupFG40p6uJEiTNPgSAjH3339YzJuIcY/Orz7aCpPuXvBMUoAiTyG Pg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2m7kdqxfve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Sep 2018 21:36:47 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w86LajCt027688
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Sep 2018 21:36:45 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w86Laf8H003298;
        Thu, 6 Sep 2018 21:36:42 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Sep 2018 14:36:41 -0700
Subject: Re: Plumbers 2018 - Performance and Scalability Microconference
To:     "Huang, Ying" <ying.huang@intel.com>,
        Christopher Lameter <cl@linux.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux-kernel@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Aaron Lu <aaron.lu@intel.com>, alex.kogan@oracle.com,
        akpm@linux-foundation.org, boqun.feng@gmail.com, brouer@redhat.com,
        dave@stgolabs.net, dave.dice@oracle.com,
        Dhaval Giani <dhaval.giani@oracle.com>, ktkhai@virtuozzo.com,
        ldufour@linux.vnet.ibm.com, Pavel.Tatashin@microsoft.com,
        paulmck@linux.vnet.ibm.com, shady.issa@oracle.com,
        tariqt@mellanox.com, tglx@linutronix.de, tim.c.chen@intel.com,
        vbabka@suse.cz, longman@redhat.com, yang.shi@linux.alibaba.com,
        shy828301@gmail.com, subhra.mazumdar@oracle.com,
        Steven Sistare <steven.sistare@oracle.com>, jwadams@google.com,
        ashwinch@google.com, sqazi@google.com,
        Shakeel Butt <shakeelb@google.com>, walken@google.com,
        rientjes@google.com, junaids@google.com,
        Neha Agarwal <nehaagarwal@google.com>,
        Hugh Dickins <hughd@google.com>
References: <1dc80ff6-f53f-ae89-be29-3408bf7d69cc@oracle.com>
 <01000165aa490dc9-64abf872-afd1-4a81-a46d-a50d0131de93-000000@email.amazonses.com>
 <877ejzqtdy.fsf@yhuang-dev.intel.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <bd6f6f8b-4880-6c20-62f5-bb6ca3b5e6f7@oracle.com>
Date:   Thu, 6 Sep 2018 14:36:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <877ejzqtdy.fsf@yhuang-dev.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9008 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=666
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809060209
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2018 06:58 PM, Huang, Ying wrote:
> Hi, Christopher,
> 
> Christopher Lameter <cl@linux.com> writes:
> 
>> On Tue, 4 Sep 2018, Daniel Jordan wrote:
>>
>>>  - Promoting huge page usage:  With memory sizes becoming ever larger, huge
>>> pages are becoming more and more important to reduce TLB misses and the
>>> overhead of memory management itself--that is, to make the system scalable
>>> with the memory size.  But there are still some remaining gaps that prevent
>>> huge pages from being deployed in some situations, such as huge page
>>> allocation latency and memory fragmentation.
>>
>> You forgot the major issue that huge pages in the page cache are not
>> supported and thus we have performance issues with fast NVME drives that
>> are now able to do 3Gbytes per sec that are only possible to reach with
>> directio and huge pages.
> 
> Yes.  That is an important gap for huge page.  Although we have huge
> page cache support for tmpfs, we lacks that for normal file systems.
> 
>> IMHO the huge page issue is just the reflection of a certain hardware
>> manufacturer inflicting pain for over a decade on its poor users by not
>> supporting larger base page sizes than 4k. No such workarounds needed on
>> platforms that support large sizes. Things just zoom along without
>> contortions necessary to deal with huge pages etc.
>>
>> Can we come up with a 2M base page VM or something? We have possible
>> memory sizes of a couple TB now. That should give us a million or so 2M
>> pages to work with.
> 
> That sounds a good idea.  Don't know whether someone has tried this.

IIRC, Hugh Dickins and some others at Google tried going down this path.
There was a brief discussion at LSF/MM.  It is something I too would like
to explore in my spare time.

-- 
Mike Kravetz
