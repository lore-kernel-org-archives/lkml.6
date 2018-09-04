Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31D1C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D99D2077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XHhiq2u2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D99D2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbeIEB4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 21:56:01 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57086 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbeIEB4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 21:56:01 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w84LNRhi018665;
        Tue, 4 Sep 2018 21:28:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 cc : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=04FZCNJpb9cAmcQ34LKzrsrVV3yxmdbHr4f8bmI7BAY=;
 b=XHhiq2u2YnOMhJgZw6a2TGUgRXck9RIaY0X24A4TNyL2zv4S6d0lplFPcsWZVKyB2usN
 PlUF4YsyAChH57KSPiFJ7ufC1Mwdbjgp58NQo0BXLQqyN/L4Eh0RqxkGirJbNof0i1Qo
 BhO7R5pRBiOcXDGz23DM4sf+4Tt3AD3fYECl7t4bKxoNQz0ndcLg3GKIP/BWMkn77imQ
 wsStWp36OYuBq4ylPj3J3CyY3knAZVgHgeYZc4AojdlbTcl09PUgQhSbTkWUpNxiWxW9
 MjL7xj+P3bjjbzv9jRMSGuXBeoePC4g0vGybkgYUbCyt7B2HPNzwgplJiRfxL4gjHh2W Aw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2m7kdqfpq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Sep 2018 21:28:21 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w84LSJh9003578
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Sep 2018 21:28:19 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w84LSHDv028773;
        Tue, 4 Sep 2018 21:28:18 GMT
Received: from [192.168.1.218] (/73.143.71.164)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Sep 2018 14:28:17 -0700
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Plumbers 2018 - Performance and Scalability Microconference
To:     linux-kernel@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Cc:     Aaron Lu <aaron.lu@intel.com>, alex.kogan@oracle.com,
        akpm@linux-foundation.org, boqun.feng@gmail.com, brouer@redhat.com,
        daniel.m.jordan@oracle.com, dave@stgolabs.net,
        dave.dice@oracle.com, Dhaval Giani <dhaval.giani@oracle.com>,
        ktkhai@virtuozzo.com, ldufour@linux.vnet.ibm.com,
        Pavel.Tatashin@microsoft.com, paulmck@linux.vnet.ibm.com,
        shady.issa@oracle.com, tariqt@mellanox.com, tglx@linutronix.de,
        tim.c.chen@intel.com, vbabka@suse.cz, longman@redhat.com,
        yang.shi@linux.alibaba.com, shy828301@gmail.com,
        Huang Ying <ying.huang@intel.com>, brouer@redhat.com,
        subhra.mazumdar@oracle.com,
        Steven Sistare <steven.sistare@oracle.com>, jwadams@google.com,
        ashwinch@google.com, sqazi@google.com,
        Shakeel Butt <shakeelb@google.com>, walken@google.com,
        rientjes@google.com, junaids@google.com,
        Neha Agarwal <nehaagarwal@google.com>
Message-ID: <1dc80ff6-f53f-ae89-be29-3408bf7d69cc@oracle.com>
Date:   Tue, 4 Sep 2018 17:28:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9006 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809040215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Tatashin, Ying Huang, and I are excited to be organizing a performance and scalability microconference this year at Plumbers[*], which is happening in Vancouver this year.  The microconference is scheduled for the morning of the second day (Wed, Nov 14).

We have a preliminary agenda and a list of confirmed and interested attendees (cc'ed), and are seeking more of both!

Some of the items on the agenda as it stands now are:

  - Promoting huge page usage:  With memory sizes becoming ever larger, huge pages are becoming more and more important to reduce TLB misses and the overhead of memory management itself--that is, to make the system scalable with the memory size.  But there are still some remaining gaps that prevent huge pages from being deployed in some situations, such as huge page allocation latency and memory fragmentation.

  - Reducing the number of users of mmap_sem:  This semaphore is frequently used throughout the kernel.  In order to facilitate scaling this longstanding bottleneck, these uses should be documented and unnecessary users should be fixed.

  - Parallelizing cpu-intensive kernel work:  Resolve problems of past approaches including extra threads interfering with other processes, playing well with power management, and proper cgroup accounting for the extra threads.  Bonus topic: proper accounting of workqueue threads running on behalf of cgroups.

  - Preserving userland during kexec with a hibernation-like mechanism.

These center around our interests, but having lots of topics to choose from ensures we cover what's most important to the community, so we would like to hear about additional topics and extensions to those listed here.  This includes, but is certainly not limited to, work in progress that would benefit from in-person discussion, real-world performance problems, and experimental and academic work.

If you haven't already done so, please let us know if you are interested in attending, or have suggestions for other attendees.

Thanks,
Daniel

[*] https://blog.linuxplumbersconf.org/2018/performance-mc/
