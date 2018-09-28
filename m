Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7108AC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39621215E4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39621215E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbeI1RIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 13:08:34 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45865 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729183AbeI1RIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 13:08:34 -0400
Received: by mail-qt1-f196.google.com with SMTP id l2-v6so6004235qtr.12;
        Fri, 28 Sep 2018 03:45:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xOH++AYkRaZix3DV0WRVFVJiA57Wu6D40566GrWT9XU=;
        b=TfLBh9fWlaFR6Fg0tcmzV8OYTRdLnDDPcJJG98+lbfh0vAQNXtWDeg5Vp7BuEKHY1b
         X3iu6XpBdjRHj5bEm+YLJRjKJEfc2doBfg82NQlRvvVc+sukJyvtBQC1dh18hzO8BQV+
         JrECDDgYoasbeU/3+O9Uw4kNmaiFivjXmHnO4UGqAkbQisbPRLIli8TTG+mHdN1t5rJC
         nrUFjtZSuld8PTNtuB/sRKSlRx2NQf1Co30TrOdzksW7BjtGX7JULkh29VRKrzjaLSWX
         ApGxzYkOJUHjumD2cFhosndHSGwu5rcthHfcNvGqhxJLJj/MVXPxnftS2FW3tCGROWFa
         zsmg==
X-Gm-Message-State: ABuFfohFigYJA5Q5xTv83bH+6vEI89gQqgXhT2ItxQAKWNsVI9yWy1KB
        E17ILPY3+RdEpIbFH4d/1rcEib/6LxLiaeukjM8=
X-Google-Smtp-Source: ACcGV63ZVGL6qYEfHFaVanC9AbKDMmzOtdBd4QI4OfiEnAGGVLxgjpipfdfVIBhJW42u+sJelPFcSSSmtmDgepAzffQ=
X-Received: by 2002:aed:2bc6:: with SMTP id e64-v6mr11812526qtd.132.1538131523422;
 Fri, 28 Sep 2018 03:45:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180912135352.19722-1-suzuki.poulose@arm.com>
 <20180912135352.19722-5-suzuki.poulose@arm.com> <ccc61e1b-768c-2a6d-3ff5-95b72bc58a6f@arm.com>
 <CAAfSe-swWPgCWN6cZbQxLL6fwaJ1qLXnC_X7A0zeYuHDaZ_A1Q@mail.gmail.com>
In-Reply-To: <CAAfSe-swWPgCWN6cZbQxLL6fwaJ1qLXnC_X7A0zeYuHDaZ_A1Q@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 28 Sep 2018 12:45:07 +0200
Message-ID: <CAK8P3a2WWFp5W5-7o-X3joOpSGgnK=s_ZyGev7gsVV0SjN0p0A@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] arm64: dts: sc9836/sc9860: Update coresight
 bindings for hardware ports
To:     Lyra Zhang <zhang.lyra@gmail.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Chunyan Zhang <chunyan.zhang@spreadtrum.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        coresight@lists.linaro.org, Leo Yan <leo.yan@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 11:19 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> Hi Suzuki,
>
> On 27 September 2018 at 16:51, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> > +To: Chunyan Zhang
> >
> > Chunyan Zhang,
> >
> > On 09/12/2018 02:53 PM, Suzuki K Poulose wrote:
> >>
> >> Switch to the new coresight bindings for hw ports
> >>
> >
> > How can we push this patch ? Do you generally send the spreadtrum
> > specific changes to ARM soc folks ? Or would you like me to post
> > this directly to ARM soc folks ?
>
> Yeah, at present sprd dts files generally got merged through arm-soc
> (I've added arm@kernel.org).

Yes, that's fine. Generally, we prefer if you collect patches for your
platform first, and then send them as a pull request or short set
of patches. for inclusion, rather than picking them up from the list.

If this is the only DT patch for spreadtrum in 4.20, I can also just
pick it up with your Ack.

       Arnd
