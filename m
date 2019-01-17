Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6ECC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE3920859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbfAQUNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 15:13:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47694 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729333AbfAQUNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 15:13:52 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0HKB950067951
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 15:13:51 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q30h402xc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 15:13:51 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Thu, 17 Jan 2019 20:13:49 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 17 Jan 2019 20:13:45 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0HKDi6o22741182
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Jan 2019 20:13:44 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3DA95AE057;
        Thu, 17 Jan 2019 20:13:44 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6589AE04D;
        Thu, 17 Jan 2019 20:13:43 +0000 (GMT)
Received: from osiris (unknown [9.145.18.25])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 17 Jan 2019 20:13:43 +0000 (GMT)
Date:   Thu, 17 Jan 2019 21:13:42 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-s390 <linux-s390@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 2/5] ipc: introduce ksys_ipc()/compat_ksys_ipc() for s390
References: <20190116131527.2071570-1-arnd@arndb.de>
 <20190116131527.2071570-3-arnd@arndb.de>
 <20190117132906.GB18351@osiris>
 <CAK8P3a1u0OJKPnuBHVy4WSFy6T04kfNw5BwkpsLmkEU4KQD5eQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1u0OJKPnuBHVy4WSFy6T04kfNw5BwkpsLmkEU4KQD5eQ@mail.gmail.com>
X-TM-AS-GCONF: 00
x-cbid: 19011720-0008-0000-0000-000002B2781A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011720-0009-0000-0000-0000221E96D9
Message-Id: <20190117201342.GA3687@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-17_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=791 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901170140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 05:29:55PM +0100, Arnd Bergmann wrote:
> On Thu, Jan 17, 2019 at 2:29 PM Heiko Carstens
> >  SYSCALL_DEFINE1(s390_personality, unsigned int, personality)
> >  {
> > diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> > index ab9d0e3c6d50..ad016a7db0ea 100644
> > --- a/kernel/sys_ni.c
> > +++ b/kernel/sys_ni.c
> > @@ -366,7 +366,7 @@ COND_SYSCALL(kexec_file_load);
> >  /* s390 */
> >  COND_SYSCALL(s390_pci_mmio_read);
> >  COND_SYSCALL(s390_pci_mmio_write);
> > -COND_SYSCALL_COMPAT(s390_ipc);
> > +COND_SYSCALL(s390_ipc);
> >
> >  /* powerpc */
> >  COND_SYSCALL(rtas);
> 
> I think you need to keep the
> 
> COND_SYSCALL_COMPAT(s390_ipc);
> 
> here, otherwise it still fails with CONFIG_SYSV_IPC=n, CONFIG_COMPAT=y, right?

Yes, you're right.

