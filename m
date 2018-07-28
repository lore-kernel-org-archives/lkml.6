Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8B0C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 21:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC0E20893
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 21:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AC0E20893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731192AbeG1WqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 18:46:12 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56338 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730551AbeG1WqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 18:46:11 -0400
Received: from localhost (unknown [172.58.40.57])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1905810150D1C;
        Sat, 28 Jul 2018 14:18:17 -0700 (PDT)
Date:   Sat, 28 Jul 2018 14:18:12 -0700 (PDT)
Message-Id: <20180728.141812.1026007723536955024.davem@davemloft.net>
To:     dima@arista.com
Cc:     nharold@google.com, fw@strlen.de, steffen.klassert@secunet.com,
        linux-kernel@vger.kernel.org, herbert@gondor.apana.org.au,
        0x7f454c46@gmail.com, netdev@vger.kernel.org, luto@kernel.org,
        ard.biesheuvel@linaro.org, hpa@zytor.com, mingo@redhat.com,
        john.stultz@linaro.org, kirill.shutemov@linux.intel.com,
        oleg@redhat.com, sboyd@kernel.org, rostedt@goodmis.org,
        tglx@linutronix.de, x86@kernel.org, linux-efi@vger.kernel.org,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        mchehab+samsung@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, eparis@redhat.com,
        kadlec@blackhole.kfki.hu, pablo@netfilter.org, paul@paul-moore.com,
        coreteam@netfilter.org, linux-audit@redhat.com,
        netfilter-devel@vger.kernel.org, fan.du@intel.com
Subject: Re: [PATCH 00/18] xfrm: Add compat layer
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1532795215.2679.27.camel@arista.com>
References: <1532703111.2679.20.camel@arista.com>
        <CADhJOfam+cY8uD4XTGvZSEFQdAgTu49G6cg6c64NJoP3bNuBmw@mail.gmail.com>
        <1532795215.2679.27.camel@arista.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 28 Jul 2018 14:18:21 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Safonov <dima@arista.com>
Date: Sat, 28 Jul 2018 17:26:55 +0100

> Well, I think, I'll rework my patches set according to critics and
> separate compat xfrm layer. I've already a selftest to check that 32/64
> bit xfrm works - so the most time-taking part is done.

The way you've done the compat structures using __packed is only going
to work on x86, just FYI.

The "32-bit alignment for 64-bit objects" thing x86 has is very much
not universal amongst ABIs having 32-bit and 64-bit variants.
