Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76238C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A9FA21855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="YvSC8dAv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbfAWSqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 13:46:47 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39154 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbfAWSqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 13:46:47 -0500
Received: from zn.tnic (p200300EC2BCA6A00F4913A0531746803.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:6a00:f491:3a05:3174:6803])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1E8791EC0229;
        Wed, 23 Jan 2019 19:46:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548269205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tMlaX9Bp3jyTRYpl6QJgghJAtKuxBwkL+WNJrCU9UNY=;
        b=YvSC8dAvWLAEDYvrqtxyk4xYqQBm4pcvhaHT0MJC4OTBxBegQLUaSWPM/wY6f2sjish/Zy
        sSDSP+nktpn/g8lnfYKr2Q3r0n31pz1hAhwPpQx62MVutBiDhRolSY6oJry3bgX3kkm+nG
        +x/7t5/JCuzjn7I38y9szUfvZTuZrZs=
Date:   Wed, 23 Jan 2019 19:46:39 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     James Morse <james.morse@arm.com>
Cc:     Rui Zhao <ruizhao@microsoft.com>, Sasha Levin <sashal@kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Kernel <linux-kernel@microsoft.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "okaya@kernel.org" <okaya@kernel.org>
Subject: Re: [PATCH] EDAC, dmc520:: add DMC520 EDAC driver
Message-ID: <20190123184639.GD3227@zn.tnic>
References: <20190118162324.17123-1-sashal@kernel.org>
 <0866a996-49f7-1498-4653-20232bef2f46@arm.com>
 <MW2PR2101MB09701C705250DAC025AFC251B3990@MW2PR2101MB0970.namprd21.prod.outlook.com>
 <7d404c61-a916-5d5e-35cc-0f6f016cd8a9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7d404c61-a916-5d5e-35cc-0f6f016cd8a9@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 06:36:23PM +0000, James Morse wrote:
> > Would like to know what's the impact if this error happens, and how to fit it
> > with current reporting in EDAC core.
> 
> At a guess the interrupt triggers when link_err_count increases. (link_err has
> an overflow bit, so the interrupt must be related to a counter).
> 
> If we could associate a link with a layer in edac, we could report errors
> against that point. But I've no idea how 'links' correspond with 'ranks and banks'!

Well, I have no clue what kind of links you guys are talking but if
those are per-chance coherent links used by cores to communicate in a
coherent fabric, or cores and devices, what would showing those errors
to the user bring ya?

Or are ya talking about different kinds of links?

In any case, the first question to ask would be, can some agent or the
user do something with the information that X or Y link errors happened?

If not, then why bother?

If yes, then that's a different story.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
