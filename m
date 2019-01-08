Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C12C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F332087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="MAU9E9l9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfAHFOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 00:14:18 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39430 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfAHFOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 00:14:17 -0500
Received: by mail-oi1-f194.google.com with SMTP id i6so2353112oia.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 21:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DPfTlBHfmJ7XISdyKygwEFKzLAg3jwHYT21kbE4eTHs=;
        b=MAU9E9l9eSGcAsov3tKU3KXUp+waFO44sqYKvTm7QsXmSpmo6bv4YQB7Eqk4AfiklX
         paOUqhgzQqiTMmDG2c90XG3o5TsiRMuqa9DuZ3CMPpuiL0mhLn76rsriNmCRiuhSNyYX
         FVhN3byHIiXgt8+1T0zDjoZPOHNeo5WE0CuJt2eagYHq6lwLl+PaCtY7xyMZ/8AMoQzJ
         h2L4ECcKCX3L2GeN4eLapR+TR9MJ9C8iZG/sJ82WjmCu4BEltchzdv0glrezu8EocmMn
         hMPZw7QLELqzK0nClj+BHTq65mqO/PH1+oGxJqYkpO06rp8h5UT+LqdMczsYGjd94kNC
         rZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DPfTlBHfmJ7XISdyKygwEFKzLAg3jwHYT21kbE4eTHs=;
        b=mvuAsz/hlhumJ1GV6FOkCYpnaSo5BCGLEs/Z+WsD49FzDxueDPaPuOA29DUIKhepZ3
         vQUPyC9N5w4Z6xevvPLM7m3bS9UlEqRQGvzro7zdi7h9MpQP9055DHeL74FJwBJhR+zi
         B0gJM48g6X4TEq9hjfmkRFMRyldGSFfOKshCcUiOZNo5RueNba/uDBSB2PbItpJFQ/E0
         3TK0hRYGY2ixYkYt0yCo3dd/WRaRjCLalo4xYQJQPBiH37Ltx7Zp+f6swum5w8wMHNg3
         lh3pzmcPf030MJWVInCQ3KA96ngJ7W40dwIB3diArcpEkZ19ystjZOHEVtpbPDzvKN4a
         7VFQ==
X-Gm-Message-State: AJcUukexxrV4eAYg7aL/yhD15IY2p6xBd18wl/9ZHqA8Gm2MTiYaYJ/q
        5xMdmQn8VJluWRwFQWTwxo+j6Ku4PnH8jIbvH2BIzw==
X-Google-Smtp-Source: ALg8bN6//+kwaa5BsuzE/xKMEoq2FPUwTuvWxiSiMKodlG7UIxbif3kJEYrKlKl62juHrmSj49qh9lypgBndMYZFgbE=
X-Received: by 2002:aca:4307:: with SMTP id q7mr239727oia.105.1546924457236;
 Mon, 07 Jan 2019 21:14:17 -0800 (PST)
MIME-Version: 1.0
References: <20190108045853.5471-1-natechancellor@gmail.com>
In-Reply-To: <20190108045853.5471-1-natechancellor@gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 7 Jan 2019 21:14:05 -0800
Message-ID: <CAPcyv4gA=qEm81k-f80oBBo9mmPcAg6szYQvtdOWFFWgd=9A4g@mail.gmail.com>
Subject: Re: [PATCH] nfit: Hide unused functions behind CONFIG_X86
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Ross Zwisler <zwisler@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 8:59 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On arm64 little endian allyesconfig:
>
> drivers/acpi/nfit/intel.c:149:12: warning: unused function 'intel_security_unlock' [-Wunused-function]
> static int intel_security_unlock(struct nvdimm *nvdimm,
>            ^
> drivers/acpi/nfit/intel.c:230:12: warning: unused function 'intel_security_erase' [-Wunused-function]
> static int intel_security_erase(struct nvdimm *nvdimm,
>            ^
> drivers/acpi/nfit/intel.c:279:12: warning: unused function 'intel_security_query_overwrite' [-Wunused-function]
> static int intel_security_query_overwrite(struct nvdimm *nvdimm)
>            ^
> drivers/acpi/nfit/intel.c:316:12: warning: unused function 'intel_security_overwrite' [-Wunused-function]
> static int intel_security_overwrite(struct nvdimm *nvdimm,
>            ^
> 4 warnings generated.
>
> These functions are only used in __intel_security_ops when CONFIG_X86 is
> set so only define these functions under that same condition.

Thanks for the report, not sure how the kbuild robot missed this. I'd
prefer marking the functions __maybe_unused rather than expanding the
ifdef guards.
