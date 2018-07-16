Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5465ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 06:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B1A62086B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 06:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B1A62086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbeGPGnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 02:43:51 -0400
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:39500 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727647AbeGPGnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 02:43:50 -0400
Received: from belgarion ([90.76.60.200])
        by mwinf5d14 with ME
        id BJJ01y0034KClF603JJ0FL; Mon, 16 Jul 2018 08:18:03 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Mon, 16 Jul 2018 08:18:03 +0200
X-ME-IP: 90.76.60.200
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Olof Johansson <olof@lixom.net>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: linux-next: build failure after merge of the arm-soc tree
References: <20180716091337.6c1b2a4d@canb.auug.org.au>
        <CAOesGMgicOOi0Nr+m_UHEGYL+ryRW65YAPwVsN+CZpo6kc2FLA@mail.gmail.com>
X-URL:  http://belgarath.falguerolles.org/
Date:   Mon, 16 Jul 2018 08:18:00 +0200
In-Reply-To: <CAOesGMgicOOi0Nr+m_UHEGYL+ryRW65YAPwVsN+CZpo6kc2FLA@mail.gmail.com>
        (Olof Johansson's message of "Sun, 15 Jul 2018 16:50:25 -0700")
Message-ID: <87601faelj.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Olof Johansson <olof@lixom.net> writes:

> It's a known issue due to dependencies with a driver tree. :(
>
> Robert, this is unfortunate. What's the dependent patches? We can pick
> them up in our tree as duplicates if needed.
I'd rather postpone one of the patches, as I explained in the pull request.
As Stephen noticed, this will be :
0d0b16b8e008 ("dmaengine: pxa: make the filter function internal")

I'll queue this one for the 4.20 cycle. By the way, all of this cames from the
fact that I didn't take this very patch in my imutable branch for this change
...

I'll also resend a pull request, without this patch if that's good for you,
which will solve the breakage.

Cheers.

-- 
Robert
