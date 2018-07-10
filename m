Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C1CC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4003C20B6F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4003C20B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388777AbeGJSrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:47:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52604 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732358AbeGJSrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:47:48 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6AIi5eV130184
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 14:47:31 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k51araut6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 14:47:31 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 10 Jul 2018 19:47:29 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 10 Jul 2018 19:47:24 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6AIlNhW21430418
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Jul 2018 18:47:23 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDD8FAE053;
        Tue, 10 Jul 2018 21:47:18 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 373E8AE045;
        Tue, 10 Jul 2018 21:47:17 +0100 (BST)
Received: from dhcp-9-31-103-18.watson.ibm.com (unknown [9.31.103.18])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 10 Jul 2018 21:47:17 +0100 (BST)
Subject: Re: [PATCH v5 7/8] ima: based on policy warn about loading firmware
 (pre-allocated buffer)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Kees Cook <keescook@chromium.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Date:   Tue, 10 Jul 2018 14:47:21 -0400
In-Reply-To: <CAKv+Gu8qjzh_Tta=n9C+cfXO29e_5RcLqfQSpvR5r7QmqzHbEg@mail.gmail.com>
References: <1530542283-26145-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1530542283-26145-8-git-send-email-zohar@linux.vnet.ibm.com>
         <CAKv+Gu-nky1yX59TL2FNQ-0q7Sy399t2WpVWSy7jqYpQY4Fxjw@mail.gmail.com>
         <1531165294.3332.40.camel@linux.ibm.com>
         <CAKv+Gu-knHeBRGqo+2pb3X9cCjwovEykoXUf=DZyP7aJpoS60A@mail.gmail.com>
         <CAKv+Gu8qjzh_Tta=n9C+cfXO29e_5RcLqfQSpvR5r7QmqzHbEg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18071018-0016-0000-0000-000001E55A55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071018-0017-0000-0000-00003239E1ED
