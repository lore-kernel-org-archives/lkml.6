Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934699AbeE2NLQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 09:11:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41932 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934669AbeE2NLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 09:11:06 -0400
Subject: Re: [next-20180517][ppc] watchdog: CPU 88 self-detected hard LOCKUP
 @ update_cfs_group+0x30/0x150
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: sachinp <sachinp@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 29 May 2018 18:39:40 +0530
In-Reply-To: <20180521165056.5f3dceeb@roar.ozlabs.ibm.com>
References: <1526883300.19317.18.camel@abdul>
         <20180521165056.5f3dceeb@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18052913-0020-0000-0000-00000E090A5C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009096; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000264; SDB=6.01039372; UDB=6.00531955; IPR=6.00818500;
 MB=3.00021358; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-29 13:11:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052913-0021-0000-0000-000061A315D4
Message-Id: <1527599380.3777.3.camel@abdul>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-29_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805290150
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-05-21 at 16:50 +1000, Nicholas Piggin wrote:
> Ah, it's POWER8.
> 
> I'm betting we have a bug with nohz timer offloading somewhere.
> 
> I *think* we may have seen similar on P9 as well, but that may be
> related to problems with stop states.
> 
> Can you reproduce it easily? I'm thinking maybe adding some
> tracepoints that track decrementer settings and interrupts, and
> nohz offload activity might show something up.

Yes, the problem is reproducible consistently on our CI setup and today
It triggered on 4.17.0-rc6 (mainline) too.

-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
