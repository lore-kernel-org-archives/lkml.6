Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3B7C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BDE0222C0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550042003;
	bh=Rf6u2X942oLf74xbpwGidDOG5s5nL0ORO3rLF/ApzbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XxXDBcNeWWGRSX2lzvTo7Yrfd7tTxZbvR9jVVEtVo6JM6TwYkxaBSMwykdYvOsvxH
	 qaEAYIuWBMU3GseZhSpaC5M/EC5MUo4OqWNlpW00ZzBUgnH9yKTMuGW2AMdnjVuw5d
	 PJciXrd+zR6zo3pROkJcMfn1zmMHk9Y9LFUn4E1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389126AbfBMHNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:13:21 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:36756 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387769AbfBMHNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:13:21 -0500
Received: by mail-wm1-f45.google.com with SMTP id j125so1185427wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 23:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tJadvOOpW0XKhtnMY260xrtOkruRY0lNhP4zR9JalGo=;
        b=s1YBfNyYntbh0K9mFj9GIi8rUPUrxhEq9Td3u1fdgJjll05d/rrPLGftZtureb/wCl
         MKM1WXnA5seQOLCur4dHxNUWNMt5VGUxwOT6zv6Q2QjGAAuxX4YgCEA7+lDvk8AQk/sI
         OwGCvTu00zXWiH4ccv7wgGhksMwHXFFhIbcsNHKJQ4B5ahtHcWKiwDOZHkJ+qXBcPnMF
         Dc5cu2y2fBt6uAWlEfe058MqBEYBzDfu9Agp/FirxeBO9r4waWSnkPMdR1o2BWLvKFqF
         xVCyHmAa3U2FWaCtiwn6FDVimlJOI5s1LuowtY7hapxOdq2mlbE7ssLTF+4zRwYv+VL3
         Cp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tJadvOOpW0XKhtnMY260xrtOkruRY0lNhP4zR9JalGo=;
        b=C/SNV0CPdvE9q0GF2btK+DqWW2iGrtt2CbcrCGAKMSeXP+zJYUyW0SpIuzXv+YgZXW
         4hZ4NySSbsnR14BcdT+AQfDPCFUyIRissIJlZRxi2huFEFDHgEM8I+hAPbFr94mImTiM
         n/h7RL1+MEzMnzPThxoIwkk+crn3v3PVhMzZFPAOfd/Jx972cqYUyXjZ3W/b5wdkKbzJ
         jQhge+AnvQ39IWPE9qXrZkUeOwP/iz1mVJGamPSHNnexTNvzFnQb7jJMH2LJEYZDgCy3
         F7XY3JoRQc/Lstd/0WntWHVEArC3OAj9q9e25gcU2c84AYGQIGoDLc0L9n1Dnab8Evgq
         0tgg==
X-Gm-Message-State: AHQUAubpwuWAVaVuWVewCzwQxPM2tcU8JJCu5G3eQ70FOgv8peJDMhQh
        dMsPbRbVeynAQUckxIQYonPvl+FW
X-Google-Smtp-Source: AHgI3IajRN7xmJ+76UVFWLYdzb7gQ9cmsYFf74Jplq+pulfPsdHD3HQQpqbZwhtRzSDxSqfeSy1BPg==
X-Received: by 2002:a1c:a6c9:: with SMTP id p192mr2024424wme.58.1550041999422;
        Tue, 12 Feb 2019 23:13:19 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id m4sm5296649wmi.3.2019.02.12.23.13.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 23:13:18 -0800 (PST)
Date:   Wed, 13 Feb 2019 08:13:16 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH -tip v3 05/10] kprobes: Search non-suffixed symbol in
 blacklist
Message-ID: <20190213071316.GA121801@gmail.com>
References: <154998785011.31052.1475728497912659748.stgit@devbox>
 <154998799234.31052.6136378903570418008.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154998799234.31052.6136378903570418008.stgit@devbox>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Newer gcc can generate some different instances of a function
> with suffixed symbols if the function is optimized and only
> has a part of that. (e.g. .constprop, .part etc.)
> 
> In this case, it is not enough to check the entry of kprobe
> blacklist because it only records non-suffixed symbol address.
> 
> To fix this issue, search non-suffixed symbol in blacklist if
> given address is within a symbol which has a suffix.
> 
> Note that this can cause false positive cases if a kprobe-safe
> function is optimized to suffixed instance and has same name
> symbol which is blacklisted.
> But I would like to chose a fail-safe design for this issue.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Why did you not add Steven's Reviewed-by tag?

Thanks,

	Ingo
