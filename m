Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id xlBOE+nIG1uSOwAAmS7hNA
	; Sat, 09 Jun 2018 12:33:19 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 002F86074D; Sat,  9 Jun 2018 12:33:18 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ChB3PFsW"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 19AD2602FC;
	Sat,  9 Jun 2018 12:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 19AD2602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753478AbeFIMdP (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 08:33:15 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:53712 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753465AbeFIMdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 08:33:12 -0400
Received: by mail-it0-f67.google.com with SMTP id a195-v6so5457347itd.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jun 2018 05:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=jW6hgR/lmWQZibF0Io+xybkyN+YdJcUx2KHgybovV9k=;
        b=ChB3PFsWVJXhJNXawx3piDyJ+GeXCPwymBT2j9R58VDyjSTJk87w0THZN5RjVrCSET
         M4QULPPhYiTQ0agCw4g2se3YekcBX3oTJAuGWRw/5jLB7KpLyYDJXsDM4W91sbDMlAZv
         oX2Rzy33CLwcGVCCMZUZWIFCHkrS/HmTv4Fk4Jm/u2pCBdGBq/neWxQMfpVpSt4OpeQt
         l81VlxOwGv0O+WS59YfYk7qrfSVEb4xdCJJqmjsjHFvW+TmtegAEVeBmGm5jAAgYhzdg
         YeXnmLdPsq4K8lI5OZ/gZnd7N1rQBJGo94OhsBBLqsX08EfELvYCMl4OkKxY9ZVtb+jI
         luow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jW6hgR/lmWQZibF0Io+xybkyN+YdJcUx2KHgybovV9k=;
        b=BP4SPbkD9VIKqKJkNKIaW1FIyxsxczKSR6vvyKISW7tPwFnlklERVaNcnaL7Tr/2dt
         kStTkMMr52zU52q2Etq4n9yv9CdBksEk69BqpITD8rciW/oDY7Ayd53+qCLqbOOkyFqD
         KpDwJuR/6yn4xWnbSvgsSGnxSxmhfszUrtqg/hRtQXkEBW4DOwbMpR/8c6JR+3xzrSb/
         VJBvgMJe0z8pp1yCKY0HerjX7r6iR9ncUwnHdVYgcnKKVWbkf/7cpW6CxFVQvaM/BC1C
         nWt0vlXdlBNmyL0mwpyzYHjZ/nMYcLhyfWxWSQ5JDmj3QX4+FVSvqX6qpB8tNjv57amf
         zl4Q==
X-Gm-Message-State: APt69E1Va40HJ0HgGnKruXGUDz2uP5HAsZ7l2PQI78EtoknwVW53TYOG
        ZPzew06ZESVIrz4IoQnavUq3mA==
X-Google-Smtp-Source: ADUXVKLnmn5mdHTtMWs5+3mmq5cf+3rEuzWiGDDhbp5O5GWQccmmrfgDqL4xcwvb+bN05V8vW0DI6Q==
X-Received: by 2002:a24:b611:: with SMTP id g17-v6mr5188348itf.63.1528547591528;
        Sat, 09 Jun 2018 05:33:11 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id 131-v6sm1875602itv.29.2018.06.09.05.33.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Jun 2018 05:33:10 -0700 (PDT)
Subject: Re: mainline boot is broken: KASAN: use-after-free in
 blk_flush_complete_seq
To: Dmitry Vyukov <dvyukov@google.com>, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <CACT4Y+ZmRj61ia-WQBC=M72o=OZWk5LSnzf2qOEuOLHAa4do_A@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <1d8de494-0a52-33f5-4c8d-0ec08cfb101c@kernel.dk>
Date: Sat, 9 Jun 2018 06:33:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZmRj61ia-WQBC=M72o=OZWk5LSnzf2qOEuOLHAa4do_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/18 3:34 AM, Dmitry Vyukov wrote:
> Hi,
> 
> Boot of mainline kernel is currently broken.
> On commit 7d3bf613e99abbd96ac7b90ee3694a246c975021.
> Config:
> https://gist.githubusercontent.com/dvyukov/9f7f1fd9e477efd85b221b3a21036c20/raw/7c56ede0840494b26045976960866f2b265c6f64/gistfile1.txt
> Should have been introduced very recently.

Can you try the below?

> You may need to also patch "umh: fix race condition", because that's
> another boot crasher currently present in tree.

Not sure that that refers to.


diff --git a/block/blk-flush.c b/block/blk-flush.c
index 058abdb50f31..ce41f666de3e 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -169,9 +169,11 @@ static bool blk_flush_complete_seq(struct request *rq,
 	struct request_queue *q = rq->q;
 	struct list_head *pending = &fq->flush_queue[fq->flush_pending_idx];
 	bool queued = false, kicked;
+	unsigned int cmd_flags;
 
 	BUG_ON(rq->flush.seq & seq);
 	rq->flush.seq |= seq;
+	cmd_flags = rq->cmd_flags;
 
 	if (likely(!error))
 		seq = blk_flush_cur_seq(rq);
@@ -212,7 +214,7 @@ static bool blk_flush_complete_seq(struct request *rq,
 		BUG();
 	}
 
-	kicked = blk_kick_flush(q, fq, rq->cmd_flags);
+	kicked = blk_kick_flush(q, fq, cmd_flags);
 	return kicked | queued;
 }
 

-- 
Jens Axboe
