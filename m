Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92509ECE566
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE3821521
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:48:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE3821521
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733286AbeITE2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 00:28:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57834 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725993AbeITE2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 00:28:46 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8JMiZR7144959
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 18:48:38 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mkuuprm4g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 18:48:38 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 19 Sep 2018 18:48:37 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 19 Sep 2018 18:48:36 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8JMmZ5i35127492
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Sep 2018 22:48:35 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7686CB2064;
        Wed, 19 Sep 2018 18:47:04 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5558BB205F;
        Wed, 19 Sep 2018 18:47:04 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 19 Sep 2018 18:47:04 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 736D716C16E4; Wed, 19 Sep 2018 15:48:35 -0700 (PDT)
Date:   Wed, 19 Sep 2018 15:48:35 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        dougmill@linux.ibm.com, eajames@linux.ibm.com, haver@linux.ibm.com,
        fbarrat@linux.ibm.com, jallen@linux.ibm.com, manoj@linux.ibm.com,
        mrochs@linux.ibm.com, mikecyr@linux.ibm.com, zohar@linux.ibm.com,
        naveen.n.rao@linux.ibm.com, pfsmorigo@linux.ibm.com,
        pjk1939@linux.ibm.com, seroyer@linux.ibm.com,
        tlfalcon@linux.ibm.com, tyreld@linux.ibm.com, ukrishn@linux.ibm.com
Subject: Re: [PATCH RFC] MAINTAINERS: Update from @linux.vnet.ibm.com to
 @linux.ibm.com
Reply-To: paulmck@linux.ibm.com
References: <20180919222733.GA13679@linux.ibm.com>
 <1537396264.14262.5.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1537396264.14262.5.camel@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18091922-0052-0000-0000-00000333AE5B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009736; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01090779; UDB=6.00563538; IPR=6.00870800;
 MB=3.00023396; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-19 22:48:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091922-0053-0000-0000-00005E20EB74
Message-Id: <20180919224835.GJ4222@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-19_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809190220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 03:31:04PM -0700, James Bottomley wrote:
> On Wed, 2018-09-19 at 15:27 -0700, Paul E. McKenney wrote:
> > IBM's patch-friendly email infrastructure is changing domains from
> > @linux.vnet.ibm.com to @linux.ibm.com, which if nothing else might
> > save a bit of typing.  This commit therefore updates us stragglers'
> > email addresses in the MAINTAINERS file.  The old addresses are
> > expected to continue to work for a few more months.
> > 
> > While in the neighborhood, remove some obsolete entries, which
> > results
> > in an orphaned subsystem: "JSM Neo PCI based serial card".
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Cc: Douglas Miller <dougmill@linux.ibm.com>
> > Cc: Eddie James <eajames@linux.ibm.com>
> > Cc: Frank Haverkamp <haver@linux.ibm.com>
> > Cc: Frederic Barrat <fbarrat@linux.ibm.com>
> > Cc: James Bottomley <jejb@linux.ibm.com>
> 
> Acked-by: James Bottomley <jejb@linux.ibm.com>

Applied, thank you!

							Thanx, Paul

