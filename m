Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB16C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2997F21566
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2997F21566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbeHWVOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 17:14:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56324 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726461AbeHWVOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 17:14:51 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7NHd0vX039827
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 13:44:03 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m1x8vhqeu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 13:44:03 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 23 Aug 2018 13:44:02 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 23 Aug 2018 13:44:00 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7NHhxog21627072
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Aug 2018 17:43:59 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F18FB205F;
        Thu, 23 Aug 2018 13:43:03 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B47FB206E;
        Thu, 23 Aug 2018 13:43:03 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 23 Aug 2018 13:43:02 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 16A2816C6B17; Thu, 23 Aug 2018 10:43:59 -0700 (PDT)
Date:   Thu, 23 Aug 2018 10:43:59 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     nicolas.pitre@linaro.org, josh@joshtriplett.org
Cc:     linux-kernel@vger.kernel.org
Subject: Kernel-only deployments?
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18082317-0060-0000-0000-000002A33A9F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009599; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01077780; UDB=6.00555712; IPR=6.00857753;
 MB=3.00022890; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-23 17:44:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082317-0061-0000-0000-00004644C39E
Message-Id: <20180823174359.GA13033@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-23_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=846 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808230183
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Does anyone do kernel-only deployments, for example, setting up an
embedded device having a Linux kernel and absolutely no userspace
whatsoever?

The reason I as is that such a mode would be mildly useful for rcutorture.

You see, rcutorture runs entirely out of initrd, never mounting a real
root partition.  The user has been required to supply the initrd, but
more people are starting to use rcutorture.  This has led to confusion
and complaints about the need to supply the initrd.  So I am finally
getting my rcutorture initrd act together, with significant dracut help
from Connor Shu.  I added mkinitramfs support for environments such as
mine that don't support dracut, at least not without significant slashing
and burning.

The mkinitramfs approach results in about 40MB of initrd, and dracut
about 10MB.  Most of this is completely useless for rcutorture, which
isn't interested in mounting filesystems, opening devices, and almost
all of the other interesting things that mkinitramfs and dracut enable.

Those who know me will not be at all surprised to learn that I went
overboard making the resulting initrd as small as possible.  I started
by throwing out everything not absolutely needed by the dash and sleep
binaries, which got me down to about 2.5MB, 1.8MB of which was libc.
This situation of course prompted me to create an initrd containing
a statically linked binary named "init" and absolutely nothing else
(not even /dev or /tmp directories), which weighs in at not quite 800KB.
This is a great improvement over 10MB, to say nothing of 40MB, but 800KB
for a C-language "for" loop containing nothing more than a single call to
sleep()?  Much of the code is there for things that I might do (dl_open(),
for example), but don't.  All I can say is that there clearly aren't many
of us left who made heavy use of systems with naked-eye-visible bits!
(Or naked-finger-feelable, for that matter.)

This further prompted the idea of modifying kernel_init() to just loop
forever, perhaps not even reaping orphaned zombies [*], given an appropriate
Kconfig option and/or kernel boot parameter.  I obviously cannot justify
this to save a sub-one-megabyte initrd for rcutorture, no matter how much
a wasted 800K might have offended my 30-years-ago self.  If I take this
next step, there have to be quite a few others benefiting significantly
from it.

So, does anyone in the deep embedded space already do this?

							Thanx, Paul

[*]	What zombies???  There is no userspace!!!

