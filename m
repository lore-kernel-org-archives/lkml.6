Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F6CECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ABF82150B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B5KnYulF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ABF82150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbeISACm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 20:02:42 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:53515 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730206AbeISACm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 20:02:42 -0400
Received: by mail-it0-f68.google.com with SMTP id p79-v6so4686152itp.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 11:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=u66qutQ6tD80qdjjbHVikkBezrMRhJw3DiD9PLTFHg0=;
        b=B5KnYulFxGkJFqUCw1Ga+8gMXUzM2BjEUDVabSPKcFw0C4v2QcFKgHNbAZ6wBKgRBT
         m+vx0c9Ecwhv/7XknqLJj3en+SJZ2ofVHBZdDpuOPcdpaCnkuZX0LSLCvqC4iV3GGQYv
         xbl9Iut7bc0zNYvuyv3YccoAHXz7cOgevmeLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=u66qutQ6tD80qdjjbHVikkBezrMRhJw3DiD9PLTFHg0=;
        b=IU2UhQ7vmer4Uw84e60MV+b8P+04mFSdlJ4LmodCnv34ZlvPKpsh1BrDEc8X4Oxz6b
         DAQy+1gWt/zuUG8S5gNqYNB1zc0K/5kBjFHmzHtr/kqcx6uzKMDIb64h9THEmfSFiAqF
         nq70gfgGzRMR8E3/gel2l2yTvc8yDZfKW4g83Jn7B+TIfHdMtSoRH5t8No8ZlVF0u+oD
         VsKbYNAvGcZf2toHS+YtbHtnTvG5Q7NIKZn1EyC14qIv2i0tuorT0M471HRiswF83jIf
         O/nvLU7ZqAJQXUH2oDrb7cuxw76cLIseO9fHjPjMGRzaui8a9teV3fn9b5NBrUZOXtHq
         0ydA==
X-Gm-Message-State: APzg51Do5E4trcK5SvsCC5mE5hYY1aItxedJ2/MiXjPXQ/74VFUdHiGy
        RTUxnV64UVSwPkCcOjDEwzZmL0BhbPDF7CCZa9QWqA==
X-Google-Smtp-Source: ANB0VdZm+IC6xQdxdPXAHVJmQX5XU1qKuKx2LyLAGhq39l+aRff6PDIkGrZGqfTlRQfkQALFght3dXVq6Thmm50a1Lo=
X-Received: by 2002:a24:57cb:: with SMTP id u194-v6mr17810280ita.148.1537295331276;
 Tue, 18 Sep 2018 11:28:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:2848:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 11:28:50
 -0700 (PDT)
In-Reply-To: <20180918161646.19105-1-Jason@zx2c4.com>
References: <20180918161646.19105-1-Jason@zx2c4.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 18 Sep 2018 11:28:50 -0700
Message-ID: <CAKv+Gu8doWS+BYzqoT7499CJX0hLm1jBSMfVxJoG3wsWFO7t1w@mail.gmail.com>
Subject: Re: [PATCH net-next v5 00/20] WireGuard: Secure Network Tunnel
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

On 18 September 2018 at 09:16, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> v5 has the most comprehensive set of changes yet, and I think should
> finally address all of the relevant issues brought up on the mailing
> list. In particular, this feedback has come from:
>
>   - Andy Lutomirski
>   - Eric Biggers
>   - Ard Biesheuvel
>   - Kevin Easton
>   - Andrew Lunn
>   - Martin Willi
>
> Changes v4->v5:
> ---------------
>   - Use fewer inlines, except when measured as necessary.
>   - Reduce size of scattergather array to fit within stack on
>     small systems.
>   - Account for larger stack frames with KASAN.
>   - The x86_64 implementations are selected according to input length.
>   - Avoid using simd for small blocks on x86_64.
>   - The simd_get/put API is now pass by reference, so that the user
>     can lazily use the context based on whether or not it's needed.
>     See the description again in the first commit for this.
>   - Add cycle counts for different sizes for x86_64 commit messages.
>   - Relax simd during chapoly sg loop.
>   - Replace -include with #if defined(...)
>   - Saner and simpler Kconfig.
>   - Split into separate modules instead of one monolithic zinc.
>   - The combination of these three last items means that there no
>     longer are any conditionals in our Makefile.
>   - Martin showed a performance regression using tcrypt in v4. This
>     has been triaged and fixed, and now the Zinc code runs faster
>     than the previous code.
>   - While I initially wasn't going to do this for the initial
>     patchset, it was just so simple to do: now there's a nosimd
>     module parameter that can be used to disable simd instructions
>     for debugging and testing, or on weird systems.
>

I was going to respond in the other thread but it is probably better
to move the discussion here.

My concern about the monolithic nature of each algo module is not only
about SIMD, and it has nothing to do with weird systems. It has to do
with micro-architectural differences which are more common on ARM than
on other architectures *, I suppose. But generalizing from that, it
has to do with policy which is currently owned by userland and not by
the kernel. This will also be important for choosing between the time
variant but less safe table based scalar AES and the much slower time
invariant version (which is substantially slower, especially on
decryption) once we move AES into this library.

So a command line option for the kernel is not the solution here. If
we can't have separate modules, could we at least have per-module
options that put the policy decisions back into userland?

* as an example, the SHA256 NEON code I collaborated on with Andy
Polyakov 2 years ago is significantly faster on some cores and not on
others


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
