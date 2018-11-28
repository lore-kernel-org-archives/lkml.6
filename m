Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEB3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 20:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B1052086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 20:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="EUgmkMLR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B1052086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbeK2Hc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 02:32:56 -0500
Received: from mail.skyhub.de ([5.9.137.197]:57880 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbeK2Hc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 02:32:56 -0500
Received: from zn.tnic (p200300EC2BC0240021C853CE8979B2E0.dip0.t-ipconnect.de [IPv6:2003:ec:2bc0:2400:21c8:53ce:8979:b2e0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DA7A11EC08EA;
        Wed, 28 Nov 2018 21:30:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1543437003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=y5DyzCM6orE2ZnnYElw2jqXMBpOpTPw5BNYwRt1Vrgo=;
        b=EUgmkMLRydEE3HiEQoeH0pVwk4gEYEH2CQMwqnML7Q/9TJtXEnqlsjleGAb7C+ofqk2jyn
        h6tQnt2FeYcY2CQH/HuKb6OM9G/WRZ5ZSA3SYo9ochLYeTKeW/dGYUeQDr45/Tm4ERVV9N
        W35Dm55Ne1cr5vpTM6728vvLB9+bWHk=
Date:   Wed, 28 Nov 2018 21:29:52 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Moger, Babu" <Babu.Moger@amd.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/resctrl: fix the uninitialized variable warning
Message-ID: <20181128202952.GA29570@zn.tnic>
References: <20181128201450.31820-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181128201450.31820-1-babu.moger@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 08:15:02PM +0000, Moger, Babu wrote:
> Fix the compiler warning caused by a recent change.

Now take your time machine, send yourself 6 months into the future, look
at that commit message and try to remember what it was fixing. Can you?

I can't.

IOW, please summarize what smatch - the static checker not the compiler
- was complaining about and why this is a good fix.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
