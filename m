Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE9BC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCDC324E6B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qj75lU0W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCDC324E6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752973AbeGBQsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 12:48:19 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:46316 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752943AbeGBQsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 12:48:17 -0400
Received: by mail-lf0-f68.google.com with SMTP id l16-v6so10260559lfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 09:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vY1VF2/omWYOrP1q8q+V/v075zM6TE+5lGipHInBLlg=;
        b=Qj75lU0WMYXOlIs6b8qwhGVc+d2l7MQ2Tia9YxJz2U8b4sZRgUKALf/RnDm6+kCwFY
         ckNoz4WG9HMQGqf4IKPZCybC0x4Dvv2Fk+ofi0dEDv9J/KGB4mPJzBcKsnW6xqEP70ZS
         eXuj3z4mCV4Jmmmrklz/8hJwpE4BmBaNxb4FnZbyfgkylOn/NlTedFsNzc/klfwcYyS/
         xoUh4zMzKDhkX7SAErkUPCSQ1Qxin6Hf0Hjrt5/u4o9S0Zdf1jDiKYjp8mRaVTy3PK78
         rhH3zXw0wb8Aer0PQvRlbDA8V9OvFY2j0K9M9AdjPfvSxD2NO0W7ygBuHM3wwaX4VnD4
         QLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vY1VF2/omWYOrP1q8q+V/v075zM6TE+5lGipHInBLlg=;
        b=tKEmFq4q0EehhsU4G8i6p85WzEa1mlPjXXbApZyVraMb41diLQ1VRiUb8MdfrlOOoY
         3BSdMXlM5HabmzLnbUlRICQYDcRe+WeFWha0Iwt+tapMmldMqARuk2afvvjzKzafthE0
         cDM2z5vZkAFHQ8arqvLvKrUSn7od3SZGz20tuUoz6DhbyHz2TAANgp7ceEwhImipRsFP
         wkQFI86OcOg67Y1PjH3lcwO2pNPESF5bgLZzQupwX77QrVaDaH+KEulEkXpWXG+3koYo
         ip+UOOTPjnvOzUcyJKlQDSRWuEqtjqrOY5+p61sTZgL8Vc93YPilo4HV4fo4LdHLoqiZ
         1bZg==
X-Gm-Message-State: APt69E1nnEpi7LS6UnwcCiesouXh827xq2QbQAwn9emCFo0lhAIAj6DN
        xuzN4gRTbznoNqoVmwtyKXU1MDHRwsMcgffofZE=
X-Google-Smtp-Source: AAOMgpfH/FqJA8AEky3GHz4wh5FkKx1KDtWpXuTr6HpjpDaPA5v4jTshwQY0A3/aP+qWCgGJLBR8cZCsMYEZHaCeXwg=
X-Received: by 2002:a19:c742:: with SMTP id x63-v6mr16500925lff.9.1530550095679;
 Mon, 02 Jul 2018 09:48:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b14:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 09:48:14 -0700 (PDT)
In-Reply-To: <20180702161229.GC11874@kroah.com>
References: <20180521181704.GA19646@jordon-HP-15-Notebook-PC>
 <CAFqt6zZdb5+32CvvU_4Pmb1u-d15-iAFb3ab0ftBLP95257Z-Q@mail.gmail.com>
 <CAFqt6zYX-BsGsTHzEzWHWTLGA=7VtSMWYy7w8dBx+hTzxyhyfw@mail.gmail.com>
 <CAFqt6zYKOaieNEQE3TrXLoh9uXwcWH496EyuT_Tuyf8nZ1zd=w@mail.gmail.com> <20180702161229.GC11874@kroah.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 2 Jul 2018 22:18:14 +0530
Message-ID: <CAFqt6zYqjrdB4V0WoeEDNd=U8_=-WX3RbbtSsOQEt_uakhFUxQ@mail.gmail.com>
Subject: Re: [PATCH v2] char: agp: Change return type to vm_fault_t
To:     airlied@linux.ie
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 9:42 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Mon, Jul 02, 2018 at 09:33:19PM +0530, Souptick Joarder wrote:
>> On Mon, Jun 18, 2018 at 5:07 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>> > On Thu, May 31, 2018 at 10:38 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>> >> On Mon, May 21, 2018 at 11:47 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>> >>> Use new return type vm_fault_t for fault handler. For now,
>> >>> this is just documenting that the function returns a
>> >>> VM_FAULT value rather than an errno. Once all instances are
>> >>> converted, vm_fault_t will become a distinct type.
>> >>>
>> >>> Ref-> commit 1c8f422059ae ("mm: change return type to
>> >>> vm_fault_t") was added in 4.17-rc1 to introduce the new
>> >>> typedef vm_fault_t. Currently we are making change to all
>> >>> drivers to return vm_fault_t for page fault handlers. As
>> >>> part of that char/agp driver is also getting changed to
>> >>> return vm_fault_t type from fault handler.
>> >>>
>> >>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> >>> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
>> >>> ---
>> >>>  drivers/char/agp/alpha-agp.c | 2 +-
>> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >>>
>> >>> diff --git a/drivers/char/agp/alpha-agp.c b/drivers/char/agp/alpha-agp.c
>> >>> index 53fe633..c9bf2c2 100644
>> >>> --- a/drivers/char/agp/alpha-agp.c
>> >>> +++ b/drivers/char/agp/alpha-agp.c
>> >>> @@ -11,7 +11,7 @@
>> >>>
>> >>>  #include "agp.h"
>> >>>
>> >>> -static int alpha_core_agp_vm_fault(struct vm_fault *vmf)
>> >>> +static vm_fault_t alpha_core_agp_vm_fault(struct vm_fault *vmf)
>> >>>  {
>> >>>         alpha_agp_info *agp = agp_bridge->dev_private_data;
>> >>>         dma_addr_t dma_addr;
>> >>> --
>> >>> 1.9.1
>> >>>
>> >>
>> >> Any comment for this patch ?
>> >
>> > Any further comment on this patch ?
>>
>> Greg, Can we get this patch in queue for 4.19 ?
>
> I am not the agp maintainer, am I?  That would be David...

Sorry about it.


David, can we get this patch in queue for 4.19 ?
