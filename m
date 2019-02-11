Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D21C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E821B217FA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXYKDBd1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbfBKUL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:11:29 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46128 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfBKUL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 15:11:28 -0500
Received: by mail-qt1-f196.google.com with SMTP id y20so177482qtm.13;
        Mon, 11 Feb 2019 12:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2w31NGh7I1ZRrr+I0Xs8sN5KEU8+wxls7ptgmApxZQ0=;
        b=OXYKDBd13MRxcolv+gA3bHqdLeX+0ulNxO6dDXtQjDCkkySt8vWr7nVLIBB4rD8H4K
         mqL8fdAREOZmixFjFx9DufbvjSJkRn+cAW6JyCbaRGqEvBBdLjKww0N4ghb0hoKpuwZh
         PG4iFtz6H5QVRQbH5mHJKdPIacrFOT71DCET7PLi7TXoOdtHJ0z+Lm6or6jfZZFGfm6P
         3H4BwO1oJxi2LTZZOiODfCHdGEKh0QT4bIj3hNB+S7lpnePWB3CDRPK8wunieUGtk78A
         DGyOUERaPrekXNRq+mZ7Jcd1snqXNRsyLTtJ4AZ+Ciey10kvY9Hl67ISxsMFOJDUo6+1
         ogvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2w31NGh7I1ZRrr+I0Xs8sN5KEU8+wxls7ptgmApxZQ0=;
        b=t6wpLEp27QYenOyzwxnGwfNIHgNd6wXR17DTEINM7o6n0vtCCI2ZFYl+/7HIdY+dOl
         SoPCxDAmQgNc9z57Z4H+euqmBurHkblG0zIC0oZIUWXWEk7UXVse/yXCirMWE1O8KkVg
         2sARXiE5xtUEolF6EeED1AdfoOb/uqyfuRE3phzE2L0qjKj710lD+B4nleYiNu8M48YR
         8I/G8dRNLDNJ7ahKX8c6pfsCvrlvhiRAav3001nZq3GJ0bRIYTXPYEf/Ub86zDUViUoQ
         S+eyIrHLL+G48pCEGFCC/8c2l+KRbcLRK2WFMM9oeM6/dnrEKa8uZhy0rIzIlRA+8hFD
         8D2A==
X-Gm-Message-State: AHQUAuYFf6WyvuCHRU/EISG309L3ESbKBaZm5QmRCSzjSk0HkqYMnKvL
        oLk9COef3JI+ZsxgwU/is2a+OkM=
X-Google-Smtp-Source: AHgI3IaZX3mahLqRjpNxSnP8kkRdJzifZ0sUUOuqGAJsJY3f/4p5b7xIVSMwNnmwjm+phukh7jpPhg==
X-Received: by 2002:ac8:1185:: with SMTP id d5mr28957051qtj.117.1549915887225;
        Mon, 11 Feb 2019 12:11:27 -0800 (PST)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id k22sm9670033qtm.73.2019.02.11.12.11.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 12:11:26 -0800 (PST)
Date:   Mon, 11 Feb 2019 15:11:20 -0500
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Baoquan He <bhe@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-acpi@vger.kernel.org, mingo@redhat.com,
        keescook@chromium.org, rjw@rjwysocki.net, lenb@kernel.org,
        ard.biesheuvel@linaro.org, indou.takao@jp.fujitsu.com,
        caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v8 0/3] x86/boot/KASLR: Parse ACPI table and limit kaslr
 in immovable memory
Message-ID: <20190211201118.pot6347rp2ieljel@gabell>
References: <20181025134050.ggiir77ehntikbwg@gabell>
 <20181106184519.GA16391@zn.tnic>
 <20181106193636.svyjwuwrlgnpuyyf@gabell>
 <20181106204511.GO13712@zn.tnic>
 <20181106222133.lb7674yzszivzihd@gabell>
 <20181108105129.GA7543@zn.tnic>
 <20181110105422.GA20023@zn.tnic>
 <20181111134556.qxv2v4g7dl5irzo7@gabell>
 <20190205150514.fvztftk75swgfayd@gabell>
 <20190211014605.GC1544@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211014605.GC1544@localhost.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

Thank you for your review.

On Mon, Feb 11, 2019 at 09:46:05AM +0800, Chao Fan wrote:
> On Tue, Feb 05, 2019 at 10:05:16AM -0500, Masayoshi Mizuma wrote:
> [...]
> 
> Hi Masa,
> 
> Sorry for delay, since last days were Chinese holiday.
> 
> >diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
> >index c5a949335..7dd61b943 100644
> >--- a/arch/x86/boot/compressed/acpi.c
> >+++ b/arch/x86/boot/compressed/acpi.c
> >@@ -288,6 +288,7 @@ int count_immovable_mem_regions(void)
> > 	struct acpi_subtable_header *sub_table;
> > 	struct acpi_table_header *table_header;
> > 	char arg[MAX_ACPI_ARG_LENGTH];
> >+	unsigned long long possible_addr, max_possible_addr = 0;
> 
> This line is so long that it should be added in first line.

Thanks. I will simplify around the local variables.

> 
> > 	int num = 0;
> > 
> > 	if (cmdline_find_option("acpi", arg, sizeof(arg)) == 3 &&
> >@@ -308,10 +309,19 @@ int count_immovable_mem_regions(void)
> > 			struct acpi_srat_mem_affinity *ma;
> > 
> > 			ma = (struct acpi_srat_mem_affinity *)sub_table;
> >-			if (!(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) && ma->length) {
> >-				immovable_mem[num].start = ma->base_address;
> >-				immovable_mem[num].size = ma->length;
> >-				num++;
> >+			if (ma->length) {
> >+				if (ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) {
> >+					possible_addr =
> >+						ma->base_address + ma->length;
> >+					if (possible_addr > max_possible_addr)
> >+						max_possible_addr =
> >+							possible_addr;
> >+				} else {
> >+					immovable_mem[num].start =
> >+						ma->base_address;
> >+					immovable_mem[num].size = ma->length;
> >+					num++;
> >+				}
> > 			}
> 
> It looks better in another mail where you add a new function.

Thanks!

- Masa
