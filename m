Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234F1C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAEBD20892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="iFExNCPR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAEBD20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbeLETA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:00:26 -0500
Received: from mail.skyhub.de ([5.9.137.197]:58746 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727436AbeLETAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:00:23 -0500
Received: from zn.tnic (p200300EC2BC09900ED3DB18DCE3E6DEF.dip0.t-ipconnect.de [IPv6:2003:ec:2bc0:9900:ed3d:b18d:ce3e:6def])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C6F321EC0B59;
        Wed,  5 Dec 2018 20:00:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544036422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=deCI49BX/nKTczjOt7d+EAZoSxRhSyQ9/QlS52WemOI=;
        b=iFExNCPRzZVhU5jhQK46WYw2zQgkBIAQIU8biYFHvZg+Np1Ag7cC2AI9kx+9bL2Hwtj6nv
        FHcF9BKJ5kCNVXRPFIOEg+nJJnt6Epsvrx5vtRH9eAMliM9jw21DagKbbP+fbu1YXcf8I0
        kfBMs16RCYQcm/ec7ujhf+ZXGkLDTOU=
Date:   Wed, 5 Dec 2018 20:00:20 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jari Ruusu <jariruusu@users.sourceforge.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        kvm ML <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3I/bcOhPw==?= <rkrcmar@redhat.com>,
        Rik van Riel <riel@surriel.com>, x86-ml <x86@kernel.org>
Subject: Re: [PATCH 4.14 121/146] x86/fpu: Disable bottom halves while
 loading FPU registers
Message-ID: <20181205190020.GO29510@zn.tnic>
References: <20181204103726.750894136@linuxfoundation.org>
 <20181204103731.697870447@linuxfoundation.org>
 <5C07FC30.43601034@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5C07FC30.43601034@users.sourceforge.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 06:26:24PM +0200, Jari Ruusu wrote:
> That same race appears to be present in older kernel branches also.
> The context is sligthly different, so the patch for 4.14 does not
> apply cleanly to older kernels. For 4.9 branch, this edit works:

You could take the upstream one, amend it with your change, test it and
send it to Greg - I believe he'll take the backport gladly.

:-)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
