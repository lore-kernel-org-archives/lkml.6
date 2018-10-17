Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6284ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21CF21528
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A21CF21528
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbeJQXzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:55:24 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39976 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQXzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:55:24 -0400
Received: by mail-qt1-f196.google.com with SMTP id b4-v6so30589011qtc.7;
        Wed, 17 Oct 2018 08:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wa8Hz74WuWs5Y9Y8/AaZ1FlIna5rAZrowvlglhcw5EI=;
        b=WjJzy2tOSAOARMGjjEJSM+pAExJ7zNs5+x6IFLjwSov8cXte6WMXWFHYtKWSUSU8sn
         H6shX5DlLC6dNMqmdU1GW6pBIF2oyOflC15TojUKE85sY++jFJ/pYQ5sbONFQ+zm7h/t
         qpObRNodA5MT0TtsgYuDJ6m4zmNpfT12T5QxhLjXvraE5Bo1rQcCQJwivXnxsoN1ONGD
         KxnAuoxRvRpP5IHJ1mE37yTLYKujEDvhmlwNoykwRLq9YHNPK1URCgLqYN0e4DZoLXXv
         HqpEBA6m5vXS7uExnjIAOguFG7bsZSTHFkp0TqZ6RnjnLZkT199kcWfvBcUYzbHLRep+
         NoYQ==
X-Gm-Message-State: ABuFfoh58xxAzO7YZ9sBmccaEDxh8mIHAsXkcldWlk14pL70r371daco
        qDE/ERbZ5nojdhWUvAzhZKYE8tG1zsTYA5k1Wp8=
X-Google-Smtp-Source: ACcGV63y//1TzyN4CeWlhYtyYu9Ps2H8kCzKZ53H7mC+xFtOT/o21v1TktXuzLEqTt7aRHrMXr5dsvd8qiYkK87KCmc=
X-Received: by 2002:a0c:e150:: with SMTP id c16mr27049856qvl.161.1539791942545;
 Wed, 17 Oct 2018 08:59:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539655731.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1539655731.git.ren_guo@c-sky.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 17 Oct 2018 17:58:46 +0200
Message-ID: <CAK8P3a25W5rE093QsmC539d+s038Wv9PmV8Xa76LQzDLk3E8Wg@mail.gmail.com>
Subject: Re: [PATCH V9 00/21] C-SKY(csky) Linux Kernel Port
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Miller <davem@davemloft.net>,
        gregkh <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 4:58 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> This is the 9th version patchset to add the Linux kernel port for
> C-SKY(csky) based on linux-4.19-rc3.
>
> There are only a few changes between V8 patchset. Hope it could be
> merged into linux-4.20 and I'm very grateful for any help.

I've gone through the entire series once more and saw no show-stoppers.
The last patch looked like it introduced a bug, but with that one dropped,
I'm happy for the architecture to get merged, unless anyone else
has any last-minute concerns. (Alternatively, explain why I'm wrong
and the code works correctly, of course).

I'd appreciate having someone else take another look at the signal
handling code, the atomics, and the DT bindings and provide another
Ack for those.

The remaining open question is about the 32-bit time_t interfaces.
With 4.20, I did not manage to get the required system calls in place
for using 64-bit time_t in a new architecture, so you will at least
start out using 32-bit time_t and likely have to keep supporting
that going forward, unless we decide to break the ABI here later
on .This is something we normally don't do, but we might make
an exception here, under the assumption that there are no
existing users with the ABI. We can debate that once we get there.

       Arnd
