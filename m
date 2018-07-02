Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909F5C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55EF425407
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:52:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55EF425407
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753432AbeGBSwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:52:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39338 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753162AbeGBSwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:52:09 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w62IhqKg181582
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 14:52:09 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jyqrvn9d3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 14:52:08 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 2 Jul 2018 14:52:08 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 2 Jul 2018 14:52:03 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w62Iq25E65732834
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Jul 2018 18:52:02 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75B16B2065;
        Mon,  2 Jul 2018 14:51:47 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 560E6B2064;
        Mon,  2 Jul 2018 14:51:47 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  2 Jul 2018 14:51:47 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A0A1A16CA366; Mon,  2 Jul 2018 11:54:15 -0700 (PDT)
Date:   Mon, 2 Jul 2018 11:54:15 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        akiyks@gmail.com, boqun.feng@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, npiggin@gmail.com,
        peterz@infradead.org, stern@rowland.harvard.edu,
        will.deacon@arm.com
Subject: Re: [PATCH 0/2] tools/memory-model: remove ACCESS_ONCE()
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180628123347.52963-1-mark.rutland@arm.com>
 <20180628123845.GA14456@andrea>
 <20180628152140.GK3593@linux.vnet.ibm.com>
 <20180628165111.GA4013@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628165111.GA4013@andrea>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18070218-0040-0000-0000-000004486539
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009296; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01055583; UDB=6.00541417; IPR=6.00833505;
 MB=3.00021965; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-02 18:52:06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070218-0041-0000-0000-0000084E813C
Message-Id: <20180702185415.GR3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-02_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807020210
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 06:51:11PM +0200, Andrea Parri wrote:
> > 1bc179880fba docs: atomic_ops: Describe atomic_set as a write operation
> > 
> > 	The above patches need at least one additional Acked-by
> > 	or Reviewed-by.  If any of you gets a chance, please do
> > 	look them over.
> 
> Glad this came out. ;-)
> 
> No objection to the patch: feel free to add my Reviewed-by: tag.

Done, thank you!

> (BTW, atomic_set() would be better mapped to WRITE_ONCE()... in fact, to
>  be fair, some archs do it the __asm__ __volatile__() way).
> 
> I do however have some suggestions concerning "the process":  searching
> LKML for the patch and the related discussion, I could only find:
> 
>   [PATCH] docs: atomic_ops: atomic_set is a write (not read) operation
> 
> and I realize that none of the person Cc:-ed in this thread, except you,
> were Cc:-ed in that discussion (in compliance with get_maintainer.pl).
> 
> My suggestions:
> 
>   1) Merge the file touched by that patch into (the recently created):
>   
>         Documentation/atomic_t.txt
> 
>      (FWIW, queued in my TODO list).

Some consolidation of documentation would be good.  ;-)

Thoughts from others?

>   2) Add the entry:
> 
> 	F: Documentation/atomic_t.txt
> 
>      to the "ATOMIC INFRASTRUCTURE" subsystem in the MAINTAINERS file so
>      that developers can easily find (the intended?) reviewers for their
>      patch. (Of course, this will need ACK from the ATOMIC people).

If the merging will take awhile, it might also be good to put
Documentation/core-api/atomic_ops.rst somewhere as well.

							Thanx, Paul

