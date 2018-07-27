Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90275C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C3B820673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C3B820673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730126AbeG0I62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 04:58:28 -0400
Received: from a.mx.secunet.com ([62.96.220.36]:57902 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729472AbeG0I61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 04:58:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id A0301201AE;
        Fri, 27 Jul 2018 11:37:33 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id t_6LZFLTIku4; Fri, 27 Jul 2018 11:37:32 +0200 (CEST)
Received: from mail-essen-01.secunet.de (mail-essen-01.secunet.de [10.53.40.204])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id E3DDB2007F;
        Fri, 27 Jul 2018 11:37:32 +0200 (CEST)
Received: from gauss2.secunet.de (10.182.7.193) by mail-essen-01.secunet.de
 (10.53.40.204) with Microsoft SMTP Server id 14.3.399.0; Fri, 27 Jul 2018
 09:37:47 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)      id 9118E318201B;
 Fri, 27 Jul 2018 09:37:47 +0200 (CEST)
Date:   Fri, 27 Jul 2018 09:37:47 +0200
From:   Steffen Klassert <steffen.klassert@secunet.com>
To:     Florian Westphal <fw@strlen.de>
CC:     Dmitry Safonov <dima@arista.com>, <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        <netdev@vger.kernel.org>, "Andy Lutomirski" <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Thomas Gleixner" <tglx@linutronix.de>, <x86@kernel.org>,
        <linux-efi@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        <linux-kselftest@vger.kernel.org>, Eric Paris <eparis@redhat.com>,
        "Jozsef Kadlecsik" <kadlec@blackhole.kfki.hu>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Paul Moore <paul@paul-moore.com>, <coreteam@netfilter.org>,
        <linux-audit@redhat.com>, <netfilter-devel@vger.kernel.org>,
        Fan Du <fan.du@intel.com>
Subject: Re: [PATCH 00/18] xfrm: Add compat layer
Message-ID: <20180727073747.h27dtojlnmc3k25v@gauss3.secunet.de>
References: <20180726023144.31066-1-dima@arista.com>
 <20180726084959.pzjvflfjq6a76du6@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180726084959.pzjvflfjq6a76du6@breakpoint.cc>
User-Agent: NeoMutt/20170609 (1.8.3)
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: B91603A4-0695-4C19-880C-8A123D7819D6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 10:49:59AM +0200, Florian Westphal wrote:
> Dmitry Safonov <dima@arista.com> wrote:
> > So, here I add a compatible layer to xfrm.
> > As xfrm uses netlink notifications, kernel should send them in ABI
> > format that an application will parse. The proposed solution is
> > to save the ABI of bind() syscall. The realization detail is
> > to create kernel-hidden, non visible to userspace netlink groups
> > for compat applications.
> 
> Why not use exisiting netlink support?
> Just add the 32bit skb to skb64->frag_list and let
> netlink find if tasks needs 64 or 32 one.
> 
> It only needs this small fix to properly signal the end of a dump:
> https://marc.info/?l=linux-netdev&m=126625240303351&w=2
> 
> I had started a second attempt to make xfrm compat work,
> but its still in early stage.
> 
> One link that might still have some value:
> https://git.breakpoint.cc/cgit/fw/net-next.git/commit/?h=xfrm_config_compat_07&id=f64430e6d9e297f3990f485a4832e273751b9869
> (compat structure definitions with BUILD_BUG_ON checking)
> 
> My plan was to make xfrm compat work strictly as shrinker (64->32)
> and expander (32->64), i.e. no/little changes to exisiting code and
> pass all "expanded" skbs through existing xfrm rcv functions.

I agree here with Florian. The code behind this ABI
is already complicated. Please stay away from generic
code a much as possible. Generic and compat code should
be clearly separated.
