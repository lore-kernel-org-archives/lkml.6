Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCED6C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 11:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8500F2174A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 11:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HfqOVnuy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8500F2174A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbeHHN1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 09:27:01 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:34253 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbeHHN1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 09:27:01 -0400
Received: by mail-oi0-f53.google.com with SMTP id 13-v6so3045174ois.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 04:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/lP/ASUVNjPQYK1QTiIkciCAp6a3dzp7KumzMgQOtAc=;
        b=HfqOVnuyjtQLWFfvmsH/ttCwTFfZ2+0uGu57EOaSKrHbjBcj9L94hlQOTVfBv3A5Bw
         hZpEwUTCD4OkSnDB027ZBSiHxoc6EJuXiZ+S2hsaopmty3An1FYZImzd9CvA8B9k44Tv
         vGSyP7G08o0vUJGSe+P6QKpMspCxWxUwuiJEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/lP/ASUVNjPQYK1QTiIkciCAp6a3dzp7KumzMgQOtAc=;
        b=KcIoBfIis2bYb5O1e0jrwgaTwLivphYRhnftXkDtcVGKDSD0/1vl1G+PDrXA92Nt4q
         nkCl1bPiKlGk9zTDP/5YSkNkRyZS2oZk1HQMm9JYC6MMDnuCP/kgW595lXpoMkS+uBxd
         eXZXo8EygxwGHbLnPmPYWmuJlsfr4usNvm8ng//RiNZSn+l8AS8qX7cq5yRX/+YMODAk
         XU5YYTPB+qzRBIj00QMW1Z4iVU9GVQjma6LY39mXKhi4hmzq4TMFcmdj+sWeK9ssGeWj
         1DekzB7EgekhbfufnrLqLs1P0AEcEwyav5yhTYv91eOYO/k9UjoCoGBkMYrI/cdPSmGt
         6aAg==
X-Gm-Message-State: AOUpUlHNvVB/ByrVsI3saWIbr0Q5E+8i8LkAW5uFdgx+sAzzh1SqGjog
        D13ruk4PptyVeII5feLYq5dp1bObVJK+nMOtIcmbpA==
X-Google-Smtp-Source: AA+uWPy6oz3h9+eN2koSRnlTQlP4bHbJVppJLolUtoVQD8AiCs5RPkWRUStrx0ngD6miyiMjivw4gv+D5mCni5OEgJw=
X-Received: by 2002:aca:5dc5:: with SMTP id r188-v6mr2491610oib.320.1533726468862;
 Wed, 08 Aug 2018 04:07:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:237a:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 04:07:48 -0700 (PDT)
In-Reply-To: <20180808105451.GE9346@sirena.org.uk>
References: <64681bf903104c8a02f118294e616e2a12a5ebe4.1533638405.git.baolin.wang@linaro.org>
 <20180807134121.GA7958@sirena.org.uk> <CAMz4kuJsyKv_fvrqRR3pdfKsLVy53Uj0KX+m_9jLxpcVcMvs9g@mail.gmail.com>
 <20180808095025.GB9346@sirena.org.uk> <CAMz4kuKZHxYiJaMHnqdAGth8XkfGnq3-Tsfc59cGjsHQHZaY7A@mail.gmail.com>
 <20180808105451.GE9346@sirena.org.uk>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 8 Aug 2018 19:07:48 +0800
Message-ID: <CAMz4kuKzSc0SZjzt1OB2FW-v608AvTNk5X165EMLn5_e-JhPHw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: spi: Add Spreadtrum SPI controller documentation
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        lanqing.liu@spreadtrum.com, linux-spi@vger.kernel.org,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 August 2018 at 18:54, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Aug 08, 2018 at 06:35:28PM +0800, Baolin Wang wrote:
>> On 8 August 2018 at 17:50, Mark Brown <broonie@kernel.org> wrote:
>
>> > Right, I don't think we added this yet (if we did I can't see it).  I'd
>> > add a new field to spi_transfer for this, then other controllers with
>> > the same support can implement it as well and drivers can start using
>> > it too.
>
>> OK. So I will name the new filed as 'word_delay', is it OK for you?
>
> Sounds good, yes.

OK. Thanks.

-- 
Baolin Wang
Best Regards
