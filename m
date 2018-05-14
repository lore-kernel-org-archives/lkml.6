Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752504AbeENVHc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 17:07:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58320 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752127AbeENVHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 17:07:31 -0400
Date: Mon, 14 May 2018 14:08:57 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Joe Perches <joe@perches.com>, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 18/18] rcu: Use pr_fmt to prefix "rcu: " to logging output
Reply-To: paulmck@linux.vnet.ibm.com
References: <cover.1525964381.git.joe@perches.com>
 <41d9686471d67f6f98d160e5891bf61061515b6d.1525964386.git.joe@perches.com>
 <20180514202910.GI26088@linux.vnet.ibm.com>
 <CAHp75Vf2O4xryPu9qFxCW7HP58Uz9c860xfNSUHKyvCqJyA8Ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vf2O4xryPu9qFxCW7HP58Uz9c860xfNSUHKyvCqJyA8Ew@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18051421-0040-0000-0000-0000042B36A1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009026; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032335; UDB=6.00527755; IPR=6.00811466;
 MB=3.00021113; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-14 21:07:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051421-0041-0000-0000-000008314A74
Message-Id: <20180514210857.GN26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805140211
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 11:37:56PM +0300, Andy Shevchenko wrote:
> On Mon, May 14, 2018 at 11:29 PM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> > On Thu, May 10, 2018 at 08:45:44AM -0700, Joe Perches wrote:
> 
> > And I took this (but kept the period), plus used "%s" to make it fit in
> > 80 characters:
> >
> >         pr_info("\tRCU restricting CPUs from %s=%d to %s=%u.\n",
> >                 "NR_CPUS", NR_CPUS, "nr_cpu_ids", nr_cpu_ids);
> 
> Why do care about 80 characters for string literals? (Checkpatch
> dropped this limit long time ago after some discussions)
> I think it's better to find line if more context given (this my
> objection agains %s for string literals).

Good point!  I am reverting that portion of the commit with attribution,
thank you!

						Thanx, Paul
