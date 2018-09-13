Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1FDFC6186
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C13421480
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C13421480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stwm.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbeIMU4I convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 16:56:08 -0400
Received: from dresden.studentenwerk.mhn.de ([141.84.225.229]:45526 "EHLO
        email.studentenwerk.mhn.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726819AbeIMU4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 16:56:08 -0400
Received: from mailhub.studentenwerk.mhn.de (mailhub.studentenwerk.mhn.de [127.0.0.1])
        by email.studentenwerk.mhn.de (Postfix) with ESMTP id 42B30B6R21zMkvh;
        Thu, 13 Sep 2018 17:46:02 +0200 (CEST)
From:   Wolfgang Walter <linux@stwm.de>
To:     Florian Westphal <fw@strlen.de>
Cc:     netdev@vger.kernel.org,
        Steffen Klassert <steffen.klassert@secunet.com>,
        David Miller <davem@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Regression: kernel 4.14 an later very slow with many ipsec tunnels
Date:   Thu, 13 Sep 2018 17:46:02 +0200
Message-ID: <3448099.9yk84El3Sa@stwm.de>
User-Agent: KMail/4.14.3 (Linux/4.14.61-debian64.all+1.1; KDE/4.14.13; x86_64; ; )
In-Reply-To: <20180913135844.3ut6fxgx67t6ndtu@breakpoint.cc>
References: <5781211.jtEvgqSZyO@stwm.de> <20180913135844.3ut6fxgx67t6ndtu@breakpoint.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 13. September 2018, 15:58:44 schrieb Florian Westphal:
> Wolfgang Walter <linux@stwm.de> wrote:
> > thanks to the fix from Steffen Klassert I could now run 4.14.69 + his
> > patch
> > and 4.18.7 + his patch without oopsing immediately.
> > 
> > But I found that those kernels perform very bad. They perform so bad that
> > they are unusable for our router with about 3000 ipsec tunnels (tunnel
> > mode network <-> network).
> 
> Can you do a 'perf record -a -g sleep 5' with 4.18 and provide 'perf
> report' result?
> 
> It would be good to see where those cycles are spent.

I'll try that but this isn't that easy as the router image does not contain 
perf. I also have to do that on our production router. I try to do that 
tomorrow evening.

What I can say is that it depends mainly on number of policy rules and SA.

Regards
-- 
Wolfgang Walter
Studentenwerk München
Anstalt des öffentlichen Rechts
