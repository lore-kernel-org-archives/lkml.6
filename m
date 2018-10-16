Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE5DC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBFEB20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJOcElll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBFEB20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbeJPQBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 12:01:32 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:33068 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbeJPQBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 12:01:32 -0400
Received: by mail-pg1-f178.google.com with SMTP id y18-v6so10487630pge.0;
        Tue, 16 Oct 2018 01:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K9ErhGaOwlvn70EuZYOINk0AgswN6DoWy2Wi43altDo=;
        b=PJOcElllHaiNtG2fa7U3FymT0mZpxvulSaal6ejNc1zOJRqPRtmb4SjuO/cxyxqtGN
         nPRYUiHzS1GdyZuyieqsEW/wjrfgkMC4wv34oqBRWBTiYyQz9uNSPtCoprwOIlcv9yHg
         fMJF+5IgQmpE437ERlJ8EZPLTOvuhLKPM22pIAxf4RYMoTx+EVWqwuDGHXv2viucbWV/
         bVy3A55UsoJ2P+otVKpy0XTMKgXj3ZM4FnFFvXBDiT6/qLvaMGhgE7Lhd+VD94rZC7du
         E+g9Yq6gIZXwL8UcK6GueCCcCwTna5U4suFZVQsVwSsGJSUNx14DoYmQqozH4V/kBm24
         uNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K9ErhGaOwlvn70EuZYOINk0AgswN6DoWy2Wi43altDo=;
        b=h73FhFvcmbfbG389e6LuWoay2BDYkC7fH8EjBUGgZKk6DMoY8SL19L6NzBD3ivoZQt
         ay0zNk8TiDkHMNPf20eDiSqR936QGF+4uRpIgy0FMFohnV54sG7+mAYaI9tGC7YbrgId
         7WXwzIR50hJfVhxXhaj0srQD+FNYcCZnOpm+nh2G1Aj4jaf5XefN4CeV5vDvkt+dvgZJ
         6GjrpwKSlqB/UQkdFb51KlL/n1fNjm8SYAJAJk13pYt23Xir3gCXqtfjjQlMXNFrUIDM
         VPVuXZQlrqgOtH7BAqDhlMb+ri2BSpAuxSq+A2uRtKR2t+c202aJ7ieia8eci9UV53Z5
         eDIg==
X-Gm-Message-State: ABuFfojzxxYSS8TeCaVjFBYUGlZVprUbiJu5piFT/8p/K9SyYF+y2i07
        ujMv+17O0+6QgI9bJQJE6qg=
X-Google-Smtp-Source: ACcGV63UgF5hfj/WL4WzoEi3DZ6VmypXTUnlBi0dVrJ8kht7v36Hin55iTOP7i7DC1cdBAedmEI3VA==
X-Received: by 2002:a65:655a:: with SMTP id a26-v6mr19186060pgw.389.1539677538352;
        Tue, 16 Oct 2018 01:12:18 -0700 (PDT)
Received: from localhost ([175.223.10.117])
        by smtp.gmail.com with ESMTPSA id n80-v6sm21170256pfh.166.2018.10.16.01.12.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 01:12:17 -0700 (PDT)
Date:   Tue, 16 Oct 2018 17:12:13 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCHv2 0/4] less deadlock prone serial consoles
Message-ID: <20181016081213.GA32747@jagdpanzerIV>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
 <20181016072328.GA4030@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016072328.GA4030@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/16/18 09:23), Peter Zijlstra wrote:
> On Tue, Oct 16, 2018 at 02:04:24PM +0900, Sergey Senozhatsky wrote:
> > 	Hello,
> > 
> > 
> > 	RFC
> > 
> > 
> > 	The patch set reduces the number of ways serial consoles
> > can deadlock the system, including the recently reported deadlock
> > in panic().
> 
> That's what I use early_printk for... :-)

I've been waiting for this comment ;-)

	-ss
