Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751727AbeBBKfh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 05:35:37 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:49518 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751630AbeBBKfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 05:35:32 -0500
Date: Fri, 2 Feb 2018 11:35:25 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Chen Baozi <cbz@baozis.org>
cc: x86@kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/retpoline: check CONFIG_RETPOLINE option when
 SPECTRE_V2_CMD_AUTO
In-Reply-To: <20180202064744.29331-1-cbz@baozis.org>
Message-ID: <alpine.DEB.2.21.1802021134270.1472@nanos.tec.linutronix.de>
References: <20180202064744.29331-1-cbz@baozis.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Feb 2018, Chen Baozi wrote:

> Currently, if there is no spectre_v2= or nospectre_v2 specified in the boot
> parameter, the kernel will automatically choose mitigation by default.
> However, when selecting the auto mode, it doesn't check whether the
> retpoline has been built in the kernel. Thus, if someone built a kernel
> without CONFIG_RETPOLINE and booted the system without specifying any
> spectre_v2 kernel parameters, the kernel would still report that it has
> enabled a minimal retpoline mitigation which is not the case. This patch
> adds the checking of CONFIG_RETPOLINE option under the 'auto' mode to fix
> it.

Thanks for sending that patch, but its already fixed and queued for upstream:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/pti&id=9471eee9186a46893726e22ebb54cade3f9bc043

Thanks,

	tglx
