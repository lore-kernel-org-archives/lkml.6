Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E98DC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFDEB25F60
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:34:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFDEB25F60
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964851AbeFYRew (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:34:52 -0400
Received: from smtprelay0210.hostedemail.com ([216.40.44.210]:37157 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S964781AbeFYRes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:34:48 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 4A9F216B08;
        Mon, 25 Jun 2018 17:34:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: mass06_c6235bbf1845
X-Filterd-Recvd-Size: 2265
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Mon, 25 Jun 2018 17:34:44 +0000 (UTC)
Message-ID: <da5592c3fe518c1050de631b9f8517c33644dba6.camel@perches.com>
Subject: Re: [PATCH v2] kvm: x86: mmu: Add cast to negated bitmasks in
 update_permission_bitmask()
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     pbonzini@redhat.com, Matthias Kaehlcke <mka@chromium.org>,
        rkrcmar@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 25 Jun 2018 10:34:43 -0700
In-Reply-To: <CAKwvOdknKQaKL=GLLktmx6h5UE1waiKED-F=_7h+keGq9jx4dQ@mail.gmail.com>
References: <20180619192504.180479-1-mka@chromium.org>
         <4dd99306-4fea-24b2-4bea-5b7927ea5e79@redhat.com>
         <CAKwvOdmmv9EtPB-jhwVruLASFve5d4h0+wx-6iY=ve=T9hbNdg@mail.gmail.com>
         <ca7719d7e917623bcd0bfd508add4d1f43c42d53.camel@perches.com>
         <CAKwvOdknKQaKL=GLLktmx6h5UE1waiKED-F=_7h+keGq9jx4dQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-25 at 13:12 -0400, Nick Desaulniers wrote:
> On Mon, Jun 25, 2018 at 1:05 PM Joe Perches <joe@perches.com> wrote:
> > On Mon, 2018-06-25 at 12:47 -0400, Nick Desaulniers wrote:
[]
> > > Here's an actual bug this warning caught applied to drivers/input/:
> > > 
> > > dae1a432ab1f ("Input: mousedev - fix implicit conversion warning"):
> > > https://patchwork.kernel.org/patch/9753771/
> > 
> > What bug is that?
> > 
> > $ cat test.c
> > #include <stdio.h>
> > #include <stdlib.h>
> > #include <memory.h>
> > 
> > int main(int argc, char **argv)
> > {
> >         static const signed char a[3] = {0x60, 3, 200};
> >         static const unsigned char b[3] = {0x60, 3, 200};
> > 
> >         printf("a and b are %s\n",
> >                memcmp(a, b, 3) == 0 ? "identical" : "different");
> > }
> > $ gcc test.c
> > $ ./a.out
> > a and b are identical
> > 
> Good point, poor choice of example on my part.

Is there an actual example of this so-called "bug"
in the kernel code?

