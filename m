Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0A2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 04:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34D12077C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 04:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H5ssc/dk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D34D12077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbeJJLcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 07:32:11 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38579 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbeJJLcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 07:32:03 -0400
Received: by mail-pf1-f194.google.com with SMTP id f29-v6so1941215pff.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 21:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=7HZpE/svjvEHFVjkdbIdljSw3Nddw+tZ5mCc3DSajcA=;
        b=H5ssc/dkNs0Wa9f6wBeCfKiX5lJxqx0x0lKnVaRb+8AG5Ncr/SZPAmILDtiRa0T959
         RFgRQr9tFfDvIYct6WMLXA0M51ijjZ5nOVWIe2LNiy0e6lXrnrNjyoNoa/mERViHkQj8
         Dxg3SiLv3rt6YkH3Dho3qUtmWGCuGQuDH0xfJSBiPHixgPH1iXcYc8rRC8HgwlvNmfwB
         pI7fcw0WkOCbtaL0BuDsP5IXrKIrilocNfMUhouKtmeD2Zd3F4JPUz0QHiZ/5LxRtRQu
         DT/ky3cWDT6+rck3GmyS35QvxXYgn7+DybkaKmDHis+Vfcw81k/XkUX9fQgTXr1EW0B0
         m6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=7HZpE/svjvEHFVjkdbIdljSw3Nddw+tZ5mCc3DSajcA=;
        b=fObIrVToWN39qf4QYUwONigvPMgqE17/o6CDR4Oxdxd9hN/cZnKOYapjiGBQfbQimQ
         qjh8JMpnFYTdsz/ZOhh9wwQp2s51+qROEzyqWeI2I7xGj4nUkeHgmO3WLBr0WDAtsaWZ
         iMC9RgTW3kbOguCGAtQYvn39FGNPDWJaxMsqh7/B8t7sG3ySLMng7GfhuCnK/Rv8yYwZ
         8gBAs+nQ19s/43ze4YmT0+ffDEzu6GqfIMS7zzZ2hDGBChH6uLqqbg6ISl++DTvKSLpG
         9IUvpd7o+Q3PGvn2WKVyPd18J7k9mp4RUOsD6ibYARqBTiXrF8czrF3RUoSUp0Sh+HyX
         XUbw==
X-Gm-Message-State: ABuFfog+Fu10FPciJ7fiOmZ1814UcABpXTLgUD5dTic9azDv6kgqMTPM
        9ekFWVgoeXsLoDZxYAh2MpuQQg==
X-Google-Smtp-Source: ACcGV63wboQ8mhMYW+233CGKDBxDHs7MHQDrAiIEGArkRfdyzhLOD4HnKn8IhiOu84AotyXXIhLJ9g==
X-Received: by 2002:a63:f347:: with SMTP id t7-v6mr27712716pgj.255.1539144710589;
        Tue, 09 Oct 2018 21:11:50 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id x20-v6sm38432703pfe.131.2018.10.09.21.11.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 21:11:49 -0700 (PDT)
Date:   Tue, 9 Oct 2018 21:11:48 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
cc:     syzbot <syzbot+77e6b28a7a7106ad0def@syzkaller.appspotmail.com>,
        hannes@cmpxchg.org, mhocko@kernel.org, akpm@linux-foundation.org,
        guro@fb.com, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, yang.s@alibaba-inc.com
Subject: Re: INFO: rcu detected stall in shmem_fault
In-Reply-To: <201810100012.w9A0Cjtn047782@www262.sakura.ne.jp>
Message-ID: <alpine.DEB.2.21.1810092106190.83503@chino.kir.corp.google.com>
References: <000000000000dc48d40577d4a587@google.com> <201810100012.w9A0Cjtn047782@www262.sakura.ne.jp>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2018, Tetsuo Handa wrote:

> syzbot is hitting RCU stall due to memcg-OOM event.
> https://syzkaller.appspot.com/bug?id=4ae3fff7fcf4c33a47c1192d2d62d2e03efffa64
> 
> What should we do if memcg-OOM found no killable task because the allocating task
> was oom_score_adj == -1000 ? Flooding printk() until RCU stall watchdog fires 
> (which seems to be caused by commit 3100dab2aa09dc6e ("mm: memcontrol: print proper
> OOM header when no eligible victim left") because syzbot was terminating the test
> upon WARN(1) removed by that commit) is not a good behavior.
> 

Not printing anything would be the obvious solution but the ideal solution 
would probably involve

 - adding feedback to the memcg oom killer that there are no killable 
   processes,

 - adding complete coverage for memcg_oom_recover() in all uncharge paths
   where the oom memcg's page_counter is decremented, and

 - having all processes stall until memcg_oom_recover() is called so 
   looping back into try_charge() has a reasonable expectation to succeed.
