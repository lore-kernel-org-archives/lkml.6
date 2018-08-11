Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E5AC46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 09:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 758A12238C
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 09:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbjgJONy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 758A12238C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbeHKMQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 08:16:44 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:32828 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbeHKMQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 08:16:43 -0400
Received: by mail-it0-f68.google.com with SMTP id d16-v6so6873599itj.0;
        Sat, 11 Aug 2018 02:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0eq28fnDUokuTC5dF8gKRyVk0QeyW90DZg+VpvBpZl4=;
        b=lbjgJONyfzcNz2Igk8pFczKn3BMnctL5JLHgqR+EFycDht6Jun+7vbQ9D4DxVCNW91
         vPNFKjCtlk7QRGVn+JG3KiLF0WzRH9HnCq8FMMjcPf/jGeRi4G63PbvKRPnETjokXOPK
         Ic5m1Rhlw3xZv6oVlkgWJXqZu089uX3TWeiGpm6+NFHLl9U3/HRv0S+81yiSU2Lu4qc2
         LrbElGm7GWtpFnmJbN1/zbcX+Q+aRNIVAWmxgM1HA3ofQe2/JQXiVI8/INu4NSlbTPca
         e/MM2fgojzi3FWcZ/+XbBuw9as4PaYjDrYD7EuclPaShv+1THIrpdQYgO9Yhzc9HjNEf
         puJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0eq28fnDUokuTC5dF8gKRyVk0QeyW90DZg+VpvBpZl4=;
        b=tES7Lja8XxXQx/dZ/OsABd1zubDTGNGItILmNFZDAe64aiv9IHGFNVBQTM95KX0Sel
         XW55ypbCRmjjCuAVVgdJEdJdib7Ae+QQpywnvaVF26CQxeXp4qbZvCUeyQhho+yAljBy
         bcTsjv9KSl4IQ14atfCNA4PgXGNHs6i4k0rKLiTEzx8rA7Be87z3mi4UMhK4uTqXfcqB
         mDu8XorbE5BuKqUzqIV7F0OuYCwgnYgvdGA4upt10qKSs8aZKEuwM65jjI/ay9LX378P
         RPVohP462rcVcuIlxgVyCbqawsyTXO54u7UNeedv/Pnoq83sWabl/8bitJRFVBNEx33Q
         BryQ==
X-Gm-Message-State: AOUpUlHfsNTHJSb8wrXRh6LFes1jvQjAgERiQQRRugNFFHekH/6JCgj6
        gfDeSNgBhdbWBL9HwZgb5P9oErAU3RtuQClJEBc=
X-Google-Smtp-Source: AA+uWPwwjmhEa484IwHiHdAzhW6ZokLkYFXCkJ4LLzpYVuXQNNhUK7fGhqhhfer5t+0KPOESdg8PBQSBLMth5kDttxU=
X-Received: by 2002:a24:68c2:: with SMTP id v185-v6mr4971997itb.128.1533980584138;
 Sat, 11 Aug 2018 02:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAO-sURTngN_mnpJp9rvutpDfz80Nq4K8JOH4fnZG2NaTafkx+g@mail.gmail.com>
 <CAO-sURTs1dc_5iY+b34Jqj4hxZFdUj9LZxTWhDdvqM8AbEqMAw@mail.gmail.com>
 <20180810165735.GT4692@linux.intel.com> <20180810214433.GA15044@linux.intel.com>
In-Reply-To: <20180810214433.GA15044@linux.intel.com>
From:   Tomas Winkler <tomasw@gmail.com>
Date:   Sat, 11 Aug 2018 12:42:53 +0300
Message-ID: <CA+i0qc5Z95QD4Pb8XYGnj+=gVfGJWARqrRN8zej0zDUrcDYW5w@mail.gmail.com>
Subject: Re: Fwd: PROBLEM: tpm_cpg can't request region with AMD/Dell fTPM
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     harlan@dds.mil, Peter Huewe <peterhuewe@gmx.de>,
        linux-integrity@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 11, 2018 at 12:45 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Fri, Aug 10, 2018 at 07:57:35PM +0300, Jarkko Sakkinen wrote:
> > On Tue, Aug 07, 2018 at 02:43:10PM -0400, Harlan Lieberman-Berg wrote:
> > > (Resending as it seems to have been spamfiltered out from the ml;
> > > sorry Peter, Jarkko for the duplicate)
> >
> > I came on Monday from four week leave and have been basically been
> > catching up with my emails :-) I'll look into this next week with
> > time.
>
> The error message is saying that someone else has reserved the resource
> (-EBUSY).
>
> This looks odd:
>
> e78bf000-e7bbefff : ACPI Non-volatile Storage
>   e7bb6000-e7bb9fff : MSFT0101:00
>   e7bba000-e7bbdfff : MSFT0101:00
>
> Why would be TPM registers mapped inside ACPI NV?
>
> I would *guess* that what is happening is that perhaps drivers/acpi/nvs.c
> maps the address space. This looks like a firmware bug, and such that we
> cannot do anything about it.
>
> I'm having a weird issue with the ACPI tables:
>
> $ acpixtract acpidump.txt
>
> Intel ACPI Component Architecture
> ACPI Binary Table Extraction Utility version 20180105
> Copyright (c) 2000 - 2018 Intel Corporation
>
>   DSDT -   31048 bytes written (0x00007948) - dsdt.dat
>   SSDT -     349 bytes written (0x0000015D) - ssdt1.dat
>   SSDT -   18086 bytes written (0x000046A6) - ssdt2.dat
>   SSDT -    5225 bytes written (0x00001469) - ssdt3.dat
>   SSDT -    1082 bytes written (0x0000043A) - ssdt4.dat
>   SSDT -    1017 bytes written (0x000003F9) - ssdt5.dat
>   SSDT -    5369 bytes written (0x000014F9) - ssdt6.dat
>
> $ iasl -d *.dat
>
> Intel ACPI Component Architecture
> ASL+ Optimizing Compiler/Disassembler version 20180105
> Copyright (c) 2000 - 2018 Intel Corporation
>
> Input file dsdt.dat, Length 0x7948 (31048) bytes
> Table [DSDT] is too long for file - needs: 0x815D, remaining in file: 0x7948
> Could not get ACPI tables from dsdt.dat, AE_BAD_HEADER
>
> This has not happened to me before.
What platform is this? This is not regular 0xfed40000 address space. I
guess this is BYT or CHT.  It's better to get dmideoce dump as well.
It looks more like a BIOS issue.
Please forward the complete data.
Thanks
Tomas
