Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE590C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA81E2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfBTUEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:04:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39514 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725834AbfBTUEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:04:07 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1KJwh2H122648
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 15:04:06 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qscjak0ts-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 15:04:06 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bblock@linux.ibm.com>;
        Wed, 20 Feb 2019 20:04:04 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Feb 2019 20:04:02 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1KK414V54395064
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Feb 2019 20:04:01 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37BF7AE051;
        Wed, 20 Feb 2019 20:04:01 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22DC7AE045;
        Wed, 20 Feb 2019 20:04:01 +0000 (GMT)
Received: from t480-pf1aa2c2 (unknown [9.145.183.227])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 20 Feb 2019 20:04:01 +0000 (GMT)
Received: from bblock by t480-pf1aa2c2 with local (Exim 4.91)
        (envelope-from <bblock@linux.ibm.com>)
        id 1gwY64-000863-4N; Wed, 20 Feb 2019 21:04:00 +0100
Date:   Wed, 20 Feb 2019 21:03:59 +0100
From:   Benjamin Block <bblock@linux.ibm.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Steffen Maier <maier@linux.ibm.com>,
        linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: replace GFP_ATOMIC with GFP_KERNEL for sdev
 allocation
References: <20190220184847.24640-1-bblock@linux.ibm.com>
 <1550689891.93548.31.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1550689891.93548.31.camel@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 19022020-0008-0000-0000-000002C2E0E8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022020-0009-0000-0000-0000222F18F8
Message-Id: <20190220200359.GB3731@t480-pf1aa2c2>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-20_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=860 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902200137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 11:11:31AM -0800, Bart Van Assche wrote:
> On Wed, 2019-02-20 at 19:48 +0100, Benjamin Block wrote:
> > We had a test-report where, under memory pressure, adding LUNs to the
> > systems would fail (the tests add LUNs strictly in sequence):
> 
> Hi Benjamin,
> 
> There are two more instances of GFP_ATOMIC in scsi_scan.c. Have you verified
> whether or not it is safe to change these into GFP_KERNEL too?
> 

No, I was lazy, but I can take a look tomorrow and fix them up as well
if they are similar to scsi_alloc_sdev().

-- 
With Best Regards, Benjamin Block      /      Linux on IBM Z Kernel Development
IBM Systems & Technology Group   /  IBM Deutschland Research & Development GmbH
Vorsitz. AufsR.: Matthias Hartmann       /      Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: AmtsG Stuttgart, HRB 243294

