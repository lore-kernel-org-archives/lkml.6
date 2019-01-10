Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD797C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7384208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbfAJTDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 14:03:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57780 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728297AbfAJTDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 14:03:49 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0AIx0XT068949
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 14:03:47 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2px9mvpfd8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 14:03:47 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 10 Jan 2019 19:03:46 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 10 Jan 2019 19:03:41 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0AJ3e1Q16908306
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Jan 2019 19:03:40 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67741B2064;
        Thu, 10 Jan 2019 19:03:40 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4725CB205F;
        Thu, 10 Jan 2019 19:03:40 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 10 Jan 2019 19:03:40 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2EDD916C5F90; Thu, 10 Jan 2019 11:03:41 -0800 (PST)
Date:   Thu, 10 Jan 2019 11:03:41 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, parri.andrea@gmail.com, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, willy@infradead.org
Subject: Re: [PATCH RFC memory-model 0/6] LKMM updates
Reply-To: paulmck@linux.ibm.com
References: <20190109210706.GA27268@linux.ibm.com>
 <Pine.LNX.4.44L0.1901101046480.1497-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1901101046480.1497-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19011019-0068-0000-0000-00000380C73E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010380; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144569; UDB=6.00595964; IPR=6.00924833;
 MB=3.00025072; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-10 19:03:45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011019-0069-0000-0000-000047155B09
Message-Id: <20190110190341.GV1215@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-10_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=1 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901100147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 10:47:26AM -0500, Alan Stern wrote:
> On Wed, 9 Jan 2019, Paul E. McKenney wrote:
> 
> > Hello!
> > 
> > This series contains updates for the Linux-kernel memory model:
> > 
> > 1-3.	Add SRCU support, courtesy of Alan Stern.
> > 
> > 4.	Update README for adding of SRCU support.
> > 
> > 5.	Update memory-barriers.txt on enforcing heavy ordering for
> > 	port-I/O accesses, courtesy of Will Deacon.  This one needs
> > 	an ack, preferably by someone from Intel.  Matthew Wilcox
> > 	posted some feedback from an Intel manual here, which might
> > 	be considered to be a close substitute, but...  ;-)
> > 
> > 	http://lkml.kernel.org/r/20181127192234.GF10377@bombadil.infradead.org
> > 
> > 6.	Update Documentation/explanation.txt to include SRCU support,
> > 	courtesy of Alan Stern.
> > 
> > 7.	Dynamically check SRCU lock-to-unlock matching, courtesy of
> > 	Luc Maranget.  This needs an ack.
> 
> Does this one still need an ack?  If so, you may apply mine.

Applied, thank you!

							Thanx, Paul

