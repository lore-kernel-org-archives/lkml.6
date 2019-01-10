Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88562C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B6620665
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbfAJT7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 14:59:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48296 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726369AbfAJT7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 14:59:08 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0AJrXJ8080213
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 14:59:07 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pxbw1swnf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 14:59:07 -0500
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <jejb@linux.ibm.com>;
        Thu, 10 Jan 2019 19:59:06 -0000
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 10 Jan 2019 19:59:03 -0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0AJx2RQ29163636
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Jan 2019 19:59:02 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A1B57805E;
        Thu, 10 Jan 2019 19:59:02 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78B8D7805C;
        Thu, 10 Jan 2019 19:59:00 +0000 (GMT)
Received: from [153.66.254.194] (unknown [9.85.186.19])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 10 Jan 2019 19:59:00 +0000 (GMT)
Subject: Re: PROBLEM: syzkaller found / pool corruption-overwrite / page in
 user-area or NULL
From:   James Bottomley <jejb@linux.ibm.com>
To:     Esme <esploit@protonmail.ch>,
        "dgilbert@interlog.com" <dgilbert@interlog.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org
Cc:     "security@kernel.org" <security@kernel.org>
Date:   Thu, 10 Jan 2019 11:58:59 -0800
In-Reply-To: <t78EEfgpy3uIwPUvqvmuQEYEWKG9avWzjUD3EyR93Qaf_tfx1gqt4XplrqMgdxR1U9SsrVdA7G9XeUZacgUin0n6lBzoxJHVJ9Ko0yzzrxI=@protonmail.ch>
References: <t78EEfgpy3uIwPUvqvmuQEYEWKG9avWzjUD3EyR93Qaf_tfx1gqt4XplrqMgdxR1U9SsrVdA7G9XeUZacgUin0n6lBzoxJHVJ9Ko0yzzrxI=@protonmail.ch>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19011019-0016-0000-0000-00000972EB19
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010380; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144587; UDB=6.00595975; IPR=6.00924852;
 MB=3.00025072; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-10 19:59:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011019-0017-0000-0000-000041B91A3C
Message-Id: <1547150339.2814.9.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-10_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901100154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-10 at 19:12 +0000, Esme wrote:
> Sorry for the resend some mail servers rejected the mime type.
> 
> Hi, I've been getting more into Kernel stuff lately and forged ahead
> with some syzkaller bug finding.  I played with reducing it further
> as you can see from the attached c code but am moving on and hope to
> get better about this process moving forward as I'm still building
> out my test systems/debugging tools.
> 
> Attached is the report and C repro that still triggers on a fresh git
> pull as of a few minutes ago, if you need anything else please let me
> know.
> Esme
> 
> Linux syzkaller 5.0.0-rc1+ #5 SMP Tue Jan 8 20:39:33 EST 2019 x86_64
> GNU/Linux

I'm not sure I'm reading this right, but it seems that a simple
allocation inside block/scsi_ioctl.h

	buffer = kzalloc(bytes, q->bounce_gfp | GFP_USER| __GFP_NOWARN);

(where bytes is < 4k) caused a slub padding check failure on free. 
From the internal details, the freeing entity seems to be KASAN as part
of its quarantine reduction (albeit triggered by this kzalloc).  I'm
not remotely familiar with what KASAN is doing, but it seems the memory
corruption problem is somewhere within the KASAN tracking?

I added linux-mm in case they can confirm this diagnosis or give me a
pointer to what might be wrong in scsi.

James

