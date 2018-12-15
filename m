Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BEAC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 00:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E79206C0
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 00:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Chca5DV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbeLOA0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 19:26:17 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36896 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbeLOA0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 19:26:17 -0500
Received: by mail-ed1-f68.google.com with SMTP id h15so6330421edb.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 16:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V95dr3G3RkBJgZIaKV8YGexD6Uh5VM+r1rC1lbrlLDQ=;
        b=Chca5DV3SKqC6gAajVcbCfugnX6NpDFc5pzG91yZrXK9BYg0/JehLWNQEpVsQJy8R5
         4DSvxTZaXrocMAf1eDtQHF6jF2V1W1x9rFWVwPHXs4bf0UncJIRG2blV82Fmpn48EK/c
         qxRLvlGTCTCZDtXp4Q+Z59gvWHjr/RR/n/qqfMD6XMiBCweJkJBhY/TsKz4M9P5zdojs
         RdhsbZp3coUcBCm7+oQcnG0n/kp2ZCJxfR4DEjRflVC6SpHgyepsH+uP5ADAL6qZVAh2
         cc3LTe1gGQEpdxdPXwEuUftRqJc0QdWJb8qsuOOdYL88wX4FXlAjkTczSl/h6RPzjanH
         SRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=V95dr3G3RkBJgZIaKV8YGexD6Uh5VM+r1rC1lbrlLDQ=;
        b=BQr0v2Z8r5ObfcaN4kGkPJWfmDeCg/VMCrOWM3APzb9ffQysYHMN/+GcnASA1IdTwF
         B5/pSI4vxc7YC/UIcqmIIv1/LlpYj/WIZXYFzMOc+PfsSgIVviKp6I7VOkhVgG3rWjsN
         8PziXRSeEZ3LW/wdbZReSogcD5Zz4NhZXb6vyFPdA82PYzHEi/AGMrqQWe6KYmnNvr+a
         YAWlnaQkY48cMc9ZAo3Tb0V8hes+BUJVpke9cn9AdS7dbFEi73Dy52OLPEgVGT6JFXzi
         I5m4xDpbYFqMU0UxyMZDFTHuTcByoIzpu0mwEiraZjyd0DXuMsWVRJ6rGfBTpgOI0vsO
         8Vrw==
X-Gm-Message-State: AA+aEWYqTzYFDRrHZXviDyV/69iNp5VcfjEHDX1NlhoyLGigrZkXJKP0
        VTuHhrSECwBFIIQW1lK7mug=
X-Google-Smtp-Source: AFSGD/WXbUI3e6qxw94DAsp4vRWnMbZNej+OknmMv3eFIci9pScO8ZAXrpNMxdpKa2CpfeuEp6Kcow==
X-Received: by 2002:a50:ae64:: with SMTP id c91mr4596263edd.222.1544833575203;
        Fri, 14 Dec 2018 16:26:15 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id d56sm1939734ede.76.2018.12.14.16.26.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 16:26:14 -0800 (PST)
Date:   Sat, 15 Dec 2018 00:26:13 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Zaslonko Mikhail <zaslonko@linux.ibm.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Pavel.Tatashin@microsoft.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        gerald.schaefer@de.ibm.com
Subject: Re: [PATCH v2 1/1] mm, memory_hotplug: Initialize struct pages for
 the full memory section
Message-ID: <20181215002613.gj3s62uuxad6n4rb@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20181212172712.34019-1-zaslonko@linux.ibm.com>
 <20181212172712.34019-2-zaslonko@linux.ibm.com>
 <20181213034615.4ntpo4cl2oo5mcx4@master>
 <e4cebbae-3fcb-f03c-3d0e-a1a44ff0675a@linux.bm.com>
 <20181213151209.hmrhrr5gvb256bzm@master>
 <674c53e2-e4b3-f21f-4613-b149acef7e53@linux.bm.com>
 <20181214101651.GE5624@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214101651.GE5624@dhcp22.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 11:19:59AM +0100, Michal Hocko wrote:
>[Your From address seems to have a typo (linux.bm.com) - fixed]
>
>On Fri 14-12-18 10:33:55, Zaslonko Mikhail wrote:
>[...]
>> Yes, it might still trigger PF_POISONED_CHECK if the first page 
>> of the pageblock is left uninitialized (poisoned).
>> But in order to cover these exceptional cases we would need to 
>> adjust memory_hotplug sysfs handler functions with similar 
>> checks (as in the for loop of memmap_init_zone()). And I guess 
>> that is what we were trying to avoid (adding special cases to 
>> memory_hotplug paths).
>
>is_mem_section_removable should test pfn_valid_within at least.
>But that would require some care because next_active_pageblock expects
>aligned pages. Ble, this code is just horrible. I would just remove it
>altogether. I strongly suspect that nobody is using it for anything
>reasonable anyway. The only reliable way to check whether a block is
>removable is to remove it. Everything else is just racy.
>

Sounds reasonable.

The result return from removable sysfs is transient. If no user rely on
this, remove this is a better way.

>-- 
>Michal Hocko
>SUSE Labs

-- 
Wei Yang
Help you, Help me
