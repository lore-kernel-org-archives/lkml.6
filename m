Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD78ECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B11D120883
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="J4DroyfD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="inE0l6ky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B11D120883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733187AbeGLVuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 17:50:05 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:46094 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733172AbeGLVuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 17:50:04 -0400
Received: by mail-yw0-f195.google.com with SMTP id e23-v6so10510834ywe.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 14:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ONWqKtYhc/tnXsuDckqvurPMc6P9qtgDSuq4r0nbps4=;
        b=J4DroyfDK48lgFYDmjLyIp3pw/MImrCE4u0CPCWPOQvqSbA750hoPwB4VYnk36qCiG
         ZpVRTcMcSLbcTI3EjGTpH/sjz8XWdcMuCAJjoBv3cfs2xB0McVlYQzTaPPgDQ2mSO3re
         gqvgEr3oqfg30ITB5JLxmlh9ElvbCbRTjRoTgG1Q0+blJFdoxetHari15vj0Ih0NObAi
         mKONFp47pA4R9SC16NfDHr57lfmBmHhWpNfd7w674L+5Ugx2bXNdmMqdmMTSm7RjyFVk
         Wau5NoaKxdwNDeT8fM0qflODlW310jyGzXEU6MZMd1dCNZUO+53R0Ygspefd429xZMvB
         4PdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ONWqKtYhc/tnXsuDckqvurPMc6P9qtgDSuq4r0nbps4=;
        b=inE0l6kyYayWY0L5rOf7MQJ5wYstA8xRtKHl/0Tp5FJtypciRVz8IDlhwBi9ldkl9N
         RTH/ITeGq8PFcEMStBBv8fa5fy3ii0xGyFYnFOP2RWbLXkC+QN/DgpZfZTrx1TT70W0L
         9Xg1Ijv605I10Cw8XhtuRMYABqhAi4i9eaSYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ONWqKtYhc/tnXsuDckqvurPMc6P9qtgDSuq4r0nbps4=;
        b=Sxx/VdkfB8DTSzSsExB0G3bMXAE2x9jCE6nrgFzoq+0MtzsevLtgP1vQpqcuXlgRog
         IWln9belBAnhYNt/ll/qnn8iqIAqAAT9frHz3PgWyi9Gt8NU4VJd5zPOt6oP9BKYRZr7
         MNM49hDaOobLcxaeIGibyOUiwd2xa/zjTnu/f/hciuxKADTGDMcexF5Cf4Z1vLdmcqye
         O7Gp7IaZtdGQYpJ9Ld+nq8Vs3QLiMQF050EE8v6Jmw4Q5BFc1w6LGRQ70kee/n0hRm8E
         +tthUlkLQqr1ND4r5OXblC/gPY+iKey1cDNcedJjlPlPG0DFTNOi8SApelSV+t7QtAm+
         YeKg==
X-Gm-Message-State: AOUpUlH0+qZsFcrUbgl/uBMAezKePcdeXtq/UU3MeqLWw1GFw3Iqfkpe
        JZqWXVlSKMHYfiEfbzOIrXzCfz/V0hjSk0iXJVyd+Q==
X-Google-Smtp-Source: AAOMgpf880B7EX6ENTGddObG5zaj7O9qeYccQUjidPmQKsFeV4rMMWR8PHt0dbB8ELyaP/F7evrn9yj6hjYjoCyAWMQ=
X-Received: by 2002:a0d:f002:: with SMTP id z2-v6mr2131459ywe.116.1531431517788;
 Thu, 12 Jul 2018 14:38:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 14:38:37
 -0700 (PDT)
In-Reply-To: <CAK8P3a3zvmAtkmqHhNO4788WQ8kbunSW8Jp-nA+hYHc2YmziEg@mail.gmail.com>
References: <20180711203619.1020-1-keescook@chromium.org> <20180711203619.1020-14-keescook@chromium.org>
 <CAK8P3a1k+cy9wAVNQMWE4tdA4aV8tiu6K3haLc+kMPt0iiUQ9Q@mail.gmail.com>
 <CAGXu5jLUME9cjntUUed9EYukzEaODDzqRmtGht=uu7YVAG2WWg@mail.gmail.com>
 <CAGXu5jK7iRv1HE7JgW95vTgg5vhye4dxjfoQyN3G7HZzp7nZhA@mail.gmail.com> <CAK8P3a3zvmAtkmqHhNO4788WQ8kbunSW8Jp-nA+hYHc2YmziEg@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 12 Jul 2018 14:38:37 -0700
X-Google-Sender-Auth: mCR6trw6s4VU_86QjS7KxqAVPr0
Message-ID: <CAGXu5j+ckXWYmPodbp5WW91HayRF8E4-DGk1fVsXmL8k0BmefA@mail.gmail.com>
Subject: Re: [PATCH v4 13/14] rxrpc: Prepare to remove VLA usage for SKCIPHER_REQUEST_ON_STACK
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Eric Biggers <ebiggers@google.com>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, qat-linux@intel.com,
        dm-devel@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 2:15 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Jul 12, 2018 at 10:30 PM, Kees Cook <keescook@chromium.org> wrote:
>> Actually, I think this can actually be adjusted to just re-use the
>> stack allocation, since rxkad_verify_packet() finishes one before
>> doing another in rxkad_verify_packet_1():
>
> That looks very nice, yes. The same thing is needed in
> rxkad_secure_packet(), right?

Yup. 4 leaf functions and the 2 callers.

-Kees

-- 
Kees Cook
Pixel Security
