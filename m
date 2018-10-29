Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A9AC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2845E20870
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:15:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2845E20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbeJ3BEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 21:04:44 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34748 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727701AbeJ3BEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 21:04:44 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id u7r3HVlkeyxt; Mon, 29 Oct 2018 17:15:27 +0100 (CET)
Received: from zn.tnic (p200300EC2BC61800329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:1800:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 25AC71EC036B;
        Mon, 29 Oct 2018 17:15:27 +0100 (CET)
Date:   Mon, 29 Oct 2018 17:15:25 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Daniel Aberger - Profihost AG <d.aberger@profihost.ag>
Cc:     tony.luck@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, s.priebe@profihost.ag,
        n.fahldieck@profihost.ag, p.kramme@profihost.ag
Subject: Re: MCE reports errors that can't be verified
Message-ID: <20181029161525.GI32150@zn.tnic>
References: <6ccf5413-ce2a-bbb9-0203-b0cc9fe2e641@profihost.ag>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6ccf5413-ce2a-bbb9-0203-b0cc9fe2e641@profihost.ag>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 11:45:04AM +0100, Daniel Aberger - Profihost AG wrote:

...

> [Mi Aug 22 13:54:47 2018] mce: [Hardware Error]: CPU 15: Machine Check:
> 0 Bank 7: cc00008000010091
> [Mi Aug 22 13:54:47 2018] mce: [Hardware Error]: TSC 0 ADDR 70fb1b3ec0
> MISC 142189886
> [Mi Aug 22 13:54:47 2018] mce: [Hardware Error]: PROCESSOR 0:306f2 TIME
> 1534938887 SOCKET 1 APIC 26 microcode 3d

The fact that you see this, means, the error has reached the last
notifier. So the EDAC notifier must've run too and handed the error to
the EDAC driver.

Can you send a full dmesg from that machine, privately to Tony and me is
fine too.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
