Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126A3C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E42206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdQQ56V2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E42206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbeIEBkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 21:40:35 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:53191 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbeIEBkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 21:40:35 -0400
Received: by mail-it0-f65.google.com with SMTP id h3-v6so7050202ita.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 14:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+8gbxUQw4SEPFFxDJfJSY3qSRPnMUocrd4TD9y9CMXg=;
        b=ZdQQ56V2+k57LAXaIip/tDRtYPpxlyy7HJu3MvfVRW7PSzqYDtVVjO1cld480xvmY0
         73tRwRZQ27P9MNDf9Wa+XwGj7a553AJD/5fhwXVikOlaRJQUfgadY2LoNuAnGfzBOw3q
         9P42hPBKjgVTUmog+y15ncw5cx7/DnrQ2WrAWQJ0Ti+iLPagUTk+ttlENh4cU28xLIox
         OetgIRpISCoBqzcvVbyVjBQzSLfZuIAJTwd1Q0j5CZqVZ7qBQf00Q8WmHSa6435ld9MY
         ipkM7ZtCbl84hVA0vmJ3OHc2q+NM+iQOHOyD9mgbIipfvz2ioY0e9WfaRcr7jTlwIiSw
         k0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+8gbxUQw4SEPFFxDJfJSY3qSRPnMUocrd4TD9y9CMXg=;
        b=rwDCrJjW8kYwVP5iRfGWQk30Ty1MlJWC2/DtZRUBVHa/3qDyBLpsfuzsCV3Jx8mlmz
         abaoG5i5U1CFxp0uZ2obIFuXLlWDG9PaUeaJm1GNsXTb9LyqHcF5yPiDq5qpJO2eahDe
         enOFgNUfx8LNcbEHkS5Lt//cDpOmppewvpt5MTG1ifCAPlf5hWxoHK0Q5HAwsX54p4xm
         HbUtMQ5ALJq8zrvj2VMOGw9Aoomz9Xipg/ZEkcWhJg1YlGSlN1C/oiP4lXPprpOWDEa7
         FU/Gj4vIi/FXCrCWm5hkdg/jYPv4tSJXAcC1Y9t2b8o6BlKoaRXpj2eExkxNMGyhMH5I
         a1YA==
X-Gm-Message-State: APzg51DvulBsqutey96o/QHlM1dnwxR4Ms503efa4h05h3IodQHn8z6s
        qVmhM5Noq2ZHeF8V/SnIzOEjgIbv5ziCAF79Aho=
X-Google-Smtp-Source: ANB0VdYJ6Zsc3PC3x7CRPEqTlhmc+3g60XcBjwOfXuAlwI29W1gnbqN0UN1JzSWadV60PCjV2VYJSbjdx4DFB3UthI0=
X-Received: by 2002:a24:918d:: with SMTP id i135-v6mr1696861ite.98.1536095621074;
 Tue, 04 Sep 2018 14:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180904181550.4416.50701.stgit@localhost.localdomain>
 <20180904183339.4416.44582.stgit@localhost.localdomain> <47657613-688d-e701-4a30-39fbd92734ba@microsoft.com>
In-Reply-To: <47657613-688d-e701-4a30-39fbd92734ba@microsoft.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Tue, 4 Sep 2018 14:13:29 -0700
Message-ID: <CAKgT0Uf4xNkPLcDvcYMwVqxoENrBZhkLkh37nC8Qbn2varsX9w@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: Move page struct poisoning from CONFIG_DEBUG_VM
 to CONFIG_DEBUG_VM_PGFLAGS
To:     Pavel.Tatashin@microsoft.com
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 1:07 PM Pasha Tatashin
<Pavel.Tatashin@microsoft.com> wrote:
>
> Hi Alexander,
>
> This is a wrong way to do it. memblock_virt_alloc_try_nid_raw() does not
> initialize allocated memory, and by setting memory to all ones in debug
> build we ensure that no callers rely on this function to return zeroed
> memory just by accident.

I get that, but setting this to all 1's is still just debugging code
and that is adding significant overhead.

> And, the accidents are frequent because most of the BIOSes and
> hypervisors zero memory for us. The exception is kexec reboot.
>
> So, the fact that page flags checks this pattern, does not mean that
> this is the only user. Memory that is returned by
> memblock_virt_alloc_try_nid_raw() is used for page table as well, and
> can be used in other places as well that don't want memblock to zero the
> memory for them for performance reasons.

The logic behind this statement is confusing. You are saying they
don't want memblock to zero the memory for performance reasons, yet
you are setting it to all 1's for debugging reasons? I get that it is
wrapped, but in my mind just using CONFIG_DEBUG_VM is too broad of a
brush. Especially with distros like Fedora enabling it by default.

> I am surprised that CONFIG_DEBUG_VM is used in production kernel, but if
> so perhaps a new CONFIG should be added: CONFIG_DEBUG_MEMBLOCK
>
> Thank you,
> Pavel

I don't know about production. I am running a Fedora kernel on my
development system and it has it enabled. It looks like it has been
that way for a while based on a FC20 Bugzilla
(https://bugzilla.redhat.com/show_bug.cgi?id=1074710). A quick look at
one of my CentOS systems shows that it doesn't have it set. I suspect
it will vary from distro to distro. I just know it spooked me when I
was stuck staring at a blank screen for three minutes when I was
booting a system with 12TB of memory since this delay can hit you
early in the boot.

I had considered adding a completely new CONFIG. The only thing is it
doesn't make much sense to have the logic setting the value to all 1's
without any logic to test for it. That is why I thought it made more
sense to just fold it into CONFIG_DEBUG_VM_PGFLAGS. I suppose I could
look at something like CONFIG_DEBUG_PAGE_INIT if we want to go that
route. I figure using something like MEMBLOCK probably wouldn't make
sense since this also impacts sparse section init.

Thanks.

- Alex
