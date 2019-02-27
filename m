Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B23FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43116218E2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551255637;
	bh=5idpe6MqiVBf7gZXb7Ff7XduBGgydtMTvDCvVi6N0j0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l/zpWJ7pSZSyQrNSfI1Qca/E+7yjeb6Qf50lZl02l+P9/q3QA8RnI0t+KG83BxsLw
	 Uy289/mr3NcUlhAYJJ7Tyk9vTpHfQP5VXFbMnKdocOz0ak+GPWjvqufdCiZPijhRKC
	 l2Cu0FAPg48sa+ylHTrxM6dbm1IegW3PlO0Eas+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbfB0IUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 03:20:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:55100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726791AbfB0IUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 03:20:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2F31218E0;
        Wed, 27 Feb 2019 08:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551255635;
        bh=5idpe6MqiVBf7gZXb7Ff7XduBGgydtMTvDCvVi6N0j0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S0dyRZ3lTdSh1VhGCefRk7S4o4t8h067lGu4zd+Maw5H8wgjyQ7f0LOu0I22xqyyi
         H3B4sbuW4doS+XIIg5hS2FCXekqdAMSmog7rKYVKeijDeC4OfhOCXwFP7ARqkx6UZo
         GSiTIjG4J2DzRn1KnLS6rTN7l37axL0jzlEuk5Bc=
Date:   Wed, 27 Feb 2019 09:20:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] x86/asm: More pinning
Message-ID: <20190227082032.GA22049@kroah.com>
References: <20190226233647.28547-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226233647.28547-1-keescook@chromium.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 03:36:44PM -0800, Kees Cook wrote:
> This adds CR0 pinning (for WP), and cleans up the CR4 pin to avoid
> taking an exception from WARN before fixing up the desired pin.
> Additionally adds lkdtm test (which depends on the CR4 patch, otherwise
> I'd send it via Greg's tree).

No objection from me to route around me, please do!

greg k-h
