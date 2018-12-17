Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937FFC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C9E320874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389381AbeLQUD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 15:03:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37816 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388749AbeLQUD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 15:03:58 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBHJx88v038084
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 15:03:57 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pegr7vhku-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 15:03:56 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 17 Dec 2018 20:03:55 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 17 Dec 2018 20:03:53 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBHK3qeq58851440
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Dec 2018 20:03:52 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 522875205A;
        Mon, 17 Dec 2018 20:03:52 +0000 (GMT)
Received: from dhcp-9-31-102-82.watson.ibm.com (unknown [9.31.102.82])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id A109E5204F;
        Mon, 17 Dec 2018 20:03:51 +0000 (GMT)
Subject: Re: [PATCH] integrity: Remove references to module keyring
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     James Morris <jmorris@namei.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org
Date:   Mon, 17 Dec 2018 15:03:51 -0500
In-Reply-To: <alpine.LRH.2.21.1812180633290.29218@namei.org>
References: <20181213013909.25737-1-bauerman@linux.ibm.com>
         <alpine.LRH.2.21.1812180633290.29218@namei.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18121720-4275-0000-0000-000002F1E626
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121720-4276-0000-0000-000037FF1E94
Message-Id: <1545077031.10804.8.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-17_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812170176
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-18 at 06:33 +1100, James Morris wrote:
> On Wed, 12 Dec 2018, Thiago Jung Bauermann wrote:
> 
> > >From what I can tell, it has never been used.

This was introduced prior to Rusty's decision to use appended
signatures for kernel modules.

> > 
> > Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> 
> Mimi, can I add your acked-by?

Acked-by: Mimi Zohar <zohar@linux.ibm.com>

> 
> 
> > ---
> >  security/integrity/digsig.c    | 1 -
> >  security/integrity/integrity.h | 5 ++---
> >  2 files changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> > index c5585e75d5d9..1ff8eab7bc8c 100644
> > --- a/security/integrity/digsig.c
> > +++ b/security/integrity/digsig.c
> > @@ -34,7 +34,6 @@ static const char * const keyring_name[INTEGRITY_KEYRING_MAX] = {
> >  	".evm",
> >  	".ima",
> >  #endif
> > -	"_module",
> >  	".platform",
> >  };
> >  
> > diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> > index aafa1266e3d5..26c415c3f879 100644
> > --- a/security/integrity/integrity.h
> > +++ b/security/integrity/integrity.h
> > @@ -152,9 +152,8 @@ int integrity_kernel_read(struct file *file, loff_t offset,
> >  
> >  #define INTEGRITY_KEYRING_EVM		0
> >  #define INTEGRITY_KEYRING_IMA		1
> > -#define INTEGRITY_KEYRING_MODULE	2
> > -#define INTEGRITY_KEYRING_PLATFORM	3
> > -#define INTEGRITY_KEYRING_MAX		4
> > +#define INTEGRITY_KEYRING_PLATFORM	2
> > +#define INTEGRITY_KEYRING_MAX		3
> >  
> >  extern struct dentry *integrity_dir;
> >  
> > 
> 

