Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A96C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1012620869
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1012620869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbeIGPbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 11:31:38 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41810 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728183AbeIGPbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 11:31:38 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WSUcfCNVJAex; Fri,  7 Sep 2018 12:51:14 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCC4300329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcc:4300:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4CC231EC0200;
        Fri,  7 Sep 2018 12:51:14 +0200 (CEST)
Date:   Fri, 7 Sep 2018 12:51:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Juergen Gross <jgross@suse.com>, x86@kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] x86/paravirt: Get rid of patch_site label
Message-ID: <20180907105112.GD12849@zn.tnic>
References: <20180907104917.12502-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180907104917.12502-1-bp@alien8.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 12:49:17PM +0200, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> When CONFIG_PARAVIRT_SPINLOCKS=n, it fires
> 
>   arch/x86/kernel/paravirt_patch_64.c: In function ‘native_patch’:
>   arch/x86/kernel/paravirt_patch_64.c:89:1: warning: label ‘patch_site’ defined but not used [-Wunused-label]
>    patch_site:
> 
> but that label can simply be removed by directly calling
> paravirt_patch_insns() there.

Whoops, no, it is still being used. Lemme see if I can remove all the
labels in that function.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
