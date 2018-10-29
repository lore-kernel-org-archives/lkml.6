Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6972C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 22:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735112084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 22:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="n7Xr2MHL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 735112084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbeJ3H3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 03:29:53 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:33610 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbeJ3H3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 03:29:53 -0400
Received: by mail-pf1-f171.google.com with SMTP id a15-v6so4768365pfn.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 15:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GCDL5HjfMRA9Z+YoLFhDcK8284h7+Eps8+wZFS6kUO4=;
        b=n7Xr2MHLngQgRv10jnQHb9fkhPso4Am21zeU97jetYTcw13bAtoRq8ZBvdLALlw9Un
         0vRvPLrjaN1yzmiq2XqJ8JlGY4T3sF22mr728k+wlo14xn4vScVj7C2KXy17V/SLO8Ep
         NFfnMH4OcaC46frJ6H6YiJPX+OXxDDJUXlHWsTcPQnof+0rMqcWnDg7NQzmlomsaMYOn
         5VPMj6Fh4h05TQdoYNSFcOMDYwrFNU0cd8EMsXCWO7NStSrWpcrahk2Yczu4XAnoifsV
         5JeR0phyKqiD93hFwvZZEVCBPqbNqP36GhIX710ZmU7FyUjKkvYYijj0iKxwBx1kYRHS
         wWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GCDL5HjfMRA9Z+YoLFhDcK8284h7+Eps8+wZFS6kUO4=;
        b=trxIN9ZIrqYz5CwG63ADkxjD+CkpS6SexG6sAF+3CTuzz3HPtxyIYqt4SOUWYHMa+i
         yyia5hbCW4v8Fpv1tLl+cIQJ+15gFgBFEylLmFX8TPifbkFkSYW9MCS7L3QXpgJCatw+
         snJvnH+748RSL289YbXTGGYh56HjRCGpkusfk4wfnJHwFaIXU1PlsiDoxgiMp+ZUWXeM
         BMaj1nt/B7UbRArsEx6wzv8akkQIgGpeJHbesSXDAQ6FwW/l0/nK4s8Hfo/dISOyY2Uc
         lAkiD3LE4w0dIRkrRcljrbWJzfONuRD6YOFfY0q7IyPR7CtWbMdahAlSfDFCuVXJjKK1
         ObLQ==
X-Gm-Message-State: AGRZ1gLaMdX/7eGpfu/wS1RPPyk9X4QDb40Pw+a9Hi/Ct5m46Gsp6RxR
        fNL6derpXRtFcvkf2lxEs2APblb8HjU=
X-Google-Smtp-Source: AJdET5eNi0OmP3ZSKHGvwlv7fvaTCDpeh8HwdDkY3DBKcipHarV9DqN7yWVAsyXsWhcohEgr5IfXZA==
X-Received: by 2002:a63:eb0e:: with SMTP id t14mr10719994pgh.445.1540852748541;
        Mon, 29 Oct 2018 15:39:08 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id a19-v6sm4723196pfi.138.2018.10.29.15.39.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 15:39:07 -0700 (PDT)
Subject: Re: [PATCH] Add cmd_flags to print_req_error
To:     Balbir Singh <sblbir@amazon.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181029005732.21040-1-sblbir@amazon.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <543de76a-e43a-9f4d-c781-e3251ea0e749@kernel.dk>
Date:   Mon, 29 Oct 2018 16:39:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181029005732.21040-1-sblbir@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/18 6:57 PM, Balbir Singh wrote:
> I ran into a bug where after hibernation due to incompatible
> backends, the block driver returned BLK_STS_NOTSUPP, with the
> current message it's hard to find out what the command flags
> were. Adding req->cmd_flags help make the problem easier to
> diagnose.

I recently did the same thing to debug something, so I like
this change. One comment:

> +	printk_ratelimited(KERN_ERR "%s: %s error, dev %s, sector %llu flags %llx\n",
> +				__func__, blk_errors[idx].name,
> +				req->rq_disk ?  req->rq_disk->disk_name : "?",
> +				(unsigned long long)blk_rq_pos(req),
> +				(unsigned long long)req->cmd_flags);

Why are you casting it to unsigned long long for printing? A simple
%x should suffice, no cast necessary.

-- 
Jens Axboe

