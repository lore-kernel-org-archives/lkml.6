Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E9BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB8052133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="l596ly5w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732368AbfAKMdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 07:33:11 -0500
Received: from mail.skyhub.de ([5.9.137.197]:58780 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725298AbfAKMdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 07:33:10 -0500
Received: from zn.tnic (p200300EC2BCAC50001F60DFCC2EB2B0F.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:c500:1f6:dfc:c2eb:2b0f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AF7111EC027A;
        Fri, 11 Jan 2019 13:33:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547209988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JYN6qDQvtPPPCKoedb2bCKmSonRtOssz3bneax6/GbE=;
        b=l596ly5wdtUuAZVnea1bTmE9hO3stcTrx+0pV2i9FtpC/m9S4OA8I7/hT9xAShAPfJG5ME
        eLNPQEXSZdHmXPP+2AhfXS/MlCFQpPQLoCI4BScH+AYfFMYKnp30tQsl6Ee82c96D6oD2V
        19BL1DOjV8p/V48V9RKcswEcHz8lG/M=
Date:   Fri, 11 Jan 2019 13:33:00 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        akpm@linux-foundation.org, bhe@redhat.com, dyoung@redhat.com,
        k-hagio@ab.jp.nec.com, anderson@redhat.com,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2 v6] kdump: add the vmcoreinfo documentation
Message-ID: <20190111123300.GE4729@zn.tnic>
References: <20190110121944.6050-1-lijiang@redhat.com>
 <20190110121944.6050-2-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190110121944.6050-2-lijiang@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 08:19:43PM +0800, Lianbo Jiang wrote:
> +init_uts_ns.name.release
> +------------------------
> +
> +The version of the Linux kernel. Used to find the corresponding source
> +code from which the kernel has been built.
> +

...

> +
> +init_uts_ns
> +-----------
> +
> +This is the UTS namespace, which is used to isolate two specific
> +elements of the system that relate to the uname(2) system call. The UTS
> +namespace is named after the data structure used to store information
> +returned by the uname(2) system call.
> +
> +User-space tools can get the kernel name, host name, kernel release
> +number, kernel version, architecture name and OS type from it.

Already asked this but no reply so lemme paste my question again:

"And this document already fulfills its purpose - those two vmcoreinfo
exports are redundant and the first one can be removed.

And now that we agreed that VMCOREINFO is not an ABI and is very tightly
coupled to the kernel version, init_uts_ns.name.release can be removed,
yes?

Or is there anything speaking against that?"

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
