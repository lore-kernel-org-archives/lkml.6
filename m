Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07730ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 23:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB2BC20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 23:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="upwuGWDS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB2BC20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbeGXARf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 20:17:35 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38221 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbeGXARf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 20:17:35 -0400
Received: by mail-pl0-f65.google.com with SMTP id b1-v6so859775pls.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 16:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=zBPWpeH57F6/tjsSw+QBzTw+lzqan3p3N7Xzh6Ivt7I=;
        b=upwuGWDSjSN0Lry0GjvIWMMpVaJY1EtE0YFgKHpUnnZSMN0O+iTsZ+k14QUrBgrCdS
         RbAdPW4GJqnQtgVQrO5hRICQgMzSTcibrSUVIdqeJPCh2Ij2lg7NFk+ImHkW9I+gjKou
         v/IZCpQJXs9RUQ0bqUbM1Tk1pQvC7wwgyEAsNooQTn1iEnKZd0ijtKIPz+EH0+W9WuAx
         4jPCvSqHCxfyNlG2OH8WNIys3D/aXA+NyiQT6cKU/vK+DEZxPWevUPLZnu6mXtdcR8MN
         2mH7JIGfGExZeJ/0LJ85B3jBLtZNsCUJb7kiaaPvoZcvW8VPCzBG7P6w8GJdy53v5yP0
         3iuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=zBPWpeH57F6/tjsSw+QBzTw+lzqan3p3N7Xzh6Ivt7I=;
        b=aWV8ParG9UCX76AQSlu8/1mlUpBaQWZh3XxcbIX+HUEy9ZAuAV3838y/unOmYqMdjM
         SBwAdOPojKK6pug9rN7PeFtohnjkRildT2GS03RD+9F8EHByZQuJF6SXKJ6zfikSTjt2
         5m7++nFoxSmGW2I5/6RMG9tFtmN21PCs6J45kEnqBOGiq97CeVifyYA4pjoO0UvYwy3H
         gopAnuhRIk0jobao7SCw7DkWPqCiyYvGFYhUrzChNvFdsebFGHCNIIosN9zYxHQWXxa5
         Cp2vjyWu26HKpuYu6XZim3uinfu9YDOJ2q3vHZ9T33WWVjkXKCeoHDe2GTP/zd+/bPGX
         gdQw==
X-Gm-Message-State: AOUpUlHXfjNuxMn8Mfp3C1GSQkFCf8a1WxrPklaBWcGvoaEnQNW8IvuY
        x2YWMrddNDaW1kS55X3cVpUw8g==
X-Google-Smtp-Source: AAOMgpfUbDCVwveHSbydOkA+ZfbM/NqP3oxA/1TFx8ZmlRIh1GRhAEaMC8tSWwCYUZ2duLGqA60G7g==
X-Received: by 2002:a17:902:1:: with SMTP id 1-v6mr14697853pla.167.1532387644332;
        Mon, 23 Jul 2018 16:14:04 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id x66-v6sm21225862pff.123.2018.07.23.16.14.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 16:14:03 -0700 (PDT)
Date:   Mon, 23 Jul 2018 16:14:02 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Yang Shi <yang.shi@linux.alibaba.com>
cc:     "Kirill A. Shutemov" <kirill@shutemov.name>, hughd@google.com,
        aaron.lu@intel.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: thp: remove use_zero_page sysfs knob
In-Reply-To: <91caed46-6437-a137-0dbc-dadd113f8d58@linux.alibaba.com>
Message-ID: <alpine.DEB.2.21.1807231610260.196032@chino.kir.corp.google.com>
References: <1532110430-115278-1-git-send-email-yang.shi@linux.alibaba.com> <20180720210626.5bnyddmn4avp2l3x@kshutemo-mobl1> <3118b646-681e-a2aa-dc7b-71d4821fa50f@linux.alibaba.com> <alpine.DEB.2.21.1807231329080.105582@chino.kir.corp.google.com>
 <91caed46-6437-a137-0dbc-dadd113f8d58@linux.alibaba.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jul 2018, Yang Shi wrote:

> > > I agree to keep it for a while to let that security bug cool down,
> > > however, if
> > > there is no user anymore, it sounds pointless to still keep a dead knob.
> > > 
> > It's not a dead knob.  We use it, and for reasons other than
> > CVE-2017-1000405.  To mitigate the cost of constantly compacting memory to
> > allocate it after it has been freed due to memry pressure, we can either
> > continue to disable it, allow it to be persistently available, or use a
> > new value for use_zero_page to specify it should be persistently
> > available.
> 
> My understanding is the cost of memory compaction is *not* unique for huge
> zero page, right? It is expected when memory pressure is met, even though huge
> zero page is disabled.
> 

It's caused by fragmentation, not necessarily memory pressure.  We've 
disabled it because compacting for tens of thousands of huge zero pages in 
the background has a noticeable impact on cpu.  Additionally, if the hzp 
cannot be allocated at runtime it increases the rss of applications that 
map it, making it unpredictable.  Making it persistent, as I've been 
suggesting, fixes these issues.
