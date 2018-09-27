Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186ABC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7D1216E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="1rQsKvHV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC7D1216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeI0Tov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 15:44:51 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:37177 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726953AbeI0Tov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 15:44:51 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 622fc1b8;
        Thu, 27 Sep 2018 13:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=kJbJIBwFj1VSoSN+yDEDgJrLb7w=; b=1rQsKv
        HVyfezV6JkNzI87kCjJpuJZuF0nNPPTkbI73haqgEtGfznNvYW6cz9eU318yCGav
        n2UDTdAdrrGc8GDWcnEhzcOHlL1gdJ83HTup9NUgvC+lIEwevzEzFn9gaj+xbeja
        T0b7N6KvGxZnq3vOQItKTP0LVQiSEZslv2CUxIZHLIUnpNGp02u0PhiWK5Laln4a
        +Qyn8/Loi35sdfIjb3RU6N/yLmVDLFwSaWbqhZem2c0RbuyiXvpoe/QpKPxp8cE+
        4hUOVyZjCNFswMWMfm+oUeH4KcdJXzX9kOT4DFN6VHIol1tfSi9kh6jkP+0qrmqY
        x6h0jCMkhugCoYiw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6cec1f13 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Thu, 27 Sep 2018 13:07:51 +0000 (UTC)
Received: by mail-oi1-f172.google.com with SMTP id d63-v6so2087355oic.12;
        Thu, 27 Sep 2018 06:26:31 -0700 (PDT)
X-Gm-Message-State: ABuFfoj8FvSuqL88Ye1ByeAoEQwHMCGPEsN1DT8FPL0BJ+IG744mOyMM
        8T6ZdvI8vQp/keDVT69FPbF1sdMq/bAvnPoOgM8=
X-Google-Smtp-Source: ACcGV61HW6kmnKtZpPcyeCXvaN5gKv2xZjcNgitwxISY0LIhUfGpUeBkN+xGGrGkMeeGRjR0YViYgiv8Dvp1lQ/nVTA=
X-Received: by 2002:aca:df42:: with SMTP id w63-v6mr3037351oig.295.1538054790312;
 Thu, 27 Sep 2018 06:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-8-Jason@zx2c4.com>
 <CAKv+Gu9mVAfdBvOMCFqRJj+wBiWu3JVOgPZdkcdjzqSdQQ5Jrw@mail.gmail.com>
 <CAHmME9r9KppoFwwNVpzpYbU+9dCPzb7Pit+4iRa4MY_ouJBWrA@mail.gmail.com>
 <CAKv+Gu8ih-TsASRGqK+ST_5+EQ0=Zo-zhGCadOdGyPjucMFTCg@mail.gmail.com>
 <CAKv+Gu8w74dUSEAGxxh=C6To6F=bSm8DjiExUPmh_LUyhoDLhg@mail.gmail.com>
 <CAHmME9pbRabkGjNh-65S9qBNNS1GLJSwZ_tTM507S_Ezr1=QLg@mail.gmail.com>
 <CAHmME9ru=kJO8QiW+uNNgt5NgFVZzRsQ4tNSgo+f+KfHs3fAKQ@mail.gmail.com>
 <CAKv+Gu-WDt8f9qVjLDRPHL7THS0BjtKHThw2RMfHbWBT8Hs8aQ@mail.gmail.com> <CAHmME9qNn5aRgtbV3bAsz3xW1A49a7RMMkOzGruBUPzLVUxVNg@mail.gmail.com>
In-Reply-To: <CAHmME9qNn5aRgtbV3bAsz3xW1A49a7RMMkOzGruBUPzLVUxVNg@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 27 Sep 2018 15:26:18 +0200
X-Gmail-Original-Message-ID: <CAHmME9rN3-7Mj5JQqt2EFPauG9vjkN5pQn3tPiJY4fPiwksaDA@mail.gmail.com>
Message-ID: <CAHmME9rN3-7Mj5JQqt2EFPauG9vjkN5pQn3tPiJY4fPiwksaDA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 07/23] zinc: ChaCha20 ARM and ARM64 implementations
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

I'm trying to optimize this for crypto performance while still taking
into account preemption concerns. I'm having a bit of trouble figuring
out a way to determine numerically what the upper bounds for this
stuff looks like. I'm sure I could pick a pretty sane number that's
arguably okay -- and way under the limit -- but I still am interested
in determining what that limit actually is. I was hoping there'd be a
debugging option called, "warn if preemption is disabled for too
long", or something, but I couldn't find anything like that. I'm also
not quite sure what the latency limits are, to just compute this with
a formula. Essentially what I'm trying to determine is:

preempt_disable();
asm volatile(".fill N, 1, 0x90;");
preempt_enable();

What is the maximum value of N for which the above is okay? What
technique would you generally use in measuring this?

Thanks,
Jason
