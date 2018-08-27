Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD94DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DCE7208D8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DCE7208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbeH0LPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 07:15:55 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57638 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbeH0LPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 07:15:55 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5r1Fi6bopbO2; Mon, 27 Aug 2018 09:30:10 +0200 (CEST)
Received: from nazgul.tnic (79-100-101-223.ip.btc-net.bg [79.100.101.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 586C11EC01E9;
        Mon, 27 Aug 2018 09:30:10 +0200 (CEST)
Date:   Mon, 27 Aug 2018 09:30:24 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jacek Tomaka <jacekt@dug.com>
Cc:     Jacek Tomaka <jacek.tomaka@poczta.fm>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode: allow non-root reading of microcode
 version and processor flags
Message-ID: <20180827073024.GA18175@nazgul.tnic>
References: <20180825035039.14409-1-jacekt@dugeo.com>
 <8DACDEF8-ED0A-42BF-8426-3AAA4BA16317@alien8.de>
 <CD5DA006-0D28-4CB9-95FA-231F0E20BF44@poczta.fm>
 <20180827040620.GB14577@nazgul.tnic>
 <CAKVxXCUMy97PzmB=zrMg_kemLooA3LHTvAPruQh2w41CU=B+Dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKVxXCUMy97PzmB=zrMg_kemLooA3LHTvAPruQh2w41CU=B+Dg@mail.gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 01:01:41PM +0800, Jacek Tomaka wrote:
> Not sure if you are leaning towards removing microcode/version interface
> altogether or you are writing your thoughts to justify merging this patch.

The latter. We cannot *ever* remove sysfs files. Never.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
