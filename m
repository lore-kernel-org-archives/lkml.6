Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397A0C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A042087E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="jULJsKtf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfANKdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:33:15 -0500
Received: from mail.skyhub.de ([5.9.137.197]:53770 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbfANKdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:33:14 -0500
Received: from zn.tnic (p200300EC2BC4CA00C95BD7F0398E53C6.dip0.t-ipconnect.de [IPv6:2003:ec:2bc4:ca00:c95b:d7f0:398e:53c6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 907401EC0543;
        Mon, 14 Jan 2019 11:33:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547461993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=i2+lb58nXp7Uh6Sz41NfTz6qYkJvPoOm/r73E9VVDuA=;
        b=jULJsKtf6ejygS7UxSzdcTj3cmwULFdOTmtsK0yUxauqahg3vdt2RyUs+GcuWr6NWRMv7F
        ZeLjz9/ls7hA5s9OYU5s/MxH7o58j0q71mNXLy7ry5Gu/K1CuEYt+BlU1m1ixIr5AXQUhb
        oxihG3RYkLVOBRFcqFdqtKCdMgiFiCM=
Date:   Mon, 14 Jan 2019 11:33:12 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "S, Shirish" <Shirish.S@amd.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "maintainer : X86 ARCHITECTURE" <x86@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "open list : X86 ARCHITECTURE" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/mce/amd: Ensure quirks are applied in resume
 path as well
Message-ID: <20190114103312.GG2773@zn.tnic>
References: <1546857399-2926-1-git-send-email-shirish.s@amd.com>
 <1546857399-2926-3-git-send-email-shirish.s@amd.com>
 <20190109220843.GK15665@zn.tnic>
 <7a9227c0-1bc3-67c5-14a8-a40d186a5ef8@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7a9227c0-1bc3-67c5-14a8-a40d186a5ef8@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 08:04:49AM +0000, S wrote:
> Perhaps no need to check the model altogether, this is applicable to 
> entire family 15, since there is no 8th Gen.

I wouldn't be so sure. At the time I did this, we excluded models >=
0x10 but I don't remember why anymore. You need to check with hw folks
whether you can really do this for the whole family.

> I have summarized this sequence after capturing the call trace in both 
> scenarios.
> 
> Its clear that the quirks are not applied during S3-> S0 transition, 
> hence the patch.

Ok.

Btw, fix your mailer: It has an empty from:

From: S

which, when I do "reply-to-all" here, generates an empty To: too.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
