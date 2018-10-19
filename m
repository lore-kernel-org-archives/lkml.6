Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387C7C67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED88121476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrJoASfw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED88121476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbeJSIHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 04:07:34 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34356 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbeJSIHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 04:07:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id f78-v6so9867754pfe.1;
        Thu, 18 Oct 2018 17:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GA8rT7XlOGh1smDGBnU2qZl/5BOoj6rKb6o9SbzHd90=;
        b=HrJoASfw6t0k7sfRBxizRvvtefWPnbgkz1ioriPC0kU0uB5KZPSnBjUueUTJCpfpEV
         UKyCWxW++HFumbmV1u+LHBoHd99dPfV0xFypHal7a6v29mvwN1FSTuFo2mkvjy2jSaAS
         3vGMcL8p0SepA49dQLQIjk2zkpZb7XLnCoas1LU3xg0OZCquRHttNH10Bk6iTIq2bRtO
         3D8Udc13XDmPlscFHyD1/Gc49hUw89hoVEspu/MVzvszBRT3BwrqV4sYfgzdE3kllATw
         dE9+kCHOnSXuRhkv7wnwVmvq9qZgb2VRtOr9UzZwvFurlgZU8iwosGSLP4VBo3SBv0F8
         lBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GA8rT7XlOGh1smDGBnU2qZl/5BOoj6rKb6o9SbzHd90=;
        b=b5B2Rlfm795bZGL2yDLVy6j4/wAL4yRLhjR1gW07gCAJqR+y2brW468akoYbvuWCUO
         D1xj7urTF9zD7rNOBovOoIJFXuIyt6zXWHB9FxjPv5WQrnzY628WhTbvAhV2UKgIJoX6
         LeLxCKG8fRZfqVOWcm9O2eqEd5WXDjm3+wQiviAeiWcZ3UOn9D3obY+hk6AeP2DlNOZi
         trTSFAnZ8vP2s3NaCS7tFQ+V+MQSfKYBgGpf+59/zZMZYkSemBXsFUocvMnlGj4xjjaL
         LGJgBDCDcoaNjvOeNBIAIRizo7u7jLsDyXo1jDLQvPNn9Ukzz+vCclTMpBtrvqEMjRRY
         Q0xA==
X-Gm-Message-State: ABuFfogA9tIKxLIgGkmxmXNMWAO5moEav0+4yAheK1vVS13B+FA0urpZ
        QD9dQL4QPFG1BZf/0o1Cdpnb2F6X
X-Google-Smtp-Source: ACcGV60hXi3YXa0XDtM2bX+LoFIeXyfVv8TBc154xtORY5sypuk8oHMAk9f2Pi58tp1jZ/TMb1UUPA==
X-Received: by 2002:a63:924e:: with SMTP id s14-v6mr29756624pgn.141.1539907447942;
        Thu, 18 Oct 2018 17:04:07 -0700 (PDT)
Received: from localhost ([110.70.52.202])
        by smtp.gmail.com with ESMTPSA id 130-v6sm21222667pfz.174.2018.10.18.17.04.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 17:04:06 -0700 (PDT)
Date:   Fri, 19 Oct 2018 09:04:03 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Calvin Owens <calvinowens@fb.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/3] printk: Introduce per-console loglevel setting
Message-ID: <20181019000403.GB877@jagdpanzerIV>
References: <08c1dc1a96afd6b6aecc5ff3c7c0e62c36670893.1506644730.git.calvinowens@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08c1dc1a96afd6b6aecc5ff3c7c0e62c36670893.1506644730.git.calvinowens@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/28/17 17:43), Calvin Owens wrote:
> Not all consoles are created equal: depending on the actual hardware,
> the latency of a printk() call can vary dramatically. The worst examples
> are serial consoles, where it can spin for tens of milliseconds banging
> the UART to emit a message, which can cause application-level problems
> when the kernel spews onto the console.
> 
> At Facebook we use netconsole to monitor our fleet, but we still have
> serial consoles attached on each host for live debugging, and the latter
> has caused problems. An obvious solution is to disable the kernel
> console output to ttyS0, but this makes live debugging frustrating,
> since crashes become silent and opaque to the ttyS0 user. Enabling it on
> the fly when needed isn't feasible, since boxes you need to debug via
> serial are likely to be borked in ways that make this impossible.
> 
> That puts us between a rock and a hard place: we'd love to set
> kernel.printk to KERN_INFO and get all the logs. But while netconsole is
> fast enough to permit that without perturbing userspace, ttyS0 is not,
> and we're forced to limit console logging to KERN_WARNING and higher.
> 
> This patch introduces a new per-console loglevel setting, and changes
> console_unlock() to use max(global_level, per_console_level) when
> deciding whether or not to emit a given log message.
> 
> This lets us have our cake and eat it too: instead of being forced to
> limit all consoles verbosity based on the speed of the slowest one, we
> can "promote" the faster console while still using a conservative system
> loglevel setting to avoid disturbing applications.

Hi Calvin,

Do you have time to address the review feedback and re-spin v2?

	-ss
