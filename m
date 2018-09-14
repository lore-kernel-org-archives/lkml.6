Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE902ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82CA420853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cjxSzrq8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82CA420853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbeINWz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 18:55:29 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33110 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727946AbeINWz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 18:55:29 -0400
Received: by mail-io1-f68.google.com with SMTP id r196-v6so6715832iod.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 10:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Sgu/0xoxstt5LRMHsBtloWI7e2LbjdZizjaT/0SLVT0=;
        b=cjxSzrq8OLoKkSht27cPt1GxUcT/2MVkfvbgFELqDJVdxfthE8Nyr6jXOO/0MqJn5w
         7sROLDmAzazOL+GVg7w+nS5w2PmrobXQ26TYOI7OLInI/7A5jXUcjhlO4qc4qHiNaKE5
         wEKe8BnG8DkYuq3wwxCTe/vd/I3xU4/pJXDuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Sgu/0xoxstt5LRMHsBtloWI7e2LbjdZizjaT/0SLVT0=;
        b=MeTZdAm6TE+XZOl5S9qH5Oz+fBNVRdWwczBVlAyvRPlcKtnrEG2l4/zzbeYUF1/HlJ
         FFFuQdU9IBbirVpPckfjEPPbD7/nzQ/KUvyyVr8in9yZjUS4lBbEqfRKvEw67Q/VhHRP
         xRXi41HwxsVleXPaTJ5z6fENFbtQT9BtHvRmp7ljgbFb7aA+ddNoPBz/8otugFtA9wVc
         c0Bdk6Y7iWgVOQZi6BvUqaTD+otVfHVopFhZsdPOl6AJ2PiiDk99Vyq4/NwJG7MF9Nkb
         OPd7Td4Lzt6mq6CTAp69A59vpMmt2RqxCrPkNFInoHj1Bd+VOlXnT+xNKSIfGQ5Lopdx
         F0Ww==
X-Gm-Message-State: APzg51CBkSgXihLJ7R3CfzMMROyTUYv0/4k2dsK1/+gEdss/sJ2OF4hj
        +logEeZRqu19J32ZUbVv1NbVMzpscTawHpF1KEjQkg==
X-Google-Smtp-Source: ANB0Vda1/gJso/BmYQoLYAXfIqSl3tyRAxtT6Yimc679Uk8J+FO5VRgZPbwuk1CjlDAL9b2U9Jd2OjhbUFOi96bmxw8=
X-Received: by 2002:a6b:ba86:: with SMTP id k128-v6mr11074335iof.170.1536946798236;
 Fri, 14 Sep 2018 10:39:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:2848:0:0:0:0:0 with HTTP; Fri, 14 Sep 2018 10:39:57
 -0700 (PDT)
In-Reply-To: <20180914161954.7325-1-Jason@zx2c4.com>
References: <20180914161954.7325-1-Jason@zx2c4.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 14 Sep 2018 19:39:57 +0200
Message-ID: <CAKv+Gu_LYsNs88uF4+G1xfOtWvNPOjiiYZKqZf7qSBkvn6iEoA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 00/20] WireGuard: Secure Network Tunnel
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 September 2018 at 18:19, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Changes v3->v4:
>   - Remove mistaken double 07/17 patch.
>   - Fix whitespace issues in blake2s assembly.
>   - It's not possible to put compound literals into __initconst, so
>     we now instead just use boring fixed size struct members.
>   - Move away from makefile ifdef maze and instead prefer kconfig values,
>     which also makes the design a bit more modular too, which could help
>     in the future.

Could you elaborate on this? From the patches, it is not clear to me
how this has improved.

>   - Port old crypto API implementations (ChaCha20 and Poly1305) to Zinc.
>   - Port security/keys/big_key to Zinc as second example of a good usage of
>     Zinc.
>   - Document precisely what is different between the kernel code and
>     CRYPTOGAMS code when the CRYPTOGAMS code is used.
>   - Move changelog to top of 00/20 message so that people can
>     actually find it.
>
> -----------------------------------------------------------
>
> This patchset is available on git.kernel.org in this branch, where it may be
> pulled directly for inclusion into net-next:
>
>   * https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/linux.git/log/?h=jd/wireguard
>
> -----------------------------------------------------------
>
> WireGuard is a secure network tunnel written especially for Linux, which
> has faced around three years of serious development, deployment, and
> scrutiny. It delivers excellent performance and is extremely easy to
> use and configure. It has been designed with the primary goal of being
> both easy to audit by virtue of being small and highly secure from a
> cryptography and systems security perspective. WireGuard is used by some
> massive companies pushing enormous amounts of traffic, and likely
> already today you've consumed bytes that at some point transited through
> a WireGuard tunnel. Even as an out-of-tree module, WireGuard has been
> integrated into various userspace tools, Linux distributions, mobile
> phones, and data centers. There are ports in several languages to
> several operating systems, and even commercial hardware and services
> sold integrating WireGuard. It is time, therefore, for WireGuard to be
> properly integrated into Linux.
>
> Ample information, including documentation, installation instructions,
> and project details, is available at:
>
>   * https://www.wireguard.com/
>   * https://www.wireguard.com/papers/wireguard.pdf
>
> As it is currently an out-of-tree module, it lives in its own git repo
> and has its own mailing list, and every commit for the module is tested
> against every stable kernel since 3.10 on a variety of architectures
> using an extensive test suite:
>
>   * https://git.zx2c4.com/WireGuard
>     https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/WireGuard.git/
>   * https://lists.zx2c4.com/mailman/listinfo/wireguard
>   * https://www.wireguard.com/build-status/
>
> The project has been broadly discussed at conferences, and was presented
> to the Netdev developers in Seoul last November, where a paper was
> released detailing some interesting aspects of the project. Dave asked
> me after the talk if I would consider sending in a v1 "sooner rather
> than later", hence this patchset. A decision is still waiting from the
> Linux Plumbers Conference, but an update on these topics may be presented
> in Vancouver in a few months. Prior presentations:
>
>   * https://www.wireguard.com/presentations/
>   * https://www.wireguard.com/papers/wireguard-netdev22.pdf
>
> The cryptography in the protocol itself has been formally verified by
> several independent academic teams with positive results, and I know of
> two additional efforts on their way to further corroborate those
> findings. The version 1 protocol is "complete", and so the purpose of
> this review is to assess the implementation of the protocol. However, it
> still may be of interest to know that the thing you're reviewing uses a
> protocol with various nice security properties:
>
>   * https://www.wireguard.com/formal-verification/
>
> This patchset is divided into four segments. The first introduces a very
> simple helper for working with the FPU state for the purposes of amortizing
> SIMD operations. The second segment is a small collection of cryptographic
> primitives, split up into several commits by primitive and by hardware. The
> third shows usage of Zinc within the existing crypto API and as a replacement
> to the existing crypto API. The last is WireGuard itself, presented as an
> unintrusive and self-contained virtual network driver.
>
> It is intended that this entire patch series enter the kernel through
> DaveM's net-next tree. Subsequently, WireGuard patches will go through
> DaveM's net-next tree, while Zinc patches will go through Greg KH's tree.
>
> Enjoy,
> Jason
