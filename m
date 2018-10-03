Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C42C64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 848A62098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QCwSZ8tV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 848A62098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbeJCVOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:14:30 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:52336 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbeJCVOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:14:30 -0400
Received: by mail-it1-f194.google.com with SMTP id 134-v6so8554152itz.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 07:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Oc5qd/SkqSI1+NPCnZbx8S/CvNmLxGH9uT1b+pGn1BM=;
        b=QCwSZ8tVdu6exAHPaoSz03RPB2Dg6ZupN+CVB8iWthQvnJyP49Aet8rtqTIl9d+QB9
         M2R8hScdaVksMq1VLXKEYADYw3UCP99r+tUGP/fUGFj2v+Tlz9PLb5pQy8Bs6gMIbSkh
         BaSlq9B2R1dEM6wOvUNWnECxBv+rablHpsMew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Oc5qd/SkqSI1+NPCnZbx8S/CvNmLxGH9uT1b+pGn1BM=;
        b=UG6xBUpyWaEw5H7uVXLI8U5//RqzhP/JYP73+E9/xuCXUAKzjgKRXHAOfCF+Hjkz2j
         K1mDCBE1NHLfl8/WN191wWomQGFYrtZrTCw3BEQ/uSKnzrKr2owYgwbWcaJ1ya4CTPwy
         d6zNkVUmLQp7l08veMjJGUAJtX8b7YDT01EOrWhW66UuzrBJNp9RZhhoy8Gzi8hTHKH6
         ZA/E+2F5XXNSJjB6+hFG0gPjhGkHQXAVwzVfb3Ry5HuXYv8u3gUe88aJHtEgE27FPXK/
         tUxFDTpW54nyOKWrrNt5PMYpp5TgQmZHZWqwbFDxtFknN3BhXayG7SD7FqDRKCTPcr8O
         QlZw==
X-Gm-Message-State: ABuFfoiG8h3wM8eVn5cqdzSjIuA7KSHJHj3a0MeQYDo8s7S6XIkoC1Xd
        BlQU8Vnzy5WtocCIt0nhxDlvvoWIrbuWdaocA9nuGg==
X-Google-Smtp-Source: ACcGV62O0K2HxF4k5hM36M8aQP5iB/okSAeOrYluumFMa0TL0mJBvI9Rbj98foX7dT9wwiBRRkMLNmsPTXUE7e5nUbc=
X-Received: by 2002:a24:57cb:: with SMTP id u194-v6mr1455533ita.148.1538576752642;
 Wed, 03 Oct 2018 07:25:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:5910:0:0:0:0:0 with HTTP; Wed, 3 Oct 2018 07:25:51 -0700 (PDT)
In-Reply-To: <CAKv+Gu9dOLbiBYKp9HG+GSPML0OJ-UuXnGsJO_re2S75ZF_qNA@mail.gmail.com>
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-24-Jason@zx2c4.com>
 <CAKv+Gu-oCH4D_otvMk+R_6z_p73Le90PkdQUUPnT6q0kWVL4Jw@mail.gmail.com>
 <CAHmME9rWkLT=92QVhbYZd1oee5wYtVRnYu0BGHkGn3bXjN-OxQ@mail.gmail.com> <CAKv+Gu9dOLbiBYKp9HG+GSPML0OJ-UuXnGsJO_re2S75ZF_qNA@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 3 Oct 2018 16:25:51 +0200
Message-ID: <CAKv+Gu-d07eqZTzh04dTtCjpnG-0fKsh7=k9BQYW_bx0Ju6gDw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 23/23] net: WireGuard secure network tunnel
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 October 2018 at 16:13, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 3 October 2018 at 16:12, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>> Hi Ard,
>>
>> On Wed, Oct 3, 2018 at 1:15 PM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>>> > +config WIREGUARD
>>> > +       tristate "WireGuard secure network tunnel"
>>> > +       depends on NET && INET
>>>
>>> I think you need to add IPV6 here
>>
>> Nope. Like much of the net tree, WireGuard can function on ipv6-less
>> kernels. If you do find something in WireGuard isn't working in a
>> v6-less configuration, I consider that to be a bug that needs fixing.
>>
>
> OK. I hit a build error yesterday, and setting CONFIG_IPV6 fixed it.
> Let me see if I can reproduce.

I get

drivers/net/wireguard/socket.o: In function `send6':
socket.c:(.text+0x56c): undefined reference to `ipv6_chk_addr'
drivers/net/wireguard/socket.o: In function `wg_socket_send_skb_to_peer':
socket.c:(.text+0x904): undefined reference to `ipv6_chk_addr'
drivers/net/wireguard/socket.o: In function `wg_socket_init':
socket.c:(.text+0x161c): undefined reference to `ipv6_mod_enabled'

if I build my kernel with WireGuard built in but IPv6 support enabled
as a module.
