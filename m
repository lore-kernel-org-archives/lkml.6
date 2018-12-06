Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0172C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 898AE2064D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="O3ZFbSs4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 898AE2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbeLFULu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 15:11:50 -0500
Received: from mail.skyhub.de ([5.9.137.197]:59316 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbeLFULu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 15:11:50 -0500
Received: from zn.tnic (p200300EC2BCE8F005573F8735857468A.dip0.t-ipconnect.de [IPv6:2003:ec:2bce:8f00:5573:f873:5857:468a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CA2661EC0BAD;
        Thu,  6 Dec 2018 21:11:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544127109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qDzvxB1vGL4SuYwFr8fSLl6ljej1Yh62zRApjyWlUJg=;
        b=O3ZFbSs4AWEdvNii3ucJ8gqPq+tvOhi8Up+a/Rq9LMb1Jrs1dEonRysVaYFL/+q5DnxsKb
        MlmhWwHlrh+UjH5kla8HV4/1XZGVH8reVkaKDDxrOdE6FcZu5SGPAUm7j7UAgVj2wMnnZB
        Pfjs1sD48Nzmgto8Ypgiwo2ZHLkRnBE=
Date:   Thu, 6 Dec 2018 21:11:47 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     lijiang <lijiang@redhat.com>
Cc:     Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, x86@kernel.org,
        linux-ia64@vger.kernel.org, linux-efi@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        ard.biesheuvel@linaro.org, tony.luck@intel.com,
        fenghua.yu@intel.com, bhe@redhat.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Toshi Kani <toshi.kani@hp.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/2 v8] resource: add the new I/O resource descriptor
 'IORES_DESC_RESERVED'
Message-ID: <20181206201147.GG3986@zn.tnic>
References: <20181129080956.20776-1-lijiang@redhat.com>
 <20181129080956.20776-2-lijiang@redhat.com>
 <20181130033703.GA23624@dhcp-128-65.nay.redhat.com>
 <bbf6352b-b060-4cb8-dfd2-99166b0149a7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bbf6352b-b060-4cb8-dfd2-99166b0149a7@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 03:04:44PM +0800, lijiang wrote:
> I have noticed the changes on x86, but for IA64, i'm not sure whether it should do the same
> thing, so keep it as before.
> 
> If IA64 people would like to give any comment, that will be appreciated.

I think you should not touch ia64 and not make Tony unnecessarily power
up the old rust.

:-)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
