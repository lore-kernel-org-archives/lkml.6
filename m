Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1DFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C2C521927
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbfBORVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:21:24 -0500
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:54042 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725939AbfBORVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 12:21:24 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from webmail.solarflare.com (webmail.solarflare.com [12.187.104.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1-us1.ppe-hosted.com (Proofpoint Essentials ESMTP Server) with ESMTPS id CF65478007D;
        Fri, 15 Feb 2019 17:21:22 +0000 (UTC)
Received: from ec-desktop.uk.solarflarecom.com (10.17.20.45) by
 ocex03.SolarFlarecom.com (10.20.40.36) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 15 Feb 2019 09:21:19 -0800
Subject: Re: [RFC PATCH v2 0/4] dynamic indirect call promotion
To:     Nadav Amit <namit@vmware.com>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
References: <1c8bfbb9-c76f-85d7-f6e2-aba33d5950b0@solarflare.com>
 <CDCF8F6E-1792-45B5-8850-88E3307D1FBD@vmware.com>
From:   Edward Cree <ecree@solarflare.com>
Message-ID: <b099e061-32fc-4111-7836-b7cdcee88455@solarflare.com>
Date:   Fri, 15 Feb 2019 17:21:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CDCF8F6E-1792-45B5-8850-88E3307D1FBD@vmware.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Originating-IP: [10.17.20.45]
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.5.1010-24430.006
X-TM-AS-Result: No-17.220600-4.000000-10
X-TMASE-MatchedRID: EMyCvCfVN1EOwH4pD14DsPHkpkyUphL9tDSfcMR+7ZPb6Y+fnTZUL3Gp
        r8/fPJWiebn5rQJdjFGo/i2p0CW+jnAvdl/gU+kW4bl1FkKDELeGFdwJo3BYbwTZqgpA5lMbQ0U
        kLoLY8eZXw9KJYGUj3Q+93jUUIXeJppO3J0cCK8mKQCqq8vYqFSdW6F4MzUDGfeB8ZkBTx8t2hT
        ZbCfSqT/5KoIbFHwDBXTyVe6NrTCX/o+5l9ZSgvnV895e/Bd2J+IfriO3cV8Rdxev9wAdy9nt+B
        mSH2O89vvJoxo0uTMQDcb80+9h4A0EXheUXJvLHi1u/Wt2ORDrvJY9pBzgg1DdeVVUZfQ6R+Tg4
        KjyDvqvO06eihbQ8SUFiRsxhYmj9Z73RnaBbLFp8qY334HYDDyDQvhfLY4eVmJBe2bRXwlPAHyD
        M1D54Trxe3HH/70YkmQ0s4SmI2jxBUAk8RafpFse31VQ+6yRGHtpQk3g8og5gOcGYycfRsD+oKb
        +VMrbtC9zIiYwIELYzoUNAtFjscge1vNu551eNVP9jNEQH04pqTX06kzHrl5soi2XrUn/JmTDwp
        0zM3zoqtq5d3cxkNT3zSp73HMHc
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.220600-4.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.5.1010-24430.006
X-MDID: 1550251283-fN6tDwSoO1LO
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/19 08:50, Nadav Amit wrote:
>> In cases where RCU cannot be used (e.g. because some callees need to RCU
>> synchronise), it might be possible to add a variant that uses
>> synchronize_rcu_tasks() when updating, but this series does not attempt this.
> I wonder why.
Mainly because I have yet to convince myself that it's the Right Thing.
Note also the following (from kernel/rcu/update.c):

/* * This is a very specialized primitive, intended only for a few uses in
* tracing and other situations requiring manipulation of function
* preambles and profiling hooks. The synchronize_rcu_tasks() function
* is not (yet) intended for heavy use from multiple CPUs.  */

> This seems like an easy solution, and according to Josh, Steven
> Rostedt and the documentation appears to be valid.
Will it hurt performance, though, if we end up (say) having rcu-tasks-
 based synchronisation for updates on every indirect call in the kernel?
(As would result from a plugin-based opt-out approach.)

> As I stated before, I think that the best solution is to use a GCC plugin,
> [...] Such a solution will not enable the calling code to be
> written in C and would require a plugin for each architecture.
I'm afraid I don't see why.  If we use the static_calls infrastructure,
 but then do a source-level transformation in the compiler plugin to turn
 indirect calls into dynamic_calls, it should be possible to create an
 opt-out system without any arch-specific code in the plugin (the arch-
 specific stuff being all in the static_calls code).
Any reason that can't be done?  (Note: I don't know much about GCC
 internals, maybe there's something obvious that stops a plugin doing
 things like that.)

> Feel free to try my code and give me feedback. I did not get a feedback on my
> last version. Is there a fundamental problem with my plugin? Did you try it 
> and got bad results, or perhaps it did not build?
I didn't test your patches yet, because I was busy trying to get mine
 working and ready to post (and also with unrelated work).  But now that
 that's done, next time I have cycles spare for indirect call stuff I
 guess testing (and reviewing) your approach will be next on my list.

> Why do you prefer an approach
> which requires annotation of the callers, instead of something that is much
> more transparent?
I'm concerned about the overhead (in both time and memory) of running
 learning on every indirect call site (including ones that aren't in a
 hot-path, and ones which have such a wide variety of callees that
 promotion really doesn't help) throughout the whole kernel.  Also, an
 annotating programmer knows the locking/rcu context and can thus tell
 whether a given dynamic_call should use synchronise_rcu_tasks(),
 synchronise_rcu(), or perhaps something else (if e.g. the call always
 happens under a mutex, then the updater work could take that mutex).

The real answer, though, is that I don't so much prefer this approach,
 as think that both should be tried "publicly" and evaluated by more
 developers than just us three.  There's a reason this series is
 marked RFC ;-)


-Ed
