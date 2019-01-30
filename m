Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76CBC282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEECE21473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbfA3Ix7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 03:53:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55444 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725850AbfA3Ix7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 03:53:59 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0U8iDLR008783
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 03:53:58 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qb8g30x68-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 03:53:58 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Wed, 30 Jan 2019 08:53:56 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 30 Jan 2019 08:53:53 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0U8rqET62521354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Jan 2019 08:53:52 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1ED5F4C04A;
        Wed, 30 Jan 2019 08:53:52 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D35D24C046;
        Wed, 30 Jan 2019 08:53:51 +0000 (GMT)
Received: from osiris (unknown [9.152.212.95])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 30 Jan 2019 08:53:51 +0000 (GMT)
Date:   Wed, 30 Jan 2019 09:53:50 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Laura Abbott <labbott@redhat.com>
Cc:     Andreas Krebbel <krebbel@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/jump_label: Correct asm contraint
References: <20190123125513.20210-1-labbott@redhat.com>
 <20190123132401.GG3424@osiris>
 <898d52cc-fa76-0888-429f-27446190653b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <898d52cc-fa76-0888-429f-27446190653b@redhat.com>
X-TM-AS-GCONF: 00
x-cbid: 19013008-0008-0000-0000-000002B7D565
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013008-0009-0000-0000-000022241B2B
Message-Id: <20190130085350.GB5299@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-30_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901300070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 08:25:58AM +0100, Laura Abbott wrote:
> On 1/23/19 5:24 AM, Heiko Carstens wrote:
> >On Wed, Jan 23, 2019 at 01:55:13PM +0100, Laura Abbott wrote:
> >>There's a build failure with gcc9:
...
> >Hmmm, this works only for the kernel image, but not for modules, which
> >we compile with "-fPIC", which again doesn't work as described in the
> >referenced bugzilla:
> >                                       ^~~
> >./arch/s390/include/asm/jump_label.h:19:2: note: in expansion of macro 'asm_volatile_goto'
> >   asm_volatile_goto("0: brcl 0,"__stringify(JUMP_LABEL_NOP_OFFSET)"\n"
> >
> >Andreas, Ilya, any idea how to fix this?
> 
> I've had to turn off s390 in Fedora until this gets fixed :(

I assume this means you only turned off CONFIG_JUMP_LABEL on s390
until we have a fix for this?

