Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9390C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ACBD2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzK6NfA6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ACBD2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeJDPxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:53:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40701 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbeJDPxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:53:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id d2-v6so4580814wro.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 02:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=I8r3A71406OutkwFn3d15NRczwxZZUohmDm3Zigkac8=;
        b=TzK6NfA6SMxP8HuGH0KODixI04bzmImqKQqU1w5vSZu7p9ug03wqanpxIY6IRt466H
         E6ELv1rp/+6xTTv3CJfeyD/iXDqiJOvXdHtYcD6/bwAsXfHgw1s+g5NinQbVKvTm748Q
         Td5i9F82qiDoKHNCwxLEANMQznJWP6Hf0OizXisGmkDArN4bMKMFob2R7/c5ly+TFjnc
         rfIuMVxEGSWIwSgFLUFA470B7yQCqdfemFUKj73JsBjwTAFcjq+G9CGZdEm5K+/W8LFs
         IN2j9V9gV291S3eIRKjPj37nNkdvontyYFVRZaTDciDghor2LRU1vVIre0ShmrKo65RB
         VCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=I8r3A71406OutkwFn3d15NRczwxZZUohmDm3Zigkac8=;
        b=op5L82IE5xpEawnZAXa/YZY07imOWaQnu3HGaoY5VmntdZsVPGADb9rS+gs8qDT/Be
         SYb+3PG17A5dkU5oOj9jNk3ZfmyGtmbSiR+oRM7zYyeou3u0bUutPNT8JXvqH5zmdt2B
         qt9ZytMk5jC5ZkSZr5Pa0YrQ62ZGMsEbL+m1BGbtrN2rdU9mcwZJOTMqcSjBYeY264lo
         qZTMdSjC0vms02rLYBSAaQMWW3QJTmzZPFkWSPGNfJJHSyxO9yT9ceP4bKKKc+jBY2mK
         V/+RcygKGLRnbI+zpwznABv623enVsXks/YcCD8TZIKa3XFkddNEl6vugxW6hEJ2gYZd
         maZQ==
X-Gm-Message-State: ABuFfoiSntnOkwxAgJKrQ61/KqEF/4EveEBOHinQs77UehgtRJ6H9xGK
        C7GqPAdsUHmGeZ4AqWyaF6s=
X-Google-Smtp-Source: ACcGV630//O9lQDqxtsZcgw7EuWCTLM0UFIFiF57nItsVdjMhsIHeT5ku0Is3ZcQOT+ESZgR533Olg==
X-Received: by 2002:a05:6000:48:: with SMTP id k8mr3892521wrx.103.1538643691207;
        Thu, 04 Oct 2018 02:01:31 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id h82-v6sm4382757wmf.14.2018.10.04.02.01.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 02:01:30 -0700 (PDT)
Date:   Thu, 4 Oct 2018 11:01:28 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v9 04/10] x86: refcount: prevent gcc distortions
Message-ID: <20181004090128.GA21864@gmail.com>
References: <20181003213100.189959-1-namit@vmware.com>
 <20181003213100.189959-5-namit@vmware.com>
 <20181004075755.GA3353@gmail.com>
 <65767CEA-370F-4180-9A81-116BE0BE2EA2@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65767CEA-370F-4180-9A81-116BE0BE2EA2@vmware.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Nadav Amit <namit@vmware.com> wrote:

> Finally, note that it’s not as if the binary always becomes smaller.
> Overall, with the full patch-set it is slightly bigger. But still, that’s
> how it was supposed to be if gcc wasn’t doing things badly.

So what I cited was the changelog for the refcount patch, which according to your
measurements reduced kernel image size.

For other patches where size grew I left that text intact.

And yes, in this particular case a slight increase in kernel size might actually be
beneficial, as we get a lot more straight-line execution in exchange. So this is
not a show-stopper property as long as the bloat isn't large.

Thanks,

	Ingo
