Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175D3C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 04:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE6D2070C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 04:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DlebsdW5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbfACEs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 23:48:56 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41360 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729358AbfACEsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 23:48:55 -0500
Received: by mail-pl1-f193.google.com with SMTP id u6so15381717plm.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 20:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wD3XC5clJgBcb8qj6+QFlJOKL54hcbtfhGqHXTkeYKQ=;
        b=DlebsdW5lff+RPbGDS2SLByu/C1tjDsxWGxidpo1iP89m+Wnjz9mYRADF390OWvb1w
         O/JyjlVafxkMq240QYceRnXncgvmZNNM7/qrOsaGahRQxKIV+MhiQyJ0CYvmUkxF5bXm
         f+Lv7vyy0k2KjKUUm2Vl4VnHs2JsR6dgrmd2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wD3XC5clJgBcb8qj6+QFlJOKL54hcbtfhGqHXTkeYKQ=;
        b=t0AgVSOOrcVTnW2/NnWE7Jmer3qV173z4qLpVam2tzc1HfrhSj1d0ypL3T9EAxjJmB
         E3QQNyGXfQpbTR8F7QSs7GbtRGJv/65UzITWD2ZB7LQvjebgblRgXIm1ntkfTpqtKXA/
         lH9HgcYnJXnIVHdYWVAO7cGqJ5uzpJKvqUOyFjlWlnLhrV1kJvsp/Sn78z8NsWekYHCd
         0+SJ+tvPEb1XIvY566sP3Ueg6SH1gAs/ns3lwsg9WTE6EYhx6puv6Z3HF1T4Hm0TkAgL
         /KLVmBpK3w3yljEp67We5Te1NnfZd6psS4ZVx8fGc8LYVEY6mzgQFKipSkqedZA9Hw/i
         DoeQ==
X-Gm-Message-State: AJcUukcfisN/7Gj78bTQhQ8ANIbW1dASBz65VxDeCCdjtG007rJHgIx9
        2MMsGDKdWo2qUxDLJ5r6HsSx7g==
X-Google-Smtp-Source: ALg8bN7eRV8ClXNiBKmZQLflSwaRLxDf6g9zcU0iaIq0tFuz7/SxTF3erLWkUgrBUsyblij6npzmjg==
X-Received: by 2002:a17:902:1008:: with SMTP id b8mr44348614pla.252.1546490934801;
        Wed, 02 Jan 2019 20:48:54 -0800 (PST)
Received: from localhost ([122.166.131.155])
        by smtp.gmail.com with ESMTPSA id h134sm108167206pfe.27.2019.01.02.20.48.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 20:48:54 -0800 (PST)
Date:   Thu, 3 Jan 2019 10:18:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Henry Chen <henryc.chen@mediatek.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Fan Chen <fan.chen@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Kees Cook <keescook@chromium.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC RESEND PATCH 0/7] Add driver for dvfsrc and add support for
 active state of scpsys on mt8183
Message-ID: <20190103044852.l7sxfqeqnxx2xbp5@vireshk-i7>
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-01-19, 22:09, Henry Chen wrote:
> The patchsets add support for MediaTek hardware module named DVFSRC
> (dynamic voltage and frequency scaling resource collector). The DVFSRC is
> a HW module which is used to collect all the requests from both software
> and hardware and turn into the decision of minimum operating voltage and
> minimum DRAM frequency to fulfill those requests.
> 
> So, This series is to implement the dvfsrc driver to collect all the
> requests of operating voltage or DRAM bandwidth from other device drivers
> likes GPU/Camera through 2 frameworks basically:
> 
> 1. PM_QOS_MEMORY_BANDWIDTH from PM QOS: to aggregate the bandwidth
>    requirements from different clients
> 2. Active state management of power domains[1]: to handle the operating
>    voltage opp requirement from different power domains

Honestly speaking I wasn't sure if anyone apart from Qcom will ever use this
feature when I wrote it first and I am quite surprised and happy to see your
patches.

They are mostly very neat and clean patches and I don't have complaints with
most of them. Lets see what comments others provide on them.

Thanks.

-- 
viresh
