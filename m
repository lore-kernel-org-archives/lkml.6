Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DAEC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 04:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C8BF21722
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 04:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C8BF21722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbeH0HvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 03:51:15 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51418 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbeH0HvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 03:51:14 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JChjUm-gRYyO; Mon, 27 Aug 2018 06:06:06 +0200 (CEST)
Received: from nazgul.tnic (79-100-101-223.ip.btc-net.bg [79.100.101.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E6F601EC023D;
        Mon, 27 Aug 2018 06:06:05 +0200 (CEST)
Date:   Mon, 27 Aug 2018 06:06:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jacek Tomaka <jacek.tomaka@poczta.fm>
Cc:     Jacek Tomaka <jacekt@dugeo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode: allow non-root reading of microcode
 version and processor flags
Message-ID: <20180827040620.GB14577@nazgul.tnic>
References: <20180825035039.14409-1-jacekt@dugeo.com>
 <8DACDEF8-ED0A-42BF-8426-3AAA4BA16317@alien8.de>
 <CD5DA006-0D28-4CB9-95FA-231F0E20BF44@poczta.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CD5DA006-0D28-4CB9-95FA-231F0E20BF44@poczta.fm>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 26, 2018 at 08:23:48PM +0800, Jacek Tomaka wrote:
> I am trying to get microcode version from user space. Reading it
> from /proc/cpuinfo requires greping/awking to extract the bits of
> information that are readily available in microcode/version.

If the only reason is because you find it hard to grep/awk, I won't
take it.

> Any reason why the same piece of information has different access
> permissions, depending on the way it is accessed?

I don't see any particular reason in the original commit which added it:

  9a4b9efa1d39 ("[PATCH] x86 microcode: add sysfs and hotplug support")

except maybe because the reload interface is root-only so making the
others root-only too, made sense.

However, we've made the microcode revision available to everyone in
/proc/cpuinfo, in the meantime, so I guess there's no point in keeping
the version file root-only anymore. And I guess the processor flags too,
while we're at it.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
