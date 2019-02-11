Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AE7C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED8421B25
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n7nfDm/D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732945AbfBKTgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:36:42 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41198 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbfBKTgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:36:42 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so65947wrs.8;
        Mon, 11 Feb 2019 11:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=D1a0L7OGkiUm/CdwA+tD4SnrFPDYPK1wPMaIJUcQTMU=;
        b=n7nfDm/DOfDnL23se9DEzD7Gng5WydSa6aLdnPMA63H8vEkIKqEB+OrdIlCoU34fkP
         N4cmX+uZsJuo2D+0RCkICRdcR3pBHws+wP5KXIfvW10gExLBNzKx4G1BUsCDAnpeM0gI
         2T6n3JUEKjsaqGfLolCtBNLr263gjj2S1jESfckSiGhCN8dzDxrlIRKaMaRPXZV+iM3f
         ep0DzxPJwJfV4YoPu17ACwBQLwkUEQPHHFfityMaGeQ57ljCxtas6o4Ff/04Ur5rjHYZ
         fyjxWlH0cPWSgrrE0yM9n0O3ms8eA3WUl3prmYRPBxZx3msDuPy/GMW2XpX1bh3RYfHd
         o6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=D1a0L7OGkiUm/CdwA+tD4SnrFPDYPK1wPMaIJUcQTMU=;
        b=aAzxymVL/+zlFeVKp3WQsIRAEY4nLCG99zuBQf4Lmp98tyb1+4Y9EslDkSdWAOBgWL
         HRj65cZcieBZmcnpJkzRSX2BLnBu4MvJpA3HmT1HXMyfDPoTDKEg27jc5e7QKqe8htIU
         RNQz0q5AzGpbHzwrkI6cCrFh5FmbGZ8qNAethwFsY2Q1Zx/S/0XckoM5HfKwmW/vGWP5
         Zqy/OcWt4Cwh7NLEyELSmhqip8U2kdDeX18qFcqdcjucFzcrcYgtEKO94OSJOzuNO+Gp
         wgZdCEnRG2NUMF9tBnS57cIfcGp/xifmkXuHHHWUvXWOpwPxKIDYUHyIvGMtfRc1ztsS
         pCQw==
X-Gm-Message-State: AHQUAuYJsnsjAMynyO3PT98dsEVd+wdkBzctrWrW56fw8LD0jYoTjR9m
        vjJekV101DgXuo43BkXBHZc=
X-Google-Smtp-Source: AHgI3Ib2q/0QJVb/6qpcqP9LGdsUeG0bWflyAb3+BNQ1U33M3QNkI4RiTzo7vzw9FTjKVPbrjNXMBQ==
X-Received: by 2002:adf:cc83:: with SMTP id p3mr11514429wrj.292.1549913799770;
        Mon, 11 Feb 2019 11:36:39 -0800 (PST)
Received: from [10.33.115.182] ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id e27sm23137197wra.67.2019.02.11.11.36.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 11:36:39 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2 09/20] x86/kprobes: instruction pages initialization
 enhancements
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20190211182221.GM19618@zn.tnic>
Date:   Mon, 11 Feb 2019 11:36:33 -0800
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Damian Tometzki <linux_dti@icloud.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>, Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        deneen.t.dock@intel.com
Content-Transfer-Encoding: 7bit
Message-Id: <173B309B-21A4-4247-BF41-8C4D0267272E@gmail.com>
References: <20190129003422.9328-1-rick.p.edgecombe@intel.com>
 <20190129003422.9328-10-rick.p.edgecombe@intel.com>
 <20190211182221.GM19618@zn.tnic>
To:     Borislav Petkov <bp@alien8.de>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Feb 11, 2019, at 10:22 AM, Borislav Petkov <bp@alien8.de> wrote:
> 
> Only nitpicks:

Thanks for the feedback. Applied.

