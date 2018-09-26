Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76106C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251042152E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 251042152E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbeIZWXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:23:42 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:46019 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbeIZWXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:23:41 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 42L2vt198Nz1qxDN;
        Wed, 26 Sep 2018 18:10:01 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 42L2vs1BcFz1qvlB;
        Wed, 26 Sep 2018 18:10:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id KLpvAv8JtntL; Wed, 26 Sep 2018 18:10:00 +0200 (CEST)
X-Auth-Info: QIluTUbOZQnE4QpEj2S78UJaS+dCd528vo+bHOFS1hvU2wd58wIiJVEweWKmAsW4
Received: from igel.home (ppp-188-174-155-122.dynamic.mnet-online.de [188.174.155.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 26 Sep 2018 18:10:00 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id ECD992C1281; Wed, 26 Sep 2018 18:09:59 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: m68k allmodconfig build errors
References: <28ebe45d-3dbd-2a82-f537-b0725f7a2bcf@infradead.org>
        <878t66idai.fsf@igel.home>
        <94dc0357-10d4-c3dc-ef2a-9643f08d2a09@infradead.org>
        <87sh48r0zf.fsf@igel.home>
        <CAMuHMdW-ZA3bUJP3Fztm5sm7TSO345Jah471oMUr89x89d51xQ@mail.gmail.com>
X-Yow:  LOOK!!  Sullen American teens wearing MADRAS shorts and
 ``Flock of Seagulls'' HAIRCUTS!
Date:   Wed, 26 Sep 2018 18:09:59 +0200
In-Reply-To: <CAMuHMdW-ZA3bUJP3Fztm5sm7TSO345Jah471oMUr89x89d51xQ@mail.gmail.com>
        (Geert Uytterhoeven's message of "Wed, 26 Sep 2018 09:44:13 +0200")
Message-ID: <87a7o4dyug.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 26 2018, Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Isn't gcc-8 just assuming that any char array must contain a valid
> NUL-terminated string, unless it is tagged with the nonstring attribute?

No, only if you call strncpy on it and make it potentially
non-terminated.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
