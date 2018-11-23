Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C5AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 21:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7678F20672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 21:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="lsmGmETf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7678F20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbeKXH7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 02:59:43 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43351 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbeKXH7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 02:59:42 -0500
Received: by mail-ot1-f67.google.com with SMTP id a11so11635937otr.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 13:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cf8Bf9cqH3KJAnd4Gakfudx+0el2GbZ4GpkjeweKinQ=;
        b=lsmGmETfoNfozEG6Ov8+UwIGqho5KN2Uhx7e3tca6RlEJEQDl50jQZTTZBR0n94K+P
         cWDxFg2wREPMDLYLOzyzihhRq8I010W1EuBjxNac+IGb9e8vus+NPIzQG64Ac8q3LjjV
         1TcEgPeF0nzE9VZdpGaOf+jh0b+e1VEXD0R3xc0vzJyQSHqf7djk/CpkovTIaCATP+Pk
         Jnec5IMWBFlNJgFXGo0zHp/WiroZ0SpGZRJbkGaoknddM3z0ByAYf+9jeOrChg/DqlPT
         tX3zO+XMHIH3tDT2T4AkfWUwIXmDQ/nrDiWsyeBGA+YL7986lF4bkxgZ1Rvh1NhgwdBD
         /3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cf8Bf9cqH3KJAnd4Gakfudx+0el2GbZ4GpkjeweKinQ=;
        b=fOpWgEZ3NXI096JNs+84MpOtQWVwwoE+tgH8fscvImlTF6Klqcq09QuFA0C6dIg65Q
         /TyIQB1gRr/cbAWCWjdRt3kNDm0HamKLMruWf12tzGI/O4YH4/U1CNi/2SBNzkkdcubH
         f/wDiSEJXD4MF2J11fVsZhCsG8kwbs6Hr/N5F8EvbORJhmSK04HSqNMVgfsR5ZEUHUHu
         J7SYkFMa+B7mZdW/qM5nw/WrQDk68OGQGlvFUzwxXW+xmd6IqfZex/ySZt7/vXned0GS
         3my/E42//Lm2wLLvmn0FmzXzrWaOawMAnqzn6sOKL/iZ8BAZmszavXVU5cbzAwxwKOPq
         d8vA==
X-Gm-Message-State: AA+aEWbUegpqF7ihp4PXkHPH+OTKNd/N75VxDlYYg7R2EGgqeLSy65XL
        C1NuNnVKxI1ztsIDah7EEqOfQ6nGWMLXSGgrU70YQA==
X-Google-Smtp-Source: AFSGD/VmF6UjjxpaCFBzvXsEkIn/R/KB7e6BjiEaeGrEkfInKy+TLr9hST3JojX4AegaPSkngJfk8UwEDj4j1P2UZts=
X-Received: by 2002:a9d:775a:: with SMTP id t26mr9129995otl.32.1543007627876;
 Fri, 23 Nov 2018 13:13:47 -0800 (PST)
MIME-Version: 1.0
References: <20181114224902.12082-1-keith.busch@intel.com> <1ed406b2-b85f-8e02-1df0-7c39aa21eca9@arm.com>
 <4ea6e80f-80ba-6992-8aa0-5c2d88996af7@intel.com> <b79804b0-32ee-03f9-fa62-a89684d46be6@arm.com>
 <c6abb754-0d82-8739-fe08-24e9402bae75@intel.com> <aae34dde-fa70-870a-9b74-fff9e385bfc9@arm.com>
 <f5315662-5c1a-68a3-4d04-21b4b5ca94b1@intel.com> <ac942498-8966-6a9b-0e55-c79ae167c679@arm.com>
 <9015e51a-3584-7bb2-cc5e-25b0ec8e5494@intel.com>
In-Reply-To: <9015e51a-3584-7bb2-cc5e-25b0ec8e5494@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 23 Nov 2018 13:13:36 -0800
Message-ID: <CAPcyv4jnnnXi9Fqaf-d7AdnKrTMDCWr-e9tAx+G6nphrEPYm=w@mail.gmail.com>
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

On Fri, Nov 23, 2018 at 11:21 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 11/22/18 10:42 PM, Anshuman Khandual wrote:
> > Are we willing to go in the direction for inclusion of a new system
> > call, subset of it appears on sysfs etc ? My primary concern is not
> > how the attribute information appears on the sysfs but lack of it's
> > completeness.
>
> A new system call makes total sense to me.  I have the same concern
> about the completeness of what's exposed in sysfs, I just don't see a
> _route_ to completeness with sysfs itself.  Thus, the minimalist
> approach as a first step.

Outside of platform-firmware-id to Linux-numa-node-id what other
userspace API infrastructure does the kernel need to provide? It seems
userspace enumeration of memory attributes is fully enabled once the
firmware-to-Linux identification is established.
