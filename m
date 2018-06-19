Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260BBC1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B2020693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9B2020693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752785AbeFSX3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 19:29:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48916 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751655AbeFSX3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 19:29:38 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5JNTC6L110166
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 19:29:37 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jq809ypp2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 19:29:37 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mrochs@linux.vnet.ibm.com>;
        Tue, 19 Jun 2018 19:29:36 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 19 Jun 2018 19:29:32 -0400
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5JNTWr548758826
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Jun 2018 23:29:32 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F5CE112061;
        Tue, 19 Jun 2018 19:29:29 -0400 (EDT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98D45112062;
        Tue, 19 Jun 2018 19:29:28 -0400 (EDT)
Received: from p8tul1-build.aus.stglabs.ibm.com (unknown [9.3.141.206])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTPS;
        Tue, 19 Jun 2018 19:29:28 -0400 (EDT)
Date:   Tue, 19 Jun 2018 18:29:30 -0500
From:   "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Uma Krishnan <ukrishn@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        brajeswar.linux@gmail.com
Subject: Re: [PATCH] scsi: cxlflash: Change return type for fault handler
References: <20180611194204.GA18687@jordon-HP-15-Notebook-PC>
 <20180613232347.GA3851@p8tul1-build.aus.stglabs.ibm.com>
 <CAFqt6zb-fDRdH1_k7QwW_YEErKYPYFNpJFrK7N82P0PLiKnRtA@mail.gmail.com>
 <1E0C8AFA-5168-4916-932E-8E1C3F0EADE6@linux.vnet.ibm.com>
 <CAFqt6zbgaqVxAVcX+ryzP5-qDDZs+Z1rNrY4mHhwr=THO++5Vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zbgaqVxAVcX+ryzP5-qDDZs+Z1rNrY4mHhwr=THO++5Vg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
x-cbid: 18061923-0040-0000-0000-000004427A41
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009222; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01049451; UDB=6.00537736; IPR=6.00828425;
 MB=3.00021747; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-19 23:29:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061923-0041-0000-0000-0000084889BF
Message-Id: <20180619232930.GB10658@p8tul1-build.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-19_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=961 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806190250
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 11:11:35PM +0530, Souptick Joarder wrote:
> On Tue, Jun 19, 2018 at 7:41 PM, Uma Krishnan
> <ukrishn@linux.vnet.ibm.com> wrote:
> >
> >
> >> On Jun 19, 2018, at 12:10 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >>
> >> On Thu, Jun 14, 2018 at 4:53 AM, Matthew R. Ochs
> >> <mrochs@linux.vnet.ibm.com> wrote:
> >>> On Tue, Jun 12, 2018 at 01:12:04AM +0530, Souptick Joarder wrote:
> >>>> Use new return type vm_fault_t for fault handler. For
> >>>> now, this is just documenting that the function returns
> >>>> a VM_FAULT value rather than an errno. Once all instances
> >>>> are converted, vm_fault_t will become a distinct type.
> >>>>
> >>>> Ref-> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
> >>>>
> >>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> >>>
> >>> This looks fine to me.
> >>>
> >>> FYI that there is another handler for this driver in a series
> >>> destined for 4.18 and currently in next/master.
> >>>
> >>> Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> >>>
> >>
> >> Matthew, is this patch queued for 4.19 ?
> >>
> > Below is the commit that added fault handler in ocxl. It is in 4.18 rc1 (upstream/master tree)
> >
> > commit 93b8f8df552c5a30bfddb75a632f1b2a436c2cae
> >     scsi: cxlflash: Support adapter context mmap and release
> 
> 
> No, that's a different patch with commit
> 93b8f8df552c5a30bfddb75a632f1b2a436c2cae.
> Not the patch under discussion in this mail thread :)
> 
> Anyway the other patch with commit 93b8f8df552c5a30b also has to be modified
> to use new return type vm_fault_t for fault handler ocxlflash_mmap_fault().
> 
> Shall I modify and submit the same ?
> 

Since this has not yet been queued for 4.19, please submit a v2 with the
modifications to also update the return type for ocxlflash_mmap_fault().


-matt

