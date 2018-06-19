Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76723C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA8320693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyduXeSb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BA8320693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965061AbeFSWRY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 18:17:24 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37919 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965030AbeFSWRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 18:17:20 -0400
Received: by mail-pf0-f193.google.com with SMTP id b74-v6so538670pfl.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 15:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LUaeA5UqA6g3K9/+Of32uFu1Tldu5MqCLKS9h5ShqEI=;
        b=VyduXeSb1HK0m13P/koAV1c09XiZ4V08wIGO+ZTkTsZc312GKvGZ1pBuAPKYuZDed5
         fho4hlCMj9StRlnPl2clfw4lXfIK3MXWVifACLvC/H5NYSRDdE/YtUDMbEokm2fJLxxN
         ZiLctKvqf2zwBiwp+ySPaXI7E5LfVYZoJJl3NHl8XtoE+7Z+88lL8msGnNmVVcM3cbi+
         YT0ZbbJISmTY8Xnb/m0dOkRJZZ3ARy1kXGSDorWp2a9yuCUWwQRwvfslcbJ4MhCyAeyG
         BFhrN8pk9yQ4ZZCjdqzdfrP9sCyQPJ1HwBfS/r6o615HNyqTkh111cOEYeiqIHvbEdWL
         bBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LUaeA5UqA6g3K9/+Of32uFu1Tldu5MqCLKS9h5ShqEI=;
        b=O23go3plYYfCdAgng3zK//ej7wHM8lmxJSEGqSfjgqrgRbZ5u7X4BP5cJ4QLaSFdD4
         90G4RkTXPFPihIZwinEWXv+J8YAu5lo9SfYyfqTCiI/aa5ptYeaDZ6r4tCxr1kCyqP2w
         oeLkNdjP07M1FOMpbsyX65znIeh7pDpILMVrtNZNTSgIMLn4LAyAN4LrIXHIjCMsGUZd
         rQDJeWNT5nGQ1rfsrK86GlqbRxDMvTqeF1gWl0LQfoPxhlxDILNCqA95LHC+cqLpDIKf
         GmrPHWOGrdCbRwUA+hgDzMs0xdiMnag4yrpJMZVPSJpIeGrQ7WhF0Ob0yHa5yig8Msuo
         uusQ==
X-Gm-Message-State: APt69E3axyR2j2GdAIlP+f691wOPO6VYh9m8pTm4u+hgSkGCbkeNyUvY
        AF8sFqwLIZtmas51rCMAACk=
X-Google-Smtp-Source: ADUXVKLS9ovD65wJgqxM9sexzkAgKbBqndQXvW0lE811oG6WGCtjL5dT7ej4fjYhOxOIryrThIGXKQ==
X-Received: by 2002:a62:d09:: with SMTP id v9-v6mr19706466pfi.163.1529446639801;
        Tue, 19 Jun 2018 15:17:19 -0700 (PDT)
Received: from [10.2.101.129] ([208.91.2.2])
        by smtp.gmail.com with ESMTPSA id s14-v6sm778426pfh.116.2018.06.19.15.17.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 15:17:18 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [RFC v2 PATCH 2/2] mm: mmap: zap pages with read mmap_sem for
 large mapping
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <1529364856-49589-3-git-send-email-yang.shi@linux.alibaba.com>
Date:   Tue, 19 Jun 2018 15:17:16 -0700
Cc:     Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        ldufour@linux.vnet.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <3DDF2672-FCC4-4387-9624-92F33C309CAE@gmail.com>
References: <1529364856-49589-1-git-send-email-yang.shi@linux.alibaba.com>
 <1529364856-49589-3-git-send-email-yang.shi@linux.alibaba.com>
To:     Yang Shi <yang.shi@linux.alibaba.com>
X-Mailer: Apple Mail (2.3445.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 4:34 PM, Yang Shi <yang.shi@linux.alibaba.com> wrote:

> When running some mmap/munmap scalability tests with large memory (i.e.
>> 300GB), the below hung task issue may happen occasionally.
> 
> INFO: task ps:14018 blocked for more than 120 seconds.
>       Tainted: G            E 4.9.79-009.ali3000.alios7.x86_64 #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
> message.
> ps              D    0 14018      1 0x00000004
> 
(snip)

> 
> Zapping pages is the most time consuming part, according to the
> suggestion from Michal Hock [1], zapping pages can be done with holding
> read mmap_sem, like what MADV_DONTNEED does. Then re-acquire write
> mmap_sem to manipulate vmas.

Does munmap() == MADV_DONTNEED + munmap() ?

For example, what happens with userfaultfd in this case? Can you get an
extra #PF, which would be visible to userspace, before the munmap is
finished?

In addition, would it be ok for the user to potentially get a zeroed page in
the time window after the MADV_DONTNEED finished removing a PTE and before
the munmap() is done?

Regards,
Nadav
