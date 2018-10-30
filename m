Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBE6C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6CA20823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o2iyJZ6E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD6CA20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbeJ3Q6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 12:58:05 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33618 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbeJ3Q6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 12:58:05 -0400
Received: by mail-pg1-f193.google.com with SMTP id q5-v6so1542337pgv.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 01:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3hAtsfc7OQxU+0gPWdO5gJRoTMpwnx03O00HTPOgQ98=;
        b=o2iyJZ6ENsVdWU5fYTvdgzoqJGrqffvkJj5LRjWjjyo5ZMNXvvX+lAGmNlEW7oOeBa
         iweSLp/o5IH1YPhw9w17vqZyU+bmljZePBkMb0Zyy2bfhcIHB8SC1SRLtD2wczR9jVDj
         41alpjYy0PpqMTeMJpKicNonIDiiZis156RGFOzuQnl9MPpCMEhpGinKhgZpZld9Ixkp
         ETGYo/4aije3rFpKbuj6zOp3pPjD7zrTxIUvSgvGS/lNmsVB3pVB/MACLuTXh7NBa+fb
         x2CEQXzy1yJym4ixlJDBNJCpoEQMyYqzF6E94VCT34XRpJAdBgtOAh/Ah/LbYyVtdjfx
         uwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3hAtsfc7OQxU+0gPWdO5gJRoTMpwnx03O00HTPOgQ98=;
        b=dkrUM5aafYzZM/3SYY1E3pieTsPFmetPf/wRimphLNR+84aaqyYpw2uZK1zMTHj8S0
         /tXZS4PcY80w+wNvDtHY/ynX1gJO9ie69BFVo2HycmHuskY2o8XTeI7aaZ8YNsI/oK6L
         2c18xfbVb5I3YkJFbIraIb9TCVBg1r1FVfbZ2Ajv6xqdFrYmVlPjHiPY3z16k+/5VwvM
         ebtTx6H9ppuT2kRC24b9Qx2LMIcy201yNdvb9g+sWuHRwgI1FE9+h8xZ+Qc9KjA3wJtF
         /7xXbdZFIaPNdKFO4h7rxjTK43wcqJJ5o2FXoqsZIjmGCpJgd6okphDtBh7AoEiqRGjg
         2Y1A==
X-Gm-Message-State: AGRZ1gIGsO8k6Xwr8XGnz0oUHWBe/w/FEWnHW+FgyDzcoE3MKqsSBdho
        iUOV6xYwllD/+OR9XiM9CNQHh47qQbE6oSaSGWw=
X-Google-Smtp-Source: AJdET5e9YsQ87kwjMn7GkN3ygM2TtPo8lgD0tZNKSisTAWvNWvjiRtL40LplT01q7WIWmzS1co/S7D5dkupKSjJq/Jg=
X-Received: by 2002:a62:1d92:: with SMTP id d140-v6mr1846665pfd.157.1540886740179;
 Tue, 30 Oct 2018 01:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <20181011085509.GS5873@dhcp22.suse.cz> <6f32f23c-c21c-9d42-7dda-a1d18613cd3c@linux.intel.com>
 <20181017075257.GF18839@dhcp22.suse.cz> <971729e6-bcfe-a386-361b-d662951e69a7@linux.intel.com>
 <20181029141210.GJ32673@dhcp22.suse.cz> <84f09883c16608ddd2ba88103f43ec6a1c649e97.camel@linux.intel.com>
 <20181029163528.GL32673@dhcp22.suse.cz> <18dfc5a0db11650ff31433311da32c95e19944d9.camel@linux.intel.com>
 <20181029172415.GM32673@dhcp22.suse.cz> <8e7a4311a240b241822945c0bb4095c9ffe5a14d.camel@linux.intel.com>
 <20181029181827.GO32673@dhcp22.suse.cz> <3281f3044fa231bbc1b02d5c5efca3502a0d05a8.camel@linux.intel.com>
In-Reply-To: <3281f3044fa231bbc1b02d5c5efca3502a0d05a8.camel@linux.intel.com>
From:   Oscar Salvador <osalvador.vilardaga@gmail.com>
Date:   Tue, 30 Oct 2018 09:05:27 +0100
Message-ID: <CAOXBz7h-yiFCPoK5tNm6qSAGm8n83fSwHYU42x5DjtSbL84zQg@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] mm: Defer ZONE_DEVICE page initialization to the
 point where we init pgmap
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-nvdimm@lists.01.org,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        dave.hansen@intel.com, Jerome Glisse <jglisse@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, mingo@kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        yi.z.zhang@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, the hotplug lock was part of the original issue. However that
> starts to drift into the area I believe Oscar was working on as a part
> of his patch set in encapsulating the move_pfn_range_to_zone and other
> calls that were contained in the hotplug lock into their own functions.


While reworking it for my patchset, I thought that we can move
move_pfn_range_to_zone
out of hotplug lock.
But then I __think__ we would have to move init_currently_empty_zone() within
the span lock as zone->zone_start_pfn is being touched there.
At least that is what the zone locking rules say about it.

Since I saw that Dan was still reworking his patchset about unify HMM/devm code,
I just took one step back and I went simpler [1].
The main reason for backing off was I felt a bit demotivated due to
the lack of feedback,
and I did not want to interfer either with your work or Dan's work.
Plus I also was unsure about some other things like whether it is ok calling
kasan_add_zero_shadow/kasan_remove_zero_shadow out of the lock.
So I decided to make less changes in regard of HMM/devm.

Unfortunately, I did not get a lot of feedback there yet.
Just some reviews from David and a confirmation that fixes one of the
issues Jonathan reported [2].

>
> I was hoping to wait until after Dan's HMM patches and Oscar's changes
> had been sorted before I get into any further refactor of this specific
> code.


I plan to ping the series, but I wanted to give more time to people
since we are in the merge window now.

[1] https://patchwork.kernel.org/cover/10642049/
[2] https://patchwork.kernel.org/patch/10642057/#22275173
