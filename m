Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 96088C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B500208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHkwqmx3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B500208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934811AbeFMI1o (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 04:27:44 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:36548 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933912AbeFMI1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 04:27:40 -0400
Received: by mail-oi0-f42.google.com with SMTP id 14-v6so1557777oie.3;
        Wed, 13 Jun 2018 01:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=AZg1nCBjfTBg4x6eFB4bqzoNVVuEelduWXRhnNDiiBE=;
        b=aHkwqmx3DaVBc8wbGFIuXwKkxi+8qpTxj28JkkA1bzt1gJTXk/JgdxH06lFl4N6bKJ
         M42khvX26b4jKhypi8sit+PXmpkkgYNK6tR7x3pQ42jwIepw0U+F63CM46ArfgL2t6vy
         E5baPsrMkaQkMvTK7IPQGfNv/whfooxlnNwype3q5eILehr4LvMZt4ABk6bHqm97UL5N
         yTrIw6yce+mugLpEaXlcf/VxURaT/X7A94P9fc8HU6As+l8gWDXFvarJLQEXwCgZiYO7
         WSymOjILKpKz4MSZYJYoqXCKa5gUnT2zTKgfg0AnfUTI89eqAk9FmDlfc2i8gjZbYX+t
         iqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=AZg1nCBjfTBg4x6eFB4bqzoNVVuEelduWXRhnNDiiBE=;
        b=e7DTkp5XO6gbG+O68ZMHgz6GBRNROvshM3OTRWv45nJIGIrvcIzgYRROf+t3pn4tS0
         bw+EbOupNqvnWYO5y/Rz1jXM4XOz63m7puivwBCMicsVyZw+Zsnh8Q02QFrlf3URPgRS
         gJaWVFx27T0JsNlNahOIt+LhVrS24Z9WJAJ5OgOnBCNBMFIL+9TBi5xMylthPFVSS8ia
         bL8i9K/tqlgiFVad/wMvx+hZPHRyIyphhCZgIGZfdyteHS1DV6G0Gw5hvbbmgX/DLZpS
         ab9Vy5RzyLPS+m0J8n5CWvnLx7pYPQrQcNm09wkCeP/L2TyuUwxQPutGaGwMxK8/B8Q5
         jWzQ==
X-Gm-Message-State: APt69E1fCeFuEJdZ2yOLs5DBdIXczEUxUF2QO4v+d64/wvNH7vHe+8jo
        S8fsoAeUjX8OMmFvh/aFCf/HWjJtlcLlEiyHtC4=
X-Google-Smtp-Source: ADUXVKJq/m5yyiM7uUipwTrHjewyi9iohIlXuyYZrc1w1eNefLLdzN2HNaStBdGhq1bHd6U0nqOZLR9mLUh8E/Dw7hE=
X-Received: by 2002:aca:ef44:: with SMTP id n65-v6mr2762783oih.120.1528878459582;
 Wed, 13 Jun 2018 01:27:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1429:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 01:27:39
 -0700 (PDT)
In-Reply-To: <CAHp75VdSW1po7fVv+A6ATTU7CkN-4nQ1haQSCq7b_+ZR9tNXCQ@mail.gmail.com>
References: <CABe79T6zQ_7Ycws5b=xaQ3edpVn1QPQyWd9p24eqLGpYbdtt0A@mail.gmail.com>
 <CAHp75VdSW1po7fVv+A6ATTU7CkN-4nQ1haQSCq7b_+ZR9tNXCQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Jun 2018 10:27:39 +0200
X-Google-Sender-Auth: EIAXGr5IZxDPHQnOpChym-xYFSQ
Message-ID: <CAJZ5v0iJcTg=X_j-4nap9d_H4jq2rwOETT8Sukx6UL5UsDKjgA@mail.gmail.com>
Subject: Re: ACPI support in common clock framework
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 10:13 AM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> +Cc: Rafael, ACPI ML
>
> On Wed, Jun 13, 2018 at 7:14 AM, Srinath Mannam
> <srinath.mannam@broadcom.com> wrote:
>> Hi Michael, Stephen,
>>
>> We are adding ACPI support in our Linux based platform.
>> At present our clock hierarchy using common clock framework through DTS.
>> Now we required ACPI support in common clock framework to upgrade our platform.
>>
>> For example, clk_get API called in many drivers to get clock device is
>> tightly coupled with DT framework.
>>
>> Please let us know, if anybody in Open Source community have plans to
>> add ACPI support for common clock framework.

There are no plans for doing that AFAICS.

Moreover, it generally would not be consistent with ACPI power
management defined by the specification.

>> If not please suggest us alternative method to use common clock
>> framework in ACPI use case.

The problem with using the clock framework on systems with ACPI is
that, in general, the clock manipulation is expected to be carried out
by ACPI power management and therefore it is "owned" by AML.
Currently, there are no defined methods for synchronizing the AML's
use of clocks for power management with what the OS may do with them
directly.

In theory, that can be worked around to some extent by representing
clocks as power resources in ASL (even though the provider information
would be missing then) and manipulating those power resources directly
from the OS.  I'm not aware of anyone doing that successfully,
however.

For simple power management it should be sufficient to let drivers
rely on the ACPI PM domain which should happen automatically in the
majority of cases anyway.

Thanks,
Rafael
