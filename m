Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D5DC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B6E1208DD
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkU1XmbJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B6E1208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966215AbeFOTrN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 15:47:13 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36711 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966074AbeFOTrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 15:47:11 -0400
Received: by mail-lf0-f65.google.com with SMTP id n24-v6so498409lfh.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 12:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KRwaxGCPjuM1ATPaEaP6RMl3xiCq1fdPBhvhd6/SZOc=;
        b=XkU1XmbJt9UqxwSkSJ181HK39Usrra8WF3n5NX2j/IGfnO6xLBHAiZg+dViKvV5qud
         5Xzaij82NEQSrcfGYZOt77Vzj3umnmZUUQP5QV57/uVNq+ECaTvQpIOpPniwHr/7ll7l
         T5QLwJDhlKr/vViKKWZFeqGrO+z62s2m1p57Ux/ThEaEBp8P9UDDn791hVg3wEVzBdiL
         Nk44MNJuvvNN+W9QMKerWcFRVUwqsnb+8ZDZAgzAUO1u9i5yTxdcjf/iO2f8ZWVeyR9L
         y4tPPiis4T5VE1M+Foag80QjGuUmR6A9etSi5wutlNc9Fsw9JgHv900TnBWdwewhA80G
         TnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KRwaxGCPjuM1ATPaEaP6RMl3xiCq1fdPBhvhd6/SZOc=;
        b=GC+BXVACX0liFZoJPaQ2iOf/VmQxsJvwY4OPR6t5mex01oJR363o+WK/W4xJSRKmv5
         6w2xkmOkM2yj0c0q9I6SHwFEYElWQBUVkP7JrgGgX/5UPYaQsmfJFZXT/aLjEtQwSFi1
         i7b1yO+xUndzkqEipmaMFxOq4CFbLXrtOJzhPowAPI/JPiqEiqHvw67ZfJEkcC53sbBA
         M7yZyf6WXOlL0jnS+picoEKOXTYnkCOGimTmlMZE7pBDXClj+1oKj7FunfJbrYuJCbZW
         9xGCbhrzpNPaI0h30kp/dv+HFASLkt0b2DpjgEKvEEpSak16lH6nrl4YOrIVE3SZlCtx
         ky4A==
X-Gm-Message-State: APt69E1hE8TD7JXnzonWrdygtnef9Cr5eaPeiLyjjbZowH/CMNEtDFf3
        ezFU5OvkUn/GWWQ9/+zb6zUK8Q==
X-Google-Smtp-Source: ADUXVKK049P6KtiBXsITvAhHOf/p9TkVVfwXgVX0hUy3WusMML3mI5jCGnCRtWbpsrSZv59EPAKdDQ==
X-Received: by 2002:a2e:520d:: with SMTP id g13-v6mr2264120ljb.23.1529092030499;
        Fri, 15 Jun 2018 12:47:10 -0700 (PDT)
Received: from mobilestation ([5.166.218.73])
        by smtp.gmail.com with ESMTPSA id i5-v6sm1621415lfc.83.2018.06.15.12.47.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 12:47:09 -0700 (PDT)
Date:   Fri, 15 Jun 2018 22:47:17 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 0/8] Fix breakage caused by the NTB multi-port patchset
Message-ID: <20180615194717.GA15240@mobilestation>
References: <20180609000819.13883-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180609000819.13883-1-logang@deltatee.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 06:08:10PM -0600, Logan Gunthorpe <logang@deltatee.com> wrote:

Good day, Logan.
Thanks for the patchset you submitted. My hopefully useful comments are
under the corresponding patches.

Regards,
-Sergey

> Hey,
> 
> Here are all the fixes required to get ntb_test on switchtec working
> again after the multi-port test patches were merged.
> 
> I'd appreciate it if future changes can be a) more careful about
> not breaking things, b) communicated more clearly so that better
> review can be done, and c) not merged until sufficient review actually
> is done.
> 
> Note, I sent the first patch in this series earlier; please disregard
> the earlier one.
> 
> Thanks,
> 
> Logan
> 
> Logan Gunthorpe (8):
>   NTB: ntb_tool: reading the link file should not end in a NULL byte
>   NTB: Setup the DMA mask globally for all drivers
>   NTB: Fix the default port and peer numbers for legacy drivers
>   NTB: ntb_pingpong: Choose doorbells based on port number
>   NTB: perf: Don't require one more memory window than number of peers
>   NTB: perf: Fix support for hardware that doesn't have port numbers
>   NTB: perf: Fix race condition when run with ntb_test
>   NTB: ntb_test: Fix bug when counting remote files
> 
>  drivers/ntb/hw/amd/ntb_hw_amd.c         |  4 ----
>  drivers/ntb/hw/idt/ntb_hw_idt.c         |  6 ------
>  drivers/ntb/hw/intel/ntb_hw_intel.c     |  4 ----
>  drivers/ntb/ntb.c                       | 22 ++++++++++++++--------
>  drivers/ntb/test/ntb_perf.c             | 22 +++++++++++++++++++---
>  drivers/ntb/test/ntb_pingpong.c         | 14 ++++++--------
>  drivers/ntb/test/ntb_tool.c             |  3 +--
>  tools/testing/selftests/ntb/ntb_test.sh |  2 +-
>  8 files changed, 41 insertions(+), 36 deletions(-)
> 
> --
> 2.11.0
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/20180609000819.13883-1-logang%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
