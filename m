Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB4FC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B3020866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="utaAIAB1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6B3020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbeILCMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 22:12:45 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:59133 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726870AbeILCMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 22:12:44 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 0d9cd3f5;
        Tue, 11 Sep 2018 20:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=7d2/Vp3t6DO4Yv49mC5jGFj7vTI=; b=utaAIA
        B1IA47JIb4BLGNwcif6N1BeNWgI6j/pdjcu+3eUh/W5F72GVOUNugWuwwV3RzufR
        aky9nv+h4aqQofSrqQ/VHs1KDFQfFOWMECBR+waIs2wvIRcVrw/2714bsi2n16vm
        nuZySBOl14fO16IeffmTj4zS6ZLXIwPKF/diEfie0dn/JGWVpZLTcSkit8DChBuk
        KbfIfdNoRQzabDqwT89jpIWu0Blaiie252/VbKYIs3pPOpCKJLFeQ3foxpyxJgCL
        8ae1Bylp+Dhq1txcSYQ6+uhZB+/clkQFy7seEbINGdahaMWIy4Q7HhAmhzwAzAdb
        NGuz3Exg3Ch0zyMg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d80d2deb (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Tue, 11 Sep 2018 20:54:48 +0000 (UTC)
Received: by mail-oi0-f44.google.com with SMTP id t68-v6so50008085oie.12;
        Tue, 11 Sep 2018 14:11:30 -0700 (PDT)
X-Gm-Message-State: APzg51BSL5UgKveo7SsFJ/NhxdzUKb4QQ8QlZgARIVXX+90m2MGIbO6i
        MPdENWX+fdo8hPhlOIWe3ucNGv2yN9xm/l7b3IE=
X-Google-Smtp-Source: ANB0Vda0EfLVRJ1oKWQf1sfwXxNO1ky6wv4qLf88qlpBTXLr0e86Ve4x0de2ryWjeO1R6z/AIgvceaptVwRjSc4agDQ=
X-Received: by 2002:aca:2e86:: with SMTP id u128-v6mr27179157oiu.132.1536700290059;
 Tue, 11 Sep 2018 14:11:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-19-Jason@zx2c4.com>
 <20180911133017.GJ30395@lunn.ch>
In-Reply-To: <20180911133017.GJ30395@lunn.ch>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 11 Sep 2018 15:08:07 -0600
X-Gmail-Original-Message-ID: <CAHmME9pwVSeE=4aUD6RKLjE+DrHY1=3OtBS7sAvdR66gaNhNtA@mail.gmail.com>
Message-ID: <CAHmME9pwVSeE=4aUD6RKLjE+DrHY1=3OtBS7sAvdR66gaNhNtA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 17/17] net: WireGuard secure network tunnel
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

On Tue, Sep 11, 2018 at 7:30 AM Andrew Lunn <andrew@lunn.ch> wrote:
> I don't know if any of the crypto people are reviewing the networking
> code, but i don't think there are many networking people reviewing the
> crypto code.
>
> So please can you put the change log between versions for the
> networking code here, where we can easily see it.

All submissions >v1 have had a changelog in the 00/17 commit.

> I see you have yet again completely ignored my request to either
> 1) Remove the inline
> 2) Argue why it should be kept.

Most uses of inline are this way after checking the compiler output on
several platforms. (Generally my build-run-test cycle is actually
build-IDAPro-run-test.) If you feel that's been done too liberally,
I'm happy to spend time rechecking each use case.
