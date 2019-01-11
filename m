Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3E3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE33C20872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="GynMm4CM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388047AbfAKQZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 11:25:31 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:32827 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731099AbfAKQZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 11:25:30 -0500
Received: by mail-ot1-f52.google.com with SMTP id i20so13635677otl.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 08:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oAkInDyjniJpNrxeYSro+8Xc80fV7Ji6IK0jrUn2go4=;
        b=GynMm4CMejh1CwRzf9A5mk1pWbr1Kd7YN4HkcRh0SLOuwUfT8P8jdMFuhN10SBogUJ
         Do8PjmFDOBpbAaYUFfVreWWY4Vgd0zdGOIKela17q10Ujo05+Juu0zJu2oUbdqe4RD+g
         sbnRbAiOh8+QLsKzjcjrJi4VcPYh4ihsYH1icy+WmDYokiV+SArrHsheCiXshTTLeN6A
         +WqHnY5YbXvc7zG3ESPYISgBEFRj3jFvnoXvTDWs8Wp8L4bVEwEZPgykBGTVHxmvBOdJ
         RJ/lUd4zYBO8AJQKr6bvpJz/A9OHAKDNIpuf6X5cc2hm8eBpN3LdvxIbfmWQJERBTydQ
         uxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oAkInDyjniJpNrxeYSro+8Xc80fV7Ji6IK0jrUn2go4=;
        b=Up8pwKPAtKT+B2EOIj0DY1W8+VRIY5HIbu5oKsPhtQdHr6lmie/xOPUMdKqBhmUNOl
         2ehWDgQ7ofLfrExUn3hw9KIDIb0jWLq/VeIZ2d6vby8MALsFbFh2f983ClYSUfRgwAuX
         8D0rTphmqd3rTXZaS/HiMIRJjoaVPdqz73qibLj5PFJLeMNWhDJUTNeJ46+aKahtrMpX
         J8EB9VC9eRJmjT+oNt7KUNl3B7pSnp0SrvlWiyYamNnjMxP6R+/LaR3XjPymxQcI8Fvp
         TGbkcyOeKuzyxsMGcisPieCZP/D06zC23MyDBQavmzh7dJOG8hrzgBJrmsjdzy/+dwVk
         QCkg==
X-Gm-Message-State: AJcUukcPzZeINcHHvaUTBkbe5za55j/YFQFz0tewh0Eemt8pQl2YcDkv
        ultfxuXj6X4GIhCDxE4DR0tq6XeR5YEQCw/lU5D6EQ==
X-Google-Smtp-Source: ALg8bN4juSUyLT5TiC6ZYmBOsMFiVeEo/fF1pAQSKTQvyitw1gQKkGL24KkgZL4/phyJvWIxsVh33MhapuF8DDSXxtg=
X-Received: by 2002:a9d:6a50:: with SMTP id h16mr9413162otn.95.1547223929462;
 Fri, 11 Jan 2019 08:25:29 -0800 (PST)
MIME-Version: 1.0
References: <20190109174341.19818-1-keith.busch@intel.com> <20190109174341.19818-8-keith.busch@intel.com>
 <87y37sit8x.fsf@linux.ibm.com> <20190110173016.GC21095@localhost.localdomain>
 <20190111113238.000068b0@huawei.com> <20190111155828.GD21095@localhost.localdomain>
In-Reply-To: <20190111155828.GD21095@localhost.localdomain>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 11 Jan 2019 08:25:17 -0800
Message-ID: <CAPcyv4iHxyQkCScMzDM3YyuP6+zhqvNXtYHg_rdhgrOq9tevbg@mail.gmail.com>
Subject: Re: [PATCHv3 07/13] node: Add heterogenous memory access attributes
To:     Keith Busch <keith.busch@intel.com>
Cc:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 7:59 AM Keith Busch <keith.busch@intel.com> wrote:
>
> On Fri, Jan 11, 2019 at 11:32:38AM +0000, Jonathan Cameron wrote:
> > On Thu, 10 Jan 2019 10:30:17 -0700
> > Keith Busch <keith.busch@intel.com> wrote:
> > > I am not aware of a real platform that has an initiator-target pair with
> > > better latency but worse bandwidth than any different initiator paired to
> > > the same target. If such a thing exists and a subsystem wants to report
> > > that, you can register any arbitrary number of groups or classes and
> > > rank them according to how you want them presented.
> > >
> >
> > It's certainly possible if you are trading off against pin count by going
> > out of the soc on a serial bus for some large SCM pool and also have a local
> > SCM pool on a ddr 'like' bus or just ddr on fairly small number of channels
> > (because some one didn't put memory on all of them).
> > We will see this fairly soon in production parts.
> >
> > So need an 'ordering' choice for this circumstance that is predictable.
>
> As long as the reported memory target access attributes are accurate for
> the initiator nodes listed under an access class, I'm not sure that it
> matters what order you use. All the information needed to make a choice
> on which pair to use is available, and the order is just an implementation
> specific decision.

Agree with Keith. If the performance is differentiated it will be in a
separate class. A hierarchy of classes is not enforced by the
interface, but it tries to advertise some semblance of the "best"
initiator pairing for a given target by default with the flexibility
to go more complex if the situation arises.

As was seen in the SCSI specification efforts to advertise all manner
of cache hinting the kernel community discovered that only a small
fraction of what hardware vendors thought mattered actually
demonstrated value in practice. That experience is instructive that
the kernel interfaces for hardware performance hints should prioritize
what makes sense for the kernel and applications generally, not
necessarily every conceivable performance detail that a hardware
platform chooses to expose, or niche applications might consume.
