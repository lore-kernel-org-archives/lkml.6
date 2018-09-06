Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEC4C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76F120844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C76F120844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbeIFRFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:05:32 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51260 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbeIFRFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:05:32 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6pyOgYqwAKoj; Thu,  6 Sep 2018 14:29:58 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCBB900329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:b900:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E32C61EC02AE;
        Thu,  6 Sep 2018 14:29:57 +0200 (CEST)
Date:   Thu, 6 Sep 2018 14:29:56 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Pu Wen <puwen@hygon.cn>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH v5 10/16] x86/mce: enable Hygon support to MCE
 infrastructure
Message-ID: <20180906122956.GF10768@zn.tnic>
References: <cover.1535459012.git.puwen@hygon.cn>
 <c1e803bc54984e54ca67278930588e85b65bb26f.1535459013.git.puwen@hygon.cn>
 <20180905092234.GC2237@zn.tnic>
 <01604799-b993-e530-817c-ad097d343fc4@hygon.cn>
 <20180905131427.GI2237@zn.tnic>
 <a9b7aa87-c99a-42ee-48df-69bec64bb468@hygon.cn>
 <20180906083924.GB10768@zn.tnic>
 <634f371e-1a2d-5b23-c9b0-5f32a8ee4cee@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <634f371e-1a2d-5b23-c9b0-5f32a8ee4cee@hygon.cn>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 07:40:52PM +0800, Pu Wen wrote:
> The first is the compilation test. Test the kernel with both MCE selected
> and unselected to see if is the compiling process successful or not.

This is a kernel compile test - it has nothing to do with actual machine
testing.

> The other test is functionality test. For example, during the MCE BIOS
> development, to see if the MCE functions OK, it may need to select and
> unselect MCE in kernel for double checking.

Say what now?! What testing do you do if you boot a kernel which doesn't
even use the functionality you're testing?!

> Actually in normal use scenario and in real product the MCE should be
> always selected.

It better be!

> To ensure this, I think there are two ways as below:
> - Select X86_MCE_AMD in CPU_SUP_HYGON config entry, it also cater to the
>   first test scenario, but meanwhile lacks flexibility.
> - The linux distros(Ubuntu, CentOS, etc) ensure that X86_MCE_AMD is
>   selected to the default config file, and indeed they do.
> Which way is better?

The first way but change that dependency to CPU_SUP_AMD because there
are people building their own kernels and don't run distro configs. And
you need CPU_SUP_AMD because you're using their code.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
