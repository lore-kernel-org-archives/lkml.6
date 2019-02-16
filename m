Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7928BC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 13:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F205222D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 13:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfBPNPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 08:15:24 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:59019 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfBPNPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 08:15:23 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 441rGJ38jnz1r01b;
        Sat, 16 Feb 2019 14:15:20 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 441rGJ29m3z1qqkS;
        Sat, 16 Feb 2019 14:15:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 8E9i_dOXwDyq; Sat, 16 Feb 2019 14:15:19 +0100 (CET)
X-Auth-Info: WAZZ1lxIpLiJaGUL7WPeQCu95RDgYXrEcAgkoSQ4XdXOKg7aXAfiS1bzR4aClOM1
Received: from igel.home (ppp-188-174-150-184.dynamic.mnet-online.de [188.174.150.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sat, 16 Feb 2019 14:15:19 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id A50CE2C202B; Sat, 16 Feb 2019 14:15:18 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@ozlabs.org, linux-mm@kvack.org, erhard_f@mailbox.org,
        jack@suse.cz, aneesh.kumar@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/64s: Fix possible corruption on big endian due to pgd/pud_present()
References: <20190214062339.7139-1-mpe@ellerman.id.au>
X-Yow:  I'll take ROAST BEEF if you're out of LAMB!!
Date:   Sat, 16 Feb 2019 14:15:18 +0100
In-Reply-To: <20190214062339.7139-1-mpe@ellerman.id.au> (Michael Ellerman's
        message of "Thu, 14 Feb 2019 17:23:39 +1100")
Message-ID: <87pnrran89.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 14 2019, Michael Ellerman <mpe@ellerman.id.au> wrote:

> The fix is simple, we need to convert the result of the bitwise && to
> an int before returning it.

Alternatively, the return type could be changed to bool, so that the
compiler does the right thing by itself.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
