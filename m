Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C54C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 23:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C9942082C
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 23:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C9942082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbeIXFyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 01:54:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40222 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725919AbeIXFyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 01:54:46 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8NNsFdr019727
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 19:55:17 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mp2rn31b3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 19:55:17 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 23 Sep 2018 19:55:15 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 23 Sep 2018 19:55:13 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8NNtCqa14942394
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 23 Sep 2018 23:55:12 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD2FAB2068;
        Sun, 23 Sep 2018 19:53:35 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E12EB2065;
        Sun, 23 Sep 2018 19:53:35 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.154.62])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 23 Sep 2018 19:53:35 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 157E516C1971; Sun, 23 Sep 2018 16:55:12 -0700 (PDT)
Date:   Sun, 23 Sep 2018 16:55:12 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: Question about ->head field of rcu_segcblist
Reply-To: paulmck@linux.ibm.com
References: <CAEXW_YQd8s9GP-TACJCbT67ZCy5guTJMW+Jue3VsEX1777UhBQ@mail.gmail.com>
 <CAEXW_YTv2wFoaVW-1yv_S5pRo85Tiad-B4u4EaYBdCx5_KWRkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YTv2wFoaVW-1yv_S5pRo85Tiad-B4u4EaYBdCx5_KWRkQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18092323-0040-0000-0000-00000474E26A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009760; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01092701; UDB=6.00564701; IPR=6.00872736;
 MB=3.00023472; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-23 23:55:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092323-0041-0000-0000-0000087CE565
Message-Id: <20180923235512.GB4222@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-23_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809230253
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2018 at 07:31:37PM -0400, Joel Fernandes wrote:
> On Sun, Sep 23, 2018 at 7:30 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > Hi Paul,
> >
> > I was parsing the Data-Structures document and had a question about
> > the following "Important note" text.
> >
> > Could it be clarified in the below text better why "remaining
> > callbacks are placed back on the RCU_DONE_TAIL segment", is a reason
> > for not depending on ->head for determining if no callbacks are
> > associated with the rcu_segcblist? If callbacks are added back to the
> > DONE_TAIL segment, then I would think rcu_head should be != NULL.
> > Infact the "rsclp->head = *rsclp->tails[RCU_DONE_TAIL];" in
> > rcu_segcblist_extract_done_cbs should set the ->head to  NULL if I
> > understand correctly.
> 
> Just to clarify, I meant set to NULL assuming all cbs were done
> waiting and ready to be invoked.

Ah, good, then that is correct.  But even then, being NULL doesn't mean
no callbacks because they might be temporarily held by rcu_do_batch().

							Thanx, Paul

