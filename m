Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B80C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 146DB206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfPk0Ln2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 146DB206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbeHWTRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 15:17:22 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:34880 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727633AbeHWTRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 15:17:22 -0400
Received: by mail-ua1-f67.google.com with SMTP id m26-v6so2187806uap.2;
        Thu, 23 Aug 2018 08:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WmA1vERHFF/2qDPA+nfYeJ6q6ef529bxANhjNbLYpec=;
        b=FfPk0Ln2oeX05S4fOPT8U/G0/dMotHTISeDxtnZGrG1eWYLdPLDxqHUkDHw1SvHcS8
         jnwTiIrNDx+Er695CHC4FxsuKYZHpwwICOxV4PUG8okJ4+XoQhsKsFg8Z3XHhqmwJVy0
         LAORuiCLk9JWiyztVADMlLMCO61WDNKA31GujcV84TrvueR/YYM1A9aSgh16cguDL/Ao
         j0L2CcbO0hjInfPT3ACMV8Mpgh9SVoe+I9B59E27g/GNHOa4p+yc1EgEiE/T4jz9q8os
         PL5hoJQFI1zclGqtaYirub67jEb17ozKlj7WXDCyY5jjWW9XvZJr2NbY4+lNeEkD3pv9
         Jpqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WmA1vERHFF/2qDPA+nfYeJ6q6ef529bxANhjNbLYpec=;
        b=paeRC+S7/jic9O7RyR2XZ8MN3axL97qXAGCjscGvmgjrgdvQOopnfnsDgS7r8VsO3J
         HKpNtV6jico9RzFCEpMdOLCzFAiJW2CRA1wYyv6gV/eFC1M6xa9Xb2VfLDdwUu97KEDN
         U10MvRkQeHIzUzTL1HwHutQL7ep7hC07hY8rsdgM0DH0bs2xWS3m0rvh0w8lUw+cT+k/
         bHN9yWsI9UsLvbUQTaanuLXEHkS/yqu6fcrAHaqA5HpqalbOquUXWCk8d1XS1cdD6ugB
         /yVzEsv6KykTEjiAbB8YpiIkXmYmZZvM8Duvhj7daTRDaVAZ1rpI+Gssc+xW8AFzpWVY
         smsA==
X-Gm-Message-State: APzg51CQnI8wNI4KPZ1/G3cbKF9RhCG7wh5DUt2UZZbbbWtGW9gtU6hk
        f5m6+x36SyV0nu+Pur4rXJNybXojXn02E5lsPqlsZiYE
X-Google-Smtp-Source: ANB0VdY5rZ+3Ikp7uAw2yUFQo+jM92vk69q5nBA9XOACfQCFB+htLx8pxFAX3wp64JV38r75upnlQdvAQLpewBNW+Iw=
X-Received: by 2002:ab0:5f21:: with SMTP id p33-v6mr6945331uah.172.1535039228389;
 Thu, 23 Aug 2018 08:47:08 -0700 (PDT)
MIME-Version: 1.0
References: <1531762009-15112-1-git-send-email-tbaicar@codeaurora.org>
 <20180719140102.GB25185@nazgul.tnic> <94e3a0fb-9b7d-045f-733b-9f063dcb39e4@arm.com>
 <45fefe7d-c6ea-5791-4477-13ecce39ce48@codeaurora.org> <b568fdcc-ca39-67ea-2799-8ed246c8ffb6@arm.com>
In-Reply-To: <b568fdcc-ca39-67ea-2799-8ed246c8ffb6@arm.com>
From:   Tyler Baicar <baicar.tyler@gmail.com>
Date:   Thu, 23 Aug 2018 11:46:59 -0400
Message-ID: <CABo9ajA7SPrVE-oiG=RicH+nL9_pp7fVATCdMugY5fuNAPzHaQ@mail.gmail.com>
Subject: Re: [RFC PATCH] EDAC, ghes: Enable per-layer error reporting for ARM
To:     James Morse <james.morse@arm.com>
Cc:     Tyler Baicar <tbaicar@codeaurora.org>, wufan@codeaurora.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        harba@qti.qualcomm.com, Borislav Petkov <bp@alien8.de>,
        mchehab@kernel.org,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        linux-edac@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello James,

