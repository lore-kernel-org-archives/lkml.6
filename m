Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72418C65BAE
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 15:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40AE720851
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 15:10:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40AE720851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbeLBPK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 10:10:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58734 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725876AbeLBPK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 10:10:57 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wB2F3INm057329
        for <linux-kernel@vger.kernel.org>; Sun, 2 Dec 2018 10:10:54 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p48u3fjjk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 10:10:54 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 2 Dec 2018 15:10:51 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 2 Dec 2018 15:10:49 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wB2FAm666095160
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 2 Dec 2018 15:10:48 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F5F242047;
        Sun,  2 Dec 2018 15:10:48 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1102B42041;
        Sun,  2 Dec 2018 15:10:47 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.106.63])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  2 Dec 2018 15:10:46 +0000 (GMT)
Subject: Re: [PATCH] docs: Extend trusted keys documentation for TPM 2.0
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Bottomley <jejb@linux.ibm.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 02 Dec 2018 10:10:36 -0500
In-Reply-To: <20181130234646.GB3792@linux.intel.com>
References: <20181019101758.1569-1-stefanb@linux.ibm.com>
         <20181106164603.w46wspmdj5e4slwe@cantor>
         <1541528254.8568.48.camel@linux.ibm.com>
         <20181130234507.GA3792@linux.intel.com>
         <20181130234646.GB3792@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18120215-0012-0000-0000-000002D373A8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120215-0013-0000-0000-00002108C665
Message-Id: <1543763436.4216.196.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-02_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812020145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-30 at 15:46 -0800, Jarkko Sakkinen wrote:
> On Fri, Nov 30, 2018 at 03:45:07PM -0800, Jarkko Sakkinen wrote:
> > On Tue, Nov 06, 2018 at 01:17:34PM -0500, Mimi Zohar wrote:
> > > On Tue, 2018-11-06 at 09:46 -0700, Jerry Snitselaar wrote:
> > > > On Fri Oct 19 18, Stefan Berger wrote:
> > > > >Extend the documentation for trusted keys with documentation for how to
> > > > >set up a key for a TPM 2.0 so it can be used with a TPM 2.0 as well.
> > > > >
> > > > >Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > > >Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > > > 
> > > > Acked-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > > 
> > > Thanks!  This patch is now staged in the #next-integrity-queued
> > > branch.
> > > 
> > > Mimi
> > 
> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> Brings to mind, in the long run where the backend code for trusted keys
> should reside.

Are you asking about coordinating staging the trusted key patches to
be upstreamed or about moving portions of the encrypted keys code out
of the keyring subsystem?

I'm not sure there needs to be a separate encrypted-keys pull request.
 Either they can be upstreamed via the TPM or the integrity subsystem
for now.

Mimi

