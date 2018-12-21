Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA73C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB2F21919
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="J9i6gmK0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390647AbeLUN0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 08:26:51 -0500
Received: from mail.skyhub.de ([5.9.137.197]:58882 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387909AbeLUN0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 08:26:50 -0500
Received: from zn.tnic (p200300EC2BD18000183B79CE2301FC6B.dip0.t-ipconnect.de [IPv6:2003:ec:2bd1:8000:183b:79ce:2301:fc6b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4D97D1EC0B86;
        Fri, 21 Dec 2018 14:26:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1545398809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ps+TzUx/JMd3Tl4K634m82I/UB2VCEzdjcSIo0sdgUU=;
        b=J9i6gmK09OkPrq/lVKVKcB0KpNpSLdLS7BND8L3Ouyduveju27qJLr5Fc1MSfxUpx95v88
        uDtIgpS9tcWbHamED77RdXCeJNUac2xMCnqYY01cjyJ7KPQZF8b1J5pZChL7mWF2v0MIBc
        pMcVgLupiqhfX50w+tkCoT1FUXwtArs=
Date:   Fri, 21 Dec 2018 14:26:42 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jia Zhang <qianyue.zj@alibaba-inc.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] x86/cpu: sort cpuinfo flags
Message-ID: <20181221132642.GE1325@zn.tnic>
References: <20181219195014.A0962820@viggo.jf.intel.com>
 <20181220120240.ermrc3hnixkin2yg@black.fi.intel.com>
 <20181220160411.GC31403@zn.tnic>
 <20181221124037.s57lt567pgzbz7z3@black.fi.intel.com>
 <20181221130403.GD1325@zn.tnic>
 <20181221131925.h6ca375bakwipmo3@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181221131925.h6ca375bakwipmo3@kshutemo-mobl1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 04:19:25PM +0300, Kirill A. Shutemov wrote:
> Dave's patch made me recall few cases were I wanted to check a presence
> of a CPU flag with very limited userspace: shell in initrd with lean
> busybox build (no grep around). Eyeballing the flag took frustratingly
> long.

Easy:

less (or more) /proc/cpuinfo

and search there with the '/' command.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
