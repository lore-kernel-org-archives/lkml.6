Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0509C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 04:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB6F2089F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 04:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfABEz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 23:55:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59878 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726353AbfABEz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 23:55:57 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x024sAG5051698
        for <linux-kernel@vger.kernel.org>; Tue, 1 Jan 2019 23:55:56 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2prgda2a9n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jan 2019 23:55:55 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <chandan@linux.ibm.com>;
        Wed, 2 Jan 2019 04:55:54 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 2 Jan 2019 04:55:51 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x024toLR58196152
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Jan 2019 04:55:50 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6DAE242052;
        Wed,  2 Jan 2019 04:55:50 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19CDB4203F;
        Wed,  2 Jan 2019 04:55:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.102.3.54])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  2 Jan 2019 04:55:48 +0000 (GMT)
From:   Chandan Rajendra <chandan@linux.ibm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: Re: linux-next: manual merge of the f2fs tree with the fscrypt tree
Date:   Wed, 02 Jan 2019 10:26:09 +0530
Organization: IBM
In-Reply-To: <20190102112610.3bc5fb97@canb.auug.org.au>
References: <20181211101322.438946fe@canb.auug.org.au> <20190102112610.3bc5fb97@canb.auug.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
x-cbid: 19010204-0020-0000-0000-000002FF5B5C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010204-0021-0000-0000-0000214F5D99
Message-Id: <2265186.H1UptfE7Oa@localhost.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-02_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901020043
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, January 2, 2019 5:56:10 AM IST Stephen Rothwell wrote:
> Hi all,
> 
> On Tue, 11 Dec 2018 10:13:22 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Today's linux-next merge of the f2fs tree got a conflict in:
> > 
> >   fs/f2fs/dir.c
> > 
> > between commit:
> > 
> >   848a010287e6 ("f2fs: use IS_ENCRYPTED() to check encryption status")
> > 
> > from the fscrypt tree and commit:
> > 
> >   4e240d1bab1e ("f2fs: check memory boundary by insane namelen")
> > 
> > from the f2fs tree.
> > 
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> > 
> 
> This is now a conflict between the fscrypt tree and Linus' tree.
> 
> 

fscrypt's master branch has fsverity patches applied. These are not available
on Linus' tree. Hence the conflict.

Just FYI, The discussion on merging fsverity into mainline kernel is still
going on.

-- 
chandan



