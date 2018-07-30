Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1322FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA4020857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koz4/Yiq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA4020857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbeG3Sx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:53:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44467 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbeG3SxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:53:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id r16-v6so13708585wrt.11;
        Mon, 30 Jul 2018 10:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IvEt2JKf40PFQSMU0dsVG4d+4kUQcpZbwgGsBaLb1aA=;
        b=koz4/YiqUc8SJnxjVICgLxI5JXa2gMHM1zPjs51Lw0nILjKnUT5ZNAiC06P8AAYpEX
         sQ1LVb/ftUgIQb+N89togKdxptBuGyaM0gpiLOot2meZAanbm4YgVYFTFTkSqheb34Ds
         bxSN7Ys+OOfcBHckcRQnofL9QxcY1jX8Mkke2iY1pSCw2OzePiot3dZjvIngJZMLKW5d
         8y0Y42j69P3HOi5lgeo0loyf4G8+ko5NR0CrB3sbaPgldcgNO4Yux5lHB7UEmIuzU3Ou
         W7+fkNo9ZxY7UN6ozjyB8Yg4pmZTKwCC2ZQw4qGh9V+iV9H0APjsDIaNs+z+xmAzVUZx
         ej7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=IvEt2JKf40PFQSMU0dsVG4d+4kUQcpZbwgGsBaLb1aA=;
        b=t/T5UCwQgbaDVPczZSEclBx4OaQndPOALWhAscWKRxXMsNsL1NPQ0j+ziOZiQ/BZ9F
         sqeoB30yqxr7Lifm97mI5W0A7r+o5a3Kq9+ie67W8hdPWdM3q3EzS8PYrykKPWKYU1z1
         g5oeQ4UsqEFSNlOTDxtzyAhjIHnJhcvNZQT+7RL2EmW8I7aCL5uu81JXa+THS7JqROg2
         QnAn43jWABbk6vBW+BJ4mf9obne1dNM8GVCruiAZphgi6f3smtApBqPIYXwWQ/eLdclI
         bRivzTtFLQJJ7tfnPPj3kKHSyrGZtoEbqcOcmmZygc3temFve0xyMuGGIncw2GVQhbQ5
         lBvg==
X-Gm-Message-State: AOUpUlH99vxmEft7cPAHJSxAMqfXrlJrUQ8AGAjZ7qGQLXdpIcqDve+k
        1GNenROrJHZFLDhF1OP6lYTbDryy
X-Google-Smtp-Source: AAOMgpfXfKgNR69DEG+zaEeWsFo7sMoGGwI0XOY4RybveUi4Tt+WtgyCnnkvTkRIu1CFrK+87SZOVA==
X-Received: by 2002:adf:93c3:: with SMTP id 61-v6mr17906493wrp.18.1532971046637;
        Mon, 30 Jul 2018 10:17:26 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id b6-v6sm17005501wru.66.2018.07.30.10.17.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 10:17:25 -0700 (PDT)
Date:   Mon, 30 Jul 2018 19:17:23 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     tglx@linutronix.de, jsperbeck@google.com,
        linux-kernel@vger.kernel.org, wsa@the-dreams.de, dave@stgolabs.net,
        dpf@google.com, pombredanne@nexb.com, deepadinamani@google.com,
        peterz@infradead.org, gregkh@linuxfoundation.org,
        will.deacon@arm.com, torvalds@linux-foundation.org, hpa@zytor.com,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:locking/urgent] i2c/mux, locking/core: Annotate the nested
 rt_mutex usage
Message-ID: <20180730171723.GA31541@gmail.com>
References: <20180720083914.1950-3-peda@axentia.se>
 <tip-7b94ea50514d1a0dc94f02723b603c27bc0ea597@git.kernel.org>
 <0bb2d26f-3d1a-fcb8-8fc4-9123a2d5a30d@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bb2d26f-3d1a-fcb8-8fc4-9123a2d5a30d@axentia.se>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Rosin <peda@axentia.se> wrote:

> On 2018-07-25 16:19, tip-bot for Peter Rosin wrote:
> > Commit-ID:  7b94ea50514d1a0dc94f02723b603c27bc0ea597
> > Gitweb:     https://git.kernel.org/tip/7b94ea50514d1a0dc94f02723b603c27bc0ea597
> > Author:     Peter Rosin <peda@axentia.se>
> > AuthorDate: Fri, 20 Jul 2018 10:39:14 +0200
> > Committer:  Ingo Molnar <mingo@kernel.org>
> > CommitDate: Wed, 25 Jul 2018 11:22:20 +0200
> > 
> > i2c/mux, locking/core: Annotate the nested rt_mutex usage
> 
> Hi!
> 
> I'm a bit curious as to why the subject line was changed on this patch?
> 
> (it was "[PATCH v4 2/2] i2c: mux: annotate the nested rt_mutex usage")
> 
> I thought the subject as I wrote it was just perfect. Was it so bad that it
> had to be edited?

It wasn't "bad", I improved it to signal that it has a new locking API dependency,
in particular that's it's dependent on this commit:

  62cedf3e60af: locking/rtmutex: Allow specifying a subclass for nested locking

This also clarified it why this i2c commit is in locking/urgent.

Thanks,

	Ingo
