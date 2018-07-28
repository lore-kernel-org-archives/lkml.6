Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D91BC6778F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 16:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 513ED20897
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 16:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="gATr94cO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 513ED20897
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbeG1RyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 13:54:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44238 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729164AbeG1RyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 13:54:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id r16-v6so8122249wrt.11
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 09:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n7+L4GqPbxZP4/dH4uzDfjMNyVc/hIi3LHfAPgk6uFQ=;
        b=gATr94cOmJEqeHDPB6K1Xlzzo+mr0yVK0zKyJc0qcEc6jT9e4MA4O+6f9SnyhZ2wxk
         qSQikEErC5FPKv+ntGVFJXvNAOLuRN1H3BR9hP5IWZuwWkcS2ZA9LGKY6YOv/uNG8YOT
         m8eiYPzC32iWrDySbqs6MX2Ue4aG0HN0Shy/2iDyCNIq60KdaAEhb/gwhb547o2NSU9x
         3MFQNIsslESCrhAcdZ/WLVZVD5u//VX11AZtFuvKrnSctqv4RksSNfLFObhJnGUXJNYp
         OY0veQL1ukMwz9y1EmnZt0uGt4Kq8zqnMYYKiuNMCp52bXqHQ9UmnXrx5x0a+g8qcnC3
         TtYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n7+L4GqPbxZP4/dH4uzDfjMNyVc/hIi3LHfAPgk6uFQ=;
        b=l50O1RQyY2aAxDts2jGBTxGxzs5D7wr7ItL0mbMqYPgXnPWSQ8V4n5sNbiQst5psS2
         duh6kdGOXAgHt2qpeh0I0cz2M+ebJFj62HM6sYCzXWOnLS4UaQtUi/9k3c6bJdQ8Gbut
         j86/DWRvEnpJBiIWOrJWKGxZJP79icWkJH8usijp9YaPXdrc4AjveoeHjym2cSfRCXD1
         QHBj3gzEbBS7fEmyTnWOeiyeRwn+CmrmOlukN44owdzyp3aJ627SNRx/DZZ+zthqtZJA
         YPL4kQOkZAi6/zSCHqN37Wxm1JYu1y5C/QKfZvJYkn3mBvXmC+Wquz+pMNzwe0yECt0H
         htCQ==
X-Gm-Message-State: AOUpUlF4wnuymqbK/bryNZd/18GEBHGqLhVwQ9O/BlMl/CVudVAaq96Q
        3v6zRYGnWlR9vGTnCekunqNwSBC/G+g=
X-Google-Smtp-Source: AAOMgpdVEI58xjjreMU4RC6fdu5ZIr2IBRbaIh/tdRXpOP+Q8R63nfAxYVzolGtZiawKV/O6jJWuAg==
X-Received: by 2002:adf:9996:: with SMTP id y22-v6mr10357518wrb.69.1532795218317;
        Sat, 28 Jul 2018 09:26:58 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id b2-v6sm8491394wmh.20.2018.07.28.09.26.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Jul 2018 09:26:57 -0700 (PDT)
Message-ID: <1532795215.2679.27.camel@arista.com>
Subject: Re: [PATCH 00/18] xfrm: Add compat layer
From:   Dmitry Safonov <dima@arista.com>
To:     Nathan Harold <nharold@google.com>
Cc:     Florian Westphal <fw@strlen.de>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-efi@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Eric Paris <eparis@redhat.com>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Paul Moore <paul@paul-moore.com>, coreteam@netfilter.org,
        linux-audit@redhat.com, netfilter-devel@vger.kernel.org,
        Fan Du <fan.du@intel.com>
Date:   Sat, 28 Jul 2018 17:26:55 +0100
In-Reply-To: <CADhJOfam+cY8uD4XTGvZSEFQdAgTu49G6cg6c64NJoP3bNuBmw@mail.gmail.com>
References: <20180726023144.31066-1-dima@arista.com>
         <20180726084959.pzjvflfjq6a76du6@breakpoint.cc>
         <20180727073747.h27dtojlnmc3k25v@gauss3.secunet.de>
         <1532700173.2679.18.camel@arista.com>
         <20180727141936.uze6ohordx7ue3no@breakpoint.cc>
         <1532703111.2679.20.camel@arista.com>
         <CADhJOfam+cY8uD4XTGvZSEFQdAgTu49G6cg6c64NJoP3bNuBmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-27 at 09:48 -0700, Nathan Harold wrote:
> We (Android) are very interested in removing the restriction for 32-
> bit userspace processes accessing xfrm netlink on 64-bit kernels.
> IPsec support is required to pass Android conformance tests, and any
> manufacturer wishing to ship 32-bit userspace with a recent kernel
> needs out-of-tree changes (removing the compat_task check) to do so.

Glad to hear - that justify my attempts more :)

> That said, it’s not difficult to work around alignment issues
> directly in userspace, so maybe we could just remove the check and
> make this the caller's responsibility? Here’s an example of the
> workaround currently in the Android tree:
> https://android.googlesource.com/platform/system/netd/+/refs/heads/ma
> ster/server/XfrmController.h#257

We've kinda same workarounds in our userspace..
But I don't think reverting the check makes much sense - it'll make
broken compat ABI in stone.
If you're fine with disgraceful hacks and just want to get rid of
additional non-mainstream patch - you can make 64-bit syscalls from 32-
bit task (hint: examples in x86 selftests).


> We could also employ a (relatively simple) solution such as the one
> above in the uapi XFRM header itself, though it would require a
> caller to declare the target kernel ABI at compile time. Maybe that’s
> not unthinkable for an uncommon case?

Well, I think, I'll rework my patches set according to critics and
separate compat xfrm layer. I've already a selftest to check that 32/64
bit xfrm works - so the most time-taking part is done.
So, if you'll wait a week or two - you may help me to justify acception
of mainstreaming those patches.

> On Fri, Jul 27, 2018 at 7:51 AM, Dmitry Safonov <dima@arista.com>
> wrote:
> > On Fri, 2018-07-27 at 16:19 +0200, Florian Westphal wrote:
> > > Dmitry Safonov <dima@arista.com> wrote:
> > > > 1. It will double copy netlink messages, making it O(n) instead
> > of
> > > > O(1), where n - is number of bind()s.. Probably we don't care
> > much.
> > > 
> > > About those bind() patches, I don't understand why they are
> > needed.
> > > 
> > > Why can't you just add the compat skb to the native skb when
> > doing
> > > the multicast call?
> > > 
> > > skb_shinfo(skb)->frag_list = compat_skb;
> > > xfrm_nlmsg_multicast(net, skb, 0, ...
> > 
> > Oh yeah, sorry, I think I misread the patch - will try to add
> > compat
> > skb in the multicast call.
> > 

-- 
Thanks,
             Dmitry
