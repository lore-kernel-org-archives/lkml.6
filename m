Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38551C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C04208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C04208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934192AbeFRLcO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 07:32:14 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51490 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933337AbeFRLcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:32:12 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GNZ5Czkx6va0; Mon, 18 Jun 2018 13:32:10 +0200 (CEST)
Received: from zn.tnic (p200300EC2BE29C00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2be2:9c00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 22E241EC05D4;
        Mon, 18 Jun 2018 13:32:10 +0200 (CEST)
Date:   Mon, 18 Jun 2018 13:32:06 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Johan Hovold <johan@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] EDAC: i7core: fix memleaks and use-after-free on
 probe and remove
Message-ID: <20180618113205.GA24921@zn.tnic>
References: <20180612124335.6420-1-johan@kernel.org>
 <20180612124335.6420-2-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180612124335.6420-2-johan@kernel.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 02:43:35PM +0200, Johan Hovold wrote:
> Make sure to free and deregister the addrmatch and chancounts devices
> allocated during probe in all error paths. Also fix use-after-free in a
> probe error path and in the remove success path where the devices were
> being put before before deregistration.
> 
> Fixes: 356f0a30860d ("i7core_edac: change the mem allocation scheme to make Documentation/kobject.txt happy")
> Cc: stable <stable@vger.kernel.org>     # 3.6
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/edac/i7core_edac.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)

Both applied, thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
