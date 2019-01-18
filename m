Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7DFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D712086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547804747;
	bh=Ec0Lnok/av984IK6z35R7ty89ucwuZnfMe4BrL2o6Fc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eR0kTNROgx4XSxD3qEGlHnUR/9Ny+k9Ddb5UAtb2huhwsUlZ1ax2MJ8I04hfzREAx
	 tAJxK8iRwH/p59DPunRAB1J4J0N7zqHxpL+7ftatHZrLeu6RUMTI6W3rhZEkH3P+de
	 5lkh4H3gJ7sXvawzCvmRVmLsOIBYda/gBYAwP2e0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfARJpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:45:45 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34238 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbfARJpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 04:45:44 -0500
Received: by mail-oi1-f195.google.com with SMTP id r62so8547566oie.1;
        Fri, 18 Jan 2019 01:45:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ec0Lnok/av984IK6z35R7ty89ucwuZnfMe4BrL2o6Fc=;
        b=t0jOy85SkJcPv6+bD685ZEfzqVHYrol74rv4jGyPlLsbZXZ4MFqlWoe82d8pCMYob/
         xA6qzynGGVFrNO1ryyVimguRL4NveZQuaYSuBzv/rHQmJFCGFm2OufQMZLl6U5muHkmG
         7w3H2lORqxOKKUlkoQCDsZcUrfvjRwYwqOoC1SToF6ieNbjNecYaiV6zRaWHBVZtsyqd
         RfpT7qKO7DjMJ1rRw6cYZecRs7TjHE4vLyR/UdlJl3lArJB8TgbDfBNc0ZBurtf5hpoj
         fA/oxcwjKYBIA3NGYjj38AD+5Zx/jr2Y+y29heOYqKKWcg/VixmqFsYR/yEXwpWvgz2Q
         s3Gw==
X-Gm-Message-State: AJcUukcKDCaTUrz0l6/RyW5zOW7WN3R/3kGxsIoHk1j1dqr2b23EaoMI
        Oa1f2KlJvUj/8L7K18HvezZ+tWDUIkUwJ1OCfP4=
X-Google-Smtp-Source: ALg8bN7fkdgmnIfWwXp/2epoAU8h56JWGgjGiE62XOprJmjY9zsAJffaqa//79KXp8GIgQ9mTIMApUAKUJ+te/aqqgc=
X-Received: by 2002:aca:6c8b:: with SMTP id h133mr278142oic.33.1547804743481;
 Fri, 18 Jan 2019 01:45:43 -0800 (PST)
MIME-Version: 1.0
References: <20190115095834.22617-1-kasong@redhat.com> <20190115095834.22617-3-kasong@redhat.com>
 <20190115231005.GF6596@zn.tnic> <CACPcB9dYD2zR7ssXFibkefo3EZuvVnLegovwTMA8MaaLP1UsYQ@mail.gmail.com>
 <20190116094619.GB15409@zn.tnic> <CACPcB9d0dKLPmZ=b++m5LYRjFUCFyLL3deDBcS4m3N-UWZ_Hyw@mail.gmail.com>
 <20190117085316.GA17940@dhcp-128-65.nay.redhat.com> <CAJZ5v0hb6Lz0knzNFTZKNb863bvDx2a1EFjTjOG2NdvyyyhniQ@mail.gmail.com>
 <CACPcB9eomuBPmxCEWEutt1gxO3=nrFFuYtKeANd0+h8DsN7M3A@mail.gmail.com>
In-Reply-To: <CACPcB9eomuBPmxCEWEutt1gxO3=nrFFuYtKeANd0+h8DsN7M3A@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Jan 2019 10:45:31 +0100
Message-ID: <CAJZ5v0jzTz9MK1krWgfHXNhqNCY_ftotbCpupJHOtPMysbNPwQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86, kexec_file_load: make it work with
 efi=noruntime or efi=old_map
To:     Kairui Song <kasong@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Dave Young <dyoung@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Robert Moore <robert.moore@intel.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 5:47 AM Kairui Song <kasong@redhat.com> wrote:
>
> On Thu, Jan 17, 2019 at 5:40 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Jan 17, 2019 at 9:53 AM Dave Young <dyoung@redhat.com> wrote:
> > >
> > > Add linux-acpi list
> >
> > Well, thanks, but please resend the patches with a CC to linux-acpi.
> >
>
> Hi, sure will do.
> Any thought on adding an acpi_os_get_root_pointer_late and store rsdp
> pointer as mentioned?

It is a good idea in general IMO, but all depends on how the code
changes will look like.

> Will updat the patch and post V2, and cc linux-acpi as well later.

Thanks!
