Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37C6C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 11:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A514A20851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 11:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FH0bfXdr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A514A20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbeKTVt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:49:59 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:36680 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728084AbeKTVt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 16:49:58 -0500
Received: by mail-it1-f195.google.com with SMTP id c9so2938713itj.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 03:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CCLbGsbFYJ0Y4QWKiXXd8QkCPAMEUuiiCC+G8BQBMrg=;
        b=FH0bfXdrJDcR9yLncY3lJsG4ZF7yKZubMuJsGY7pzVNqEDea5GeKAei9XGL/wQthhE
         WFDdWvFGVSBe4gg9CLQVfPm4t0uHtATxl46JesqBngNfdiszaIiWzhJ9LIYlpJlyx5nk
         VBnIz/BFAxK7p360OTAxuUrF5QQ4RDV/N70Ync328IH19GAW/8bxOwh6s9qtCnV16kFT
         S0AtqBeTbb34vJCH9jft/6qWx9utA7ZWjZsNFpOLTZxToo7lPzmddyHN/J1W8LhnOx5U
         wDacjs4k/5rMeFQV1z63Y6x3iqonGeyuoeNYVYSWWE7dJoAt6muCKu8VIcYMbnTmA6N2
         AXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CCLbGsbFYJ0Y4QWKiXXd8QkCPAMEUuiiCC+G8BQBMrg=;
        b=gjhU1GOVZZfljqhLLRhCtRMDlqWqzFMGj1QVulJsNMP0mOuhlhJv0XFM1Bhpn5U3CU
         Y+H3lIOwJq/tQIdPZJffHqrGgOn/dbLctoXO+bqXYz6yJinhr6nLpu7rqWEOWT164B/o
         6g4hLmVJH5vz+UgtN2GUfkQPu+fA9IVh1PcoteR+biY1cT23NhFbkf472xj1nhSoZPpE
         i69s9YWXTLkMfvg3wUDyfm6UMHfavDBV2KsiCJNA7zROja7jKfzFl5LwYjwxJXiA4VF2
         53lYlexqAwK0HuqJb8klp+FXtJQ46lBL0cuwk65p96RNFe1oWerG4FK5wWJ8v8tnKvJX
         LhvQ==
X-Gm-Message-State: AA+aEWY4fZ83R5W5Yjq3Vw2n8XDh6JfrscXuxeouEfL4aNk6aiX7slTa
        LUtaJlimjISFvdB4tkicFDfU4vsYrmPMi3g6p05lqA==
X-Google-Smtp-Source: AJdET5dB64URKLN71AmaCBkMz5sKok2YK+SscxOcgJNgDD4gd2JcknOR2F1Bpa7rXPtcQLMa0364jyv9Um9qHnCmvqg=
X-Received: by 2002:a24:b009:: with SMTP id d9-v6mr1647274itf.166.1542712879217;
 Tue, 20 Nov 2018 03:21:19 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:b003:0:0:0:0:0 with HTTP; Tue, 20 Nov 2018 03:20:58
 -0800 (PST)
In-Reply-To: <20181117084649.GA24182@nautica>
References: <CACT4Y+bv5dWx0JwCzTPD3mWJRaMHOtRVcvpV5fdQ5KS7zAF_fA@mail.gmail.com>
 <20181010144059.GA20918@nautica> <CACT4Y+Zx5nDN-H8WfC4WtgK7YeAWZig9WsDr1J4DXZBZb+vgWQ@mail.gmail.com>
 <20181010155814.GC20918@nautica> <CACT4Y+bJvxXeJxbAKCPTm0X608t302Kcq+F7Ccot3_-wx7sdog@mail.gmail.com>
 <20181011131045.GA32030@nautica> <CACT4Y+YvJ-KT4UxtOXpou1xpT3wBASDkt135zr2BwrRi0gv4Tw@mail.gmail.com>
 <20181011141928.GB32030@nautica> <CACT4Y+byESz-LuzM07ik6-VVHoD7OhO_BB0qOLNUZ4j-ao9CFA@mail.gmail.com>
 <20181012150855.GA22149@nautica> <20181117084649.GA24182@nautica>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 20 Nov 2018 12:20:58 +0100
Message-ID: <CACT4Y+YzEUouqi7daSBcJWak67rEdMEichWHpeZH-ggO+fD_nw@mail.gmail.com>
Subject: Re: 9p/RDMA for syzkaller (Was: BUG: corrupted list in p9_read_work)
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        David Miller <davem@davemloft.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        netdev <netdev@vger.kernel.org>,
        Ron Minnich <rminnich@sandia.gov>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 17, 2018 at 9:46 AM, Dominique Martinet
<asmadeus@codewreck.org> wrote:
> Dominique Martinet wrote on Fri, Oct 12, 2018:
>> Hmm, good point; I hadn't looked at the network level how this is
>> emulated.
>> When I use a single VM I do not see anything with tcpdump on any
>> interface, so I assume the kernel short-cuts the interface in this case.
>> When communicating between two machines there obviously is traffic; it
>> appears to be transported over udp - I see the messages I sent in plain
>> text in the dump and there is only a handful of packets for the whole
>> connecting and teardown so it's definitely much simpler.
>>
>> This might have some knob I am not aware of to force the driver to send
>> udp in the local setup, if we can it's going to be much easier to
>> reimplement the rxe emulation protocol with raw syscalls than what I was
>> describing earlier...
>
> I've taken a little bit of time to look at this.
> Unfortunately, I haven't been able to find any knob to make a
> single-machine setup send UDP over an interface; would have hoped that
> playing with multiple interfaces might be a way around this (e.g. use
> the rxe driver on one interface and listen on the udp port on the other
> one), but I couldn't get this to work and don't see anything in the code
> that hints it might be configurable.
> It seems to realize that the remote IP is assigned locally anyway and
> while I cannot "bind" to an address that wasn't added to the rxe driver
> at the rdma_cm level, trying to connect to it never sends any packet to
> a ncat listening on 4791/udp on that interface...
> If anyone has an idea, it'd be great!
>
> Protocole-wise, once we get that to work it doesn't look very difficult
> to implement some basic "accept connection and send acks/replies" small
> server, but we need the first part to work...

I don't understand most of the words here, so I probably won't be of help.

Leon told me that there is some kind of software emulation RDMA
interface (CONFIG_RDMA_RXE?). Maybe it can be used to create an
emulated RDMA interface per test process and use it to communicate
with 9p client?
