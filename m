Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96175C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C69C20883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547811926;
	bh=jVcWQBi9YSzjt7qYvO+JdecqQDz4uLGpMUW7PkX0mOM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=P7xE51jcnhaDq043Vvqf/r16a8/VklLD81cZmuj5Ls9C3l8tP/VfCJqihkGGaCIOQ
	 SppxPr6tsiOLwVj+AXOQp5kUEVYF2nKkTPgL6cOgMl4nGl7p5/edgzEFRvIEzmNgsP
	 d1pNsWFbQGG3Mej1Q119IRYUVCjQuUIXEVCnKsG0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfARLpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 06:45:24 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37457 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbfARLpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 06:45:24 -0500
Received: by mail-ot1-f68.google.com with SMTP id s13so14122199otq.4;
        Fri, 18 Jan 2019 03:45:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jVcWQBi9YSzjt7qYvO+JdecqQDz4uLGpMUW7PkX0mOM=;
        b=lySoSEgdXrMWo47a0wNZYVCUyqEna4+sPbmnaZN8xgh1bKodOaDD4fXtSDYhkdCwJh
         Ic/t/ggWSa5ss4i18MJQtxNVte9+OwG4DNuthbHldpUOpqcUINtfo0IxWVJyyId5ak7F
         nlFlW+Cx2iVew/c9//bNfdlSdnguoWWViwOz0w1nzBfVA4xYTXyGsVzQA6VFDJJZ5yOS
         yHvCfia6WP8/b8X8XuiZQfqgTYLby7D/KcaY1auazKDBqR3zEHBaOG2rT0ojcyo/pxGt
         CUrqUG6qRBd5ChsC1R197ZEPQ34VqX3nAV+LpzbYT67+3Ia1JAs7IEsDIleyg01PRODV
         IZnA==
X-Gm-Message-State: AJcUuken/4Gg8yf9sCg+JMTj0tHaegRpbOWm2VpDUOu5QpQfQ5D4qICI
        1QBnCLFFqMS73KjVf4yGQ5iL9k7W88zjilV+J7rbCDgucso=
X-Google-Smtp-Source: ALg8bN7q2jmNIcoyyD5ZLQmz1zYpQMsvYtQgk7zm85J2PT4iQb2O7UtR4ziXgW8Kb7EDvoOjpu+wH3fOkKLxy7h5qyw=
X-Received: by 2002:a9d:588c:: with SMTP id x12mr11805369otg.139.1547811923427;
 Fri, 18 Jan 2019 03:45:23 -0800 (PST)
MIME-Version: 1.0
References: <20190117161722.3945-1-okaya@kernel.org> <20190117163722.GE5023@zn.tnic>
 <c0fa174a-2e7b-2ef2-4913-167934c68c06@kernel.org> <20190117215631.GF5023@zn.tnic>
 <CAJZ5v0hHFASeJb8z8QwQkh-tCs409pnaywtWcqLP5K5ZDGhTsw@mail.gmail.com> <20190117220959.GG5023@zn.tnic>
In-Reply-To: <20190117220959.GG5023@zn.tnic>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Jan 2019 12:45:12 +0100
Message-ID: <CAJZ5v0iR=0ZoS_=KpTRefZ+fdZOKAAH1PSxfS0cfyS+zx39Hgw@mail.gmail.com>
Subject: Re: [for-next][PATCH] x86/Kconfig: Select PCI_LOCKLESS_CONFIG if PCI
 is enabled
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 11:10 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Jan 17, 2019 at 11:05:43PM +0100, Rafael J. Wysocki wrote:
> > I have patches for intel_ips and intel_pmc_ipc queued up (will be
> > pushed for -rc3), plus some others.
>
> Yeah, I saw the patchset and applied some of them locally so that I be
> able to do randconfig builds. Do you have a branch somewhere which I can
> merge locally for testing?

You can pull the tag I've just pushed to Linus:
https://lore.kernel.org/lkml/CAJZ5v0jiK=zLP4cUsw=y9ea7PLHHgy=xshAsHFhTgyDJH+kOiQ@mail.gmail.com/T/#u
