Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AD1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C18217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="K2AAQtqa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfBZNYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 08:24:21 -0500
Received: from mail.skyhub.de ([5.9.137.197]:55214 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfBZNYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 08:24:20 -0500
Received: from zn.tnic (p200300EC2BCDB20004BF6FA0AD9E5D61.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:b200:4bf:6fa0:ad9e:5d61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 819301EC0354;
        Tue, 26 Feb 2019 14:24:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1551187459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1BsnaSmJdNQ8P7PIzcxWBJoGEX7jiQuJXU44hV0QUMM=;
        b=K2AAQtqaL1iIEq7KE4oRuk4AO4ch6NjV+IdEp/Hp9ujhNJqFDTkvd5OR1iPIHKgYIlr4Pj
        ooOM4heDbaRCMQtO+zuyAJMeBFdVtoESsATBw/AyjA3qHR2nl1e5ut4U/c/00q7h/maLZ4
        VgJ+QDp6cInGpHKlmf0pm67Xsf/36Ng=
Date:   Tue, 26 Feb 2019 14:24:16 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] EDAC/amd64: Support more than two Controllers for
 Chip Select handling
Message-ID: <20190226132416.GE14836@zn.tnic>
References: <20190219202536.15462-1-Yazen.Ghannam@amd.com>
 <20190219202536.15462-4-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190219202536.15462-4-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 08:26:09PM +0000, Ghannam, Yazen wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> The struct chip_select array that's used for saving Chip Select bases
> and masks is fixed at length of two. There should be one struct
> chip_select for each controller, so this array should be increased to
> support systems that may have more than two controllers.
> 
> Increase the size of the struct chip_select array to eight, which is the
> largest number of controllers per die currently supported on AMD
> systems.
> 
> Also, carve out the Fam17h+ reading of the bases/masks into a separate
> function. This effectively reverts the original bases/masks reading code
> to pre-Fam17h support.

I like it simpler again. :-)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
