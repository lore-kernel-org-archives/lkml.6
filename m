Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3D0C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B752083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EeWlg3v4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3B752083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754204AbeFSW6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 18:58:42 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:33658 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752895AbeFSW6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 18:58:41 -0400
Received: by mail-io0-f193.google.com with SMTP id d185-v6so1775814ioe.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 15:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rjOkcl2o5XGY7KL1Qr6bzrqTeyHYeOtX35Su9n7z2/I=;
        b=EeWlg3v47GXGCaYJH2DVs1T2xqXmyBJIRG/mqFFpV2DUZcH2cUxKXAsO3/EKBWzWkE
         KoX5mB8jkJLRTve+Zwsdgw4+jdnLEgcR0Cn/ueLmREFzlGVU0OxSSPsHUdXVMevk22G9
         buQcVI9LAsQIFxM/NooPRDn1J/dOufKZfV56Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rjOkcl2o5XGY7KL1Qr6bzrqTeyHYeOtX35Su9n7z2/I=;
        b=Xa5f4YoibNLP4F4f0aRo8aKHm3irUM1uii4yat2LSZkHx79gNJpVmlNGGj8tJNbIRT
         DZ1yAXGvxQ7kg1XwhSHk1ZL/ScTQ5xFy+pF5cD63vVS/QFnWgDMwh5fNLTPshUXop7Ya
         NnbbWu3aISuTp5oilaLtCYG22bc1Y1VIleTMNoQCWiC3VCEspRagIHD4qC2PrfTAEOG+
         7WTcEXw+6KGfehAXJ0Cy4L6ezpmTyvg+bO4BoLFq3kNITuiD4cl3AXv5qg0dy6EQhwPA
         E7hngVUFZl1BxaQqncJ6zAq8ibH0q7SqrXLe95ucUXUiBaU4vAxpuSjbmTQKGG5NaA9w
         fn0w==
X-Gm-Message-State: APt69E2bs4aQmiOeCM+Xefi+YsEP62IE9MjBpmmYGyBie7ekX5vfzFp2
        buQDV4Mg1Ov6NLaDxiVcemc678uuCfjQftgrAZ9png==
X-Google-Smtp-Source: ADUXVKLSLerl5QPizSy1BcMae/CUh0hA4fimuNHpGV54dsimqfouiQi8GVDzdyLgHKhZrFShDeh3OKwYKAlPK6sTlqA=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr16095630iov.203.1529449120846;
 Tue, 19 Jun 2018 15:58:40 -0700 (PDT)
MIME-Version: 1.0
References: <1281327087.2168.67.camel@pasglop>
In-Reply-To: <1281327087.2168.67.camel@pasglop>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Jun 2018 07:58:30 +0900
Message-ID: <CA+55aFxRyp4G4niZ=aMk+epdSbu5MB1oJg_h4NhLkxsM+f+SLQ@mail.gmail.com>
Subject: Re: [git pull] Please pull powerpc.git next branch
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev list <linuxppc-dev@ozlabs.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 5:23 AM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

I love the alleged line removal, but there's nothing in that 'merge'
branch. It points to an ancient powerpc commit from 2016.

And please, signed tags. I know you do them, because you used to send me them.

             Linus
