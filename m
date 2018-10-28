Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27863C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 17:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4EC820831
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 17:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4EC820831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbeJ2COn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 22:14:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42618 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726592AbeJ2COn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 22:14:43 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9SHTQ66195841
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 13:29:26 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nd54hu0th-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 13:29:26 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 28 Oct 2018 13:29:22 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 28 Oct 2018 13:29:17 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9SHTHeU28115106
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 28 Oct 2018 17:29:17 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EBE71B2064;
        Sun, 28 Oct 2018 17:29:16 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9CDDB205F;
        Sun, 28 Oct 2018 17:29:16 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.185.180])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 28 Oct 2018 17:29:16 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 39AF016C06E6; Sun, 28 Oct 2018 10:29:18 -0700 (PDT)
Date:   Sun, 28 Oct 2018 10:29:18 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] rcu: doc: update example about stale data
Reply-To: paulmck@linux.ibm.com
References: <20181028021653.155513-1-joel@joelfernandes.org>
 <CAEXW_YTCJS9Yxt4J=nbF+Omdon_4Li2BUiVzALGX246fMA9J2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YTCJS9Yxt4J=nbF+Omdon_4Li2BUiVzALGX246fMA9J2Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18102817-0060-0000-0000-000002C80516
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009945; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01109274; UDB=6.00574677; IPR=6.00889360;
 MB=3.00023940; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-28 17:29:22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102817-0061-0000-0000-0000470069B4
Message-Id: <20181028172918.GO4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-28_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=946 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810280162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 27, 2018 at 09:44:31PM -0700, Joel Fernandes wrote:
> On Sat, Oct 27, 2018 at 7:16 PM, Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> > The RCU example for 'rejecting stale data' on system-call auditting
> > stops iterating through the rules if a deleted one is found. It makes
> > more sense to continue looking at other rules once a deleted one is
> > rejected. Although the original example is fine, this makes it more
> > meaningful.
> 
> Sorry, I messed up the patch title, it is supposed to be 'doc: rcu:
> ...'. I can resend it if you want.

Hmmm...  There doesn't seem to be any consistent standard for documentation
patches.  I see "Documentation: networking:", "docs:", "doc:" (which is
what I normally use), "doc:doc-guide:", "Documentation/process:",
"doc/devicetree:", "media: doc:", and who knows what all else.

Including "Documentation" seems excessive.  I guess I am OK with
"doc: rcu:", but either just plain "doc:" or "doc/rcu:" would be fine
with me as well.

							Thanx, Paul

