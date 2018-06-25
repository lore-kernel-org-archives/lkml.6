Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BE5C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 375B625C14
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 375B625C14
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934740AbeFYPJa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:09:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57028 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934638AbeFYPJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:09:27 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5PExWmG015385
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 11:09:27 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ju0vup6mn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 11:09:26 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gor@linux.ibm.com>;
        Mon, 25 Jun 2018 16:09:24 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 16:09:20 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5PF9Jgt35258368
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Jun 2018 15:09:19 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17D0B4C04E;
        Mon, 25 Jun 2018 16:09:13 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C133C4C046;
        Mon, 25 Jun 2018 16:09:12 +0100 (BST)
Received: from localhost (unknown [9.152.212.171])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 25 Jun 2018 16:09:12 +0100 (BST)
Date:   Mon, 25 Jun 2018 17:09:17 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, qemu-s390x <qemu-s390x@nongnu.org>,
        qemu-devel <qemu-devel@nongnu.org>,
        Thomas Huth <thuth@redhat.com>
Subject: Re: s390 qemu boot failure in -next
References: <64bcba64-b88f-3594-da6e-7c2118482c20@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64bcba64-b88f-3594-da6e-7c2118482c20@roeck-us.net>
X-TM-AS-GCONF: 00
x-cbid: 18062515-0016-0000-0000-000001DFE464
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062515-0017-0000-0000-0000323417F3
Message-Id: <cover.thread-8b0da3.your-ad-here.call-01529937119-ext-3705@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=761 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806250175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 06:35:30AM -0700, Guenter Roeck wrote:
> On 06/25/2018 05:26 AM, Christian Borntraeger wrote:
> > 
> > 
> > On 06/25/2018 10:49 AM, Cornelia Huck wrote:
> > > On Mon, 25 Jun 2018 10:36:33 +0200
> > > Vasily Gorbik <gor@linux.ibm.com> wrote:
> > > 
> > > > This change has been done on purpose. Uncompressed image is not going
> > > > to be bootable any more. In future the decompressor phase would get
> > > > more function (early memory detection as an example) and there is no
> > > > chance to duplicate that code in uncompressed image as well (to keep it
> > > > bootable on its own). The patch series commit messages contain more
> > > > technical details.
> > > > 
> > > > For qemu either bzImage or arch/s390/boot/compressed/vmlinux should be
> > > > used, which are bootable images.
> > > > 
> > > > But that's really confusing that uncompressed vmlinux is still kind
> > > > of booting. May be we should discuss how to avoid this confusion
> > > > (may be change uncompressed image enty point to a function doing
> > > > disabled wait with badb007 or smth) and how to encourage people to use
> > > > arch/s390/boot/compressed/vmlinux instead.
> > > 
> 
> If an image is not expected to be bootable, a message such as "This image does
> not boot. Please use <correct image>" would be nice. Unfortunately, which image
> to boot under qemu is pretty much undocumented, and it is guesswork for each
> architecture/platform.
> 
> Guenter
> 
> > I talked to Vasily and the vmlinux file in the linux source path is just an
> > intermediate file. Future changes will happen that will make that ELF file
> > unsuitable for direct boot anyway (e.g. think about potential ASLR or Kasan
> > changes).
> > 
> >   If yes, it would make sense to explicitly fence it. But I'm
> > > worried that it would break previously working setups (did we document
> > > the purpose of the images anywhere?
> > > 

To avoid confusion with trying to boot uncompressed vmlinux under qemu
we could detect it and print "nice" message in the kernel.

Please consider the following patch.

Vasily Gorbik (1):
  s390/boot: block uncompressed vmlinux booting attempts

 arch/s390/boot/head.S         |  4 ++--
 arch/s390/include/asm/setup.h |  3 ++-
 arch/s390/kernel/early.c      | 12 ++++++++++++
 3 files changed, 16 insertions(+), 3 deletions(-)

-- 
⣔⢻⣟⢢ 2.18.0.rc2.13.g4da9a5d
⣿⢿⡿⣿ pacman edition

