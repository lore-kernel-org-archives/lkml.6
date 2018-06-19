Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3384C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2055204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:11:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2055204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966430AbeFSOLr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 10:11:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52026 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965681AbeFSOLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 10:11:46 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5JE9T9B098336
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 10:11:46 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jq2tvhs1v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 10:11:45 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ukrishn@linux.vnet.ibm.com>;
        Tue, 19 Jun 2018 10:11:45 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 19 Jun 2018 10:11:42 -0400
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5JEBfnJ328120
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Jun 2018 14:11:41 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 835DF28067;
        Tue, 19 Jun 2018 10:11:31 -0400 (EDT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 969982805C;
        Tue, 19 Jun 2018 10:11:30 -0400 (EDT)
Received: from [9.85.237.157] (unknown [9.85.237.157])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTPS;
        Tue, 19 Jun 2018 10:11:30 -0400 (EDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH] scsi: cxlflash: Change return type for fault handler
From:   Uma Krishnan <ukrishn@linux.vnet.ibm.com>
In-Reply-To: <CAFqt6zb-fDRdH1_k7QwW_YEErKYPYFNpJFrK7N82P0PLiKnRtA@mail.gmail.com>
Date:   Tue, 19 Jun 2018 09:11:38 -0500
Cc:     "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        brajeswar.linux@gmail.com
Content-Transfer-Encoding: 8BIT
References: <20180611194204.GA18687@jordon-HP-15-Notebook-PC>
 <20180613232347.GA3851@p8tul1-build.aus.stglabs.ibm.com>
 <CAFqt6zb-fDRdH1_k7QwW_YEErKYPYFNpJFrK7N82P0PLiKnRtA@mail.gmail.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
X-Mailer: Apple Mail (2.3445.8.2)
X-TM-AS-GCONF: 00
x-cbid: 18061914-2213-0000-0000-000002BC17F5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009219; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01049265; UDB=6.00537625; IPR=6.00828238;
 MB=3.00021736; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-19 14:11:44
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061914-2214-0000-0000-00005A88D5E8
Message-Id: <1E0C8AFA-5168-4916-932E-8E1C3F0EADE6@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-19_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=742 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806190160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 19, 2018, at 12:10 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> 
> On Thu, Jun 14, 2018 at 4:53 AM, Matthew R. Ochs
> <mrochs@linux.vnet.ibm.com> wrote:
>> On Tue, Jun 12, 2018 at 01:12:04AM +0530, Souptick Joarder wrote:
>>> Use new return type vm_fault_t for fault handler. For
>>> now, this is just documenting that the function returns
>>> a VM_FAULT value rather than an errno. Once all instances
>>> are converted, vm_fault_t will become a distinct type.
>>> 
>>> Ref-> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
>>> 
>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> 
>> This looks fine to me.
>> 
>> FYI that there is another handler for this driver in a series
>> destined for 4.18 and currently in next/master.
>> 
>> Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
>> 
> 
> Matthew, is this patch queued for 4.19 ?
> 
Below is the commit that added fault handler in ocxl. It is in 4.18 rc1 (upstream/master tree)

commit 93b8f8df552c5a30bfddb75a632f1b2a436c2cae
    scsi: cxlflash: Support adapter context mmap and release
