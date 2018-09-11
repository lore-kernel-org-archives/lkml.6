Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E6DC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E1020866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:51:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E1020866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbeIKPuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 11:50:10 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37448 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbeIKPuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 11:50:10 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AvqSdCiUzjs1; Tue, 11 Sep 2018 12:51:22 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC6F600329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:f600:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 49C201EC0118;
        Tue, 11 Sep 2018 12:51:22 +0200 (CEST)
Date:   Tue, 11 Sep 2018 12:51:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     tglx@linutronix.de
Cc:     Pu Wen <puwen@hygon.cn>, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com,
        mchehab@kernel.org, mikhail.jin@gmail.com,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH v6 15/16] EDAC, amd64: Add Hygon Dhyana support
Message-ID: <20180911105120.GH12094@zn.tnic>
References: <cover.1536550549.git.puwen@hygon.cn>
 <7deadc44054d62e3617b9f302f4e5d1fd0d382e7.1536550550.git.puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7deadc44054d62e3617b9f302f4e5d1fd0d382e7.1536550550.git.puwen@hygon.cn>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 09:20:24PM +0800, Pu Wen wrote:
> To make AMD64 EDAC and MCE drivers working on Hygon platforms, add
> support for Hygon Dhyana CPU by using the code path of AMD family
> 17h.
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  drivers/edac/amd64_edac.c | 8 +++++++-
>  drivers/edac/mce_amd.c    | 4 +++-
>  2 files changed, 10 insertions(+), 2 deletions(-)

This one conflicts with

  8960de4a5ca7 ("EDAC, amd64: Add Family 17h, models 10h-2fh support")

in my tree.

tglx, what do you suggest?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
