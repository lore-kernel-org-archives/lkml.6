Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EA5ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1E62081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D1E62081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbeKIAjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:39:15 -0500
Received: from mail.skyhub.de ([5.9.137.197]:35206 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbeKIAjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:39:15 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lXBDOdHRiHvi; Thu,  8 Nov 2018 16:03:19 +0100 (CET)
Received: from zn.tnic (p200300EC2BD03D00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bd0:3d00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C1D351EC03C8;
        Thu,  8 Nov 2018 16:03:19 +0100 (CET)
Date:   Thu, 8 Nov 2018 16:03:18 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, suravee.suthikulpanit@amd.com, puwen@hygon.cn,
        davidwang@zhaoxin.com, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn
Subject: Re: [PATCH v2] x86/cpu: fix prototype warning
Message-ID: <20181108150318.GD7543@zn.tnic>
References: <1541639548-11149-1-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1541639548-11149-1-git-send-email-wang.yi59@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 09:12:28AM +0800, Yi Wang wrote:
> This patch fix the following build warnings which because of missing
> include file:
> 
> arch/x86/kernel/cpu/cacheinfo.c:647:6: warning: no previous prototype for ‘cacheinfo_amd_init_llc_id’ [-Wmissing-prototypes]
> arch/x86/kernel/cpu/cacheinfo.c:686:6: warning: no previous prototype for ‘cacheinfo_hygon_init_llc_id’ [-Wmissing-prototypes]
> arch/x86/kernel/cpu/scattered.c:37:6: warning: no previous prototype for ‘init_scattered_cpuid_features’ [-Wmissing-prototypes]
> arch/x86/kernel/cpu/scattered.c:60:5: warning: no previous prototype for ‘get_scattered_cpuid_leaf’ [-Wmissing-prototypes]

That function is gone in:

https://git.kernel.org/tip/43500e6f294d175602606c77bfb0d8cd4ea88b4f

You probably should run your test against tip/master.

Also, you should say in your commit message that this is an extra
warning - -Wmissing-prototypes - which is not enabled by default but a
W=1 one.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
