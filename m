Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F14CC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 05:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF22821872
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 05:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ELPqKfMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfAYFeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 00:34:46 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46003 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfAYFep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 00:34:45 -0500
Received: by mail-oi1-f196.google.com with SMTP id y1so6834659oie.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 21:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gRXxT5dd8d8+j8LdW5JZWV4AmLZH7T1kf1JeldOAZic=;
        b=ELPqKfMdoZpJNs4Cp/6kotqNPv9jCHqvoTrGouz4wDUX8l1hlNFZ7jFumds7fqU1pu
         /tQ68/lKi3QF7vnRYWUYdvniAHMOCqxwVSwvIqQBXxF00LWaGt+1lEnA9TcwlqeGglyU
         3g6p81DmGTvelvKrg9p0z1NRlTJgYrh6XlSek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gRXxT5dd8d8+j8LdW5JZWV4AmLZH7T1kf1JeldOAZic=;
        b=fxqmAPhEvnJk2BrkkvB7eLMDk7LDtzdVSdkvcRbhG68YiwGOH73gsAYURCbSPRxU9q
         2kCCjhr0Auh7Q+WsPYpzCASPl68nMAj8j+NKbyzVClgSc0w4I5fiRMXmPT/WFEYeUv6y
         gnos2INbV2IAQ7f9xoCx7GWg3O62VOHsPCNvcLOJ1LNby5QwLzuDWjDHiW8I3JGAu7lp
         GQz2FKHG/XBdQoXNjAOeAn3jLoJdYsndj8hQodDVpJ26j5ZA3K8X0jSDre52BsI4OT1L
         2M8mlsRuQbZjeO/GBLFwuodqYUsmY4N3MmWKsT4ZMAVAVGXKwAU5SICxGDnkc2EgDHRe
         2YvA==
X-Gm-Message-State: AJcUukfUAIN/yVMR0gckKtPKmpiizL6UkN9nEN2e+FionswBzxDsfDip
        mEGmb1lqmMDFATrQYdMJPv3c1R/bYxsDVw==
X-Google-Smtp-Source: ALg8bN4tJ/BM1VBBgSD1X94MBaphhar8RNsk7655LcUpdR/OEL5l9IeD52W7Hkndewe0R0VwCk3aug==
X-Received: by 2002:aca:b882:: with SMTP id i124mr444242oif.127.1548394484542;
        Thu, 24 Jan 2019 21:34:44 -0800 (PST)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com. [209.85.210.53])
        by smtp.gmail.com with ESMTPSA id q199sm906707oic.39.2019.01.24.21.34.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 21:34:44 -0800 (PST)
Received: by mail-ot1-f53.google.com with SMTP id 32so7458661ota.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 21:34:43 -0800 (PST)
X-Received: by 2002:a9d:5549:: with SMTP id h9mr6214316oti.83.1548394483048;
 Thu, 24 Jan 2019 21:34:43 -0800 (PST)
MIME-Version: 1.0
References: <20190117162008.25217-1-stanimir.varbanov@linaro.org>
 <CAPBb6MVOPmRhhM=J-RqLOpc+mDbnxYdCMO3mqQfgN-F3b=kBCw@mail.gmail.com> <10deb3d1-2b10-43fe-bc77-4465f561c90a@linaro.org>
In-Reply-To: <10deb3d1-2b10-43fe-bc77-4465f561c90a@linaro.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Fri, 25 Jan 2019 14:34:31 +0900
X-Gmail-Original-Message-ID: <CAPBb6MUqi3xhgE_WPRP_7gZWcH2WGz8A7vskGGJW9zGM0=D1Sw@mail.gmail.com>
Message-ID: <CAPBb6MUqi3xhgE_WPRP_7gZWcH2WGz8A7vskGGJW9zGM0=D1Sw@mail.gmail.com>
Subject: Re: [PATCH 00/10] Venus stateful Codec API
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Malathi Gottam <mgottam@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 7:13 PM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Hi Alex,
>
> Thank you for review and valuable comments!
>
> On 1/24/19 10:43 AM, Alexandre Courbot wrote:
> > Hi Stanimir,
> >
> > On Fri, Jan 18, 2019 at 1:20 AM Stanimir Varbanov
> > <stanimir.varbanov@linaro.org> wrote:
> >>
> >> Hello,
> >>
> >> This aims to make Venus decoder compliant with stateful Codec API [1].
> >> The patches 1-9 are preparation for the cherry on the cake patch 10
> >> which implements the decoder state machine similar to the one in the
> >> stateful codec API documentation.
> >
> > Thanks *a lot* for this series! I am still stress-testing it against
> > the Chromium decoder tests, but so far it has been rock-solid. I have
> > a few inline comments on some patches ; I will also want to review the
> > state machine more thoroughly after refreshing my mind on Tomasz doc,
> > but this looks pretty promising already.
>
> I'm expecting problems with ResetAfterFirstConfigInfo. I don't know why
> but this test case is very dirty. I'd appreciate any help to decipher
> what is the sequence of v4l2 calls made by this unittest case.

I did not see any issue with ResetAfterFirstConfigInfo, however
ResourceExhaustion seems to hang once in a while. But I could already
see this behavior with the older patchset.

In any case I plan to thoroughly review the state machine. I agree it
is a bit complex to grasp.
