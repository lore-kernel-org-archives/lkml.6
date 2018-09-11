Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE83C43143
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 00:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A86542086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 00:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zCBHge2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A86542086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbeIKFfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 01:35:48 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45916 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeIKFfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 01:35:48 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8B0cgQS087625;
        Tue, 11 Sep 2018 00:38:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=YZA/Cq+l3yBuMoAjxpcuIVFJlaNzR3dZ4jRE5uiip8I=;
 b=zCBHge2/zqGbMzuCO2kxnNq6BNkguAvynhh+Y04yB+ZWO546/Llj9ZVJMOaUfDyP6r6o
 wIntoEywUDKUslf26hSgdGK/lR0ZoSSAdXubbb+9b6D1VMPdZs8Q2VaekCQ4VRIxHPsI
 I08qIist2O9DbQKlcvLLJnKbHShQ/AxxyZCXOEeThNbAAYqA67gyyKfoLFGy2NZJV4EM
 +n3fcRPtPpyMndyNWvNK5FSvkuM17zabe2GxpTfJkKoztgpUXrtIb1SY1yiofZo1lpGZ
 kyRGkBZVibWq3pgfretm35BU6zn7Ces/8YNpGBl39ciNvGKFEihosuJ3omUA9e29M0sJ DA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2mc6cph17t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Sep 2018 00:38:42 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8B0ceJ1024898
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Sep 2018 00:38:41 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8B0cdTR023777;
        Tue, 11 Sep 2018 00:38:39 GMT
Received: from [192.168.1.218] (/73.143.71.164)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Sep 2018 17:38:39 -0700
Subject: Re: Plumbers 2018 - Performance and Scalability Microconference
To:     John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Cc:     Aaron Lu <aaron.lu@intel.com>, alex.kogan@oracle.com,
        akpm@linux-foundation.org, boqun.feng@gmail.com, brouer@redhat.com,
        dave@stgolabs.net, dave.dice@oracle.com,
        Dhaval Giani <dhaval.giani@oracle.com>, ktkhai@virtuozzo.com,
        ldufour@linux.vnet.ibm.com, Pavel.Tatashin@microsoft.com,
        paulmck@linux.vnet.ibm.com, shady.issa@oracle.com,
        tariqt@mellanox.com, tglx@linutronix.de, tim.c.chen@intel.com,
        vbabka@suse.cz, longman@redhat.com, yang.shi@linux.alibaba.com,
        shy828301@gmail.com, Huang Ying <ying.huang@intel.com>,
        subhra.mazumdar@oracle.com,
        Steven Sistare <steven.sistare@oracle.com>, jwadams@google.com,
        ashwinch@google.com, sqazi@google.com,
        Shakeel Butt <shakeelb@google.com>, walken@google.com,
        rientjes@google.com, junaids@google.com,
        Neha Agarwal <nehaagarwal@google.com>
References: <1dc80ff6-f53f-ae89-be29-3408bf7d69cc@oracle.com>
 <35c2c79f-efbe-f6b2-43a6-52da82145638@nvidia.com>
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
Message-ID: <0f49f722-1759-f097-ff46-4ec7286dc69e@oracle.com>
Date:   Mon, 10 Sep 2018 20:38:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <35c2c79f-efbe-f6b2-43a6-52da82145638@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9012 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809110006
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/18 12:13 AM, John Hubbard wrote:
> I'm interested in the first 3 of those 4 topics, so if it doesn't conflict with HMM topics or
> fix-gup-with-dma topics, I'd like to attend.

Great, we'll add your name to the list.

> GPUs generally need to access large chunks of
> memory, and that includes migrating (dma-copying) pages around.
> 
> So for example a multi-threaded migration of huge pages between normal RAM and GPU memory is an
> intriguing direction (and I realize that it's a well-known topic, already). Doing that properly
> (how many threads to use?) seems like it requires scheduler interaction.

Yes, in past discussions of multithreading kernel work, there's been some discussion of a scheduler API that could answer "are there idle CPUs we could use to multithread?".

Instead of adding an interface, though, we could just let the scheduler do something it already knows how to do: prioritize.

Additional threads used to parallelize kernel work could run at the lowest priority (i.e. MAX_NICE).  If the machine is heavily loaded, these extra threads simply won't run and other workloads on the system will be unaffected.

There's the issue of priority inversion if one or more of those extra threads get started and are then preempted by normal-priority tasks midway through, but the main thread doing the job can just will its priority to each worker in turn once it's finished, so at most one thread will be active on a heavily loaded system, again leaving other workloads on the system undisturbed.
