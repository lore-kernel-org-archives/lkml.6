Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22101C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE83620664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpQitV9O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE83620664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbeJaAy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:54:59 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46957 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbeJaAy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 20:54:59 -0400
Received: by mail-lf1-f66.google.com with SMTP id o2-v6so9268266lfl.13;
        Tue, 30 Oct 2018 09:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=1IEEeuUR/J5GCCap9VgHErkjtB5GQJrDwGqFb/dZsqI=;
        b=IpQitV9Ozh/cfI7YXZrHpi5qh+kMPgggVRyjwuy3x1rePfzvmkLQGTm6qsFxDRPXR7
         ZlRxs8lVrcWZRe0EoVj99NA0eQLJiX0yrPuXEKwe/2jUcJhyqyd8vEhpOr2Sp9EN7/R/
         F98dk7FFwI+Jq9b3xnG40NWJNhaGqUee+QHJ/OqjMd7QbOeyQW8mCaQmAN1y2tHho4Zq
         S7U9r7qEoPwJdLT3VojbkngKGy1bCBRfz9AqmBy2bDAqGcsJKRh13TjF3JqAn2zSzXxr
         ZI9bzrqAQBtzUJEq/V1SoEnVsmg/S37/t6QmzpcS8mRc+K9jzeKppHQH6PEKpC6npdC2
         mAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=1IEEeuUR/J5GCCap9VgHErkjtB5GQJrDwGqFb/dZsqI=;
        b=M/xtTTdXgZfvGC+7KWqaLF/0Phl0oMjS41FsjqmwguKJef/PjCobmdFHUapp1/davX
         KhuiWmZqTCL6YKhMtT4nCOnBloteJc3qgcNUI/w3tlvv46blEcbP6NOYbENf8IQVq3sI
         V2xgaXr0inxwLlOByz8scRjKEEJTwhfW3PPK712Y3tIxjg3VTubyfTMjT7GMR2u2Iqjq
         /C34rSgqTHdr9whH7LIYNMuuCYlSflaGt9FsxHfPTiQ4ItqUrdfX9CtqdGsG2BEJI9eH
         z6SPug5sMbTdmsKf3nNHXGk1bIvHA5Vi71P9gtUBC+7rvYzpGpckR2Nor3U/Qfmss00V
         hx2g==
X-Gm-Message-State: AGRZ1gJMNnE+lpTwoRuuOyZea3OLtBD5lQUBzUMVtgvspjs8kovWgy1f
        7I/DPe3FDYasue8D796rCI+NKxM6pKw=
X-Google-Smtp-Source: AJdET5ectI9MyGwzDpn/YdWd4K2lckLVG8lNGQ9qBDaJ9s6MvT+J6x24PM1bfNJ/QDOidGyqI/4zrg==
X-Received: by 2002:a19:4948:: with SMTP id l8-v6mr2182701lfj.16.1540915254528;
        Tue, 30 Oct 2018 09:00:54 -0700 (PDT)
Received: from ?IPv6:2001:14bb:52:7be:f0bf:dd2d:f008:5213? (dmkd798g-7z2-yccwcp-4.rev.dnainternet.fi. [2001:14bb:52:7be:f0bf:dd2d:f008:5213])
        by smtp.gmail.com with ESMTPSA id a4-v6sm3747201lfa.91.2018.10.30.09.00.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 09:00:53 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
Subject: Build error in drivers/cpufreq/intel_pstate.c
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <e176a41a-eb24-7f2c-bb75-a9b18eab420f@gmail.com>
Date:   Tue, 30 Oct 2018 18:00:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm getting the following build error:

/home/igor/dev/kernel/linux/drivers/cpufreq/intel_pstate.c: In function 
‘show_base_frequency’:
/home/igor/dev/kernel/linux/drivers/cpufreq/intel_pstate.c:726:10: 
error: implicit declaration of function 
‘intel_pstate_get_cppc_guranteed’; did you mean ‘intel_pstate_get_epp’? 
[-Werror=implicit-function-declaration]
   ratio = intel_pstate_get_cppc_guranteed(policy->cpu);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
           intel_pstate_get_epp



on top of:

commit 11743c56785c751c087eecdb98713eef796609e0
Merge: 929e134c43c9 928002a5e9da

--
igor
