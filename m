Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B9EC07E85
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605EF2082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="N8kySNC/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 605EF2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbeLERMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:12:36 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42292 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727297AbeLERMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:12:35 -0500
Received: from zn.tnic (p200300EC2BC09900993F789616C996F0.dip0.t-ipconnect.de [IPv6:2003:ec:2bc0:9900:993f:7896:16c9:96f0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 70EAF1EC04FB;
        Wed,  5 Dec 2018 18:12:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544029953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=q8ZbivEMth9AESCMbOjzBjOAjdutp3qmUwboNDYX2Pg=;
        b=N8kySNC/uh2Mi7hZsa30dCREZIxRRmNfJlaerFvwqIJESvEgHamp72sICfXf8kxcCTAJyg
        dFAp+U7QDwhlq90KBL8vInrYmOeEqUTEwIBIf2+22NOvPxEpZPnU7SrKxZ0WPW1WA9BtkW
        HVdaD9EMs+P3XIg4sfUFy0DKsGFxF6E=
Date:   Wed, 5 Dec 2018 18:12:27 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tracy Smith <tlsmith3777@gmail.com>
Cc:     york.sun@nxp.com, linux-edac@vger.kernel.org,
        util-linux@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: edac driver injection of uncorrected errors & utils
Message-ID: <20181205171226.GL29510@zn.tnic>
References: <CAChUvXMVHxhawLFPFzz_0+iFxjQ+dRwpTsCGo95oc8Y+7a-2DQ@mail.gmail.com>
 <AM0PR04MB3971FBCF6CB23BE778D39EED9AD80@AM0PR04MB3971.eurprd04.prod.outlook.com>
 <CAChUvXPCfwfHrntJHWpsydYZE=P692Axd0pFE+GjZCXtx1fgog@mail.gmail.com>
 <CAChUvXMWZ-LYyqnczM-bt9cDP0r1XT+F1dcYuRHiVcx=QR7_Jw@mail.gmail.com>
 <AM0PR04MB3971768EA5D50D7045B462619AD10@AM0PR04MB3971.eurprd04.prod.outlook.com>
 <CAChUvXN8rZqxBaV2qbdR8uymsmZAk_Jnc2kxSUf+kBf76QHV9A@mail.gmail.com>
 <AM0PR04MB3971FFCCDAF29E7DF0F0EE159AD10@AM0PR04MB3971.eurprd04.prod.outlook.com>
 <CAChUvXNz=XR37EeVRJFnF195BGgjPgCeFv6nbjR3yV2_mQwxBQ@mail.gmail.com>
 <20181128234415.GH16830@zn.tnic>
 <CAChUvXPgntzMbAhcg8y2HJyyZWwaqNPe66efmpfyHLgN1JSW_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAChUvXPgntzMbAhcg8y2HJyyZWwaqNPe66efmpfyHLgN1JSW_w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 10:37:52AM -0600, Tracy Smith wrote:
> This was very helpful.

I'm glad.

Can you do me a favor pls and not top-post when replying on a mailing
list?

Thx.

> Tracing through the code, it doesn't do a panic
> before Linux crashes from multi-bit errors because as York has
> indicated, this type of memory controller doesn't limit the number of
> errors.
> 
> I do have a general question about single bit errors.  The EDAC driver
> corrects single bit errors by doing a scrub, is this correct?  The
> edac code does not do periodic scrubs, but I see scrubs when a
> correctable error is found (edac_mc_scrub_block and edac_atomic_scrub
> in edac_mc.c)?
> 
> This is more directed toward York for layerscape.

Yes, this is all platform-specific as you can see that some arches
implement that atomic scrubbing thing. Also, not every driver sets

  mci->scrub_mode == SCRUB_SW_SRC

in order to even do the scrubbing.

HTH.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
