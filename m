Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D597DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0C32145D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="iNugaPRR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F0C32145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731907AbeK1Dzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:55:48 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33463 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731768AbeK1Dyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:54:53 -0500
Received: by mail-oi1-f196.google.com with SMTP id c206so19939778oib.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 08:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+TUKvNyWHtP7n3h7wLLhST1c5AhhjeLrIUlsLCYZqe8=;
        b=iNugaPRR31iHt+uG/Z+fg3BS3fX3BqNOPO43l0UN3QbmyzZMv4DG36GDgycK6JGnXw
         6iW/SWuZxfuZDq3n2+IvTNKyAePrakGXcepVLH5DVufkI8tInT4pfVCfi7JHu8x+sHrl
         ejyvpjC9WvmqPbTvCmSm8LlOreeoP99dcObRetlsWQwiG5v3K+PXo3D/nZz3Ch1M3uW1
         J+YjcLhQ+ut16nifn7GP7unzUmIATqK8SXMhvpGCbYLiScA/zHZOafr3mVdAr+lVCRZj
         rby+Q7SncGyGSBwD+twKoqrDrvvZPdDnCG7S4ZfWK2Ft5assAm7nPVUOjiE720txehd9
         LHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+TUKvNyWHtP7n3h7wLLhST1c5AhhjeLrIUlsLCYZqe8=;
        b=t90PZ0BhAe+sbpTfbD5t98X3m8tIWnB0xqlULjtHOHg8tneOfIUbnBcOD4xjGEFJkD
         icg5AP8JK4Ac/2ZCnt1zjD4V4z4cWdGaZB2JYr+g1Vikj71mNMlRlVpGzaiYWyaAqen8
         CHunkaQrtpXOhI7M+STEaxLyWs5r/cDQIWVXRIppLRplKfAWWxRmsxBIgs3nzqG7emLc
         kYUEXCFukTSUEXp8QjrTcz7YVUU2DH4qVAKzJDlHIqniOSEzvHHXbPc/FqQVMuDMBR3J
         4Mvr4mynKD0Djnsmq3KVaoVvtTFLUPfI9C5Bh67owamh0zDWaF8ISHpBCiY1pbEVB6BM
         qJfg==
X-Gm-Message-State: AGRZ1gLaGCAJxXiuq/HvteU/lxqtzJpYhMvDuL1M4sxf+K3B3XapdjFW
        tpU7DXzmQgHzmr3BjaQdhn+V+HrZsMZgNyDTazRaFA==
X-Google-Smtp-Source: AJdET5dMDF8d/U8yTBm1sFW8FaTew4YZ9l61WYCemifGuHHKCEkBNBfpUryxZcYcjk9BhLOTCr6mXAZEgOB9Lisswf0=
X-Received: by 2002:aca:d944:: with SMTP id q65-v6mr19304787oig.0.1543337781677;
 Tue, 27 Nov 2018 08:56:21 -0800 (PST)
MIME-Version: 1.0
References: <20181114224902.12082-1-keith.busch@intel.com> <1ed406b2-b85f-8e02-1df0-7c39aa21eca9@arm.com>
 <4ea6e80f-80ba-6992-8aa0-5c2d88996af7@intel.com> <b79804b0-32ee-03f9-fa62-a89684d46be6@arm.com>
 <c6abb754-0d82-8739-fe08-24e9402bae75@intel.com> <aae34dde-fa70-870a-9b74-fff9e385bfc9@arm.com>
 <f5315662-5c1a-68a3-4d04-21b4b5ca94b1@intel.com> <ac942498-8966-6a9b-0e55-c79ae167c679@arm.com>
 <9015e51a-3584-7bb2-cc5e-25b0ec8e5494@intel.com> <CAPcyv4jnnnXi9Fqaf-d7AdnKrTMDCWr-e9tAx+G6nphrEPYm=w@mail.gmail.com>
 <b9962dfa-924f-77f7-a40f-407dd20e9082@intel.com> <CAPcyv4hVFMvut9+Rq7G41yyKzV072U33YEeHNh160VBr3QW-nw@mail.gmail.com>
 <325d0e69-053a-ae9c-eede-7cdf28b1dbd6@arm.com>
In-Reply-To: <325d0e69-053a-ae9c-eede-7cdf28b1dbd6@arm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 27 Nov 2018 08:56:09 -0800
Message-ID: <CAPcyv4iA+yA_OZMUSbJTV=c9=QsRAcLjzLK94uuVsMTaPu6eTg@mail.gmail.com>
Subject: Re: [PATCH 0/7] ACPI HMAT memory sysfs representation
To:     anshuman.khandual@arm.com
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 2:15 AM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 11/26/2018 11:38 PM, Dan Williams wrote:
> > On Mon, Nov 26, 2018 at 8:42 AM Dave Hansen <dave.hansen@intel.com> wrote:
> >>
> >> On 11/23/18 1:13 PM, Dan Williams wrote:
> >>>> A new system call makes total sense to me.  I have the same concern
> >>>> about the completeness of what's exposed in sysfs, I just don't see a
> >>>> _route_ to completeness with sysfs itself.  Thus, the minimalist
> >>>> approach as a first step.
> >>> Outside of platform-firmware-id to Linux-numa-node-id what other
> >>> userspace API infrastructure does the kernel need to provide? It seems
> >>> userspace enumeration of memory attributes is fully enabled once the
> >>> firmware-to-Linux identification is established.
> >>
> >> It would be nice not to have each app need to know about each specific
> >> platform's firmware.
> >
> > The app wouldn't need to know if it uses a common library. Whether the
> > library calls into the kernel or not is an implementation detail. If
> > it is information that only the app cares about and the kernel does
> > not consume, why have a syscall?
>
> If we just care about platform-firmware-id <--> Linux-numa-node-id mapping
> and fetching memory attribute from the platform (and hiding implementation
> details in a library) then the following interface should be sufficient.
>
> /sys/devices/system/node/nodeX/platform_id
>
> But as the series proposes (and rightly so) kernel needs to start providing
> ABI interfaces for memory attributes instead of hiding them in libraries.

Yes, I can get on board with sysfs providing a subset of the
performance description for administrators to discover the common case
via scripting and leave the exhaustive attribute description to a
separate interface. I was pushing back on the notion that sysfs must
be that exhaustive interface... we're making progress.

I still think we need /sys/devices/system/node/nodeX/platform_id to
enable higher order platform enumeration tooling, but that need not be
the end of the kernel interface description.
