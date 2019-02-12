Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549DDC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24BB220818
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3ddIB3R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbfBLKmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:42:10 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43553 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728909AbfBLKjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:39:02 -0500
Received: by mail-pf1-f196.google.com with SMTP id q17so1093005pfh.10;
        Tue, 12 Feb 2019 02:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fqY4P2eYdKgxqtOm2MYGL2GqiOza+mZcZqBwzxHlMfY=;
        b=d3ddIB3R03kACqgoLZik6hryMgyRyyu2dWAZEvKtvvvXetLP8uQRgjN54SzxSfEvnN
         yIbA21gNGZ/LsBmP+RxMMCrMHZXOc4rdyHyfLaZ7tOwmhBOhp9N9Ty1iCL1utoNX0Rtg
         UsHwZjEsxI6n8AvodKgYoAmj+ann439xkVw534JKCwI2hlIpERx7bA1zAlt0Ho/zQC9z
         t7ZgKIj0HEIi4WxYb66xkKgbBxXHmrNKLBFSvjbasB9ZNIY43ovIHF9vti14xrnJ8ana
         CKuzf8k4TAJ1F5b0hfeCb7YICB9ru1r3LFUobKY7kVflJDUAh//1Lzr8wcHL3bcrrP3X
         N4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fqY4P2eYdKgxqtOm2MYGL2GqiOza+mZcZqBwzxHlMfY=;
        b=YYqxeD5pQzgWsoXb8oVMw02V4ojY45nYwlEJfnQa485mEvcgZ/QWN2XDe11EwENq5A
         MH6oL1uohJGmSmDmv9+8AH15GGJmPgoxvGcWJoV9Ik4le82qIRAMxLCWrMeGXp61Q14P
         Szz9vqIsOkp4CVp9pDSB5FGrEBK428Z7V5Obh2Oe+PJPQughnY58Gynn+mCRru70alLW
         2CurP8YDSC1bSXTI7/pYBhUcCQ5ZYZM7NBliDYrIg75mHAz8Bp9Uhg37G0y6M85Pm3mH
         fwh1I5QcxdrNOnxMlhXaoC6wMkPh8o+l2JNqmvcmhgqto/DKRZdzkWgUWHQD/PzJSUGb
         EsYw==
X-Gm-Message-State: AHQUAuZ5bdBTrCg58ARssGBiJtQvLU9S8gcb4wFsgqvCTBT+nfLZWhrm
        jn3SD9hJ+rFZyDSJpwvLY22ZuEDAOtsMyIVrzfHk4rtu
X-Google-Smtp-Source: AHgI3IbNLFRGmmQ8VeGy5Sy53Nrn4fdpmMvO4rayMf3X03hniOtEGDmt+pjvxaEJywvbmVnjGvr/egKOThsC5EW0KhE=
X-Received: by 2002:a63:20e:: with SMTP id 14mr2994592pgc.161.1549967941912;
 Tue, 12 Feb 2019 02:39:01 -0800 (PST)
MIME-Version: 1.0
References: <20190201073234.13280-1-rajneesh.bhardwaj@linux.intel.com>
 <20190201073234.13280-10-rajneesh.bhardwaj@linux.intel.com>
 <20190211164118.GA23796@genxfsim-desktop> <78e5e6b3-5712-6ef5-283c-83b0f6d3dcc7@linux.intel.com>
 <CAHp75VeZwgM9KPNahmpsLzzkmOKDN2JeBKQWO9hBK_O=Gk8oFw@mail.gmail.com> <38444053-cbab-ae6d-9504-18ca3cd84d15@linux.intel.com>
In-Reply-To: <38444053-cbab-ae6d-9504-18ca3cd84d15@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Feb 2019 12:38:50 +0200
Message-ID: <CAHp75VdDDe1xM7dOAQ==fpSFW6qMiSqRD_9vXF83XGb3YGbBFw@mail.gmail.com>
Subject: Re: [PATCH 09/10] platform/x86: intel_pmc_core: Add Package cstates
 residency info
To:     "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Cc:     Anshuman Gupta <anshuman.gupta@intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "David E. Box" <david.e.box@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 12:34 PM Bhardwaj, Rajneesh
<rajneesh.bhardwaj@linux.intel.com> wrote:
> On 12-Feb-19 3:55 PM, Andy Shevchenko wrote:
> > On Mon, Feb 11, 2019 at 8:32 PM Bhardwaj, Rajneesh
> > <rajneesh.bhardwaj@linux.intel.com> wrote:
> >> On 11-Feb-19 10:11 PM, Anshuman Gupta wrote:
> >>> On Fri, Feb 01, 2019 at 01:02:33PM +0530, Rajneesh Bhardwaj wrote:

> Sure Andy, I can do as you suggest but i am confused now because on
> another patch i've got "Acked-and-tested-by" only i.e. just one single
> tag. So for consistency, what should i do? I also noticed that this tag
> is used about 59 times in Linux kernel and i even found one
> "Reported-Acked-and-Tested-by" too :) though i understand these may not
> be acceptable by all Maintainers. So, please guide.

The rule of thumb is to be closer to what you got from a person and at
the same time don't push custom (non- or rarely used) tags.
So, 59 uses seems okay to me to use that tag as is.

-- 
With Best Regards,
Andy Shevchenko
