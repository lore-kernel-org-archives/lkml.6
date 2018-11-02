Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D03C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 283D52081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 283D52081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbeKBWUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 18:20:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44626 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726094AbeKBWUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 18:20:24 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA2DAaU8073633
        for <linux-kernel@vger.kernel.org>; Fri, 2 Nov 2018 09:13:16 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ngnusbswy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 09:13:15 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 2 Nov 2018 13:13:15 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 2 Nov 2018 13:13:12 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA2DDBiF2490648
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 2 Nov 2018 13:13:11 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD80BB2065;
        Fri,  2 Nov 2018 13:13:11 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B938B2064;
        Fri,  2 Nov 2018 13:13:11 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.148.108])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  2 Nov 2018 13:13:11 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C0DF516C0659; Fri,  2 Nov 2018 06:13:11 -0700 (PDT)
Date:   Fri, 2 Nov 2018 06:13:11 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     NeilBrown <neil@brown.name>, Mishi Choudhary <mishi@linux.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org
Subject: Re: [Ksummit-discuss] Call to Action Re: [PATCH 0/7] Code of
 Conduct: Fix some wording, and add an interpretation document
Reply-To: paulmck@linux.ibm.com
References: <20181020134908.GA32218@kroah.com>
 <87y3ar80ac.fsf@notabene.neil.brown.name>
 <20181021222608.GA24845@localhost>
 <875zxt919d.fsf@notabene.neil.brown.name>
 <20181024121622.GA10942@localhost>
 <87ftwt6850.fsf@notabene.neil.brown.name>
 <20181027011010.GA29769@localhost>
 <20181101164544.GA31540@linux.ibm.com>
 <20181101211152.GA6007@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101211152.GA6007@localhost>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18110213-0052-0000-0000-0000034EE983
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009971; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01111581; UDB=6.00576065; IPR=6.00891673;
 MB=3.00024004; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-02 13:13:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110213-0053-0000-0000-00005EA1197D
Message-Id: <20181102131311.GP4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-02_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=610 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811020121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 02:11:53PM -0700, Josh Triplett wrote:
> On Thu, Nov 01, 2018 at 09:45:44AM -0700, Paul E. McKenney wrote:
> > On Sat, Oct 27, 2018 at 02:10:10AM +0100, Josh Triplett wrote:
> > > Not when that document started out effectively saying, in an elaborate
> > > way, "code > people".
> > 
> > Interesting.
> > 
> > I am curious what leads you to your "code > people" statement.  Of course,
> > one could argue that this does not really matter given that the code of
> > conflict is no longer.  However, I would like to understand for future
> > reference, if for no other reason.
> > 
> > One possibility is that you are restricting the "people" to only those
> > people directly contributing in one way or another.  But those using the
> > kernel (both directly and indirectly) are important as well, and it is
> > exactly this group that is served by "the most robust operating system
> > kernel ever", the chest-beating sentiment notwithstanding.  Which is in
> > fact why I must reject (or rework or whatever) any patch that might result
> > in too-short RCU grace periods:  The needs of the patch's submitter are
> > quite emphatically outweighed by the needs of the kernel's many users,
> > and many of the various technical requirements and restrictions are in
> > fact proxies for the needs of these users.
> 
> As discussed in many other places as well, nobody is suggesting at all
> that the standards for accepting code should change. Reject the patches
> you would have rejected, accept the patches you would have accepted.

There have been a great many discussions in a great many places expressing
a great many views, but it is good to hear your view on this particular
point.  It should come as no surprise that I advise you in the strongest
possible terms to continue with the view that standards for accepting code
into the Linux kernel should not decrease.

>                                                                      All
> of this affects *communication*.

Communication is inherently difficult.  As I suspect the two of us just
demonstrated.  ;-)

							Thanx, Paul

