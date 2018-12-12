Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C52C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67792084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KFq4iPsE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VtewGMCX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E67792084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbeLLJsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 04:48:21 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:45776 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbeLLJsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 04:48:20 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 43C8F60225; Wed, 12 Dec 2018 09:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544608099;
        bh=rYD3K4r/VUqk2f1jf8fOj6v6z8WZa1NQ1E0/DWrckDs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KFq4iPsE73s5DJZqBR67Wb/rymuBuh/yWiLEzhbSz1ZjY56hCMJZxZVPhLi5lkoaP
         dyJLGfXGNjWFo+4x830UN8M4nbSA/FOFmRMni7YFvQErlLDPilYFlyDNvf1izuKHlt
         gJBoTEgn4Yl3VAJrJqSjZpMeAfCok7KEWvtMi1jQ=
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ACE25601B4;
        Wed, 12 Dec 2018 09:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544608098;
        bh=rYD3K4r/VUqk2f1jf8fOj6v6z8WZa1NQ1E0/DWrckDs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VtewGMCX3A7XHe5Q/UtU62Pi4y01lNS7pld0p42FLjjbA2aRWOgY37ydyiFWrTqTr
         QgbEFn+pPNHn/VbNSjWRShZdUIpZgUmUBbkYfSsbR5rPzNN7lxFWWmNGp0v6ktCZrQ
         lbfMyMxiMj7f3bZUGAl3OVJkadl5LxEEBgf0PE9I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ACE25601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qk1-f177.google.com with SMTP id n12so10322457qkh.11;
        Wed, 12 Dec 2018 01:48:18 -0800 (PST)
X-Gm-Message-State: AA+aEWaF1PXxnuG3+Si5HGdWOBD3H8ZAxEe+72btgPWui/BkEPI3YOoW
        NDzNowT1KdMaWywKSJCqC3Pgc2oWlFnNPfeGouc=
X-Google-Smtp-Source: AFSGD/Ve6eaZ2BtoMLUJLcf+fMeqfkpQWwQ9bm2vyxyOCTvwUfN6d1rEO4eJtVIjDr08YjRggQPQJxe/d/b2Pvkk9To=
X-Received: by 2002:a37:9604:: with SMTP id y4mr18048312qkd.279.1544608097919;
 Wed, 12 Dec 2018 01:48:17 -0800 (PST)
MIME-Version: 1.0
References: <20181011094930.17010-1-vivek.gautam@codeaurora.org>
 <20181011094930.17010-2-vivek.gautam@codeaurora.org> <20181011221630.GA5841@bogus>
 <9ca4bb4f-3e6e-21cc-819e-80b979b934d0@codeaurora.org>
In-Reply-To: <9ca4bb4f-3e6e-21cc-819e-80b979b934d0@codeaurora.org>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Wed, 12 Dec 2018 15:18:06 +0530
X-Gmail-Original-Message-ID: <CAFp+6iF80P-o=Z-aNOMQwWMTcO4jcgSR0wOzd4GvmB3zTvWZLw@mail.gmail.com>
Message-ID: <CAFp+6iF80P-o=Z-aNOMQwWMTcO4jcgSR0wOzd4GvmB3zTvWZLw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: arm-smmu: Add binding doc for Qcom smmu-500
To:     Will Deacon <will.deacon@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        David Brown <david.brown@linaro.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        "robh+dt" <robh+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Fri, Oct 12, 2018 at 11:37 AM Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
>
>
>
> On 10/12/2018 3:46 AM, Rob Herring wrote:
> > On Thu, 11 Oct 2018 15:19:29 +0530, Vivek Gautam wrote:
> >> Qcom's implementation of arm,mmu-500 works well with current
> >> arm-smmu driver implementation. Adding a soc specific compatible
> >> along with arm,mmu-500 makes the bindings future safe.
> >>
> >> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> >> ---
> >>
> >> Changes since v3:
> >>   - Refined language more to state things directly for the bindings
> >>     description.
> >>
> >>   Documentation/devicetree/bindings/iommu/arm,smmu.txt | 4 ++++
> >>   1 file changed, 4 insertions(+)
> >>
> > Reviewed-by: Rob Herring <robh@kernel.org>
>
> Thank you Rob.
>

Can you please pick this one as well to your tree? This goes on top of the
bindings patch for "qcom,smmu-v2". So, it can't go through Andy's tree.
Will ask Andy to pick the second patch of the series, that adds the dt node.

I guess as I sent this one along with the dt patch, I would have
mistakenly added
you to 'cc' list rather than 'to' list.
Let me know if you would like me to resend it.

Thank
Vivek

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
