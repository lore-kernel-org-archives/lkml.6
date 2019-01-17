Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2150EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A5620859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbfAQUTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 15:19:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54160 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729150AbfAQUT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 15:19:29 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0HKItIk012652
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 15:19:28 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q305b94rn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 15:19:28 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Thu, 17 Jan 2019 20:19:26 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 17 Jan 2019 20:19:22 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0HKJMmP60424336
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Jan 2019 20:19:22 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DCC2311C050;
        Thu, 17 Jan 2019 20:19:21 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A04E11C04A;
        Thu, 17 Jan 2019 20:19:21 +0000 (GMT)
Received: from osiris (unknown [9.145.18.25])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 17 Jan 2019 20:19:21 +0000 (GMT)
Date:   Thu, 17 Jan 2019 21:19:20 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-s390 <linux-s390@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 0/5] s390: rework compat wrapper generation
References: <20190116131527.2071570-1-arnd@arndb.de>
 <20190117133619.GD18351@osiris>
 <CAK8P3a2KvCwAa5yp+f_cZOX4Osd_tvwfBto=aMEMW9TNbePQ9w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2KvCwAa5yp+f_cZOX4Osd_tvwfBto=aMEMW9TNbePQ9w@mail.gmail.com>
X-TM-AS-GCONF: 00
x-cbid: 19011720-0008-0000-0000-000002B278C5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011720-0009-0000-0000-0000221E9787
Message-Id: <20190117201920.GB3687@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-17_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=958 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901170141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 05:21:50PM +0100, Arnd Bergmann wrote:
> On Thu, Jan 17, 2019 at 2:36 PM Heiko Carstens
> <heiko.carstens@de.ibm.com> wrote:
> >
> > On Wed, Jan 16, 2019 at 02:15:18PM +0100, Arnd Bergmann wrote:
> 
> > > I did not test the changes at runtime, but I looked at the
> > > generated object code, which seems fine here and includes
> > > the same conversions as before.
> >
> > All looks good and seems to work fine. This is a very nice
> > simplification of our compat code, even if it adds some dead code to
> > the kernel image.
> >
> > I did some tests and it all looks good. Also the generated code looks
> > fine. So, if nothing breaks, this will go upstream with next merge
> > window via the s390 tree.
> >
> > Thanks again for your work!
> 
> Awesome, thanks for testing it so quickly and agreeing to merge it!
> 
> There is a dependency that I now have for my y2038 syscall series
> of course, so I'd need to have those patches on top of the s390 series.
> 
> I think we can either have a shared git branch that gets merged both
> into your s390 tree and my y2038 tree, or we merge it only through
> my tree, with your Ack.
> 
> Does that work for you?

I'll discuss this with Martin tomorrow, however I think a shared git
branch would be the best solution. I want to get as much testing as
possible for this patch set, which means this must also be in the s390
tree.

