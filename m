Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9053BC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1BF9208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="QHx/biTE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1BF9208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936365AbeFORuU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 13:50:20 -0400
Received: from mail.efficios.com ([167.114.142.138]:50294 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932194AbeFORuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 13:50:18 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 46AED22B6BD;
        Fri, 15 Jun 2018 13:50:18 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id IlI_9IyM5Puz; Fri, 15 Jun 2018 13:50:17 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id D91ED22B6BA;
        Fri, 15 Jun 2018 13:50:17 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D91ED22B6BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1529085017;
        bh=ugdPHqB4NyO3WnoOGIXshz4+Q97pPFWbQNxYdkNKtao=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=QHx/biTEhrn4xilx6asQ3jJvfGiak5RsmmLpYTS2XaawS4AfraqsvB1dNjYMuquUs
         hVNFfw2DfyWyXBRy7lClHPnEzrTD7atA+xB5GU66enCwKTRBZnsLD7K8HWiyxh7Il0
         MT0qnPlbP6atjPO4LFYUo/WVfrdbAnvU1Wz4da1xtpcE9kO778eg8OxL2R83PstdXY
         pVYZC2WLc+3KH9f9T4TWN5ZF06D2AK50VsyBDU8Pa08054dbWN4VFcS+rmMCjt81et
         8lRckuQEX5Lm6U3u6LeChHNlPI+Vp0SxhmaO97eecSs1vEUPtjw1QeUH0YY0VtVBbn
         0aIifCLRv62Tg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id TZlTSmDtuOgA; Fri, 15 Jun 2018 13:50:17 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id C441D22B6B3;
        Fri, 15 Jun 2018 13:50:17 -0400 (EDT)
Date:   Fri, 15 Jun 2018 13:50:17 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Pavel Machek <pavel@ucw.cz>, carlos <carlos@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>
Message-ID: <422468177.14427.1529085017684.JavaMail.zimbra@efficios.com>
In-Reply-To: <b5c0a91b-b428-7807-0f16-97f15e632bdb@redhat.com>
References: <1084280721.10859.1528746558696.JavaMail.zimbra@efficios.com> <31fc101a-295b-067b-1a82-7e9e509fc92f@redhat.com> <305409897.10888.1528747473727.JavaMail.zimbra@efficios.com> <091061df-3482-8762-30e4-feaf3417be11@redhat.com> <417742741.11550.1528821084084.JavaMail.zimbra@efficios.com> <20180614122759.GB8798@amd> <894222691.12973.1528981314012.JavaMail.zimbra@efficios.com> <b5c0a91b-b428-7807-0f16-97f15e632bdb@redhat.com>
Subject: Re: Restartable Sequences system call merged into Linux
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: Restartable Sequences system call merged into Linux
Thread-Index: FxHJxO2X/PkHE33fjREx7yFbJyZx8w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 15, 2018, at 1:09 AM, Florian Weimer fweimer@redhat.com wrote:

> On 06/14/2018 03:01 PM, Mathieu Desnoyers wrote:
>> Another alternative would be to somehow let glibc handle the registration,
>> perhaps only doing it for applications expressing their interest for rseq.
> 
> That's not really possible.  We can't rely on the visibility of symbol
> bindings due to lazy binding and hidden visibility.  Registration of
> intent by other means will not work because if it is done from user
> code, some other library may have already launched a thread at this point.
> 
> (It's also a moot point if we want to use restartable sequences in glibc
> itself.)

Considering that we can expect the glibc memory allocator to benefit from
rseq to speed up its memory allocator, this means pretty much any application
linked against glibc *will* end up using rseq indirectly.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
