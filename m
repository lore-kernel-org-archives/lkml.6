Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D97C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 00:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A97F217FB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 00:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WI2ZOtPl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731189AbeLQAft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 19:35:49 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43107 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731067AbeLQAft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 19:35:49 -0500
Received: by mail-pf1-f196.google.com with SMTP id w73so5452906pfk.10
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 16:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RgIlC7A4UYDpRtoEc+8O7U9tHCUeXvc2JiyMmXvoWdk=;
        b=WI2ZOtPljUMUsa8Ch1hRjj6skPqXuEakXWWErDA+hddfRrbPOYPtjAIjngv4MMQ/HW
         jZtixNCG7EiNywcLY+uolo1vzk12IvzCZgk7GMj857WwfL4sR/wMrKbJKf2RplH9K3J0
         8hUQ9vYQ+AtLIpVf9pO+uw0FK/T9xZaoZD37s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RgIlC7A4UYDpRtoEc+8O7U9tHCUeXvc2JiyMmXvoWdk=;
        b=DIDAoeis52xtPJcTjGK7r8QdhgsDG4rmCF8R/7GyLUD6pMZ5JGy8BGxfgeXDHu+rTV
         mf/UjNeGRIuMefLsFn2NluQFnj5gmeWnVaquPEdod+ZjPjc1sRrtXNSASJAGIkGbBI8Z
         5X00v9DQaWJNCVCbQVCzCZ3sn8N441b5x5LrNBk3mN5dYvZ988pu5APOxZM+FNIbnScl
         DqObmWnRcAqL4EOLJmKoRitl5Ulq2R67J0HpbRQPr+BtnQ2tijsvUAPaGwzwogzMu1lg
         ADMDr8ULcihmMIvxBljRNiCGoHuPQqRCeswl7BWmkTSrJ1isMps0ZnYAYA/ikZv6gE87
         d+2Q==
X-Gm-Message-State: AA+aEWZU15nVK9XRWOKbOgEtRVKK3zQur98KMa1sOJz5XUuclB60dt+J
        4dSJ1JGENXgcEy4SuvSgwKDJwA==
X-Google-Smtp-Source: AFSGD/UmmcVR8ntOA/wvu4nkHYmtfU1o60iHbCpKvH90qLvgUfrTdvSG88xo2kHrS3EXyJ7Er3RwWQ==
X-Received: by 2002:a65:5a4c:: with SMTP id z12mr10342469pgs.188.1545006948365;
        Sun, 16 Dec 2018 16:35:48 -0800 (PST)
Received: from dragon (61-216-91-114.HINET-IP.hinet.net. [61.216.91.114])
        by smtp.gmail.com with ESMTPSA id r80sm15412874pfa.111.2018.12.16.16.35.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 16 Dec 2018 16:35:46 -0800 (PST)
Date:   Mon, 17 Dec 2018 08:34:40 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        Anu Ramanathan <anur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] phy: qualcomm: Add Synopsys High-Speed USB PHY
 driver
Message-ID: <20181217003434.GA7208@dragon>
References: <20181127100722.9993-1-shawn.guo@linaro.org>
 <20181127100722.9993-3-shawn.guo@linaro.org>
 <b0d02b1c-cc44-69fe-0765-84caf76eaea1@ti.com>
 <20181204060104.GA11391@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204060104.GA11391@dragon>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 02:01:07PM +0800, Shawn Guo wrote:
> Hi Kishon,
> 
> On Tue, Dec 04, 2018 at 10:38:19AM +0530, Kishon Vijay Abraham I wrote:
> > Hi,
> > 
> > On 27/11/18 3:37 PM, Shawn Guo wrote:
> > > It adds Synopsys 28nm Femto High-Speed USB PHY driver support, which
> > > is usually paired with Synopsys DWC3 USB controllers on Qualcomm SoCs.
> > 
> > Is this Synopsys PHY specific to Qualcomm or could it be used by other vendors
> > (with just changing tuning parameters)? If it could be used by other vendors
> > then it would make sense to add this PHY driver in synopsys directory.
> 
> My knowledge is that this Synopsys PHY is specific to Qualcomm SoCs.
> @Sriharsha, correct me if I'm wrong.

Kishon,

Do you have any further comments on the patches?  We are close the 4.21
merge window, and I really hope they can hit mainline with 4.21 release.
Thanks.

Shawn
