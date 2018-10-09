Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157E8C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B77213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpBj9+LR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97B77213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbeJIN14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 09:27:56 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:39244 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeJIN14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 09:27:56 -0400
Received: by mail-wr1-f41.google.com with SMTP id 61-v6so392496wrb.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 23:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8bdlqv+fk+B9p2/xRp1EpZH62eATHLa+d39zf0LLb1c=;
        b=ZpBj9+LRib1+bJvhep7VRjHopB0dUksl7EqS7aakIpnQn8Ex8GY5Ul1NgJ4Rl6+uPc
         M60ZudX+AVmtECWNl6YvoPBLOP8jQ8dLmc3mOGuRiLkeCa09Ck683pjqiiUfw2dRvq0V
         6OEYP0c7TLU4N47voTO4NpM1onyWIFbBzyVMqOvXHJ6Rduyq3GNhi8NrwF7O+86jqHGc
         lBGSvOdssusXxesjA4RQVa2eOurB57Z075clQj89JHfxe/Yc+TPpUUf5XUO4Ssr8D5ks
         qKNyiKrj8c6rXk2Op2cMyli49yFyByu/9nk7wN4h9ATPC38/2zgcv40r4AW0494NA3v9
         2/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8bdlqv+fk+B9p2/xRp1EpZH62eATHLa+d39zf0LLb1c=;
        b=FUAZda0YJ0xMByT9Pi174CV4A93yCG5GF5692kjH+pq0dUWFZIjIfD6I9nElGwbpBN
         1ieNFs7gLeKQzIwAXDLkz0ElhygwZWTUH56N1HzN5k81kOpyYfOL3kiTvYlQ2VRC8vX4
         4JYEOiFa4XdcZHJyDoR2fA97658M5GaRd97gYrDSA9tzfMSpMlipihXpwl1lZFAh73BU
         GD5Ani3Mvy1+Wb+j5EbV+BVzTVLHd6REEs8Wsp7GqN8d6Ecu8J9zkpMmHq1KntnJMgJI
         59l9ZCATAWzqqiNmp6FHJ1/B8ZOU5SZ+BkVSDIRRlq1wLrYvZpvAW3u2qQnKVtjCuX6i
         qTlw==
X-Gm-Message-State: ABuFfogaXlCUXcU9sS+57kKZyt44I3jNqIfvE/ictmGvbg6O/vgbVm8n
        hdNmB+/IkpzCCKjmuhl+UgU=
X-Google-Smtp-Source: ACcGV634Ikc7QnZG8w8h/Rdo/NdUlHDaXBaH4PBlDhSN1Yhdx9gPaB+tN3qv2FYwk22vb2ISCK0rcw==
X-Received: by 2002:adf:b109:: with SMTP id l9-v6mr18090761wra.101.1539065557699;
        Mon, 08 Oct 2018 23:12:37 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 90-v6sm24217542wrg.86.2018.10.08.23.12.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 23:12:36 -0700 (PDT)
Date:   Tue, 9 Oct 2018 08:12:34 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: unwind_init() takes 100 ms
Message-ID: <20181009061234.GA116930@gmail.com>
References: <81a1ff79-b303-c384-f926-c9618afac8f0@molgen.mpg.de>
 <20181008173417.crlfndi3p5pevnx3@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008173417.crlfndi3p5pevnx3@treble>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> > 4.  Would a command line parameter be reasonable `disable_unwind`, so people
> > could decrease their boot time with distribution kernels, and easily turn it
> > back on, when they need a stacktrace without having to rebuild the Linux
> > kernel?
> 
> I think a boot cmdline option to disable ORC would be ok.

I don't agree with such a kludge: 100 msecs isn't the end of the world for a
distro kernel bootup which takes a lot longer than that typically, and we'd like to
see the build time sorting implemented as well.

Let's fix this for real intstead of a workaround that is going to decrease
the debuggability of the kernel *significantly*.

> I'm not sure about a runtime toggle though.  It might be racy and I'd
> rather avoid that completely, unless there's a solid justification for
> it.

No, just no ...

Debug facilities need to be robust, dependable and as simple as possible.

Thanks,

	Ingo
