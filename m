Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E1FC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4681E218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YJsrB8GA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfBGRaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:30:13 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34763 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfBGRaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:30:13 -0500
Received: by mail-wr1-f66.google.com with SMTP id z15so767341wrn.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 09:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qu0dRqPUSjOdzq7j6pd1ZLan3UMC6JPf/TW98nCCGgM=;
        b=YJsrB8GAFThYErhft7AJUdEz7Lr+MVlotC84Z3cw0LtTpYAmnx6gRUYHNE5ElNHfn4
         rXYXPhiAeJQrsh246ZGL8u4K5dERroFeh+szU8XAqBVo4/eE2TBwoYUXQvyZlSOAId6L
         CNYGXThVGk38ukRR7FvlhFa+qIUA7LA4/+W5Lv7EqJK9YWNzhZE7rvgdF2y6tXZR5rYO
         R+Tdh8/S7xN/Lwa3ZpT+ipIfVSPYvOYmbWSD8/7jC33cvBR1euG1BhQWZtkpCAft7R55
         w86Tb35F9W2iFpNjUsE3Orh5Wvb12pDlxdaSj/clq7bE67I2fLcjsfDNm4MyIm5bLFKE
         KI8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qu0dRqPUSjOdzq7j6pd1ZLan3UMC6JPf/TW98nCCGgM=;
        b=k6dvETv4XJaKJWqEYbQkaAiuu7ORWTSUjDZAkbCZFPSw3qB+zU1qjUYX0L5FvIbuzv
         2t6YLqKW40DVErlcIUdy7dMn/+xkmvjJNrvVtF0jy5laXNPxnkbeZixocFUznNxbUspK
         tFtr/TXw+0XUeheLp4BnBZi85jmMHcqIe/X6aq9H4s/anhwsILjxY8d+JJckuYUGF2Wo
         927HdtzRBaelaD+mSpM/YXnZtCPxndNqQPPVnG8Mm3BlkwompozlMizZrDYA9wpSo4tY
         Efli5alcPd6xc5pWQTNSPOYKpJf4vZIwMz+xod2+zkOXnfdv2PBbKQXXpXtg5iHPQREU
         vqYA==
X-Gm-Message-State: AHQUAua17SjxsKZw5HiY5vGKRCs77Tc3PNNHA1gw851RSoWZ3RrYehNU
        zQs+61JDuqbs1xSBqPNNa/zodLdNNnXvRlPOOsJk
X-Google-Smtp-Source: AHgI3IYPXeGcu7yJxe5xoWT7MxDyKbri48xQGlSX2jgO53lWtqJ6Q2HqcJIdD7DPeYZ6f8H0sn87+KaGhlkTRfYvsno=
X-Received: by 2002:adf:eb12:: with SMTP id s18mr12878757wrn.120.1549560611390;
 Thu, 07 Feb 2019 09:30:11 -0800 (PST)
MIME-Version: 1.0
References: <20181226232258.GA23526@syn-yoga530> <20190205120545.GA1045@kunai>
 <CAErSpo5kvFVwo-DCLYT_7UmRQKS1jHahFXawvnZUtZ=ApHKz1Q@mail.gmail.com>
 <20190207155326.GC4796@kunai> <8d70ae32-8e4d-d2aa-e213-4b2f678d7da0@amd.com>
In-Reply-To: <8d70ae32-8e4d-d2aa-e213-4b2f678d7da0@amd.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu, 7 Feb 2019 11:29:59 -0600
Message-ID: <CAErSpo5-LAfmoddxT0W_TLryytbKpR694W9dv096=mKGJrL8rw@mail.gmail.com>
Subject: Re: [PATCH v15] i2c: Add drivers for the AMD PCIe MP2 I2C controller
To:     "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Elie Morisse <syniurge@gmail.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Singh, Sandeep" <Sandeep.Singh@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 10:47 AM Shah, Nehal-bakulchandra
<Nehal-bakulchandra.Shah@amd.com> wrote:
>
>
>  Hi Bjorn and Wolfram,
> On 2/7/2019 9:23 PM, Wolfram Sang wrote:
> > Hi Bjorn,
> >
> > thanks a lot for your additional information!
> >
> >> IMHO the split into two drivers is a bit of a mess and doesn't really
> >> correspond with the hardware, as I mentioned at [1].  The PCI device
> >> is the real hardware and the driver should claim that.  AFAICT the
> >> ACPI device exists only to pass some config information to the PCI
> >> driver.  I think the natural approach would be for the PCI driver to
> >> directly search the ACPI namespace for that config information.
> >
> > AFAIR the AMD folks insisted on the two driver setup because they need
> > it in the future? Maybe they can explain again here?
> >
> >> The fact that driver_find_device() is essentially unused except for a
> >> few very special cases is a good clue that there's probably a better
> >> way.
> >
> > Excactly this thinking made me recommend something else, too. Let's see
> > what we can come up with.
>
> First of really thanks for your valuable review. It may seem to be illogical to have two separate drivers, however as explained
> in past we are working on another solution for some upcoming thing. In that case we need MP2-PCI communication driver which will be reused.
> At this point of time i can't talk much about that but once solution is ready, we will be pushing that as well. Hence i sincerely requesting
> to  have two separate driver.

This is not my area and my opinion is by no means definitive.  But
FWIW, I don't think the argument that "a secret project will someday
require the ungainly design currently proposed" is worth very much.
Until we've seen the upcoming project, it's impossible to say whether
this two-driver design is the best approach for it.  I'd say it's
quite likely that people might have alternate proposals.

Bjorn
