Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F04BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 02:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F11205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 02:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="jY4zAGqe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfAQCst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 21:48:49 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41843 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfAQCst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 21:48:49 -0500
Received: by mail-qk1-f193.google.com with SMTP id 189so5158444qkj.8;
        Wed, 16 Jan 2019 18:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9li+6dKy82nfP6IXQsUZqEUGFFE4s5Pj00jdazTthFk=;
        b=jY4zAGqe8y8lpCsiqm9m/KgiUQIb1k1LqXm1c1HZwSetLbw3QaLuNxhzvmDtYUikhH
         78ZiNXtzSwVMj5I27BCu4Og6AyvZzw8VHn6R604WuRv1/KwuVye1fws4SAOZ2Do5vobR
         kP6lT2gRCVsplGc/JmboPjzSqK76BiScRtMq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9li+6dKy82nfP6IXQsUZqEUGFFE4s5Pj00jdazTthFk=;
        b=JO42BrNHmgc5kfx7kn0Tqevj+vJ+GFfowuLpR6CmUHaVudSnam03iWBGsb78tssSxW
         xOIGoJOEvuA83RvZij4Zi37rVw9O3yzM8Qe3uML/gbasv2pkO7MoEApMap0Pm/7orj1x
         HFYOm5r26sdb+yBGyksNMoGYLXNR9uikk20ulzZDfof2SL2ckHH20u2dZOJOX/KqGaDh
         kWaVjYRz2o6A8oyyj+TAQVZ1jPQHF+mAe21x+mUKKf3v/G4axnk2SMQS5AI5fmuq6uMY
         KCewKTvNHjvRk7imJCd1DPVekOkp8gGOppyFZn10LOpnGkwgEjcexHZT+x93XHmJPOsF
         7ixg==
X-Gm-Message-State: AJcUukf5KidTJ/6C4T0BETBrt6QlQnyie5KebXHDHI+PPJ2WjZuvs0VJ
        3TrGB5n8rbUNsGgzyGKvRSnbTSP6IlAG/MgcqYY=
X-Google-Smtp-Source: ALg8bN6S0ZkkQqCqSM52W9OpcMUcZwXcTDuxo85athkDUTfOiowTNeCMIfLjqWY72yeyKjpfjJU/S5kXnmbQZeQpeek=
X-Received: by 2002:a37:61cd:: with SMTP id v196mr9332441qkb.25.1547693327920;
 Wed, 16 Jan 2019 18:48:47 -0800 (PST)
MIME-Version: 1.0
References: <20181217200405.2904551-1-vijaykhemka@fb.com> <20181217200405.2904551-4-vijaykhemka@fb.com>
 <F23E6426-F6FE-4F10-A88A-D5862D5407B4@fb.com>
In-Reply-To: <F23E6426-F6FE-4F10-A88A-D5862D5407B4@fb.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 17 Jan 2019 13:48:36 +1100
Message-ID: <CACPK8Xfn_iNWe+iWash2MV2e+Uz_0mV9Hwz_PdgNzfYpmrLvcw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] ARM: dts: aspeed: Add lpc ctrl for Facebook
To:     Vijay Khemka <vijaykhemka@fb.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2018 at 05:06, Vijay Khemka <vijaykhemka@fb.com> wrote:
>
> =EF=BB=BFOn 12/17/18, 12:04 PM, "Vijay Khemka" <vijaykhemka@fb.com> wrote=
:
>
>     Added lpc ctrl device to enable LPC clock in Facebook
>     Tiogapass device tree.
>
>     Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
>
> Joel, Can you please take care of these patches merge.

I did not apply this one as I think the description will change once
we've merged your aspeed-lpc-ctrl patch.

Cheers,

Joel