Message-Id: <1531248441.3332.142.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-10_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807100199
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-10 at 08:56 +0200, Ard Biesheuvel wrote:
> On 10 July 2018 at 08:51, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > On 9 July 2018 at 21:41, Mimi Zohar <zohar@linux.ibm.com> wrote:
> >> On Mon, 2018-07-02 at 17:30 +0200, Ard Biesheuvel wrote:
> >>> On 2 July 2018 at 16:38, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> >>> > Some systems are memory constrained but they need to load very large
> >>> > firmwares.  The firmware subsystem allows drivers to request this
> >>> > firmware be loaded from the filesystem, but this requires that the
> >>> > entire firmware be loaded into kernel memory first before it's provided
> >>> > to the driver.  This can lead to a situation where we map the firmware
> >>> > twice, once to load the firmware into kernel memory and once to copy the
> >>> > firmware into the final resting place.
> >>> >
> >>> > To resolve this problem, commit a098ecd2fa7d ("firmware: support loading
> >>> > into a pre-allocated buffer") introduced request_firmware_into_buf() API
> >>> > that allows drivers to request firmware be loaded directly into a
> >>> > pre-allocated buffer. (Based on the mailing list discussions, calling
> >>> > dma_alloc_coherent() is unnecessary and confusing.)
> >>> >
> >>> > (Very broken/buggy) devices using pre-allocated memory run the risk of
> >>> > the firmware being accessible to the device prior to the completion of
> >>> > IMA's signature verification.  For the time being, this patch emits a
> >>> > warning, but does not prevent the loading of the firmware.
> >>> >
> >>>
> >>> As I attempted to explain in the exchange with Luis, this has nothing
> >>> to do with broken or buggy devices, but is simply the reality we have
> >>> to deal with on platforms that lack IOMMUs.
> >>
> >>> Even if you load into one buffer, carry out the signature verification
> >>> and *only then* copy it to another buffer, a bus master could
> >>> potentially read it from the first buffer as well. Mapping for DMA
> >>> does *not* mean 'making the memory readable by the device' unless
> >>> IOMMUs are being used. Otherwise, a bus master can read it from the
> >>> first buffer, or even patch the code that performs the security check
> >>> in the first place. For such platforms, copying the data around to
> >>> prevent the device from reading it is simply pointless, as well as any
> >>> other mitigation in software to protect yourself from misbehaving bus
> >>> masters.
> >>
> >> Thank you for taking the time to explain this again.
> >>
> >>> So issuing a warning in this particular case is rather arbitrary. On
> >>> these platforms, all bus masters can read (and modify) all of your
> >>> memory all of the time, and as long as the firmware loader code takes
> >>> care not to provide the DMA address to the device until after the
> >>> verification is complete, it really has done all it reasonably can in
> >>> the environment that it is expected to operate in.
> >>
> >> So for the non-IOMMU system case, differentiating between pre-
> >> allocated buffers vs. using two buffers doesn't make sense.
> >>
> >>>
> >>> (The use of dma_alloc_coherent() is a bit of a red herring here, as it
> >>> incorporates the DMA map operation. However, DMA map is a no-op on
> >>> systems with cache coherent 1:1 DMA [iow, all PCs and most arm64
> >>> platforms unless they have IOMMUs], and so there is not much
> >>> difference between memory allocated with kmalloc() or with
> >>> dma_alloc_coherent() in terms of whether the device can access it
> >>> freely)
> >>
> >> What about systems with an IOMMU?
> >>
> >
> > On systems with an IOMMU, performing the DMA map will create an entry
> > in the IOMMU page tables for the physical region associated with the
> > buffer, making the region accessible to the device. For platforms in
> > this category, using dma_alloc_coherent() for allocating a buffer to
> > pass firmware to the device does open a window where the device could
> > theoretically access this data while the validation is still in
> > progress.
> >
> > Note that the device still needs to be informed about the address of
> > the buffer: just calling dma_alloc_coherent() will not allow the
> > device to find the firmware image in its memory space, and arbitrary
> > DMA accesses performed by the device will trigger faults that are
> > reported to the OS. So the window between DMA map (or
> > dma_alloc_coherent()) and the device specific command to pass the DMA
> > buffer address to the device is not inherently unsafe IMO, but I do
> > understand the need to cover this scenario.
> >
> > As I pointed out before, using coherent DMA buffers to perform
> > streaming DMA is generally a bad idea, since they may be allocated
> > from a finite pool, and may use uncached mappings, making the access
> > slower than necessary (while streaming DMA can use any kmalloc'ed
> > buffer and will just flush the contents of the caches to main memory
> > when the DMA map is performed).
> >
> > So to summarize again: in my opinion, using a single buffer is not a
> > problem as long as the validation completes before the DMA map is
> > performed. This will provide the expected guarantees on systems with
> > IOMMUs, and will not complicate matters on systems where there is no
> > point in obsessing about this anyway given that devices can access all
> > of memory whenever they want to.

It sound like as long as the pre-allocated buffer is not being re-
used, either by being mapped to multiple devices or used to load
multiple firmware blobs, it is safe.

> >
> > As for the Qualcomm case: dma_alloc_coherent() is not needed here but
> > simply ends up being used because it was already wired up in the
> > qualcomm specific secure world API, which amounts to doing syscalls
> > into a higher privilege level than the one the kernel itself runs at.
> > So again, reasoning about whether the secure world will look at your
> > data before you checked the sig is rather pointless, and adding
> > special cases to the IMA api to cater for this use case seems like a
> > waste of engineering and review effort to me. If we have to do
> > something to tie up this loose end, let's try switching it to the
> > streaming DMA api instead.
> >
> 
> Forgot to mention: the Qualcomm case is about passing data to the CPU
> running at another privilege level, so IOMMU vs !IOMMU is not a factor
> here.

Agreed.  It sounds like the dependency would be on whether the buffer
has been DMA mapped.

Mimi

