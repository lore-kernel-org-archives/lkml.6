Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30DFC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 05:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7100208C1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 05:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bT65MOzT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7100208C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbeHTJJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 05:09:32 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39025 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbeHTJJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 05:09:31 -0400
Received: by mail-pl0-f66.google.com with SMTP id w14-v6so6536621plp.6;
        Sun, 19 Aug 2018 22:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/aT7vgHVYCN5UDchWpy3AxmmVi+xj71Z/BCx4k/XWmE=;
        b=bT65MOzT+Jgfc1I46szBS65RMpsQUXY3bh21DsbeKjqWaOeFAp+Pj1XK4ZGJ+ZVTjb
         lXsO2uCMuYBSXYWCtvmZLvJOdvY14ZWlVF0zeewukXhe2SXPjNNC+xspgwLwz2kpwZ58
         OD42dqBuCTFLiSQXln7LaoXVQH7GjBhGJI5KBI0bWZUBJBihoVtoqfgzI/1U/gCG7k+D
         rPIm+R+3JKr95J/LCQtGuR26z4pPse26W7/gz1mcv3iNlE7STUkFNOLetJ63eVxCihSg
         tSM8KyAHsHIufvSCi2mlN8h+0Eq5rHV4PzUQuCaF/FQkXfRohuIxAR/xGI6zip3m4RF6
         9/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/aT7vgHVYCN5UDchWpy3AxmmVi+xj71Z/BCx4k/XWmE=;
        b=M+32q3jBcnH5Su1o7Xa31F16U9u5YM6M7MfOu1Ko+FheLiHNNtMujYiupWkKxitDL3
         3t/yCasih5N83E2RNcJ6sranIDvWyMJfJ0cmBU8Jn4yQGDHwUe3VZXvWWBcalZRh7DCO
         GePNaN3jUsZQ4Y1d9ZmovSctdXovoKFwVxTWSKHqgExd0w0/mLwtGArJzYVdBbi/pOYv
         mpX/g7oiDEwX3e8OUXmCVjnfoVH7l/sy+NShxCYeJZfrsK0TyF9O+ObqHO87aBZcUK0G
         F5CyjpzjzP2huJWFksPVonPjLcdqiIsj4FUW8GmLOskW5uM8rN80SoJVgalTrjBqFG32
         dVQA==
X-Gm-Message-State: AOUpUlFej8yLMFNEQ4K/Vd8f0Q1jrEWK1Uw1qpeuxgBCuChlSuWHgku2
        a8FFTxE2tgVtSYHT9D/fqtJvs1EpXZSt/Vg/oJk=
X-Google-Smtp-Source: AA+uWPyt/Tj55GFilhPqkgeOHyIwV5I7qBbsKTHku0r94D1TwzOyWk03U8wWSCY5pd89uG11SCxCpIIMX4d7hNG1pBM=
X-Received: by 2002:a17:902:8c84:: with SMTP id t4-v6mr44779084plo.100.1534744516018;
 Sun, 19 Aug 2018 22:55:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:6d90:0:0:0:0 with HTTP; Sun, 19 Aug 2018 22:54:55
 -0700 (PDT)
In-Reply-To: <20180817150948.GA20845@rob-hp-laptop>
References: <1534403190-28523-1-git-send-email-jliang@xilinx.com>
 <1534403190-28523-8-git-send-email-jliang@xilinx.com> <20180817150948.GA20845@rob-hp-laptop>
From:   Wendy Liang <sunnyliangjy@gmail.com>
Date:   Sun, 19 Aug 2018 22:54:55 -0700
Message-ID: <CAA07jV9FqeFM4Y8SaPdAaYPskNcx0Ct6ywfdX459pzsub15xCw@mail.gmail.com>
Subject: Re: [PATCH 7/7] Documentation: devicetree: Add Xilinx R5 rproc binding
To:     Rob Herring <robh@kernel.org>
Cc:     Wendy Liang <wendy.liang@xilinx.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, rajan.vaja@xilinx.com,
        jollys@xilinx.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wendy Liang <jliang@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 8:09 AM, Rob Herring <robh@kernel.org> wrote:
> Hi, this email is from Rob's (experimental) review bot. I found a couple
> of common problems with your patch. Please see below.
>
> On Thu, 16 Aug 2018 00:06:30 -0700, Wendy Liang wrote:
>> Add device tree binding for Xilinx Cortex-r5 remoteproc.
>>
>> Signed-off-by: Wendy Liang <jliang@xilinx.com>
>
> The preferred subject prefix is "dt-bindings: <binding dir>: ...".
Will updated in the next release
>
>> ---
>>  .../remoteproc/xlnx,zynqmp-r5-remoteproc.txt       | 81 ++++++++++++++++++++++
>>  1 file changed, 81 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5-remoteproc.txt
>>
