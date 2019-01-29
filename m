Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C41C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE8B2086C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="MuxjwOZA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfA2RFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:05:08 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42216 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728017AbfA2RFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:05:08 -0500
Received: from zn.tnic (p200300EC2BCC5400E03D356D4AA330A5.dip0.t-ipconnect.de [IPv6:2003:ec:2bcc:5400:e03d:356d:4aa3:30a5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C38181EC0245;
        Tue, 29 Jan 2019 18:05:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548781506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=aFt7AURr4ocBAbk09L2UuTjX0kxpip2b/p/REPGDiMA=;
        b=MuxjwOZAmRYOA85/2FgJemKPfAB3AF38xR4Y3lBtTzYYnReS2P8/ZYyuezLHS9l5wCtGWh
        djv9vqWpQvRH7P60OdI3bGJLaP5e3wej4t1XiW1GrPRrUvbWcI/PQDa5gXNzoblmct/fra
        neOkTMVPLBcXB9R/ikquudDo+oPdQmo=
Date:   Tue, 29 Jan 2019 18:04:58 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86/events: Mark expected switch fall-throughs
Message-ID: <20190129170458.GC27037@zn.tnic>
References: <20190125184917.GA7289@embeddedor>
 <20190129152500.GA25706@zn.tnic>
 <8aa46db0-6983-62c4-7dc6-e006d20cd84b@embeddedor.com>
 <20190129160753.GA27037@zn.tnic>
 <db4c4c57-fcdb-5101-a3b6-d1f3c587185e@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <db4c4c57-fcdb-5101-a3b6-d1f3c587185e@embeddedor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 10:19:59AM -0600, Gustavo A. R. Silva wrote:
> Yeah. But I don't want to send patches to every person that has touched the file.

Yes but you should *definitely* CC supporters and reviewers.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
