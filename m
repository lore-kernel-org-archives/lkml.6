Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC841C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD9220659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qjHe9qzd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbfANRFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 12:05:03 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:59126 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfANRFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 12:05:02 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0EGrksQ047505;
        Mon, 14 Jan 2019 17:04:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=7AFiiHYy7HBKm+Dazr0Agt4+SEq1G0/dENZ+3Arm9gQ=;
 b=qjHe9qzd1FfaQNDamwF5UBGPJppNtog/e/3cKn2kM6lv+CtkAtGIxoc7RYjjNFVsvz1Y
 S3j8suPhEGJuhw9t9H3KJoWkNMuLMkirVg7e76mzInPA93KmT/M4QMa+VKyz/uLZYdWy
 gAyRFMy7IahU86qt5Q0pP3szm8rWc6P6YPnTCZX9a8zw6SpHhnjL7PCsJiS/Uh16Hg0N
 5uxb9BIjzIFlhN+GX7Zau1576tW097yMDaGyuEAbPWw9ZUt41nAxAjoYucVqh+sXb9Yi
 5np3DOAL/47Tg38czK4UZzj5toypLcdBRWp/DIQDgyV8Tm6mWiF2anZY8X2x8a5J1UXx HQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2pybjrxqrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jan 2019 17:04:27 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0EH4Ptm002298
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jan 2019 17:04:26 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0EH4NGA016660;
        Mon, 14 Jan 2019 17:04:24 GMT
Received: from [10.152.35.100] (/10.152.35.100)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 14 Jan 2019 09:04:22 -0800
Subject: Re: [PATCH v4 10/10] sched/fair: Provide idle search schedstats
To:     Rick Lindsley <ricklind@linux.vnet.ibm.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        quentin.perret@arm.com, linux-kernel@vger.kernel.org
References: <1544131696-2888-1-git-send-email-steven.sistare@oracle.com>
 <1544131696-2888-11-git-send-email-steven.sistare@oracle.com>
 <6966a01e-8144-f268-ac9b-3e6fad3a5b2d@linux.vnet.ibm.com>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <5447e3b5-db58-1ace-9974-6dfc250b4a1e@oracle.com>
Date:   Mon, 14 Jan 2019 12:04:19 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <6966a01e-8144-f268-ac9b-3e6fad3a5b2d@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9136 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=635
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901140139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/24/2018 7:25 AM, Rick Lindsley wrote:
> On 12/06/2018 01:28 PM, Steve Sistare wrote:
>> Add schedstats to measure the effectiveness of searching for idle CPUs
>> and stealing tasks.  This is a temporary patch intended for use during
>> development only.  SCHEDSTAT_VERSION is bumped to 16, and the following
>> fields are added to the per-CPU statistics of /proc/schedstat:
> 
> Why only temporary?  It would seem that this might be useful information in the future too, for other developers with either new code or new use cases.
> 
> Rick

Yes, they could be useful.  I suspect it would take a while to reach consensus
on new field definition, and whether their usefulness outweighs the downside
of breaking out of tree tools that assume version 15.

- Steve
