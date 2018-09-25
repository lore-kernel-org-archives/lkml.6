Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888EAC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BCF7208D9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MigxsZ8u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BCF7208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbeIYTIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 15:08:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52274 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728881AbeIYTIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 15:08:31 -0400
Received: by mail-wm1-f68.google.com with SMTP id l7-v6so8522905wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 06:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IcaaMvsHdGR2TkmohTvF009GqYanXfu3ZOjBBsoCgL0=;
        b=MigxsZ8uoK9j521r7fKjv86eam3idWcdLJm6fxyJDkxDUoH31vr3CiaKQgPzIHephR
         vPeUh4TS8JVguuM7qE+lWIy6b5ilqH7RNjJW8SGDkLo9lyqpHS7p6Et/uO3KLcyC2lyV
         8ahaQMJEyXm0HjtOynvyvVaELmXhKfp8LBvkXeFntiqpzqJlA+HNn6L/UrwNcQ9tJUmP
         kuI91L95ZSSPjIDxtEVma7rfcb2k8LJmnCtrGuXAn7XB6wPHPK2vOs1/sTSJ0Xj+Unbp
         wxp/URUI4JNZFBWzZbThhThkRUOfC/UP/Kb4qIx+a+UjAG58RS8ZFoxWqmZLr82CTg9l
         bsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IcaaMvsHdGR2TkmohTvF009GqYanXfu3ZOjBBsoCgL0=;
        b=JlCQNGokJZO+Kpj4K3xZHBaoyM/v1c7HYoy1dBezQ0Hadobah4AJou6rcP9jN1D27B
         biYhrAY1dtgfGvuwq4yk+cS0B03hsLgt2ayYt/FrDJIZKfpQWles5j/9UGrMYI34SUh+
         xAJT8aEqw4/fth23eq9acguas3+GHCLSNB7BTe6TVCTEyIjeyAa0EpyDdHzZA+Rl1jjY
         Q/G8sz2W5VdFDUgkRRbLWQRRIN41C0d3rwzuslmMBxtVrrPcOq0m3pPG3IeyOKHGo+ho
         aqSs53zsVFhXWFRsLPnhnYyd3nju16WSnX/d7xzptxVblJg3z5tlbDspOrPhREyDIU8P
         jrDA==
X-Gm-Message-State: ABuFfoisJxdJN81NhbxoHioh06VG1ntzUvpBPJKoNHM5O4bVb0zbMgi4
        b0BqS9rfsI8EHpF966785lY=
X-Google-Smtp-Source: ACcGV62j3IQsAKGWUOddSnm9VV4/SMjmipwVOJzY8WENAQwysuHwiYxqGzY9QCAvqkz/YTTnXQBzTQ==
X-Received: by 2002:a1c:5e08:: with SMTP id s8-v6mr637500wmb.88.1537880462293;
        Tue, 25 Sep 2018 06:01:02 -0700 (PDT)
Received: from localhost ([178.121.95.75])
        by smtp.gmail.com with ESMTPSA id g2-v6sm1996925wmh.16.2018.09.25.06.01.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 06:01:01 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Tue, 25 Sep 2018 22:00:57 +0900
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] printk: CON_PRINTBUFFER console registration is a bit
 racy
Message-ID: <20180925130057.GA601@tigerII.localdomain>
References: <20180914023428.814-1-sergey.senozhatsky@gmail.com>
 <20180914085934.m2bgixltdzpfh62o@pathway.suse.cz>
 <20180914111953.GA20572@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914111953.GA20572@tigerII.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/14/18 20:19), Sergey Senozhatsky wrote:
> On (09/14/18 10:59), Petr Mladek wrote:
> > 
> > Well, I am not sure if it is worth the code complexity.
> >
> 
> Well, I don't think we need to bother that much here. Besides,
> exclusive_console is cleared under logbuf_lock with preemption
> disabled now. So we set it under logbuf_lock and !irq and we
> clear it under logbuf_lock and !irq. Looks quite OK to me.

Petr, Steven,
any opinions? The patch is rather trivial.

	-ss
