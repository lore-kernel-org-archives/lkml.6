Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12359C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 18:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D607E21780
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 18:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mk99Qytf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D607E21780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732956AbeKOEGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 23:06:52 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40744 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731192AbeKOEGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 23:06:52 -0500
Received: by mail-pl1-f195.google.com with SMTP id b22-v6so2692714pls.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 10:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1ovRvZGQSWtqecLbqSafVVYgSiBi9D/p2+yALXnG+yk=;
        b=Mk99QytfFNJrw5LqJAHt7HnQzy97X9YU2LTd7hUtojLxI1QdilHWAyzju9eHWvuk8Q
         l3JjsCeA1+/lHUhjo2mIc9VsrszPg9XKeJjP8CZWz5dEJvh7LV074W99GJ4AAOLYtxhC
         GjlTTjA0/GtUKzpcGlcBcYJbox+qo9l+reH38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1ovRvZGQSWtqecLbqSafVVYgSiBi9D/p2+yALXnG+yk=;
        b=BJoYlijY+BzY1vKysIiQEpOVxzUioVY37XSJdizAk/+G0oyuOTST937oUpfk5NkaDi
         /xpmqc/vksS7CYCMYMmYXnxpWcyKKv5e+fxmCmh4C+DX6dIVuRx/rjItk+9ZdQlyrny1
         9imk/FAsaqXXE7HUo5raLj/SepV9D7utlSZmy3eCprNXVSSd+tbztSIroHeZCh5jaY2N
         2ZT29uLH7ia3zqKqfPjTFCZFPLPq0ZiCsmbVA8wM7cBXrj9p5uCQKXB65OCfFEwqWSb6
         smINAqBjqkoqxC5vNSRGXRw8AwT/r4aBfxVvn0NCbPwJ2uBKnuJiX4daIsgJ6/FAOIdu
         NRVQ==
X-Gm-Message-State: AGRZ1gLPwBgZ22NvRPqikyzOyYT2EHYyGYwWCHokZbKL9V7xr6NLpGAp
        Rq7SCMPFXaFpuxRPlW8A7SPIqA==
X-Google-Smtp-Source: AJdET5d2RwStbeq3/CqYK0tEDOtJcLlgjhDdZiAoEOiK3uMliKEIb7vHvCZpvGX9wMcHTCSuOxfQeA==
X-Received: by 2002:a17:902:3084:: with SMTP id v4-v6mr2852693plb.326.1542218559206;
        Wed, 14 Nov 2018 10:02:39 -0800 (PST)
Received: from localhost ([64.114.255.97])
        by smtp.gmail.com with ESMTPSA id f62sm23320538pgc.67.2018.11.14.10.02.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 10:02:38 -0800 (PST)
Date:   Wed, 14 Nov 2018 10:02:37 -0800
From:   Andy Gross <andy.gross@linaro.org>
To:     Arun Kumar Neelakantam <aneela@codeaurora.org>
Cc:     davem@davemloft.net, bjorn.andersson@linaro.org,
        clew@codeaurora.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        fw@strlen.de, hannes@stressinduktion.org, dvlasenk@redhat.com,
        nicolas.dechesne@linaro.org, David Brown <david.brown@linaro.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>
Subject: Re: [PATCH] soc: qcom: qmi_interface: Limit txn ids to U16_MAX
Message-ID: <20181114180237.GD14703@hector>
References: <1538545205-17939-1-git-send-email-aneela@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538545205-17939-1-git-send-email-aneela@codeaurora.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 11:10:02AM +0530, Arun Kumar Neelakantam wrote:
> Txn IDs created up to INT_MAX cause overflow while storing
> the IDs in u16 type supported by QMI header.
> 
> Limit the txn IDs max value to U16_MAX to avoid overflow.
> 
> Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
> ---

Thanks for sending this in.  I'll queue it up.


Andy
