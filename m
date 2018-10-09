Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404F2C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB99521479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB99521479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbeJIOyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 10:54:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:34936 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726057AbeJIOyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 10:54:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9FB12AEBA;
        Tue,  9 Oct 2018 07:39:15 +0000 (UTC)
Date:   Tue, 9 Oct 2018 09:39:13 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@alien8.de>,
        linux-tip-commits@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Toshimitsu Kani <toshi.kani@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [tip:x86/urgent] x86/mm: Avoid VLA in pgd_alloc()
Message-ID: <20181009073913.e4r7qwzb2c6qrji4@suse.de>
References: <20181005161333.765973-1-arnd@arndb.de>
 <tip-1be3f247c2882a82279cbcf43717581ea943b692@git.kernel.org>
 <20181008202209.GA6597@zn.tnic>
 <CAGXu5j+4hjJSFpYi=5SqDmkonJ79J=hcb65qJC8+_r6+5NHewg@mail.gmail.com>
 <CAK8P3a2KTzTD5d10KkmcKh=_E7J7EJkE48wrcUe4AAwDiBVuEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2KTzTD5d10KkmcKh=_E7J7EJkE48wrcUe4AAwDiBVuEQ@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Tue, Oct 09, 2018 at 09:33:56AM +0200, Arnd Bergmann wrote:
> Ah, cool, thanks for the analysis. Is the patch already reverted?
> I.e. should I send a replacement patch, or a relative fix, or is
> someone else already on it?

Kees sent a fix which is already in tip-tree:

	https://lore.kernel.org/lkml/20181008235434.GA35035@beast/

Regards,

	Joerg
