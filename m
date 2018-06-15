Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 09B2BC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 06:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BADD520864
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 06:04:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BADD520864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755814AbeFOGEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 02:04:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:55388 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755607AbeFOGEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 02:04:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1992CAC31;
        Fri, 15 Jun 2018 06:04:52 +0000 (UTC)
Date:   Fri, 15 Jun 2018 08:04:51 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Juergen Gross <jgross@suse.com>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>,
        Mike Latimer <mlatimer@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/pti: don't report XenPV as vulnerable
In-Reply-To: <a5bfcabb-827b-fbf7-9395-de9332697c25@suse.com>
Message-ID: <nycvar.YFH.7.76.1806150801530.6203@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1806150025220.6203@cbobk.fhfr.pm> <a5bfcabb-827b-fbf7-9395-de9332697c25@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jun 2018, Juergen Gross wrote:

> wrong for 64-bit, too, in case the mitigation is disabled at hypervisor 
> level.

If that is indeed possible (is it?), then the check we have in 
pti_check_boottime_disable() is wrong as well.

> So the test should be done only for CONFIG_X86_64 

Fair enough.

> and the returned string should be e.g. "Mitigation: XEN".

Well, perhaps; it'd confuse all the scripts that are checking whether 
system is fully secured or not by parsing sysfs files ... but that's 
mostly their problem.

Thanks,

-- 
Jiri Kosina
SUSE Labs

