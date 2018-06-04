Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751149AbeFDPpb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 11:45:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37446 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750815AbeFDPpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 11:45:30 -0400
Date: Mon, 4 Jun 2018 08:45:20 -0700
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Rik van Riel <riel@surriel.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 02/19] sched/numa: Evaluate move once per node
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1528106428-19992-3-git-send-email-srikar@linux.vnet.ibm.com>
 <1528123887.7898.103.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1528123887.7898.103.camel@surriel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18060415-0020-0000-0000-0000029701B6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060415-0021-0000-0000-000020E301BD
Message-Id: <20180604154520.GB30328@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-04_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806040184
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Rik van Riel <riel@surriel.com> [2018-06-04 10:51:27]:

> On Mon, 2018-06-04 at 15:30 +0530, Srikar Dronamraju wrote:
> 
> 
> Just bike shedding, but it may be easier to read
> if the "we found our destination" check were written
> more explicitly:
> 
> 
> 	if (!cur) {
> 		if (move && imp > env->best_imp)
> 			gote assign;
> 		else
> 			goto unlock;
> 	}
> 

will incorporate this.


> Also, the "move" variable seems to indicate that
> the NUMA code may move the task, but not a decision
> that moving the task is better than a swap.
> 
> Would it make sense to call it "maymove"?

Okay, will incorporate this too.

> 
> I like how this patch simplifies the code a little.
> 

Thanks.
