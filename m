Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753265AbeFDNtB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 09:49:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56946 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753063AbeFDNs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 09:48:59 -0400
Date: Mon, 4 Jun 2018 06:48:52 -0700
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 04/19] sched/numa: Set preferred_node based on best_cpu
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1528106428-19992-5-git-send-email-srikar@linux.vnet.ibm.com>
 <20180604122336.GS12217@hirez.programming.kicks-ass.net>
 <20180604125939.GB38574@linux.vnet.ibm.com>
 <20180604133953.GU12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180604133953.GU12217@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18060413-0028-0000-0000-000002CC862E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060413-0029-0000-0000-000023830C51
Message-Id: <20180604134852.GA30328@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-04_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806040163
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Zijlstra <peterz@infradead.org> [2018-06-04 15:39:53]:

> > >
> > > That seems to entirely loose the active_node thing, or are you saying
> > > best_cpu already includes that? (Changelog could use a little help there
> > > I suppose)
> > 
> > I think checking for active_nodes before calling sched_setnuma was a
> > mistake.
> > 
> > Before this change, we may be retaining numa_preferred_nid to be the
> > source node while we select another node with better numa affinity to
> > run on. So we are creating a situation where we force a thread to run on
> > a node which is not going to be its preferred_node. So in the course of
> > regular load balancing, this task might then be moved to set
> > preferred_node which is actually not the preferred_node.
> 
> Then your Changelog had better explain all that, no?
> 

I had mentioned
"Modify to set the preferred node based of best_cpu."
I will update that to describe the situation.
