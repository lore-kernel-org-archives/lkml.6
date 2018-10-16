Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBECC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D6ED2145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D6ED2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbeJQDv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 23:51:26 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43178 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727154AbeJQDv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 23:51:26 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cZLBXRxIhsDI; Tue, 16 Oct 2018 21:59:05 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCC9600329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcc:9600:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DF8B71EC0319;
        Tue, 16 Oct 2018 21:59:04 +0200 (CEST)
Date:   Tue, 16 Oct 2018 21:59:02 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Baoquan He <bhe@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        mingo@redhat.com, hpa@zytor.com, keescook@chromium.org,
        rjw@rjwysocki.net, lenb@kernel.org, ard.biesheuvel@linaro.org,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v8 0/3] x86/boot/KASLR: Parse ACPI table and limit kaslr
 in immovable memory
Message-ID: <20181016195902.GK5212@zn.tnic>
References: <20181011002955.GJ25297@MiWiFi-R3L-srv>
 <20181011055154.GB6667@localhost.localdomain>
 <20181013201958.zfzv5ahhe3xz7bwi@gabell>
 <20181013203429.GE31650@zn.tnic>
 <20181013214550.ag5qzokhkrkwnzsy@gabell>
 <20181013220541.GI31650@zn.tnic>
 <20181015005035.z3xym6nx43hogdge@gabell>
 <20181016151353.punyk7exekut2543@gabell>
 <20181016191113.GI5212@zn.tnic>
 <20181016195429.tovdgqq77gz3eek2@gabell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181016195429.tovdgqq77gz3eek2@gabell>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 03:54:30PM -0400, Masayoshi Mizuma wrote:
> Ah, sorry, I misunderstood your suggetion...
> In parse_setup_data(), the data is picked up from boot_params,

Yes, this is the pointer to the setup_data linked list head. See

Documentation/ABI/testing/sysfs-kernel-boot_params
Documentation/x86/boot.txt

for more information and basically grep the tree for examples.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
