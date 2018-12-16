Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB95CC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 00:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1302086D
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 00:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="pNTkyHsz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbeLPAIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 19:08:07 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42058 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727216AbeLPAIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 19:08:07 -0500
Received: from zn.tnic (p200300EC2BDCE200ADD97DAFC8659476.dip0.t-ipconnect.de [IPv6:2003:ec:2bdc:e200:add9:7daf:c865:9476])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 253141EC0B62;
        Sun, 16 Dec 2018 01:08:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544918886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B6InRbKs6E0Z9hOojID/uv86qd/ilichcbUssSBnWwI=;
        b=pNTkyHszyHx0mQaiN/pOD6O0XqZ2yOiAJEAh9NcsnF7nNtCiTZTZbJTz3qOiueAF/xTyPr
        6Ty2GH3oonRIYYb4Ie3ktsjhLt5zrdzOktPB3uPnLNyZakY2dL9ofm6Dp7bL1izTDFLKUR
        OMnLztdrYsukBaAw5ep7XqjwNpM3Gtc=
Date:   Sun, 16 Dec 2018 01:08:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problem with late AMD microcode reload/feedback
Message-ID: <20181216000804.GD6693@zn.tnic>
References: <CACna6ryhfaOFS4qjZoLjJqcu5LQd05_jDndL5+GpADTHhu3_7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACna6ryhfaOFS4qjZoLjJqcu5LQd05_jDndL5+GpADTHhu3_7Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 12:46:05AM +0100, Rafał Miłecki wrote:
> I'm trying to reload AMD Ryzen Mobile (fam17h) microcode doing:
> echo 1 > /sys/devices/system/cpu/microcode/reload

Also, I'd advise against using the late loading method but put the
microcode in the initrd (which your distro should be probably doing,
already):

Documentation/x86/microcode.txt

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
