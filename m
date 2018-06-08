Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id zaSHEMheGlvPeQAAmS7hNA
	; Fri, 08 Jun 2018 10:47:36 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2846A607E4; Fri,  8 Jun 2018 10:47:36 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdRM90a/"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7F123606FA;
	Fri,  8 Jun 2018 10:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7F123606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751483AbeFHKrd (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 06:47:33 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40095 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751056AbeFHKrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 06:47:31 -0400
Received: by mail-lf0-f65.google.com with SMTP id q11-v6so19364358lfc.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 03:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PFD0VpUfrp1iROTJgJhiS4hDGulXIL/e5KCjLwGx/t4=;
        b=MdRM90a/q1EFy8/G+sU7niM9W9MQJm3NgGehbwEZw4SDEwEnt53A7mZ1X84+NZ1Rhd
         EVmMG3JrvKN9yhB2jmQJDbIKKJSc7PcoLTGeLHw1OdfFynsJW0lxIGdnq0jvgHYshQq3
         Fp7G6EST/XSJ+xVWyyKpu8aarNwDtXPN5BpdmJxiFG8G5kDkSIPmO3eH0LfXWHYKaxMp
         2CHSJKrm+VA0QJpw7ZW+9utra3ctC8cOVTDE6c/AJ6J8MNezSsVeChQBfT1tgMewfKaA
         hdMZq65XIj601oSxXzbAO7/xj70YOaiUCGSOhW8JOg1XuE5rYC2uwN2Yw/6JL0oq0Kzl
         QzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PFD0VpUfrp1iROTJgJhiS4hDGulXIL/e5KCjLwGx/t4=;
        b=AIG1ce77IB8pTc4XcV77e00tiei4PTaHy6Haksu4LPgSbLROwzXNnvEJC6qqNrm48u
         G95fvISWY9ieKrQLS6q0gECCY9xN1gCLMzcnnwwHHLJ0bknOxS3zSNRE4jLQD3a1USQr
         fQGznt1jsHajW/Z2ro2y8YTJfqZrclD8ECM2+JJU7B79pbdCF+WadaSp4xiIx1Vs/ARA
         tgsRXXmOYLapUOfVjroiPxmNu9zIFWlAErxF/4NwrqbPTW6IuRopI9qqUNg3WUboUJsa
         MwzCX77Gq/T++PfrM+aA6C1WwUIcYg1TEBzr9U49PgmFuhil0b4KJ9BUFCTLOVTsl0Oz
         hyLA==
X-Gm-Message-State: APt69E3CUn9quxWEaJmzXopMC38IjWFptcQIl4N/uhBUyDPv54H5Gchm
        0O1b27zd5z5qZOpTREQrF0RJwy9LjItSi2VMKiI=
X-Google-Smtp-Source: ADUXVKLNmi/TI7lPE/Vi4fZMGohpylzCLXfwjTbOLYOBXdJBIvAMyu+mIa+56UopEkjIwuEaUeuIrqjoI57M65MSArM=
X-Received: by 2002:a19:b203:: with SMTP id b3-v6mr3481176lff.84.1528454850371;
 Fri, 08 Jun 2018 03:47:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:d885:0:0:0:0:0 with HTTP; Fri, 8 Jun 2018 03:47:29 -0700 (PDT)
In-Reply-To: <cf6ee7ab-5818-3309-5a0d-ba047d3f900c@ti.com>
References: <20180522181357.GA31257@jordon-HP-15-Notebook-PC> <cf6ee7ab-5818-3309-5a0d-ba047d3f900c@ti.com>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Fri, 8 Jun 2018 16:17:29 +0530
Message-ID: <CAFqt6zYLPc=GzJBTTHH5MuUzer8aa7nwS6y8aPFn05hNXgoiEw@mail.gmail.com>
Subject: Re: [PATCH v2] gpu: drm: omapdrm: Adding new typedef vm_fault_t
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 8, 2018 at 11:47 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> Hi,
>
> On 22/05/18 21:13, Souptick Joarder wrote:
>> Use new return type vm_fault_t for fault handler. For
>> now, this is just documenting that the function returns
>> a VM_FAULT value rather than an errno. Once all instances
>> are converted, vm_fault_t will become a distinct type.
>>
>> Ref-> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
>>
>> Previously vm_insert_mixed() returns err which driver
>> mapped into VM_FAULT_* type. Also return value of
>> vm_insert_mixed() not handled correctly and 0 was
>> returned inside fault_2d() as default. The new function
>> vmf_insert_mixed() will replace this inefficiency by
>> returning correct VM_FAULT_* type.
>>
>> vmf_error() is the newly introduce inline function
>> in 4.17-rc6.
>>
>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
>> ---
>> v2: Fixed kbuild error by initialized ret
>>     in fault_2d().
>>
>>  drivers/gpu/drm/omapdrm/omap_gem.c | 51 +++++++++++++++++---------------------
>>  drivers/gpu/drm/omapdrm/omap_gem.h |  3 ++-
>>  2 files changed, 25 insertions(+), 29 deletions(-)
>
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>
> It's too late to get this to 4.18 via my normal routes. If you have
> other similar patches queued and Linus/maintainers are ok to merge this
> late, feel free to queue this that way.
>
> Otherwise I can pick this up for my 4.19 patches.
>

4.19 looks ok. In case, we have pushed this patch into 4.18-rc-x along
with few others, will notify you.
