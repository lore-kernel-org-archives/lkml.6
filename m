Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A261C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346A020893
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:41:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 346A020893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbeG0KCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 06:02:01 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:34255 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729431AbeG0KCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 06:02:00 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 41cMr36JzDz1qvnL;
        Fri, 27 Jul 2018 10:41:07 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 41cMr35ZgBz20xTF;
        Fri, 27 Jul 2018 10:41:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id llpo6ExXIX3m; Fri, 27 Jul 2018 10:41:05 +0200 (CEST)
X-Auth-Info: uxiIcWPB8EZppfbXqgfuaZIrl+WlbduaSfTzkvND/RNBwwC2QLKwRBCSMQC/hvMw
Received: from igel.home (ppp-188-174-155-24.dynamic.mnet-online.de [188.174.155.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 27 Jul 2018 10:41:05 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 0F8B32C1140; Fri, 27 Jul 2018 10:40:54 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: Re: m68k allmodconfig build errors
References: <28ebe45d-3dbd-2a82-f537-b0725f7a2bcf@infradead.org>
        <878t66idai.fsf@igel.home>
        <94dc0357-10d4-c3dc-ef2a-9643f08d2a09@infradead.org>
        <alpine.LNX.2.21.1807241423000.8@nippy.intranet>
        <761399f0-0b10-716c-1e80-cfb19c06e455@infradead.org>
        <alpine.LNX.2.21.1807271428300.65@nippy.intranet>
X-Yow:  Is this "BIKINI BEACH"?
Date:   Fri, 27 Jul 2018 10:40:54 +0200
In-Reply-To: <alpine.LNX.2.21.1807271428300.65@nippy.intranet> (Finn Thain's
        message of "Fri, 27 Jul 2018 14:44:17 +1000 (AEST)")
Message-ID: <87in513wbt.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 27 2018, Finn Thain <fthain@telegraphics.com.au> wrote:

> Why doesn't gcc convert strncmp to __builtin_strcmp?

It does.  In fact, it first converts strncmp to __builtin_strncmp, then
optimizes it to __builtin_strcmp.  Finally, __bultin_strcmp is expanded
to a call to strcmp.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
