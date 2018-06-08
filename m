Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id fVj0AV1SGlvHFwAAmS7hNA
	; Fri, 08 Jun 2018 09:55:11 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 44A89607A4; Fri,  8 Jun 2018 09:55:11 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hauMv+Jr"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 94B43605A5;
	Fri,  8 Jun 2018 09:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 94B43605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752769AbeFHJzI (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 05:55:08 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41099 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751128AbeFHJzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 05:55:06 -0400
Received: by mail-pl0-f66.google.com with SMTP id az12-v6so8008048plb.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 02:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EYO0vZ1erv6BX3KHgti8Jao7dcT7CUE+D1ALzL5tdWU=;
        b=hauMv+JrRoQ4nFtVVUdTA3Xb5zKUtR7WpZcRRXy9Cn9AgWNzX23AH1RqsS9wGj85xF
         hGh7NjDDUlC/Ihb9eamycycoxEEXDSly3t+UZbW8g83aYUHf8f5F1h1YtRzLrwJXOhFB
         F2HUqXwAm+j05f0YnTqBS00frn9kGXm10q+zH1o3hXYCIhMAQkKLoPb3S61KfPYlnQK9
         VsI8IXnXLrTnwVs9ckpx5o716yNf3VUwKAKNFXf6pGXjv09RM9FmP0glrDxpZBu1OCEO
         qogH6K7c1rR60AJWLqX6QiOg8WiExnWQZYgojnSZ5gjGimcIwbEt/9N9rNh1KlvRe3CG
         MGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EYO0vZ1erv6BX3KHgti8Jao7dcT7CUE+D1ALzL5tdWU=;
        b=Hs5XCPxKp3tNl1dFzXmejiD7VJZGafxnMSma1AN6hwW3KkYjDDGX4/hpQwwYl2cHxq
         yBEYHMHnlQkn9QJBZOcfx5LZvxoHZDYA0qB+GyTnGZXNP7feB26Clm9UZIy/7SMBAEa4
         KNbvK5LPciQNfKQt7/e4x9zTn/VV46YRuesjuxvwXOiiHPlA2ryxEgLk7P83TzOBxggh
         hI4wtnEpiI1aDmXgmREG4K8YLHXwWXqfiF3LGAJj7Y7miISDKywtJe+wCTHLPFy4xGRG
         LAS5DbugARsbWtbk9yGXS/7Fr/T9zGvL6Ie8DQ3QAjOW/1DY5SR0pxp8jyMHgv1MV+Pq
         or1w==
X-Gm-Message-State: APt69E3F2I2LEapx2yfPVNIIuKFaOzzUlDpUJfcwhbdJyEwkhGx12D8a
        5iMnMnqRRlzQcWWHEFlKOYuqOwDh6dwJ73QgzQiayQ==
X-Google-Smtp-Source: ADUXVKIFy2Y+lojwKSrCSfVUjl2ekRINaibxKX+CSxLPlnXu/f5CUf/zl6KX9tQTgqBONzU/NxsG2mG5est9dd9XpkM=
X-Received: by 2002:a17:902:8486:: with SMTP id c6-v6mr5669884plo.283.1528451705674;
 Fri, 08 Jun 2018 02:55:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:d42:0:0:0:0 with HTTP; Fri, 8 Jun 2018 02:54:45
 -0700 (PDT)
In-Reply-To: <20180526072203.GA724@sol.localdomain>
References: <001a11449aa2faf11805643af581@google.com> <CACT4Y+YOmbZGdBbFpmjRJXABGe1tD=F+3na77DwoPCEaROADyw@mail.gmail.com>
 <20180202221829.tdiji2332t7orcxj@gmail.com> <CACT4Y+afpDQ7A3caRmskML06h8Q6+NkVAn6HtV93ExPec-g2pA@mail.gmail.com>
 <20180526072203.GA724@sol.localdomain>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 8 Jun 2018 11:54:45 +0200
Message-ID: <CACT4Y+Zh8eWPLTrVyOufeXd6LMcUdQr8Q07OWWGTTgwOYT6Gvg@mail.gmail.com>
Subject: Re: WARNING: kernel stack regs has bad 'bp' value (3)
To: Eric Biggers <ebiggers3@gmail.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        syzbot <syzbot+ffa3a158337bbc01ff09@syzkaller.appspotmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
        <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26, 2018 at 9:22 AM, Eric Biggers <ebiggers3@gmail.com> wrote:
> On Sat, May 12, 2018 at 10:43:08AM +0200, Dmitry Vyukov wrote:
>> On Fri, Feb 2, 2018 at 11:18 PM, Eric Biggers <ebiggers3@gmail.com> wrote:
>> > On Fri, Feb 02, 2018 at 02:57:32PM +0100, Dmitry Vyukov wrote:
>> >> On Fri, Feb 2, 2018 at 2:48 PM, syzbot
>> >> <syzbot+ffa3a158337bbc01ff09@syzkaller.appspotmail.com> wrote:
>> >> > Hello,
>> >> >
>> >> > syzbot hit the following crash on upstream commit
>> >> > 7109a04eae81c41ed529da9f3c48c3655ccea741 (Thu Feb 1 17:37:30 2018 +0000)
>> >> > Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide
>> >> >
>> >> > So far this crash happened 4 times on net-next, upstream.
>> >> > C reproducer is attached.
>> >> > syzkaller reproducer is attached.
>> >> > Raw console output is attached.
>> >> > compiler: gcc (GCC) 7.1.1 20170620
>> >> > .config is attached.
>> >>
>> >>
>> >> From suspicious frames I see salsa20_asm_crypt there, so +crypto maintainers.
>> >>
>> >
>> > Looks like the x86 implementations of Salsa20 (both i586 and x86_64) need to be
>> > updated to not use %ebp/%rbp.
>>
>> Ard,
>>
>> This was bisected as introduced by:
>>
>> commit 83dee2ce1ae791c3dc0c9d4d3a8d42cb109613f6
>> Author: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Date:   Fri Jan 19 12:04:34 2018 +0000
>>
>>     crypto: sha3-generic - rewrite KECCAK transform to help the
>> compiler optimize
>>
>> https://gist.githubusercontent.com/dvyukov/47f93f5a0679170dddf93bc019b42f6d/raw/65beac8ddd30003bbd4e9729236dc8572094abf7/gistfile1.txt
>
> Note that syzbot's original C reproducer (from Feb 1) for this actually
> triggered the warning through salsa20-asm, which I've just proposed to "fix" by
> https://patchwork.kernel.org/patch/10428863/.  sha3-generic is apparently
> another instance of the same bug, where the %rbp register is used for data.


Mailed "crypto: don't optimize keccakf()" to fix this.

Amusingly __optimize("O3") always lead to degraded performance as gcc does not
inline across different optimizations levels, so keccakf() wasn't inlined
into its callers and keccakf_round() wasn't inlined into keccakf().
