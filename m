Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DAAC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BBC0208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amnutLZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BBC0208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936422AbeFOTOg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 15:14:36 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:40238 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936308AbeFOTOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 15:14:34 -0400
Received: by mail-pg0-f66.google.com with SMTP id w8-v6so1792687pgp.7;
        Fri, 15 Jun 2018 12:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Tu+wdFiTZB5OuHwQKVPrPd5LaIlGwbfcnz5ZQbxw8bY=;
        b=amnutLZK7Vjt+OcpA34gVKdxVEu7r4Z3Xpj5sn6CBw7ZJMjXjCjspusApe83K80kB2
         nMH4TRPOC38mlQmTccIWxxwonm8pPsCtNw3kBuSiVuqCVCHERElml9oXAq+Ua7TUMcaK
         d1Eu6Tf3TpcGEFscjmdVRklIBsejmlk3k1WQ0fjpI9WJUBURc0KNt/sj+aHqYwdrLiXB
         D+yAqWcURslWM3SjcB36jSbaGvpteJs6hJFmUEqFQNoLRraZQiEnfLxOrLGDyp/5QV+o
         yWyXcGNxuIpCGssook/6q7BdWBEhVx5+qAj7VCKwXnRGv6GUt5nSWcpHh3tKmcLOdfLu
         3PEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tu+wdFiTZB5OuHwQKVPrPd5LaIlGwbfcnz5ZQbxw8bY=;
        b=j4cN4deoztoQIaP7atyv9N+6ZoxRs9562LwIw5XFVatiODf5wPPGxq8PxAH/+Q7fWa
         BS/e3H1MdqVcBR2zKv3hIAjXqCpKq4BB35bgxpkZlyZ93kGhbBG+oMsRQ7Q9eBJeGelS
         tDJKusKvkw7YhVEZsPgqI2fnfU8/kp5h70gws064BzWNxAecfAa5oiKvjSC2pnwKk5kI
         yK4FoLwazvUkrnfwCZJ0fJb3nb/LYz1IwrqlpCx6Ocd4S+ytYEW/EkHextIOxbhuSrlY
         GiCu+nj/xGdLIbAYOWd1hhcXfhcJfFPbw83mrdWw2pA1QcnooH+lB75qVUH8+PyZW/8P
         25Ug==
X-Gm-Message-State: APt69E0uB8ugzC00F6kBLAFe2lNmyULV/XGZqq3gQFKv97kSRWMjmzcn
        H+Xl129bgWezXLkwQmIqGs/fX974
X-Google-Smtp-Source: ADUXVKJzmrH8JCAO7tU3xYRY1yq7l7z3rYptxuMpo4kxLMRAwrVZsXf2htyjW5WbiAwysYrrjVUWNw==
X-Received: by 2002:a65:5143:: with SMTP id g3-v6mr2707427pgq.190.1529090074147;
        Fri, 15 Jun 2018 12:14:34 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id h8-v6sm10179734pgq.35.2018.06.15.12.14.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 12:14:33 -0700 (PDT)
Subject: Re: [PATCH] Revert "net: pskb_trim_rcsum() and CHECKSUM_COMPLETE are
 friends"
To:     Mathieu Malaterre <malat@debian.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20180615185645.8921-1-malat@debian.org>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <fbb95c11-240c-1a11-0a62-0483908c577e@gmail.com>
Date:   Fri, 15 Jun 2018 12:14:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180615185645.8921-1-malat@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/15/2018 11:56 AM, Mathieu Malaterre wrote:
> This reverts commit 88078d98d1bb085d72af8437707279e203524fa5.
> 
> It causes regressions for people using chips driven by the sungem
> driver. Suspicion is that the skb->csum value isn't being adjusted
> properly.
> 
> Symptoms as seen on G4+sungem are:
> 
> [   34.023281] eth0: hw csum failure
> [   34.023438] CPU: 0 PID: 0 Comm: swapper Not tainted 4.17.0+ #2
> [   34.023618] Call Trace:
> [   34.023707] [dffedbd0] [c069ddac] __skb_checksum_complete+0xf0/0x108 (unreliable)
> [   34.023948] [dffedbf0] [c0777a70] tcp_v4_rcv+0x604/0xe00
> [   34.024118] [dffedc70] [c0731624] ip_local_deliver_finish+0xa8/0x3c4
> [   34.024315] [dffedcb0] [c0732430] ip_local_deliver+0xf0/0x154
> [   34.024493] [dffedcf0] [c07328dc] ip_rcv+0x448/0x774
> [   34.024653] [dffedd50] [c06aeae0] __netif_receive_skb_core+0x5e8/0x1184
> [   34.024857] [dffedde0] [c06bba20] napi_gro_receive+0x160/0x22c
> [   34.025044] [dffede10] [e14b2590] gem_poll+0x7fc/0x1ac0 [sungem]
> [   34.025228] [dffedee0] [c06bacf0] net_rx_action+0x34c/0x618
> [   34.025402] [dffedf60] [c07fd27c] __do_softirq+0x16c/0x5f0
> [   34.025575] [dffedfd0] [c0064c7c] irq_exit+0x110/0x1a8
> [   34.025738] [dffedff0] [c0016170] call_do_irq+0x24/0x3c
> [   34.025903] [c0cf7e80] [c0009a84] do_IRQ+0x98/0x1a0
> [   34.026055] [c0cf7eb0] [c001b474] ret_from_except+0x0/0x14
> [   34.026225] --- interrupt: 501 at arch_cpu_idle+0x30/0x78
>                    LR = arch_cpu_idle+0x30/0x78
> [   34.026510] [c0cf7f70] [c0cf6000] 0xc0cf6000 (unreliable)
> [   34.026682] [c0cf7f80] [c00a3868] do_idle+0xc4/0x158
> [   34.026835] [c0cf7fb0] [c00a3ab0] cpu_startup_entry+0x20/0x28
> [   34.027013] [c0cf7fc0] [c0998820] start_kernel+0x47c/0x490
> [   34.027181] [c0cf7ff0] [00003444] 0x3444
> 
> See commit 7ce5a27f2ef8 ("Revert "net: Handle CHECKSUM_COMPLETE more
> adequately in pskb_trim_rcsum()."") for previous reference.

This fix seems to hide a bug in csum functions on this architecture.

Or a bug on this NIC when receiving a small packet (less than 60 bytes).
Maybe the padding bytes are not included in NIC provided csum, and not 0.




