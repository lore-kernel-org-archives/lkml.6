Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24B7C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9722020892
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMegr81u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9722020892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730858AbeKGHtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:49:06 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36586 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbeKGHtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:49:06 -0500
Received: by mail-qt1-f194.google.com with SMTP id u34-v6so4573176qth.3;
        Tue, 06 Nov 2018 14:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cbndkx+b6KHg4Q+hofAyMrf3q5SWbKVDUldDNz+Diz0=;
        b=XMegr81uingNSoqXFH36uQDq2gcVPPFWRp2zszS+0I93eZV8+q/iwMjsGiWIJOxOZx
         kpifKdkVIfDu9jBDsoc2PmXcpPLTFXzGywjA0hkS01eWS4J3xjpho7jGeupCZcH4DGI2
         sHjKV93M67I0RVfiT7l16Xe/7hCymrXchVdQGNzxhdnA32Kt1WYeoBPjNV2rRwtiIptJ
         jIpNaOtoAkTMKBHg8DIstgGE/ccPKNo8au+yP/cXwlcXBHZyBkE66jJTNQIYLAfRCKee
         2tuqYF85Ge1t9piQSYwrb+v64kEf2GwJR96gZue+Df0E5vu5x+5Ni2qz+ZFAUWPd2LNm
         0Snw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cbndkx+b6KHg4Q+hofAyMrf3q5SWbKVDUldDNz+Diz0=;
        b=fNgBwecKUkHNPNsn4fBklgmc35PXtHyUvEHpm51K44f5KO5CKU2DaoiA8k2WRKIs8V
         w1N+JMGhUk1iGPG0ktUqCMYoOFzGbIWYtLin/9LGrdMOGIXOjWvDSIykkCyg6w6ba0u3
         42C1rODfPYfR25aUEgdiuXoYt48A13d28d1392Q+HFO2pAUBW+OPG0C8FiRsNDBg9KgO
         YOI2s/entf8IkBx6s3AgbTVAUIHaH499kMGZGOxlHYXV0A84IpHKdcM3g7vfMTJQpZGK
         3KtrGhFXVdCCcGVbpB/Hr1/1FF39wf6ZEhTLzN9cVYf9Y4bSCeVeU4EXFkFwrpUEowRZ
         8Jtg==
X-Gm-Message-State: AGRZ1gLild/hQ7amSR3vABQvhASeqN5oEChFQjooYt3E0oRlNco+TIBc
        Pr7NfAQPjF46DHEFQXTh7Q==
X-Google-Smtp-Source: AJdET5ezvukvrx+SaFu8kayDbFYEHott75nO8iB0dlOs2ucfPBhtAoj6OhDJC5z3/sIxaKW7lmCthw==
X-Received: by 2002:a0c:9a4a:: with SMTP id q10mr11608685qvd.150.1541542900245;
        Tue, 06 Nov 2018 14:21:40 -0800 (PST)
Received: from gabell ([2601:18f:600:d880:c1f1:36c5:d40:1949])
        by smtp.gmail.com with ESMTPSA id 88-v6sm12855805qte.6.2018.11.06.14.21.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 14:21:39 -0800 (PST)
Date:   Tue, 6 Nov 2018 17:21:34 -0500
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
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
Message-ID: <20181106222133.lb7674yzszivzihd@gabell>
References: <20181016151353.punyk7exekut2543@gabell>
 <20181016191113.GI5212@zn.tnic>
 <20181016195429.tovdgqq77gz3eek2@gabell>
 <20181016195902.GK5212@zn.tnic>
 <20181022154204.kagmdb55jtoez4ca@gabell>
 <20181025103345.GF14020@nazgul.tnic>
 <20181025134050.ggiir77ehntikbwg@gabell>
 <20181106184519.GA16391@zn.tnic>
 <20181106193636.svyjwuwrlgnpuyyf@gabell>
 <20181106204511.GO13712@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106204511.GO13712@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 09:45:11PM +0100, Borislav Petkov wrote:
> On Tue, Nov 06, 2018 at 02:36:38PM -0500, Masayoshi Mizuma wrote:
> > Yes, I think I can see what you are saying. However, I'm not sure how
> > I use the setup_data in legacy BIOS environment.
> 
> What is "legacy BIOS environment" and what does that have to do with
> setup_data?

My proposed patch [1] is useful only for EFI environment. The patch
allocates a setup_date structure by efi_call_early() and store the
KASLR data into the memory area.

+static void setup_kaslr(struct boot_params *params)
+{
+	struct setup_data *kaslr_data = NULL;
+	struct setup_data *data;
+	unsigned long size;
+	efi_status_t status;
+
+	size = sizeof(struct setup_data) + sizeof(unsigned long long);
+
+	status = efi_call_early(allocate_pool, EFI_LOADER_DATA,
+			size, (void **)&kaslr_data);

I'm not sure how I allocate such memory on no EFI environment.
Am I missing something...?

[1] https://lkml.kernel.org/r/20181022154204.kagmdb55jtoez4ca@gabell

Thanks,
Masa
