Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C42ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 18:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC10620779
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 18:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pf5HS34g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC10620779
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731948AbeGMS2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 14:28:52 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34580 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731119AbeGMS2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 14:28:51 -0400
Received: by mail-oi0-f68.google.com with SMTP id 13-v6so63858851ois.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 11:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qop5IxV6RcoTDB/Lt4qWrcoaLpC27ka4Ke3FcS3VCag=;
        b=pf5HS34gC/rJ3gFYn6Xru+GORC2+Lg0PQqkqZkW9rCE8AkPqKMFLeWc3LRQL2QvnYI
         Q225bQQF84LOMzFgxOWgDjVBD87nT14TjvVlNCd25s3JEcPxl/KGsWMmV1CprUdp2+GA
         RU28PafSBQOJ5QwaYY3XgGCFZLJvrkC1POGcJx86ir7gfu3xBJeSlh76AIyLYu6Ye2cH
         8WEHze6hBxtGVU/N3qVRlaB4xJRXGSzie0ykDwAgMPCsec2L9WS9qBJs9Hq6PNVWmHHs
         24K1UG4rBkbO7SHXVQPNwRp0KxCKYqFqk1od26g3MEgCZ+u9fN284HzFJDUixq3dkWkK
         mxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qop5IxV6RcoTDB/Lt4qWrcoaLpC27ka4Ke3FcS3VCag=;
        b=HzvNvPEfGq/aq+4WKJl6rVNyrxmZbLD6Wz+RQ4l+Vi0r5+eEcFWzfXxVhA4/JWpkbm
         kGLcat9GTPreGzQOQzF7CAuorVKOIcbagY60AYNUL0OOy9HF2p9OytdaIxvXqFqcYVBd
         HpFTumZAFtEdnXryROsREu30XgoeS4M3G7fiYXEPuTOvPTtZQO6k2DIDhe4eVgQG9Z1C
         Qdq3Xu6OgdoxR/CDF1Z1nZO0moF1Y9ig/QHep3bfEwJNk9ofIvpvcrjO+QgLBTLS9C33
         oyxrE8erXBEcJ03Q8w4De5FgaNJhaqGmUwSYZqr4HigTEHKt08C9usIOpnwE0HtyZUWp
         PVrQ==
X-Gm-Message-State: AOUpUlH+YsOl7GPLYyyQtX31NM5W2vOFcwsqYZ3eqSnJ+GeXKUMaSBgs
        AhjlDxkkSTy45DqGt+15h2yuQFp+VNB3/o2qJtkGAA==
X-Google-Smtp-Source: AAOMgpcVK/90U91c/Rflu/XKes5FPhq/5DZjmFv+A4K+6cCQgP9o4puIQbL63qWbnKJhVgMZ5+ym17kOE5gzNBw+Hsw=
X-Received: by 2002:aca:a641:: with SMTP id p62-v6mr8168945oie.151.1531505587188;
 Fri, 13 Jul 2018 11:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180626165812.4141-1-jae.hyun.yoo@linux.intel.com>
 <CAFd5g45z--ucXf-So517tgrayZT6x2TGvaUvaDF7zeRNn7CPXw@mail.gmail.com>
 <e51471e6-0f8a-bffc-34c8-1e74239fdbcf@linux.intel.com> <CAFd5g47j_h4ZrT8Eg1FZ8sAj5ekCUH20jUVub75ozdkg8_YW7Q@mail.gmail.com>
 <921b1ab7-9c9f-0aeb-da89-5a1a27d009f0@linux.intel.com> <d3f10fc1-635b-3a5d-a967-2816eac005fc@linux.intel.com>
In-Reply-To: <d3f10fc1-635b-3a5d-a967-2816eac005fc@linux.intel.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 13 Jul 2018 11:12:55 -0700
Message-ID: <CAFd5g47zdPdqqjVJtNHtFk+jKgciKbMcEH9M-W9rL4DgLM5hkg@mail.gmail.com>
Subject: Re: [PATCH] i2c: aspeed: Improve driver to support multi-master use
 cases stably
To:     jae.hyun.yoo@linux.intel.com
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        james.feist@linux.intel.com, vernon.mauery@linux.intel.com,
        Benjamin Fair <benjaminfair@google.com>,
        Patrick Venture <venture@google.com>, gary_hsu@aspeedtech.com,
        Ryan Chen <ryan_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 10:22 AM Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
>
> On 7/12/2018 11:21 AM, Jae Hyun Yoo wrote:
> > On 7/12/2018 2:33 AM, Brendan Higgins wrote:
> >> On Wed, Jun 27, 2018 at 10:55 AM Jae Hyun Yoo
> >> <jae.hyun.yoo@linux.intel.com> wrote:
<snip>
> >> <snip>
> >>>>> +       for (;;) {
> >>>>> +               if (!(readl(bus->base + ASPEED_I2C_CMD_REG) &
> >>>>> +                     (ASPEED_I2CD_BUS_BUSY_STS |
> >>>>> +                      ASPEED_I2CD_XFER_MODE_STS_MASK)))
> >>>>
> >>>> Is using the Transfer Mode State Machine bits necessary? The
> >>>> documentation marks it as "for debugging purpose only," so relying on
> >>>> it makes me nervous.
> >>>>
> >>>
> >>> As you said, the documentation marks it as "for debugging purpose only."
> >>> but ASPEED also uses this way in their SDK code because it's the best
> >>> way for checking bus busy status which can cover both single and
> >>> multi-master use cases.
> >>>
> >>
> >> Well, it would also be really nice to have access to this bit if
> >> someone wants
> >> to implement MCTP. Could we maybe check with Aspeed what them meant by
> >> "for
> >> debugging purposes only" and document it here? It makes me nervous to
> >> rely on
> >> debugging functionality for normal usage.
> >>
> >
> > Okay, I'll check it with Aspeed. Will let you know their response.
> >
>
> I've checked it with Gary Hsu <gary_hsu@aspeedtech.com> and he confirmed
> that the bits reflect real information and good to be used in practical
> code.

Huh. For my own edification, could you ask them why they said "for debugging
purpose only" in the documentation? I am just really curious what they meant by
that. I would be satisfied if you just CC'ed me on your email thread with Gary,
and I can ask him myself.

>
> I'll add a comment like below:
>
> /*
>   * This is marked as 'for debugging purpose only' in datasheet but
>   * ASPEED confirmed that this reflects real information and good
>   * to be used in practical code.
>   */
>
> Is it acceptable then?

Yeah, that's fine.

<snip>

Cheers
