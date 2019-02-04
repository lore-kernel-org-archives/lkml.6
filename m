Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F309C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E202087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zyfd+33z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbfBDTPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 14:15:30 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56171 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfBDTPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 14:15:30 -0500
Received: by mail-wm1-f67.google.com with SMTP id y139so1067247wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 11:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sjd/gpLNTKreRRpeadZuAFUWi4BCvIcYWCkBfGFB9Uc=;
        b=Zyfd+33zXs06+ui76B+Js0mjUaqNwKqgdUMJ7YcXrPfzgYzr4Sb7MTfcwhD68yWbxs
         CNfHr5hCkRt7aivuk0/I0NS8f28Mz/Uaz3RCcYMplLqtnimhigZYWPZyIKFOTulMO2Lj
         9NE6PZ5DzlWHDt/+uUCZ6GBfAyUW35jI8wZr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sjd/gpLNTKreRRpeadZuAFUWi4BCvIcYWCkBfGFB9Uc=;
        b=qg6cWc72vfDjgHhk2s0EtuG/1d+e1oQd9HmC5v8VC0dR0k3ypdTNZJAMbZolrpISD5
         kA5Q2AGLuNXLPqn7Rk1weYOui9tT/9nnF6KUQoA8LnFYEqNJ/0MrGRd3Uyvk7xG6MMAp
         DmKBwdPQIrekTfpTdMrgBUX1aOsP2eE8cJ2deKIgKXKo7gmcGRJAiVWU4K3B7a9pbsSk
         jlC2ql2s7D3UsLctpjoHkmro7LKQMUdO3mMOa5TA4M+dJlaIDerxCt82NoW/KjBvEOy0
         8zUz+WMGuBogxsVsxR8KA9cwdI1tdsYk9bbZ3tVyrEHbu4CuCDXROP0UqB/NjSyhwZMs
         lRoQ==
X-Gm-Message-State: AHQUAuZJFiirwJaQzTmIHTc9UW2C/VT059kyHDKvdGpCq378/Qy0FRQ9
        xxGK2LkJKJMcBxEyvMLBK6xKN5V5Yc+BaxqTGeeQKg==
X-Google-Smtp-Source: AHgI3IZzXt5GYnozx9vPJMEs5mTdXmyGuvnNp/hS8pWOx6zUmsvY3Yst95djA4bKlPPa9hC3Th02rVmVCE0pZUVH4NQ=
X-Received: by 2002:a1c:b456:: with SMTP id d83mr678719wmf.115.1549307728239;
 Mon, 04 Feb 2019 11:15:28 -0800 (PST)
MIME-Version: 1.0
References: <1548361463-28372-1-git-send-email-john.stultz@linaro.org> <20190204090154.GM4296@vkoul-mobl>
In-Reply-To: <20190204090154.GM4296@vkoul-mobl>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 4 Feb 2019 11:15:15 -0800
Message-ID: <CALAqxLVo8aukbc61YX0r3ABDWYJ_cisSb2NxN1qNyWJ_tfYCyw@mail.gmail.com>
Subject: Re: [PATCH 0/8 v5] k3dma patches to add support for hi3660/HiKey960
To:     Vinod Koul <vkoul@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Guodong Xu <guodong.xu@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Ryan Grachek <ryan@edited.us>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 4, 2019 at 1:03 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 24-01-19, 12:24, John Stultz wrote:
> > This patch series is based on recent work by Tanglei Han, and
> > adds support for hi3660 SoCs as found on the HiKey960 board,
> > along with a few patches I've been carrying.
>
> Applied and fixed the minor style issues in patch 5, and retagged 3 thru
> 5 to dmaengine: xxx, thanks

My apologies for the style mistake. Your help is very much appreciated
here! Thanks so much again!

Just to clarify, are you planning on taking the reviewed binding
documents (patches 1&2) via your tree?

thanks
-john
