Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C2BC004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 02:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7DB20840
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 02:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUf+3VmH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E7DB20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbeJAJM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 05:12:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44848 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbeJAJM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 05:12:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id g2-v6so8323187pgu.11
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 19:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rPdcmrltulzJkEuEmVXOPPDqv5gYoeLZfgs9OSIgqwA=;
        b=FUf+3VmHmUofAbU/3vTAYBnUIUfpu7RxrsvWIOwIS/aYoN8Z1gyoNPzlI3QYL8+XBt
         BnMfwgE4IUeokD00oucNQfFZF8Q0g2oDG5/abza33JTcPtNXzR04es+4lvI/KQTsjHCF
         4g6QHXTic+1d6Dm3+lh+4IsBDCVgYh7HUvjPe/o1rz45jObmBmKXzoECi6dXIP0n8Asb
         Y4QjxxX/wm9biUmtXCAe8Ke8E4grJ+U2NOc9H6J50uGj+ilpl542GTjhOcraFp6ie4hL
         gd7ji4zQB17hlDruKFgBGU/cxQ81gx+/VG3I3QoumN8MU6Q44JJ++UNMEjIP5DnMAyF7
         oq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rPdcmrltulzJkEuEmVXOPPDqv5gYoeLZfgs9OSIgqwA=;
        b=BaBNYpduhmDiHGXo1OUYBPumXsDjW+rnYjzgjfbvI2+U0tl9OQ9+VX6iPnVQMtecwA
         vhg5utJ464izyA9NnqQMc9tTuZ9C1VB8uOFLpMysqROBQc64xJ/ZZMHZa6dLYXQ7xDRU
         e+4ZucTtG3H2WyttyzhZWcaSwhu3yJg9cAIg8zzTIwXtEsHqksb+3HoaAtKU40OGhQuy
         jItz2oVzw1kT+O7gYyDYDq0rgM0AGfxCbyPmnCQxuOoHQZ67DXa6dkHaOl65xlpONkFq
         1yYBhZJnPr5jRgvrq2EFVuFKiVOuzPh57klGqchZ4P10Nem0vWjH4jy8vk7RAahUPgOU
         H1+Q==
X-Gm-Message-State: ABuFfoiY6ZQ7/Gk6yRdVSsTzjCxYUowEqtLIgJkfrN4w0Gfv/nQsBWds
        WleZwjzINcn1H7RxqfgIdR4=
X-Google-Smtp-Source: ACcGV61rFNQzBxfVja5CgIjGw6VUBxSzrDX0z0W/JBEnP0hneKeW/qf8xWhyNqiBb/7CKvfZGKnRAg==
X-Received: by 2002:a63:c20:: with SMTP id b32-v6mr8355759pgl.400.1538361447102;
        Sun, 30 Sep 2018 19:37:27 -0700 (PDT)
Received: from localhost ([39.7.15.30])
        by smtp.gmail.com with ESMTPSA id d81-v6sm19235958pfj.122.2018.09.30.19.37.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Sep 2018 19:37:25 -0700 (PDT)
Date:   Mon, 1 Oct 2018 11:37:21 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        kbuild test robot <fengguang.wu@intel.com>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
Message-ID: <20181001023721.GA6409@jagdpanzerIV>
References: <49d22738-17ad-410a-be0a-d27d76ba9f37@i-love.sakura.ne.jp>
 <20180914115028.GB20572@tigerII.localdomain>
 <e855cbef-03ff-b4ac-3e06-d2f2f48cfb1f@i-love.sakura.ne.jp>
 <20180914122217.GA518@tigerII.localdomain>
 <a661ed7f-889a-1811-0ada-111cc5185d05@i-love.sakura.ne.jp>
 <7dadfa8c-1f69-ae0f-d747-dbbc9f97c2b6@i-love.sakura.ne.jp>
 <20180928090939.GE1160@jagdpanzerIV>
 <3b378c7d-c613-4a8d-67f8-946fac8ad0b0@i-love.sakura.ne.jp>
 <20180929105151.GA1392@tigerII.localdomain>
 <91efcff8-dc6d-b7b4-9ac8-2f3882289f95@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91efcff8-dc6d-b7b4-9ac8-2f3882289f95@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/29/18 20:15), Tetsuo Handa wrote:
> 
> Because there is no guarantee that memory information is dumped under the
> oom_lock mutex. The oom_lock is held when calling out_of_memory(), and it
> cannot be held when reporting GFP_ATOMIC memory allocation failures.

IOW, static pr_line buffer needs additional synchronization for OOM. Correct?

If we are about to have a list of printk buffers then we probably can
define a list of NR_CPUS cont buffers. And we probably can reuse the
existing struct cont for buffered printk, having 2 different struct-s
for the same thing - struct cont and struct printk_buffer - is not very
cool.

> But I don't want line buffered printk() API to truncate upon out of
> space for line buffered printk() API.

All printk()-s are limited by LOG_LINE_MAX. Buffered printk() is not
special.

	-ss
