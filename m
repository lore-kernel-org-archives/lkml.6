Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB7DC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 12:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF932086B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 12:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF932086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbeJZU4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 16:56:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55672 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727650AbeJZU4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 16:56:00 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9QC9kvK103030
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 08:19:06 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nbydksc37-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 08:19:05 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gerald.schaefer@de.ibm.com>;
        Fri, 26 Oct 2018 13:19:03 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 26 Oct 2018 13:19:00 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9QCIxjZ3408360
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Oct 2018 12:18:59 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97384A4053;
        Fri, 26 Oct 2018 12:18:59 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C5CAA4040;
        Fri, 26 Oct 2018 12:18:59 +0000 (GMT)
Received: from thinkpad (unknown [9.145.68.88])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 26 Oct 2018 12:18:59 +0000 (GMT)
Date:   Fri, 26 Oct 2018 14:18:58 +0200
From:   Gerald Schaefer <gerald.schaefer@de.ibm.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Greg KH <greg@kroah.com>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH AUTOSEL 4.14 02/15] s390/hibernate: fix error handling
 when suspend cpu != resume cpu
In-Reply-To: <20181026110920.GF2015@sasha-vm>
References: <20181022102026.40869-1-sashal@kernel.org>
        <20181022102026.40869-2-sashal@kernel.org>
        <20181026090543.GC20200@amd>
        <20181026092214.GA4307@kroah.com>
        <20181026101549.GA30955@amd>
        <20181026110920.GF2015@sasha-vm>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 18102612-0012-0000-0000-000002BE2CAC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102612-0013-0000-0000-000020F24293
Message-Id: <20181026141858.4e55669d@thinkpad>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-26_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1031 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810260107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Oct 2018 07:09:20 -0400
Sasha Levin <sashal@kernel.org> wrote:

> On Fri, Oct 26, 2018 at 12:15:49PM +0200, Pavel Machek wrote:
> >On Fri 2018-10-26 10:22:14, Greg KH wrote:  
> >> On Fri, Oct 26, 2018 at 11:05:43AM +0200, Pavel Machek wrote:  
> >> > On Mon 2018-10-22 06:20:13, Sasha Levin wrote:  
> >> > > From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
> >> > >
> >> > > [ Upstream commit 55a5542a546238354d1f209f794414168cf8c71d ]
> >> > >
> >> > > The resume code checks if the resume cpu is the same as the suspend cpu.
> >> > > If not, and if it is also not possible to switch to the suspend cpu, an
> >> > > error message should be printed and the resume process should be stopped
> >> > > by loading a disabled wait psw.
> >> > >
> >> > > The current logic is broken in multiple ways, the message is never printed,
> >> > > and the disabled wait psw never loaded because the kernel panics before that:
> >> > > - sam31 and SIGP_SET_ARCHITECTURE to ESA mode is wrong, this will break
> >> > >   on the first 64bit instruction in sclp_early_printk().
> >> > > - The init stack should be used, but the stack pointer is not set up correctly
> >> > >   (missing aghi %r15,-STACK_FRAME_OVERHEAD).
> >> > > - __sclp_early_printk() checks the sclp_init_state. If it is not
> >> > >   sclp_init_state_uninitialized, it simply returns w/o printing anything.
> >> > >   In the resumed kernel however, sclp_init_state will never be uninitialized.  
> >> >
> >> > Stable patches should fix one bug, and one bug only.  
> >>
> >> So should upstream patches, but the rule of "stable patches match
> >> upstream identically" overrules this :)  
> >
> >a) There is no such rule for upstream.  
> 
> I invite you to read the docs in Documentation/process/ where you'll
> find gems like "Each logically independent change should be formatted as
> a separate patch".
> 
> >b) You should split the patch if it is important enough.
> >
> >c) The "stable patches match upstream identically" rule does not
> >exist. Check the documentation.  
> 
> The rule in question here is that every patch that goes into -stable
> must be upstream. If we were to split this patch, it would create 2+
> patches that do not exist upstream, thus breaking our own rules.
> 
> Anyway, given that this is an upstream issue, I'll also invite you to
> have this discussion with the maintainer of the subsystem this patch
> went into; you raise a valid concern which can hopefully be addressed by
> that maintainer.

It fixes the error message when suspend cpu != resume cpu, and splitting
it up would result in multiple patches where none of them would fix the
issue by itself, so they are logically connected.

Anyway, that patch did not have a cc: stable on purpose, it fixes an
esoteric special case, where the kernel would end up in disabled wait
anyway, with or without the patch. So it would be perfectly fine to not
include it in any stable update.

