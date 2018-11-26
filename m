Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC928C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77DA520817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="px+R53O9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77DA520817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbeK0FDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 00:03:19 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45708 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725199AbeK0FDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 00:03:19 -0500
Received: by mail-ot1-f65.google.com with SMTP id 32so17465817ota.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 10:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AzI3Y6/89Bw4vbZl5XXZYpJXzbnTAAgZ69VKphCpYl8=;
        b=px+R53O95subW6m6mOWCNlVfDv1A0Vq2NjWh1Xu6pzSO4VrsgnBE6f1MEQZlDXQYbV
         YHUkR0PWAXKdiEuiEf0cELGLoulA4lf9VirFJkG0ODSsRwbd6f5kq2QDY57jODCrG7pt
         vMFiFkfgvmyeDn0qpGL1HbzrJoC3zH800lfolLcFbbI4vk9vCYaLmtVtZpKtt/Nq7UWq
         46yBEus2pekcivAH6eEGqfZH1zoS7yaLdZ1Y5U+g8nY3YIDH31eLv3RczWB2vABNP017
         eVEA1g0JHBDF5x8BuvDzFE+loN/sprLGkiv/8rgdZJUnhQb5fNkexQPrKREeWzsrHVqf
         Fd7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AzI3Y6/89Bw4vbZl5XXZYpJXzbnTAAgZ69VKphCpYl8=;
        b=hcn786D49mb01IgCe7PMDGFizyMAUUiPkoSZxXvpIpH8GxbKXhIh7qv5eJUf77aENt
         QYLDQ4MraKvXPr5bp0QHI5wliLGYP3upJDheSgu/LBe1ZZHo0mwlcsuqUbcXRhrN8BOr
         dZ0R0XJFX4uxAFbnY2VaRDG70zD+14nQEZl+urJmMRp/Uy+sjgNeiGTEtoAo7Z+V/1Dz
         DF4l/uwdFPwUoy6JSeFcwK7CtqJD2XIx8ZEbIS+4FxgbFkV9eQFi01qAa/tJppkylfI/
         Wt15AKaO7N1W+5cl1GHxdybC23xndBQ8gE7lsuB2myTKn0R1B2aX2jl/ehABJTaa4jn9
         csEg==
X-Gm-Message-State: AA+aEWb/dxfIMmo8+HGBlMRQZ/f1BSK36vYFpziZyya86pFtOjnFf2oX
        P5sFPoz6yUmV6aNnUuSgHkM3pgfWE31tjEzeOo58XWx3
X-Google-Smtp-Source: AFSGD/U4tbq8gjfRU3pLgczr33MS9sSLEqsQzqjsqhHMbcd2nCBSRd1gJGHEVNOHUz1etj9kW4z+US0NUocNX3P7/oY=
X-Received: by 2002:a9d:3ac:: with SMTP id f41mr12033324otf.98.1543255705724;
 Mon, 26 Nov 2018 10:08:25 -0800 (PST)
MIME-Version: 1.0
References: <20181114224902.12082-1-keith.busch@intel.com> <1ed406b2-b85f-8e02-1df0-7c39aa21eca9@arm.com>
 <4ea6e80f-80ba-6992-8aa0-5c2d88996af7@intel.com> <b79804b0-32ee-03f9-fa62-a89684d46be6@arm.com>
 <c6abb754-0d82-8739-fe08-24e9402bae75@intel.com> <aae34dde-fa70-870a-9b74-fff9e385bfc9@arm.com>
 <f5315662-5c1a-68a3-4d04-21b4b5ca94b1@intel.com> <ac942498-8966-6a9b-0e55-c79ae167c679@arm.com>
 <9015e51a-3584-7bb2-cc5e-25b0ec8e5494@intel.com> <CAPcyv4jnnnXi9Fqaf-d7AdnKrTMDCWr-e9tAx+G6nphrEPYm=w@mail.gmail.com>
 <b9962dfa-924f-77f7-a40f-407dd20e9082@intel.com>
In-Reply-To: <b9962dfa-924f-77f7-a40f-407dd20e9082@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 26 Nov 2018 10:08:12 -0800
Message-ID: <CAPcyv4hVFMvut9+Rq7G41yyKzV072U33YEeHNh160VBr3QW-nw@mail.gmail.com>
Subject: Re: [PATCH 0/7] ACPI HMAT memory sysfs representation
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     anshuman.khandual@arm.com, Keith Busch <keith.busch@intel.com>,
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

On Mon, Nov 26, 2018 at 8:42 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 11/23/18 1:13 PM, Dan Williams wrote:
> >> A new system call makes total sense to me.  I have the same concern
> >> about the completeness of what's exposed in sysfs, I just don't see a
> >> _route_ to completeness with sysfs itself.  Thus, the minimalist
> >> approach as a first step.
> > Outside of platform-firmware-id to Linux-numa-node-id what other
> > userspace API infrastructure does the kernel need to provide? It seems
> > userspace enumeration of memory attributes is fully enabled once the
> > firmware-to-Linux identification is established.
>
> It would be nice not to have each app need to know about each specific
> platform's firmware.

The app wouldn't need to know if it uses a common library. Whether the
library calls into the kernel or not is an implementation detail. If
it is information that only the app cares about and the kernel does
not consume, why have a syscall?
