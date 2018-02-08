Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751986AbeBHEKh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 23:10:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44012 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751269AbeBHEKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 23:10:35 -0500
Date: Wed, 7 Feb 2018 20:10:39 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Matthew Wilcox <willy@infradead.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        mingo@redhat.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rao.shoaib@oracle.com
Subject: Re: [PATCH 0/2] rcu: Transform kfree_rcu() into kvfree_rcu()
Reply-To: paulmck@linux.vnet.ibm.com
References: <151791170164.5994.8253310844733420079.stgit@localhost.localdomain>
 <20180207021703.GC3617@linux.vnet.ibm.com>
 <20180207042334.GA16175@bombadil.infradead.org>
 <20180207050200.GH3617@linux.vnet.ibm.com>
 <db9bda80-7506-ae25-2c0a-45eaa08963d9@virtuozzo.com>
 <20180207083104.GK3617@linux.vnet.ibm.com>
 <20180207085700.393f90d0@gandalf.local.home>
 <20180207174513.5cc9b503@redhat.com>
 <20180207181055.GB12446@bombadil.infradead.org>
 <20180207132619.6595e4a9@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207132619.6595e4a9@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18020804-0056-0000-0000-000004178461
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008494; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000249; SDB=6.00986544; UDB=6.00500676; IPR=6.00765908;
 BA=6.00005819; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019434; XFM=3.00000015;
 UTC=2018-02-08 04:10:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020804-0057-0000-0000-0000084EF47D
Message-Id: <20180208041039.GR3617@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-08_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802080036
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 01:26:19PM -0500, Steven Rostedt wrote:
> On Wed, 7 Feb 2018 10:10:55 -0800
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > > For the record, I fully agree with Steve here. 
> 
> Thanks, but...
> 
> > > 
> > > And being a performance "fanatic" I don't like to have the extra branch
> > > (and compares) in the free code path... but it's a MM-decision (and
> > > sometimes you should not listen to "fanatics" ;-))  
> > 
> > While free_rcu() is not withut its performance requirements, I think it's
> > currently dominated by cache misses and not by branches.  By the time RCU
> > gets to run callbacks, memory is certainly L1/L2 cache-cold and probably
> > L3 cache-cold.  Also calling the callback functions is utterly impossible
> > for the branch predictor.
> 
> I agree with Matthew.
> 
> This is far from any fast path. A few extra branches isn't going to
> hurt anything here as it's mostly just garbage collection. With or
> without the Spectre fixes.

What Steve said!

							Thanx, Paul
