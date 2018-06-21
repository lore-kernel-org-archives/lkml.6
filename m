Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F1AC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 15:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B768C2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 15:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B768C2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933312AbeFUPDz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 11:03:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45302 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932879AbeFUPDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 11:03:53 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5LEt7Q2016567
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 11:03:53 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jrcnwmx86-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 11:03:52 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 21 Jun 2018 11:03:51 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 21 Jun 2018 11:03:46 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5LF3jLU61407472
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Jun 2018 15:03:46 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C483B2064;
        Thu, 21 Jun 2018 11:03:32 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6ACC6B2067;
        Thu, 21 Jun 2018 11:03:32 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 21 Jun 2018 11:03:32 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1E70016C3BD3; Thu, 21 Jun 2018 08:05:47 -0700 (PDT)
Date:   Thu, 21 Jun 2018 08:05:47 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     Byungchul Park <max.byungchul.park@gmail.com>,
        jiangshanlai@gmail.com, josh@joshtriplett.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        Joel Fernandes <joel@joelfernandes.org>, luto@kernel.org
Subject: Re: [RFC 2/2] rcu: Remove ->dynticks_nmi_nesting from struct
 rcu_dynticks
Reply-To: paulmck@linux.vnet.ibm.com
References: <1529484440-20634-1-git-send-email-byungchul.park@lge.com>
 <1529484440-20634-2-git-send-email-byungchul.park@lge.com>
 <20180620145814.GQ3593@linux.vnet.ibm.com>
 <CANrsvRMYc5u3L53nnnGC6p-QcjBTfLPjkJGZyubGWAPauc-W8w@mail.gmail.com>
 <20180620164902.GW3593@linux.vnet.ibm.com>
 <CANrsvRPAWv8LgSvPrGgLiXnjrtK3CmpJgdpNsuu-0LZJTYeYWQ@mail.gmail.com>
 <20180620174037.GZ3593@linux.vnet.ibm.com>
 <20180621063949.GA28024@X58A-UD3R>
 <20180621100830.GC28024@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621100830.GC28024@X58A-UD3R>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062115-2213-0000-0000-000002BE1810
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009233; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01050237; UDB=6.00538206; IPR=6.00829207;
 MB=3.00021784; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-21 15:03:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062115-2214-0000-0000-00005A8F87E4
Message-Id: <20180621150547.GF3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-21_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=568 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806210165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 07:08:30PM +0900, Byungchul Park wrote:
> On Thu, Jun 21, 2018 at 03:39:49PM +0900, Byungchul Park wrote:
> 
> [...]
> 
> > I applied what you suggested and re-named rcu_nmi_{enter,exit} to
>                                                ^
>                         rcu_nmi_{enter,exit}_common(bool irq)
> 
> > rcu_irq_{enter,exit} and applied the same re-naming to
>           ^
>      rcu_irq_{enter,exit}_common(bool nmi)
> 
> > ->dynticks_nmi_nesting as well, since those are not things to do with
>            ^
>     dynticks_nmi_nesting -> dynticks_irq_nesting
> 
> > nmi anymore but both irq and nmi.
> > 
> > I think "irq" is better to represent both irq and nmi than "nmi".
> > Please let me know if you don't think so. I can get rid of the re-
> > naming from the patch.

Again, we need to keep "nmi".  There is a lot of irq-safe code in the
Linux kernel, but not so much nmi-safe code, so we need to give the
reader as many hints as we can that this code is unusual.

							Thanx, Paul

