Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3E2C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FCAF20844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FCAF20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbeIFRlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:41:20 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:39276 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbeIFRlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:41:19 -0400
Received: by mail-qt0-f196.google.com with SMTP id o15-v6so12083432qtk.6;
        Thu, 06 Sep 2018 06:05:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cu+k9yKRf2QMFnxAFAWWxRdzk+b7JUhgG9yk5bk7M4U=;
        b=ix/E2DVVgOBLcnc8Hsj2XPmKOFHe5MPtN8nJmvOjoULlb0btvRIlJwiHnOTg4Nnp/b
         D5v3E44ozHndcjc1zoL4smG11oN9af7ebtcs2rQzl6j/kkBkmB4TAMv7y7BRK5aM4F9N
         5F3YNirKFAlPepomAZRzBnC5t4ChCLYrEXU/HwtmeeFDBXk2a0LXQGi7nfK8f4mYdf82
         +A+toBfnhRpfT0vVMm+H/VBma8B773MfCkgyWEFxfr18Q2I7k5IF8OiFtK7a/+dFP7Fm
         iNwKsD8B7i4g/BrPBMUNesyup/BrepvwlzOKoyF4vVO+5HaKArgjQMXWkD0As4sGXMLr
         ounA==
X-Gm-Message-State: APzg51BJXVg5rjOc4X5Bej0Nh6z6bNprY57g5ARnU8wdCvUpoQaPlusM
        XNm8TeBgZIx2kff3EkpbBx18Lvb3yVQTfqOhgtk=
X-Google-Smtp-Source: ANB0VdZDcUZVcX7hE8cREiqeQMGuCG/yF+vFhysvynt/+QJ2eoXwqDeU+ax0Ymb99TKRHS/q7hFZJdNP/m9/+TFRsy8=
X-Received: by 2002:a0c:fb08:: with SMTP id c8-v6mr1877659qvp.149.1536239154483;
 Thu, 06 Sep 2018 06:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536138304.git.ren_guo@c-sky.com> <62dae1828ade759584bbf1507fe4a9e69d247a50.1536138304.git.ren_guo@c-sky.com>
 <CABGGiswB5OUU7JDP+-s3s8ONkXZY2AAvSijQedsNtZ6p8LqZeA@mail.gmail.com> <20180906021254.GC29405@guoren-Inspiron-7460>
In-Reply-To: <20180906021254.GC29405@guoren-Inspiron-7460>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 6 Sep 2018 15:05:38 +0200
Message-ID: <CAK8P3a3h4KxkvAXZV+=7T6vdiQdOd0quos9BUtX-E=Q2H_0rfA@mail.gmail.com>
Subject: Re: [PATCH V3 21/26] dt-bindings: interrupt-controller: C-SKY APB intc
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     Rob Herring <robh@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 4:13 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> On Wed, Sep 05, 2018 at 07:43:10PM -0500, Rob Herring wrote:
> > On Wed, Sep 5, 2018 at 7:10 AM Guo Ren <ren_guo@c-sky.com> wrote:
> > >
> > > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > > +
> > > +       intc: interrupt-controller {
> >
> > Needs a unit-address.
> Ok, change it to:
>             intc: interrupt-controller@0x00500000 {

The unit address has no leading 0x or leading zeroes, so
interrupt-controller@500000

        Arnd
