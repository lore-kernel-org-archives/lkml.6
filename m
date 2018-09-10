Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE51C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3905920880
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="0JUgui5n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3905920880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbeIKABg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 20:01:36 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:37755 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbeIKABg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 20:01:36 -0400
Received: by mail-oi0-f65.google.com with SMTP id p84-v6so42336508oic.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 12:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jKyub4B9Q64SfHqCBkA854eodPXkyEKwX8P1lU6zRK8=;
        b=0JUgui5n5+DXIq43nr06xiK0susLpUI1r+hmKaMiJ9TzeH8XSKpDk4rZ17mXCzfMp1
         h5ELLOJ/fw1bCdrIFvk1fMItJnGi1v402XGXusPF/qZg+PcVVG3VlOeq2GRvA+Ttq82O
         U/Z1/YFc+wIxEdm9F/i4PnZBjxU88jnb30VRI2mLkXakgXqvqnjQnff0rPPTjm4AUzn0
         AEbsnc1T4QC86ltriWuN24UrhJ6VDPreNtNVNQaAFqb6Y7bMIx9w38HQTHEd6zWc0e8Y
         vDhTImEaqBEZ0oCq9XtXAGgfE8kUocJyIpRIN4X3Ws7o2sMSl9O81GL81E9g3wSdjBfy
         8jtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jKyub4B9Q64SfHqCBkA854eodPXkyEKwX8P1lU6zRK8=;
        b=rdXQRihRNEPjkalY2LasO5J6i7G9kRkeBeRAysDkAmQ/Dj8FR+gyy9occhnLzTpZXy
         qCyjgFXDSqjC27N2+wIF3c5djG9BzgsRxZYEO6aNZ1xG7Xvww8LDSjrYLIInjfJZTT5A
         oRB+e2iV9GMDlPD8zbrlq20mIkMl1WrMoVrttyxD/gb9ZYSmsmniiqUNoLhxeJMBbIjM
         dZLQIw+CihfyoRlr9q7eVi65cTbYcQ6HkyuNRWIJdQC2z4vDWDjQHwZEm/5aHTljYypI
         T5tlMly0yV7V2KCdj8vZGuY35dQGIlp0EI+VA8UFjkp7mtIltyVHEAyLtxvSXIp7DIGg
         qQNg==
X-Gm-Message-State: APzg51CiUbBhqOsy8pxEZo66L3c2aD7LWSlHsMFf4snvDjFYiwWYDww2
        7sP4E1bxmsOfz0KTgptE3keHG+K3Ia3Ey5v9bNMeKA==
X-Google-Smtp-Source: ANB0VdZ5crlKKc41md/JcT/NrOlOKc9CA9QEtRoZTd9V2MWaBOVfh9jKcp8PzKzoW6Uev2bNNtWmWvPeyl41p4Prd6E=
X-Received: by 2002:aca:4914:: with SMTP id w20-v6mr25153979oia.5.1536606365531;
 Mon, 10 Sep 2018 12:06:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:8e85:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 12:06:04
 -0700 (PDT)
In-Reply-To: <20180724072937.GD28386@dhcp22.suse.cz>
References: <153176041838.12695.3365448145295112857.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAGM2rea9AwQGaf1JiV_SDDKTKyP_n+dG9Z20gtTZEkuZPFnXFQ@mail.gmail.com>
 <CAPcyv4jo91jKjwn-M7cOhG=6vJ3c-QCyp0W+T+CtmiKGyZP1ng@mail.gmail.com>
 <CAGM2reacO1HF91yH8OR5w5AdZwPgwfSFfjDNBsHbP66v1rEg=g@mail.gmail.com>
 <20180717155006.GL7193@dhcp22.suse.cz> <CAA9_cmez_vrjBYvcpXT_5ziQ2CqRFzPbEWMO2kdmjW0rWhkaCA@mail.gmail.com>
 <20180718120529.GY7193@dhcp22.suse.cz> <3f43729d-fd4e-a488-e04d-026ef5a28dd9@intel.com>
 <20180723110928.GC31229@dhcp22.suse.cz> <510a1213-e391-bad6-4239-60fa477aaac0@intel.com>
 <20180724072937.GD28386@dhcp22.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 10 Sep 2018 12:06:04 -0700
Message-ID: <CAPcyv4hZUgoMvUTcQLVQWvpvHnJYoPaet4b2VE-qPLtUPDgSaQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] mm: Asynchronous + multithreaded memmap init for ZONE_DEVICE
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Rich Felker <dalias@libc.org>, Jan Kara <jack@suse.cz>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-mm <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Alexander Duyck <alexander.h.duyck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ adding Alex ]

On Tue, Jul 24, 2018 at 12:29 AM, Michal Hocko <mhocko@kernel.org> wrote:
> On Mon 23-07-18 09:15:32, Dave Hansen wrote:
>> On 07/23/2018 04:09 AM, Michal Hocko wrote:
>> > On Thu 19-07-18 11:41:10, Dave Hansen wrote:
>> >> Are you looking for the actual end-user reports?  This was more of a
>> >> case of the customer plugging in some persistent memory DIMMs, noticing
>> >> the boot delta and calling the folks who sold them the DIMMs (Intel).
>> > But this doesn't sound like something to rush a solution for in the
>> > upcoming merge windown, does it?
>>
>> No, we should not rush it.  We'll try to rework it properly.
>
> Thanks a lot Dave! I definitely do not mean to block this at all. I just
> really do not like to have the code even more cluttered than we have
> now.

Hi Michal,

I'm back from vacation. I owe you an apology I was entirely too
prickly on this thread, and the vacation cool-off-time was much
needed.

I come back to see that Alex has found a trove of low hanging fruit to
speed up ZONE_DEVICE init and ditch most of the complication I was
pushing. I'll let him chime in on the direction he wants to take this.