On Thu, Aug 23, 2018 at 5:29 AM James Morse <james.morse@arm.com> wrote:
> On 19/07/18 19:36, Tyler Baicar wrote:
> > On 7/19/2018 10:46 AM, James Morse wrote:
> >> On 19/07/18 15:01, Borislav Petkov wrote:
> >>> On Mon, Jul 16, 2018 at 01:26:49PM -0400, Tyler Baicar wrote:
> >>>> Enable per-layer error reporting for ARM systems so that the error
> >>>> counters are incremented per-DIMM.
>
> This 'layer' term seems to be EDAC's artificial view of memory.
>

Yes, it's just the terminology that EDAC uses for locating a DIMM.

"Layer" can mean several things here:

https://elixir.bootlin.com/linux/latest/source/include/linux/edac.h#L318

We should be able to avoid the layer definitions with the SMBIOS handles.

>
> >> Does this work on x86, and its just the dmi/cper fields have a subtle difference?
>
> > There are CPU specific EDAC drivers for a lot of x86 folks and those drivers
> > populate the layer information in a custom way.
>
> Not for GHES surely?
>

Correct, the x86 drivers that properly increment the DIMM error counters are not
tied to the ghes_edac driver.

>
> (DPC == DIMM per Channel?)
>

Yes.

> > The goal is to be able to enable the per layer error reporting in the ghes_edac
> > driver so that the per dimm counters exposed in the EDAC sysfs nodes are properly
> > updated.
>
> What do you mean by layer? I can't find anything in the ACPI/UEFI/SMBIOS specs
> that uses this term...
>
> If its just 'per dimm counters' you're after, this looks straightforward.
>

Yes, we just need a way to increment the per DIMM counters that are
exposed by the
EDAC sysfs nodes.

> [re-ordered hunk:]
> > This seems pretty hacky to me, so if anyone has other suggestions please share
> > them.
>
> CPER's "Memory Error Record 2" thinks that "NODE, CARD and MODULE should provide
> the information necessary to identify the failing FRU". As EDAC has three
> 'levels', these are what they should correspond to for ghes-edac.
>
> I assume NODE means rack/chassis in some distributed system. Lets ignore it as
> it doesn't seem to map to anything in the SMBIOS table.

I believe NODE should map to socket number for multi-socket systems.

> The CPER record's card and module numbers are useless to us, as we need to know
> how many there will be in advance. (does this version of firmware count from 0
> or 1?)
>
> ... but CPER also gives us a 'Card Handle' and 'Module Handle'.
> 'Module Handle' maps to SMBIOS:17 Memory Device (aka, a DIMM). The Handle is a
> word-value in the structure, so it doesn't depend on the layout/parse-order of
> the SMBIOS tables. When we count the DIMMs in edac-ghes we can give them some
> level-idx, then use the handle to find which level-idx to use for this DIMM.
>
> ghes_edac_report_mem_error() already picks up the module-handle, but only uses
> it to print the bank/device.
>
> 'Card' doesn't mean much to me, but it maps to SMBIOS:17 "Memory Array
> Structure", which the Memory Device structure also points to.
> Card then must mean "a collection of memory devices (DIMMs) that operate
> together to form an address space".
>
> This might be what I think of as a memory-controller, or it might be something
> more complicated. Regardless, the CPER records think its relevant.
>
> For the edac:layers, we could walk the DMI table to find these structures, and
> build the layers from them. If the Memory-array-structures are missing, we can
> use the existing 1:NUM_DIMMS approach.
>

I think the proper way to get this working would be to use these handles. We can
avoid populating this layer information and instead have a mapping of type 17
index number (how edac is numbering the DIMMs today) to the handle number.
Then we will need a new function to increment the counter based on the handle
number rather than this layer information. Is that how you are envisioning it?

Thanks,
Tyler
