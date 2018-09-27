Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE959C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ABAD2156B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ABAD2156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbeI0MM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 08:12:56 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59820 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbeI0MM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 08:12:56 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ts7m6w-tl98F; Thu, 27 Sep 2018 07:56:23 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC7FB00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc7:fb00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EE22E1EC02C1;
        Thu, 27 Sep 2018 07:56:22 +0200 (CEST)
Date:   Thu, 27 Sep 2018 07:56:25 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Justin Ernst <justin.ernst@hpe.com>
Cc:     russ.anderson@hpe.com, Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Raise maximum number of memory controllers
Message-ID: <20180927055625.GB30912@zn.tnic>
References: <20180925143449.284634-1-justin.ernst@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180925143449.284634-1-justin.ernst@hpe.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 09:34:49AM -0500, Justin Ernst wrote:
> We observe an oops in the skx_edac module during boot.
> Examining /var/log/messages:
> [ 3401.985757] EDAC MC0: Giving out device to module skx_edac controller Skylake Socket#0 IMC#0
> [ 3401.985887] EDAC MC1: Giving out device to module skx_edac controller Skylake Socket#0 IMC#1
> [ 3401.986014] EDAC MC2: Giving out device to module skx_edac controller Skylake Socket#1 IMC#0
> ...
> [ 3401.987318] EDAC MC13: Giving out device to module skx_edac controller Skylake Socket#0 IMC#1
> [ 3401.987435] EDAC MC14: Giving out device to module skx_edac controller Skylake Socket#1 IMC#0
> [ 3401.987556] EDAC MC15: Giving out device to module skx_edac controller Skylake Socket#1 IMC#1
> [ 3401.987579] Too many memory controllers: 16
> [ 3402.042614] EDAC MC: Removed device 0 for skx_edac Skylake Socket#0 IMC#0
> 
> We observe there are two memory controllers per socket, with a limit of 16.
> Raise the maximum number of memory controllers from 16 to 2 * MAX_NUMNODES (1024).
> 
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-edac@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Acked-by: Russ Anderson <russ.anderson@hpe.com>
> Signed-off-by: Justin Ernst <justin.ernst@hpe.com>
> ---
>  include/linux/edac.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
