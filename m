Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192B9C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E252560D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6E252560D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754311AbeFYIgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 04:36:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46802 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751469AbeFYIgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 04:36:40 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5P8Y1sm064767
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 04:36:40 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jtuxbtpkn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 04:36:39 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gor@linux.ibm.com>;
        Mon, 25 Jun 2018 09:36:38 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 09:36:35 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5P8aYXo21758188
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Jun 2018 08:36:34 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E79F52054;
        Mon, 25 Jun 2018 09:36:30 +0100 (BST)
Received: from localhost (unknown [9.152.212.171])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 323F25204E;
        Mon, 25 Jun 2018 09:36:30 +0100 (BST)
Date:   Mon, 25 Jun 2018 10:36:33 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        qemu-s390x <qemu-s390x@nongnu.org>,
        qemu-devel <qemu-devel@nongnu.org>,
        Thomas Huth <thuth@redhat.com>
Subject: Re: s390 qemu boot failure in -next
References: <20180622194736.GA5794@roeck-us.net>
 <126ac556-0602-b927-58f5-cb5f65a5e0ec@de.ibm.com>
 <88d9afed-f91d-c320-13c8-9a93fc52b700@de.ibm.com>
 <20180625100548.64222dad.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180625100548.64222dad.cohuck@redhat.com>
X-TM-AS-GCONF: 00
x-cbid: 18062508-0028-0000-0000-000002D48E28
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062508-0029-0000-0000-0000238BEB67
Message-Id: <your-ad-here.call-01529915788-ext-6027@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=877 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806250102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change has been done on purpose. Uncompressed image is not going
to be bootable any more. In future the decompressor phase would get
more function (early memory detection as an example) and there is no
chance to duplicate that code in uncompressed image as well (to keep it
bootable on its own). The patch series commit messages contain more
technical details.

For qemu either bzImage or arch/s390/boot/compressed/vmlinux should be
used, which are bootable images.

But that's really confusing that uncompressed vmlinux is still kind
of booting. May be we should discuss how to avoid this confusion
(may be change uncompressed image enty point to a function doing
disabled wait with badb007 or smth) and how to encourage people to use
arch/s390/boot/compressed/vmlinux instead.

On Mon, Jun 25, 2018 at 10:05:48AM +0200, Cornelia Huck wrote:
> On Mon, 25 Jun 2018 09:27:59 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
> > Also adding QEMU.
> > 
> > On 06/25/2018 09:10 AM, Christian Borntraeger wrote:
> > > 
> > > 
> > > On 06/22/2018 09:47 PM, Guenter Roeck wrote:  
> > >> Hi,
> > >>
> > >> starting with commit 's390/boot: make head.S and als.c be part of the
> > >> decompressor only' in -next, s390 immages no longer boot in qemu.
> > >> As far as I can see, the reason is that the command line is no longer
> > >> passed from qemu to the kernel, which results in a panic because the
> > >> root file system can not be mounted.
> > >>
> > >> Was this change made on purpose ? If so, is there a way to get qemu
> > >> back to working ?  
> > > 
> > > Certainly not on purpose.
> > > 
> > > Vasily, I can reproduce this with KVM and an external kernel boot of the vmlinux file (the elf file)
> > > 
> > > e.g.
> > > 
> > > qemu-system-s390 -enable-kvm -nographic -kernel vmlinux -append "this string no longer is command line"
> > > 
> > > The compressed image (bzImage) seems to work fine though.
> > > 
> > > This seems to be an unfortunate side effect of QEMUs ways to "guess" its Linux (checking for start
> > > address 0x10000, which is no longer true for the vmlinux file). With the pure vmlinux elf file
> > > the load address is 0x100000 as there is no unpacker.
> 
> Do we consider these locations to be an exported interface, or is it
> just QEMU guessing?
> 
> > > 
> > > Guenter, can you check if arch/s390/boot/bzImage works for you as a workaround?  
> > 
> > Something like this in QEMU 
> > 
> > diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> > index f278036fa7..14153ce880 100644
> > --- a/hw/s390x/ipl.c
> > +++ b/hw/s390x/ipl.c
> > @@ -187,11 +187,13 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
> >           */
> >          if (pentry == KERN_IMAGE_START || pentry == 0x800) {
> >              ipl->start_addr = KERN_IMAGE_START;
> > -            /* Overwrite parameters in the kernel image, which are "rom" */
> > -            strcpy(rom_ptr(KERN_PARM_AREA), ipl->cmdline);
> >          } else {
> >              ipl->start_addr = pentry;
> >          }
> > +       if (ipl->cmdline) {
> > +            /* If there is a command line, put it in the right place */
> > +            strcpy(rom_ptr(KERN_PARM_AREA), ipl->cmdline);
> > +       }
> 
> Check for the magic Linux string (like in the non-elf case) first?
> 
> >  
> >          if (ipl->initrd) {
> >              ram_addr_t initrd_offset;
> > 
> > would put the command line in no matter what the start address is.
> 
> I'm for putting that one in (and backporting it to qemu-stable). It's a
> bit worrying, though, that our ipl code is so fragile...
> 

