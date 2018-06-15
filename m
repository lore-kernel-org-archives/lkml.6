Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1A1C4C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 06:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2DB22086A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 06:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2DB22086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755830AbeFOGjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 02:39:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:59531 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755665AbeFOGjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 02:39:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9D7F8ADB4;
        Fri, 15 Jun 2018 06:39:04 +0000 (UTC)
Date:   Fri, 15 Jun 2018 08:39:03 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Juergen Gross <jgross@suse.com>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>,
        Mike Latimer <mlatimer@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/pti: don't report XenPV as vulnerable
In-Reply-To: <821642fe-775b-e68c-2a66-73b73c810289@suse.com>
Message-ID: <nycvar.YFH.7.76.1806150837100.6203@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1806150025220.6203@cbobk.fhfr.pm> <a5bfcabb-827b-fbf7-9395-de9332697c25@suse.com> <nycvar.YFH.7.76.1806150801530.6203@cbobk.fhfr.pm> <ff9f4a24-6e69-cc7b-ba75-e82c9182a805@suse.com> <nycvar.YFH.7.76.1806150815440.6203@cbobk.fhfr.pm>
 <821642fe-775b-e68c-2a66-73b73c810289@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jun 2018, Juergen Gross wrote:

> Why? PTI has to be disabled in PV guests as it can't work there due to 
> missing paravirtualization of the PTI feature (mov to/from %cr3).
> 
> The Xen meltdown mitigation ("XPTI") for 64-bit pv guests is primarily 
> securing the hypervisor against meltdown attacks of the guest. The guest 
> itself can't do anything in this regard in 64-bit mode, as user and 
> kernel code are already using different %cr3 values even without PTI.

That I know. Then I am probably dense today, but could you please again 
explain what you meant by this in your first reply:

	"This is wrong for [ ... ] for 64-bit, too, in case the mitigation is 
	 disabled at hypervisor level."

-- 
Jiri Kosina
SUSE Labs

