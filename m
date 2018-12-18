Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D310C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC16217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="hJpxFsnZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbeLRLlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:41:22 -0500
Received: from mail.skyhub.de ([5.9.137.197]:35350 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbeLRLlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:41:21 -0500
Received: from zn.tnic (p200300EC2BD17800B0C9856CE6A48B11.dip0.t-ipconnect.de [IPv6:2003:ec:2bd1:7800:b0c9:856c:e6a4:8b11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AAD471EC0230;
        Tue, 18 Dec 2018 12:41:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1545133279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=l5JRiN5uznoDQAqFX3WDLhur2EpQtG6ZJJkRqN6BZS4=;
        b=hJpxFsnZvkskd/BhWAGFdReWrs+BWo5midiD787gd/EQtDEQftvUpzl12gK6ZiL/JxiHvJ
        sSP+U1B9W7XhlU/eyHww9tpyLPjm3hcTWONZObC+1Q2l4yNZCtjWESqiOgJ0szJG1gqj3D
        n+u0ky1BJJDtTaGDFMWk2UtRuiDdjyI=
Date:   Tue, 18 Dec 2018 12:41:18 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     lijiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        akpm@linux-foundation.org, bhe@redhat.com, dyoung@redhat.com,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2 v3] kdump: add the vmcoreinfo documentation
Message-ID: <20181218114118.GE7485@zn.tnic>
References: <20181216131617.2612-1-lijiang@redhat.com>
 <20181216131617.2612-2-lijiang@redhat.com>
 <20181217130024.GD12165@zn.tnic>
 <826c1a6b-41da-bc1a-f9c2-0d52e774b572@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <826c1a6b-41da-bc1a-f9c2-0d52e774b572@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 03:31:32PM +0800, lijiang wrote:
> The printk_log is used to output human readable text, it will encapsulate header
> information for log_buf, such as timestamp, syslog level, etc.

Me asking those questions is supposed to hint that the explanations need
improvement. But you get the idea...

> >> +PG_lru|PG_private|PG_swapcache|PG_swapbacked|PG_slab|
> >> +PG_hwpoision|PG_head_mask
> >> +=====================================================
> >> +It means the attribute of a page. These flags will be used to filter
> >> +the free pages.
> >> +
> >> +PAGE_BUDDY_MAPCOUNT_VALUE or ~PG_buddy
> >> +======================================
> >> +The 'PG_buddy' flag indicates that the page is free and in the buddy
> >> +system. Makedumpfile can exclude the free pages managed by a buddy.
> > 
> > That text belongs with the one above?
> > 
> It exported the value of (~PG_buddy), so it is placed here independently.

Then make that obvious in the description. The one above talks about the
PG flags and this one should talk about PAGE_BUDDY_MAPCOUNT_VALUE and
what it is used for. The fact that it is computed by negating PG_buddy
is an implementation detail.

> These two variables are somewhat similar, but they are used in
> different scenarios.

Those different scenarious need to be part of the description.

> >> +KERNEL_IMAGE_SIZE
> >> +=================
> >> +The size of 'KERNEL_IMAGE_SIZE', currently unused.
> > 
> > So remove?
> > 
> 
> I'm not sure whether it should be removed, so i keep it.

If it is unused, it should be removed as an VMCOREINFO export and from
the docs. But that can be done later, as a separate patch.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
