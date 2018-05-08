Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933201AbeEHQvy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 12:51:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38122 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932960AbeEHQvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 12:51:53 -0400
Date: Tue, 8 May 2018 09:53:13 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/signal: Remove no longer required irqsave/restore
Reply-To: paulmck@linux.vnet.ibm.com
References: <87sh77b5w7.fsf@xmission.com>
 <20180504194510.GW26088@linux.vnet.ibm.com>
 <87vac39oaf.fsf@xmission.com>
 <20180504203713.GY26088@linux.vnet.ibm.com>
 <87k1siaf8y.fsf@xmission.com>
 <20180505052500.GN26088@linux.vnet.ibm.com>
 <alpine.DEB.2.21.1805050755240.1685@nanos.tec.linutronix.de>
 <alpine.DEB.2.20.1805081539060.2262@hypnos.tec.linutronix.de>
 <20180508145351.GC26088@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1805081744090.2262@hypnos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1805081744090.2262@hypnos.tec.linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18050816-0056-0000-0000-0000044B65A8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008994; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000259; SDB=6.01029372; UDB=6.00525984; IPR=6.00808505;
 MB=3.00020997; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-08 16:51:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050816-0057-0000-0000-0000088F72D5
Message-Id: <20180508165313.GH26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-08_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805080161
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08, 2018 at 05:49:25PM +0200, Anna-Maria Gleixner wrote:
> On Tue, 8 May 2018, Paul E. McKenney wrote:
> 
> > On Tue, May 08, 2018 at 03:42:25PM +0200, Anna-Maria Gleixner wrote:
> > > On Sat, 5 May 2018, Thomas Gleixner wrote:
> > > 
> > > > On Fri, 4 May 2018, Paul E. McKenney wrote:
> > > > > On Fri, May 04, 2018 at 11:38:37PM -0500, Eric W. Biederman wrote:
> > > > > > > (Me, I would run rcutorture scenario TREE03 for an extended time period
> > > > > > > on b4abf91047cf with your patch applied.
> > > > > 
> > > > > And with lockdep enabled, which TREE03 does not do by default.
> > > > 
> > > > Will run that again to make sure.
> > > 
> > > I ran the rcutorture scenario TREE03 for 4 hours with the above
> > > described setup. It was successful and without any lockdep splats.
> > 
> > Thank you for the testing, Anna-Maria!  If you give them a Tested-by,
> > I will give them an ack.  ;-)
> > 
> 
> If it is ok to give a Tested-by to the patch I wrote, I will do this
> to get your ack :)
> 
> Tested-by: Anna-Maria Gleixner <anna-maria@linutronix.de>

It wasn't even all that early in the morning for me, was it?  ;-)
Anyway:

Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

I am sure that you have already considered adding your test results to the
commit log as an alternative to applying a Tested-by to your own patch.

							Thanx, Paul
