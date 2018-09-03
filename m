Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A35C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 07:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 559DC20843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 07:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 559DC20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbeICLaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 07:30:08 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37072 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbeICLaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 07:30:08 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HpNjWtvDASEP; Mon,  3 Sep 2018 09:11:02 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCF4100329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcf:4100:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C3C541EC01AF;
        Mon,  3 Sep 2018 09:11:01 +0200 (CEST)
Date:   Mon, 3 Sep 2018 09:12:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
Cc:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        Lee Chun-Yi <jlee@suse.com>, Al Stone <astone@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH V2 2/6] x86/efi: Remove __init attribute from memory
 mapping functions
Message-ID: <20180903071207.GA10249@zn.tnic>
References: <1535881594-25469-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1535881594-25469-3-git-send-email-sai.praneeth.prakhya@intel.com>
 <20180902105602.GA19431@zn.tnic>
 <FFF73D592F13FD46B8700F0A279B802F485B9142@ORSMSX114.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <FFF73D592F13FD46B8700F0A279B802F485B9142@ORSMSX114.amr.corp.intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 05:03:56AM +0000, Prakhya, Sai Praneeth wrote:
> Hmm.. thought that __efi_init might be confusing with the normal __init attribute

How would that be confusing? It has "__efi" prepended?!

All I'm saying is, if you're going to define your own function
attributes, do them generic and short. "_fixup" is too specific IMO. It
also enlarges function definitions unnecessarily.

With "__efi_init" you already denote that it is a special attribute
which has relevance in the EFI code only. What you do about it - the
*fixup* - is the thing you do with the attribute. But you don't have to
have the "what you do" in the attribute name too.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
