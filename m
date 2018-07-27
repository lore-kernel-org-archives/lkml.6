Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFA2C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 086D3208AC
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="fXDhjx1J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 086D3208AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388467AbeG0QOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 12:14:11 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42653 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732167AbeG0QOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 12:14:11 -0400
Received: by mail-ed1-f68.google.com with SMTP id r4-v6so4055312edp.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 07:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UQJVtxRGPcQe0fQXpa8GiDd0JLtf9Zq6OF0cDueEkC0=;
        b=fXDhjx1JS3AFs+HKZUI9TZKdgxz9vdNVDtDi0qWkY1QW0t2EOhYdFGPMn8A43YTSHJ
         TgutD0+gUXfmKEt42AenHq6f0409Nlw1cmtqz6GCXRn5yZytntbl/QZ4M1LKYh/XqSwr
         nA66yh+BC0qIztErz1F0qYzfrlYQGvrKWOWI+g5aXOylqRAv8VVZHei98V/sIMcgc9RE
         T6ll6tSHZIOgsADkenmWooQCDmvhdxI+9OETCc3kRzsT4QegRWRKHcTUh35g84sH4GTD
         MUXTER5CkiSxTVM/PnRYNwvj8XY5Ht3flgeqzufFdR7tqAuy6j+VZrO6YCDjffs1Mjl/
         fKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UQJVtxRGPcQe0fQXpa8GiDd0JLtf9Zq6OF0cDueEkC0=;
        b=OauA2udtHlC8XkkfRw5Hotn5qLv+5uogK1TC/zvZ2Dd1wnu9p71uJBvxoXwyyPpQJg
         na+/kVJ9kcWD42MB/yU8HUAKTfOUIHPrimMsBzjvFE1KWOVGxSRaw73vxjPCuVufkqAM
         HHpJZlYDtrzIYuID9GLHKKQYXmVj5xFVyodOShj6iVT9p6+8XgUwFDVyvtAiWNrQLByp
         /YGmCjSRCK+6GJc+BC0WivkApTyue3j6Kwz3+yRuEZm/lXQpGcdHhDzbOVpF/l9T66Nt
         RkfFIv+yRAG8Tq207kWPpYbEMidlQabimtDuRS68WChJpinKeBRTjRTdIPCmc3OnaG9r
         xUQg==
X-Gm-Message-State: AOUpUlGYjhFonnF6WKcNnr4D8TB1QGzAsrUagu38KET5JA+q7X5HT6m3
        8bpXtGWe1vXIUn9KYp9xAencow==
X-Google-Smtp-Source: AAOMgpfmTJKKcLM9uiUvzTUlA5VObFhq6qp+YJram5PlP4BGIb0FIfCWBkUJSbNgMERBkHrmTbWDLw==
X-Received: by 2002:a50:a762:: with SMTP id h89-v6mr7717578edc.261.1532703114442;
        Fri, 27 Jul 2018 07:51:54 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id g8-v6sm2134260edh.87.2018.07.27.07.51.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 07:51:53 -0700 (PDT)
Message-ID: <1532703111.2679.20.camel@arista.com>
Subject: Re: [PATCH 00/18] xfrm: Add compat layer
From:   Dmitry Safonov <dima@arista.com>
To:     Florian Westphal <fw@strlen.de>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
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
Date:   Fri, 27 Jul 2018 15:51:51 +0100
In-Reply-To: <20180727141936.uze6ohordx7ue3no@breakpoint.cc>
References: <20180726023144.31066-1-dima@arista.com>
         <20180726084959.pzjvflfjq6a76du6@breakpoint.cc>
         <20180727073747.h27dtojlnmc3k25v@gauss3.secunet.de>
         <1532700173.2679.18.camel@arista.com>
         <20180727141936.uze6ohordx7ue3no@breakpoint.cc>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-27 at 16:19 +0200, Florian Westphal wrote:
> Dmitry Safonov <dima@arista.com> wrote:
> > 1. It will double copy netlink messages, making it O(n) instead of
> > O(1), where n - is number of bind()s.. Probably we don't care much.
> 
> About those bind() patches, I don't understand why they are needed.
> 
> Why can't you just add the compat skb to the native skb when doing
> the multicast call?
> 
> skb_shinfo(skb)->frag_list = compat_skb;
> xfrm_nlmsg_multicast(net, skb, 0, ...

Oh yeah, sorry, I think I misread the patch - will try to add compat
skb in the multicast call.

-- 
Thanks,
             Dmitry
