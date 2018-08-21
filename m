Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E683C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1847820E20
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1847820E20
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbeHURyr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 13:54:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:39852 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727206AbeHURyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 13:54:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 62639AE5B;
        Tue, 21 Aug 2018 14:34:22 +0000 (UTC)
Date:   Tue, 21 Aug 2018 16:34:21 +0200
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Schmauss, Erik" <erik.schmauss@intel.com>,
        Lv <lv.zheng@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        devel@acpica.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>
Subject: Re: Regression: 18996f2db918 ("ACPICA: Events: Stop unconditionally
 clearing ACPI IRQs during suspend/resume" breaks resume from suspend
Message-ID: <20180821163421.3208af59@kitsune.suse.cz>
In-Reply-To: <CAJZ5v0hMZ_bmCy7vQBfzu6RNVkCX0V9qRtqYVNmFOefc1TnGCA@mail.gmail.com>
References: <20180820182906.48f7743f@kitsune.suse.cz>
        <CAJZ5v0hMZ_bmCy7vQBfzu6RNVkCX0V9qRtqYVNmFOefc1TnGCA@mail.gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2018 08:50:36 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Mon, Aug 20, 2018 at 6:29 PM Michal Suchánek <msuchanek@suse.de>
> wrote:
> >
> > Hello,
> >
> > after commit 18996f2db918 ("ACPICA: Events: Stop unconditionally
> > clearing ACPI IRQs during suspend/resume") I am no longer able to
> > resume from suspend.
> >
> > Reported in bugzilla
> > https://bugzilla.kernel.org/show_bug.cgi?id=200841
> >
> > Reverting this on top of 4.18 fixes the issue. acpidump output is
> > attaches in the bugzilla.
> >
> > Is there anything else that can be done to diagnose the issue?  
> 
> Can you please test the patch at
> https://patchwork.kernel.org/patch/10563631/ to start with?
> 

Yes, that works for me.

Thanks

Michal
