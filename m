Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D37C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D961B21741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="M7CI4+3R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732295AbeLTQFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:05:53 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34049 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731179AbeLTQFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:05:50 -0500
Received: by mail-lj1-f193.google.com with SMTP id u89-v6so2059904lje.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 08:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kq1Rt/DJPoJgGyX1gjzJ3R1/H4Nvy8Nlgu/OiQiL5pE=;
        b=M7CI4+3RMUcxvrs+9pCVGW8gamJFJOhhIMVuuc4o+gRy8aXlHw9zLihoFwLMuWTPta
         YjqG2dlOfd4JYjBhm7f0miryZT1RIyeKEYcqMYJTevco2BsFDGFVpipr/2eD4XL+X+Sx
         ZuWxL2jgLPtyJ7rxMsdN5UGXoCLaxS1/qq+HA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kq1Rt/DJPoJgGyX1gjzJ3R1/H4Nvy8Nlgu/OiQiL5pE=;
        b=QeMRF6Gwb1jTtlqg6vLCfG+7vlNzrLJKUlFTMzJg+6l+IK1Z0S105yua73+9N0B7NJ
         k/TK0Ua4m+aWlI6OLvuZu4WgWccUmv0t0TFL2SRWD6q6xOXn/n4qF8fA5rjD2wK3gbDm
         zB/d8/sUq7Q0Nja2h76khNLwetqI/dgkxpMRHo0U+ttox0jVh3Tc7D2AOHWFQXC88LHn
         5aZfZVjFKeOH3Bcwvp9dXs+9HawpHTaaghFvO3skB52DL+qne68h1rRd0F8Rjd9tEsXM
         tF/gDQaCoTmtH6szxkyN8Sdr8pvYLtMnMf4y2f/JeXVCBihHWfslTq+KYP45KZ8oIlzA
         yg/g==
X-Gm-Message-State: AA+aEWaV14kNFfWjX8j3Y/pvkKh9N7SH4wKUy2VPkT3yvJvkxzy7Wb6G
        GHQ4zFivdmF5uFOfRxy674JbZqhlgi8=
X-Google-Smtp-Source: ALg8bN4SfU4w8GoXjO9045wDsI6yUVtS/L066FjQLDdqg+RJ9FjcO97u+ZOUvyt5jokOYEZLE3dtlA==
X-Received: by 2002:a2e:744:: with SMTP id i4-v6mr766516ljd.140.1545321946844;
        Thu, 20 Dec 2018 08:05:46 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id a2-v6sm4241418lji.13.2018.12.20.08.05.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 08:05:45 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id c19-v6so2045455lja.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 08:05:45 -0800 (PST)
X-Received: by 2002:a2e:9c7:: with SMTP id 190-v6mr7032012ljj.120.1545321945074;
 Thu, 20 Dec 2018 08:05:45 -0800 (PST)
MIME-Version: 1.0
References: <20181220091931.zcibvplow3oxzacs@inn2.lkp.intel.com>
In-Reply-To: <20181220091931.zcibvplow3oxzacs@inn2.lkp.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 20 Dec 2018 08:05:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjvxCn2uYp7USY5bbVuffJcugusxHc-RU7u5H1=ubMyPw@mail.gmail.com>
Message-ID: <CAHk-=wjvxCn2uYp7USY5bbVuffJcugusxHc-RU7u5H1=ubMyPw@mail.gmail.com>
Subject: Re: [ide] ec7d9c9ce8: WARNING:at_fs/proc/generic.c:#remove_proc_entry
To:     kernel test robot <lkp@intel.com>, Christoph Hellwig <hch@lst.de>,
        David Miller <davem@davemloft.net>
Cc:     LKML <linux-kernel@vger.kernel.org>, lkp@01.org,
        linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 1:19 AM kernel test robot <lkp@intel.com> wrote:
>
> FYI, we noticed the following commit (built with gcc-7):
>
> commit: ec7d9c9ce897174243af4fcd201dbfc34df0f3a3 ("ide: replace ->proc_fops with ->proc_show")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

Funky.  How did the kernel test robot suddenly figure out an 8-month
old problem?

> [   44.180514] WARNING: CPU: 1 PID: 165 at fs/proc/generic.c:662 remove_proc_entry+0xb9/0x155

This is a warning for somebody doing "remove_proc_entry() on a name
that doesn't actually exist in that /proc directory.

In this case, it does seem to be due to the named commit adding a

+               remove_proc_entry("settings", drive->proc);

to ide_proc_unregister_device(), and looking at the patch I get the
feeling that it's due to a typo: the code *creates* the file called
"setting", but removes the file "settings". Note the missing "s" at
creation time.

And yes, the name of the /proc file _should_be "settings", judging by
the rest of the patch.

So it does seem to be a real bug. Nobody noticed until now? Why did
the test robot suddenly react to it?

              Linus
