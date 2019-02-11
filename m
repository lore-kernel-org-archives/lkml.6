Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93743C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D62A222AC
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549893063;
	bh=irJEMI34d+DDeIUnQE3jZfUAzy8S7XQTsuN9qFZX3rA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wf9iLfhvPCukgG5U9pA93zFVhIjgcFuDRQnwQLL2vTZi9z6bAqj0Ci0y54WAJDkj6
	 HM9Qoo2sXmnDzwZPWJUr602nLH6akpg0+GCOdPMHnfHx5NoBApo/ka9EEU2FqCaCLF
	 yT7ZRaRkrFhRcoCZsZjWCw/61UF09oB5yzcCEyE8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbfBKNvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:51:01 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34805 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbfBKNvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:51:01 -0500
Received: by mail-wm1-f68.google.com with SMTP id y185so14634375wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 05:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tyuBF5omOjOWP2Wg1s+y5HPB2qWLu+Z4sR2RDbDp6C0=;
        b=E/qjRiFxxjEFV0iY483YKbTXkYap9oCjJnefj58oZ5S4/fLnuvJalatMMTzmq2VTCi
         vNppwIvF2FstC1LWaLxc+GFa+YVR5cA4FQn42SWFc/gizkA4vwB9oe3pUvDOakuB/CeZ
         05DC5EwMxAppcNTBzz/gSihGVy7DRQSDXkNdeuwzTtnmCJNeVKPf2n4sD+wLIR7LhBBZ
         DUL/Rsu6sbM5wNp2DoC8EPEDpYTc/O0W+4xGPnZz7lF7ovBrPj89kJN1ExnFWVeVB102
         XwVQ+rq2uvRHHQrp1gPpgltNspTU3e3W1fJ1K32X4PZuvESO66aeuMFDBYRkOBZzQRVR
         rhhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tyuBF5omOjOWP2Wg1s+y5HPB2qWLu+Z4sR2RDbDp6C0=;
        b=bMB+buH/s0AbgbdoRxZoS+oLxVwpl9uYR14iXTwJzIR+65CGZw3TLpw6CoW3/F8Jsh
         Wc9sWE/pY3+PPbRFzrOLDroSqhrAj2vbUh3PssZW5viVKAZM1FaC26gm21CKvTGr8ddV
         YjOIWZblk9JREJxcbI7qT/DnLN1QicJBgUQz4LymQnA7pFhlcq8V3EcSTmB/bu85EK8D
         sFP4DkFUkw3CTpHkmaG6IKjNvlbu5paXw8atRHD2PNVIvXQzwWI6+tub9SVa5aRtm4uT
         QAnNQmgDSzKQyXt+eJASUO3vk3uPatnVf7bC2Kx/3ltxrSzNtf7bfbPpu+SZ9/AS5Zd+
         0EAg==
X-Gm-Message-State: AHQUAuZcoHok6ia60j7suVzPg5YIthpRX0T4KZocGApHXnHr7dM7w4P1
        bCr4B1RaFAAj7KULU+4Mz8U=
X-Google-Smtp-Source: AHgI3IZ5OtgUzJ2QSzjS9QRsKa8dPUexXV8yeFeGr4ImpwuEdK0WRAUNskx/H9bsNvvAXMO97IDwcQ==
X-Received: by 2002:a1c:7016:: with SMTP id l22mr10137552wmc.70.1549893059421;
        Mon, 11 Feb 2019 05:50:59 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id l12sm6865936wrt.87.2019.02.11.05.50.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 05:50:58 -0800 (PST)
Date:   Mon, 11 Feb 2019 14:50:56 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>
Subject: Re: [PATCH v2 0/9] kprobes: Fix and improve blacklist symbols
Message-ID: <20190211135056.GA36142@gmail.com>
References: <154725993986.18060.2759150647140353514.stgit@devbox>
 <20190114111810.79016d7d@gandalf.local.home>
 <20190201223153.0ccdf06378ac953eb2651ea9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201223153.0ccdf06378ac953eb2651ea9@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi Ingo,
> 
> Can I ask you to pick this series and Andrea's patch?
> Or would I better update this series on the latest tip/master?

Yeah, an updated series with Andrea's patch included, against latest 
-tip, would be nice.

Thanks!

	Ingo
