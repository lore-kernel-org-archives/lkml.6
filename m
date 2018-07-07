Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1CCC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 05:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DFA2224C4
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 05:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="eUYhpJhv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DFA2224C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751887AbeGGFWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 01:22:42 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:52730 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750762AbeGGFWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 01:22:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 430F68EE212;
        Fri,  6 Jul 2018 22:22:40 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8FyLL7WtGB7t; Fri,  6 Jul 2018 22:22:40 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B7FE88EE02B;
        Fri,  6 Jul 2018 22:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1530940959;
        bh=TQV2voITECnSl5AMZtPBlpU4+lW8+BbQtEsw0k+Z+Nw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=eUYhpJhv+Ap1nycMSE7pYlXR94ki9tUYTxmZBiywUtPZuFKh3T34hMwGeGXrzeP0X
         T8gwa96IaY4Gmozbj+ECk/NTwfQklAsbgo6rxIT9NpyZi0u0Iv7UlW/2YjoTpmtAvt
         GntRxYzpRHMh/Jcdn8r5qTJvlfSVVAtoCAzCXb1c=
Message-ID: <1530940958.3135.4.camel@HansenPartnership.com>
Subject: Re: [GIT PULL] SCSI fixes for 4.18-rc3
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 06 Jul 2018 22:22:38 -0700
In-Reply-To: <CA+55aFxAy__3hE1OoUFPKZfptLT1cXuoujsnSGXBMzJPQ+Qjzg@mail.gmail.com>
References: <1530913134.3135.2.camel@HansenPartnership.com>
         <CA+55aFy-o3fRtkQnJU=0zv7CPUtgfKiwhfQi_05K25Y_-mx+_w@mail.gmail.com>
         <CA+55aFxQ8QzGTWsVdVQVok9cLbgZDFjG2g3JZtWJd+G9jHkYoQ@mail.gmail.com>
         <CA+55aFxAy__3hE1OoUFPKZfptLT1cXuoujsnSGXBMzJPQ+Qjzg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-06 at 19:48 -0700, Linus Torvalds wrote:
> On Fri, Jul 6, 2018 at 7:39 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > 
> > I'd rather add a deprecation warning to the whole "read/write
> > to /dev/sg" itself
> 
> In the meantime, I've pulled this, but do wonder why we actually
> allow that crazy read/write that doesn't even work for any other
> models (ie I guarantee you that cdrom writers etc don't use that
> interface, because SG_IO is the only thing that works on most
> hardware).

We did discuss removing the r/w interface, but, as you say, it's been
around for ages so it's not clear what regressions would surface if we
did.  It's mostly root only (with certain distro exceptions), so the
consensus for a short term fix was to make sure it couldn't be
exploited.  Long term we'll absolutely look into removing it.

The argument I've seen for the old interface is userspace programs that
want multiple outstanding commands in the old event driven single
threaded model (with SG_IO you need one thread for each command) but if
you asked me to name any, I couldn't, so perhaps they're all gone by
now.

James

