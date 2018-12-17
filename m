Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F801C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E471206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Q5Jow4qB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732453AbeLQLwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:52:54 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51124 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726831AbeLQLwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 06:52:54 -0500
Received: from zn.tnic (p200300EC2BC8CE0001731E093D136BFD.dip0.t-ipconnect.de [IPv6:2003:ec:2bc8:ce00:173:1e09:3d13:6bfd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0515E1EC023A;
        Mon, 17 Dec 2018 12:52:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1545047572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PI0dugphtFY80Bhv4IO35Z80Pef4adWfD6CI9pzJocA=;
        b=Q5Jow4qBDEcJMKZdDWuCaRiNKSpo0RKtddOgilIcJHlh8HK97AQEZ6aI6yXVjIRW1tOfu+
        yrXpONisSaBnpOcIUS33AjraLszYSPdGmddHkX+k+aj7ZMzs4HGEH2yaba6vsJipNfFoQh
        N1unHWdp6A+2BlyiApDB0ImNfLtg0ZA=
Date:   Mon, 17 Dec 2018 12:52:45 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        akpm@linux-foundation.org, bhe@redhat.com, dyoung@redhat.com,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2 v3] kdump: add the vmcoreinfo documentation
Message-ID: <20181217115245.GA12165@zn.tnic>
References: <20181216131617.2612-1-lijiang@redhat.com>
 <20181216131617.2612-2-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181216131617.2612-2-lijiang@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 09:16:16PM +0800, Lianbo Jiang wrote:
> +================
> +Common variables
> +================
> +
> +init_uts_ns.name.release
> +========================
> +The number of OS release. Based on this version number, people can find
> +the source code for the corresponding version. When analyzing the vmcore,
> +people must read the source code to find the reason why the kernel crashed.
> +

> +
> +init_uts_ns
> +===========
> +This is the UTS namespace, which is used to isolate two specific elements
> +of the system that relate to the uname system call. The UTS namespace is
> +named after the data structure used to store information returned by the
> +uname system call.
> +
> +User-space tools can get the kernel name, host name, kernel release number,
> +kernel version, architecture name and OS type from the 'init_uts_ns'.

And this document already fulfills its purpose - those two vmcoreinfo
exports are redundant and the first one can be removed.

And now that we agreed that VMCOREINFO is not an ABI and is very tightly
coupled to the kernel version, init_uts_ns.name.release can be removed,
yes?

Or is there anything speaking against that?

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
