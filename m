Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D31CECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 23:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C38852085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 23:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U31uksvd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C38852085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbeJ0HpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 03:45:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57518 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbeJ0HpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 03:45:18 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9QN4ICE116328;
        Fri, 26 Oct 2018 23:05:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=E2TBzyRn4FlZDssLAOxZ1HbDJPookG1+ECYnRV9id/A=;
 b=U31uksvdoYOnWiyTkL18NMEqLO/sUBppiU8JaG09naPwnKkM6s+0PAcPPoxehdUpcxs3
 Ghg1BoIsVwgW2DJ6eSc/PqwwQO1Tz1j1NweSjDOa5gojiRT4ZoGMSOE8TCXF6VTD46P5
 2UVoTRsiXsnQ0x1A3cUU6cZ1SImEEwDVHK6Em4eA2Q/hi7J5Ya6j1lrWJco0S5Mrkg81
 4VoG7NyJbJ8pY9OGu9jk7qCcTFtynkGhcLRMs6We18kgaAxHV+53EQyEZ0wb4ByCEcqt
 +cszmW8889HReK7+1Y2DWfRq67IckUikU7XtSVCHTh7SDFgWA8f9aGd7JNQK6XprTTzu bw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2n7ususj03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Oct 2018 23:05:54 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9QN5sKL005016
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Oct 2018 23:05:54 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9QN5rkp008015;
        Fri, 26 Oct 2018 23:05:54 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 26 Oct 2018 16:05:52 -0700
Subject: Re: [RFC 00/60] Coscheduling for Linux
To:     =?UTF-8?Q?Jan_H=2e_Sch=c3=b6nherr?= <jschoenh@amazon.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
References: <20180907214047.26914-1-jschoenh@amazon.de>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <65abfba5-7c51-fd99-898e-f6e74969fea3@oracle.com>
Date:   Fri, 26 Oct 2018 16:05:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20180907214047.26914-1-jschoenh@amazon.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9058 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810260192
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> D) What can I *not* do with this?
> ---------------------------------
>
> Besides the missing load-balancing within coscheduled task-groups, this
> implementation has the following properties, which might be considered
> short-comings.
>
> This particular implementation focuses on SCHED_OTHER tasks managed by CFS
> and allows coscheduling them. Interrupts as well as tasks in higher
> scheduling classes are currently out-of-scope: they are assumed to be
> negligible interruptions as far as coscheduling is concerned and they do
> *not* cause a preemption of a whole group. This implementation could be
> extended to cover higher scheduling classes. Interrupts, however, are an
> orthogonal issue.
>
> The collective context switch from one coscheduled set of tasks to another
> -- while fast -- is not atomic. If a use-case needs the absolute guarantee
> that all tasks of the previous set have stopped executing before any task
> of the next set starts executing, an additional hand-shake/barrier needs to
> be added.
>
The leader doesn't kick the other cpus _immediately_ to switch to a
different cosched group. So threads from previous cosched group will keep
running in other HTs till their sched_slice is over (in worst case). This
can still keep the window of L1TF vulnerability open?
