Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6532C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB6D20855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfARIs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:48:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58428 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727271AbfARIs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:48:58 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0I8cuVU006669
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 03:48:57 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q37ver3tq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 03:48:57 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Fri, 18 Jan 2019 08:48:55 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 18 Jan 2019 08:48:52 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0I8mpsb6357452
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Jan 2019 08:48:51 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 576BCA4060;
        Fri, 18 Jan 2019 08:48:51 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20C20A405C;
        Fri, 18 Jan 2019 08:48:51 +0000 (GMT)
Received: from mschwideX1 (unknown [9.152.96.40])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 18 Jan 2019 08:48:51 +0000 (GMT)
Date:   Fri, 18 Jan 2019 09:48:50 +0100
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 0/5] s390: rework compat wrapper generation
In-Reply-To: <20190117201920.GB3687@osiris>
References: <20190116131527.2071570-1-arnd@arndb.de>
        <20190117133619.GD18351@osiris>
        <CAK8P3a2KvCwAa5yp+f_cZOX4Osd_tvwfBto=aMEMW9TNbePQ9w@mail.gmail.com>
        <20190117201920.GB3687@osiris>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19011808-0020-0000-0000-000003082290
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011808-0021-0000-0000-0000215947E4
Message-Id: <20190118094850.07f84efc@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-18_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901180066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2019 21:19:20 +0100
Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> On Thu, Jan 17, 2019 at 05:21:50PM +0100, Arnd Bergmann wrote:
> > On Thu, Jan 17, 2019 at 2:36 PM Heiko Carstens
> > <heiko.carstens@de.ibm.com> wrote:  
> > >
> > > On Wed, Jan 16, 2019 at 02:15:18PM +0100, Arnd Bergmann wrote:  
> >   
> > > > I did not test the changes at runtime, but I looked at the
> > > > generated object code, which seems fine here and includes
> > > > the same conversions as before.  
> > >
> > > All looks good and seems to work fine. This is a very nice
> > > simplification of our compat code, even if it adds some dead code to
> > > the kernel image.
> > >
> > > I did some tests and it all looks good. Also the generated code looks
> > > fine. So, if nothing breaks, this will go upstream with next merge
> > > window via the s390 tree.
> > >
> > > Thanks again for your work!  
> > 
> > Awesome, thanks for testing it so quickly and agreeing to merge it!
> > 
> > There is a dependency that I now have for my y2038 syscall series
> > of course, so I'd need to have those patches on top of the s390 series.
> > 
> > I think we can either have a shared git branch that gets merged both
> > into your s390 tree and my y2038 tree, or we merge it only through
> > my tree, with your Ack.
> > 
> > Does that work for you?  
> 
> I'll discuss this with Martin tomorrow, however I think a shared git
> branch would be the best solution. I want to get as much testing as
> possible for this patch set, which means this must also be in the s390
> tree.

Yes, a shared git branch seems like the best solutoin, this is now
available as a topic branch on the s390/linux:

git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git compat

The branch has been merged to the features branch for v5.1.

Thanks for the work on the compat code, good stuff!

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

