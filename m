Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F21DC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680ED2081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OzvZ2uOB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 680ED2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbeKHFuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:50:21 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:58182 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbeKHFuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:50:21 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA7KE0q7030267;
        Wed, 7 Nov 2018 20:17:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=+WWL/hQutMQsmGXNEbRLbDY4ZbZKu1vK68oS0++EHd0=;
 b=OzvZ2uOBCL06qIQw3A9yIh3jSdTXLTxLiuj9uWDXtekPLITXd2Elb3+JwvOFiigWumeI
 K9yHO60+bAnn4Y06UEs6z5eJ+mdRkXAeIT9pkqu0tDXK5S1fX9Gz4fLSZc+WAcguzL9W
 +uBhu5DWR6zXvwDDuol8XyP0jSsChXw7oRHJgDtbIyA8q+2B7IugepzNmY49KffvXxBA
 DU47RbZ3UmTUyy5Mg2XFA+1irv8Zn+DvDz2s56hXxqWgWcvdkaXD6RSHOQMOjljiCONf
 wF79xWgfJ9z6YooVxgHcrm4RABXTnlLz7KsmEvGHQdEKAUOWiQC7asHYZDhpiMCMfORW eQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2nh3mpwsng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Nov 2018 20:17:47 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA7KHgEh002694
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Nov 2018 20:17:42 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wA7KHeA4032689;
        Wed, 7 Nov 2018 20:17:40 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 07 Nov 2018 12:17:39 -0800
Date:   Wed, 7 Nov 2018 12:17:47 -0800
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>, linux-mm@kvack.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        aarcange@redhat.com, aaron.lu@intel.com, akpm@linux-foundation.org,
        alex.williamson@redhat.com, bsd@redhat.com,
        darrick.wong@oracle.com, dave.hansen@linux.intel.com,
        jgg@mellanox.com, jwadams@google.com, jiangshanlai@gmail.com,
        mike.kravetz@oracle.com, Pavel.Tatashin@microsoft.com,
        prasad.singamsetty@oracle.com, rdunlap@infradead.org,
        steven.sistare@oracle.com, tim.c.chen@intel.com, tj@kernel.org,
        vbabka@suse.cz, peterz@infradead.org
Subject: Re: [RFC PATCH v4 00/13] ktask: multithread CPU-intensive kernel work
Message-ID: <20181107201746.luifrt3l2l7bkych@ca-dmjordan1.us.oracle.com>
References: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
 <20181105172931.GP4361@dhcp22.suse.cz>
 <20181106012955.br5swua3ykvolyjq@ca-dmjordan1.us.oracle.com>
 <20181106092145.GF27423@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181106092145.GF27423@dhcp22.suse.cz>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9070 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811070180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 10:21:45AM +0100, Michal Hocko wrote:
> On Mon 05-11-18 17:29:55, Daniel Jordan wrote:
> > On Mon, Nov 05, 2018 at 06:29:31PM +0100, Michal Hocko wrote:
> > > On Mon 05-11-18 11:55:45, Daniel Jordan wrote:
> > > > Michal, you mentioned that ktask should be sensitive to CPU utilization[1].
> > > > ktask threads now run at the lowest priority on the system to avoid disturbing
> > > > busy CPUs (more details in patches 4 and 5).  Does this address your concern?
> > > > The plan to address your other comments is explained below.
> > > 
> > > I have only glanced through the documentation patch and it looks like it
> > > will be much less disruptive than the previous attempts. Now the obvious
> > > question is how does this behave on a moderately or even busy system
> > > when you compare that to a single threaded execution. Some numbers about
> > > best/worst case execution would be really helpful.
> > 
> > Patches 4 and 5 have some numbers where a ktask and non-ktask workload compete
> > against each other.  Those show either 8 ktask threads on 8 CPUs (worst case) or no ktask threads (best case).
> > 
> > By single threaded execution, I guess you mean 1 ktask thread.  I'll run the
> > experiments that way too and post the numbers.
> 
> I mean a comparision of how much time it gets to accomplish the same
> amount of work if it was done singlethreaded to ktask based distribution
> on a idle system (best case for both) and fully contended system (the
> worst case). It would be also great to get some numbers on partially
> contended system to see how much the priority handover etc. acts under
> different CPU contention.

Ok, thanks for clarifying.

Testing notes
 - The two workloads used were confined to run anywhere within an 8-CPU cpumask
 - The vfio workload started a 64G VM using THP
 - usemem was enlisted to create CPU load doing page clearing, just as the vfio
   case is doing, so the two compete for the same system resources.  usemem ran
   four times with each of its threads allocating and freeing 30G of memory each
   time.  Four usemem threads simulate Michal's partially contended system
 - ktask helpers always run at MAX_NICE
 - renice?=yes means run with patch 5, renice?=no means without
 - CPU:   2 nodes * 24 cores/node * 2 threads/core = 96 CPUs
          Intel(R) Xeon(R) Platinum 8160 CPU @ 2.10GHz
						
         vfio  usemem
          thr     thr  renice?          ktask sec        usemem sec
        -----  ------  -------   ----------------  ----------------
                    4      n/a                      24.0 ( ± 0.1% )
                    8      n/a                      25.3 ( ± 0.0% )
                                                             
            1       0      n/a   13.5 ( ±  0.0% )
            1       4      n/a   14.2 ( ±  0.4% )   24.1 ( ± 0.3% )
 ***        1       8      n/a   17.3 ( ± 10.4% )   29.7 ( ± 0.4% )
                                                             
            8       0       no    2.8 ( ±  1.5% )
            8       4       no    4.7 ( ±  0.8% )   24.1 ( ± 0.2% )
            8       8       no   13.7 ( ±  8.8% )   27.2 ( ± 1.2% )
        
            8       0      yes    2.8 ( ±  1.0% )
            8       4      yes    4.7 ( ±  1.4% )   24.1 ( ± 0.0% )
 ***        8       8      yes    9.2 ( ±  2.2% )   27.0 ( ± 0.4% )

Renicing under partial contention (usemem nthr=4) doesn't affect vfio, but
renicing under heavy contention (usemem nthr=8) does: the 8-thread vfio case is
slower when the ktask master thread doesn't will its priority to each helper at
a time.

Comparing the ***'d lines, using 8 vfio threads instead of 1 causes the threads
of both workloads to finish sooner under heavy contention.
