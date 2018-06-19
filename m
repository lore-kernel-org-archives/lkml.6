Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4DDC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2977205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2977205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757316AbeFSOsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 10:48:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54808 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756829AbeFSOsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 10:48:02 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5JEdphS060325
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 10:48:02 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jq3g0h8av-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 10:48:01 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 19 Jun 2018 10:48:01 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 19 Jun 2018 10:47:57 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5JEluPc16777492
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Jun 2018 14:47:56 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC06AB205F;
        Tue, 19 Jun 2018 10:47:45 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD69AB2068;
        Tue, 19 Jun 2018 10:47:45 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 19 Jun 2018 10:47:45 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B79BD16C2DE8; Tue, 19 Jun 2018 07:49:56 -0700 (PDT)
Date:   Tue, 19 Jun 2018 07:49:56 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        bigeasy@linutronix.de, oleg@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH 0/3] sched/swait: Convert to full exclusive mode
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180612083449.100099222@infradead.org>
 <20180614012742.GP3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614012742.GP3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18061914-0060-0000-0000-0000027F95BA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009220; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01049278; UDB=6.00537632; IPR=6.00828250;
 MB=3.00021739; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-19 14:47:59
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061914-0061-0000-0000-000045815F41
Message-Id: <20180619144956.GA23737@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-19_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806190165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 06:27:42PM -0700, Paul E. McKenney wrote:
> On Tue, Jun 12, 2018 at 10:34:49AM +0200, Peter Zijlstra wrote:
> > As mentioned by Linus, swait is exclusive mode and had better behave like it
> > and be named like it.
> > 
> > Make it so.
> 
> Cool!
> 
> When I tried testing it on x86 against recent mainline, I got:
> 
> "WARNING: WARNING: Bad or missing .orc_unwind table.  Disabling unwinder."
> 
> But when I tested on recent mainline without your patches:
> 
> 	4597fcff0704 "Merge tag 'for-4.18/dm-changes-v2' of
> 	git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm"
> 
> I get the same warning.  Trying again on today's mainline, but in the
> meantime, is anyone else seeing this?

And this patch fixes this issue, FWIW:

https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1713797.html

							Thanx, Paul

