Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DEDC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029222077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C/rQC2eX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 029222077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbeIDWYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 18:24:05 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:37275 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeIDWYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 18:24:05 -0400
Received: by mail-io0-f195.google.com with SMTP id v14-v6so3763932iob.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 10:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WfJIpNIBcJFhZzF66AaGNnJaEezM3BGzn5y88uenBc0=;
        b=C/rQC2eXtgD7L0Ec0cvWeAL2/G5hlqR03LdWvbbFoDQOErp84BWvaGhZ4ZTmp5+wX6
         pjRr3H9EnmL/Ddwq0ar3XJ4fB8rQ9b2JRlZREan7KbdmOBFCAKBFlMMaBGwWG3Zzv3wm
         AkDvna3Dh+0XuFMaVa850vjnHYBs0h5MRPMASZMrh2BVkqBa+soaGIyWJEz+rvfgVTNs
         57sFVrZtzH6H5xfzSewhRLobYhXQqubn4bZNDCBfz/i+zVNRc1nxExOGH9iQ9bZli4K8
         nHzViRociHkpITeT5kpPS6VHddlMC44og9ojFJZOTJHdQoqjL3i8rKWtVerjAQRhKY6K
         dNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WfJIpNIBcJFhZzF66AaGNnJaEezM3BGzn5y88uenBc0=;
        b=HrnT/2GleGZ7FnzuavAY92wysWF+lGRlF20LQB/CVnOCRSEX4HVbEDnxmlXdbFir9o
         Vm874F3B7r/XtsN7MAIZkLVZ6JhFuu2vDmSRDuFXYB7Ux06ZB4ZGN0PQjIIQi4AMX8K9
         xrXmg14tABO6uyXKK1RW09p9Zc05rdNW9J/43H/LVtUfV3IsNSUpnfmsbz32udJZ0lFO
         SCNM23ImwaRSHpvQbLTc+eMsiq50HoLBcyR0/fPAhxni9ds4vvuBG51DmwPY9/lukB3g
         ibngaGGn6cOAOuKWTZABR4IU7EleFodt/fb1Etxc/a6Z4Yo3n+5GqfS/3rhWTFBhnp6U
         CZ9Q==
X-Gm-Message-State: APzg51BXRG8xXWjN//HR9iK6GBGyPcKEOL8GjO329pPZpQcT37x11btv
        IuYnG1D8H69aTmYaF7nag6Gogec3kLUOVBDDojQzqw==
X-Google-Smtp-Source: ANB0VdY+oMOijOwSsY9dGHWEkF3sVmjQM5O/a957o21avynIGODBhhUiiH3v2T3k69uEO59m8hGM2jV0iKvmt2rrUUA=
X-Received: by 2002:a6b:ee13:: with SMTP id i19-v6mr23727164ioh.132.1536083873826;
 Tue, 04 Sep 2018 10:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180829021754.21850-1-bhe@redhat.com> <20180829114940.k36272hhxa7fznva@kshutemo-mobl1>
In-Reply-To: <20180829114940.k36272hhxa7fznva@kshutemo-mobl1>
From:   Thomas Garnier <thgarnie@google.com>
Date:   Tue, 4 Sep 2018 10:57:42 -0700
Message-ID: <CAJcbSZGgyirW5E5cvz=oi0BhtcqfjJEw5xThQrm=irnqesFrNQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/mm/KASLR: Fix the wrong calculation of kalsr
 region initial size
To:     kirill@shutemov.name
Cc:     Baoquan He <bhe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Baoquan!

Reviewed-by: Thomas Garnier <thgarnie@google.com>

On Wed, Aug 29, 2018 at 4:49 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Wed, Aug 29, 2018 at 10:17:53AM +0800, Baoquan He wrote:
> > In memory KASLR, __PHYSICAL_MASK_SHIFT is taken to calculate the
> > initial size of the direct mapping region. This is right in the
> > old code where __PHYSICAL_MASK_SHIFT was equal to MAX_PHYSMEM_BITS,
> > 46bit, and only 4-level mode was supported.
> >
> > Later, in commit:
> > b83ce5ee91471d ("x86/mm/64: Make __PHYSICAL_MASK_SHIFT always 52"),
> > __PHYSICAL_MASK_SHIFT was changed to be 52 always, no matter it's
> > 5-level or 4-level. This is wrong for 4-level paging. Then when
> > adapt phyiscal memory region size based on available memory, it
> > will overflow if the amount of system RAM and the padding is bigger
> > than 64TB.
> >
> > In fact, here MAX_PHYSMEM_BITS should be used instead. Fix it by
> > by replacing __PHYSICAL_MASK_SHIFT with MAX_PHYSMEM_BITS.
> >
> > Signed-off-by: Baoquan He <bhe@redhat.com>
>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>
> --
>  Kirill A. Shutemov



-- 
Thomas
