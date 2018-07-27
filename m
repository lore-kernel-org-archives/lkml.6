Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9D5C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9AF2064D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="afn+Kn1d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B9AF2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388659AbeG0PZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 11:25:02 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44047 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388340AbeG0PZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 11:25:02 -0400
Received: by mail-ed1-f68.google.com with SMTP id f23-v6so3995475edr.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 07:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RDMa7ZZB11S2ffQj7xk9t8USijX93S+edv+PxO2xFxI=;
        b=afn+Kn1dNANfrd8mtkREapwQ4M2E2mmnWoJAVeuY+57OO/EbKqmNaVAPvA9IfxNXEL
         SyOchrdWpFdGdc3VbQxHdW7gJRCEVYFV9vPFrZDQM6VOpMxNSrjKn4aN5zX+sWPp/DSE
         mKn1fpo4z/ahm6X0NuRDWknyxAuIkjpD0x9KhB++nMOtpDWl/S7TpqnZfWd/f4uOK3Fq
         I0+/TZj+EAQItjiy1eeJJXAesrMw75pS12pyRSEn5MOAdREDqNBPVXgsxQ6X8N/OFbav
         j6629hcu9VNtKNIveO7iiDSJ6j7AipDUTIKeAAGZFK3/9iV7H3Y0fIGcssgSjxQTPOQa
         +bsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RDMa7ZZB11S2ffQj7xk9t8USijX93S+edv+PxO2xFxI=;
        b=KP2u17WmHHiHWZkP3PdbQUlDoclfjvXp0DSNxOsnd9/b2wGQ2VgpdKz4t2hn79iJg3
         T7yqqnukY/5LoqlLma27yzDXOKOSk/v1PC1JRPBbm8ioZcoZK2zW0vZIivIIIXJ+u71R
         CHGVgk1RkNSd93Ctqu2cVSF0D+K3hdNIkKppU1+twWAEaXik1ypv9eKmGATKuvRMzpiV
         +kGUOyP9kiBQ0LI0X3aNHqikA6zWiTfkOpDkSZgAYuxxJGwVa+/rp8vGOTOl2mcRxeyW
         8kLbIcVk/7cWFigydWPXNYLRF8EXCjaTmR4TeWJIY7tNfP69k+UenPXQmKlp/CasQRoK
         +g8Q==
X-Gm-Message-State: AOUpUlH4n4oo4uCN90WI7zS9fLrpEgfTUDTSxIIgZbFA6Z87FiUZxdG6
        rwSKJw3FK5Jp3fXpW17YbyuT0Q==
X-Google-Smtp-Source: AAOMgpetFfrQJjes17ObysBgk3iOG375VAzH0aFugXoKuI8wx51X3hO/xZzb4/CjoQvkNruwLwU76Q==
X-Received: by 2002:a50:d59d:: with SMTP id v29-v6mr7655417edi.307.1532700176153;
        Fri, 27 Jul 2018 07:02:56 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id d26-v6sm3823482ede.50.2018.07.27.07.02.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 07:02:55 -0700 (PDT)
Message-ID: <1532700173.2679.18.camel@arista.com>
Subject: Re: [PATCH 00/18] xfrm: Add compat layer
From:   Dmitry Safonov <dima@arista.com>
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        Florian Westphal <fw@strlen.de>
Cc:     linux-kernel@vger.kernel.org,
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
Date:   Fri, 27 Jul 2018 15:02:53 +0100
In-Reply-To: <20180727073747.h27dtojlnmc3k25v@gauss3.secunet.de>
References: <20180726023144.31066-1-dima@arista.com>
         <20180726084959.pzjvflfjq6a76du6@breakpoint.cc>
         <20180727073747.h27dtojlnmc3k25v@gauss3.secunet.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-27 at 09:37 +0200, Steffen Klassert wrote:
> On Thu, Jul 26, 2018 at 10:49:59AM +0200, Florian Westphal wrote:
> > Dmitry Safonov <dima@arista.com> wrote:
> > > So, here I add a compatible layer to xfrm.
> > > As xfrm uses netlink notifications, kernel should send them in
> > > ABI
> > > format that an application will parse. The proposed solution is
> > > to save the ABI of bind() syscall. The realization detail is
> > > to create kernel-hidden, non visible to userspace netlink groups
> > > for compat applications.
> > 
> > Why not use exisiting netlink support?
> > Just add the 32bit skb to skb64->frag_list and let
> > netlink find if tasks needs 64 or 32 one.
> > 
> > It only needs this small fix to properly signal the end of a dump:
> > https://marc.info/?l=linux-netdev&m=126625240303351&w=2
> > 
> > I had started a second attempt to make xfrm compat work,
> > but its still in early stage.
> > 
> > One link that might still have some value:
> > https://git.breakpoint.cc/cgit/fw/net-next.git/commit/?h=xfrm_confi
> > g_compat_07&id=f64430e6d9e297f3990f485a4832e273751b9869
> > (compat structure definitions with BUILD_BUG_ON checking)
> > 
> > My plan was to make xfrm compat work strictly as shrinker (64->32)
> > and expander (32->64), i.e. no/little changes to exisiting code and
> > pass all "expanded" skbs through existing xfrm rcv functions.
> 
> I agree here with Florian. The code behind this ABI
> is already complicated. Please stay away from generic
> code a much as possible. Generic and compat code should
> be clearly separated.

Yeah, I tend to agree that it would be better to separate it.
But:
1. It will double copy netlink messages, making it O(n) instead of
O(1), where n - is number of bind()s.. Probably we don't care much.
2. The patches not-yet-done on the link have +500 added lines - as much
as my working patches set, so probably it'll add more code.

Probably, we don't care that much about amount of code added and
additional copies than about separating compat layer from the main
code. Will look into that.

-- 
Thanks,
             Dmitry
