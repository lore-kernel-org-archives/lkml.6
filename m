Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AC9C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816E320989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548874596;
	bh=B5EHpOWBz1oLic823K7k5VtistyeI47H/eTmIVWEX9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=STBwFXYdjU9Rm9lN54AORVdqYTdgZkNeu0CWLkmipkk1wNMwB1zKdD+e/99Ct8H2p
	 2crF8g0gkNdVcekDTj4TuShmumDtQIAgghfdGyzIE3Ov6rTmHJrCvG95VgHxnzWhx5
	 My7nF7LUKhjtaVEfJz0LCnoqUC7IKg8n8f7v8EAw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387412AbfA3S4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:56:34 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46089 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728286AbfA3S4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:56:34 -0500
Received: by mail-oi1-f193.google.com with SMTP id x202so496302oif.13;
        Wed, 30 Jan 2019 10:56:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7tYleCvxXM9aAe+YNTm/SXB2stymoy/BxFIfogF/Yeg=;
        b=co9lO6KnWL6MUE6GPBVThQEkVVU5o2hLQmZkr+CRzxm3kI/EGielqdyW0jugbHEbVz
         gbMkjfz4gAb9ytyUs0+zH+ckcqCT3TtvZ5LtvI5Tht2rd/4HPh8kV6qSYGYJdnuCbuxj
         qzYpE4loMYi+FfEdFB4nX4ugUzMXsY3i/0y44XUYlm2Md6NjfD3eX0EFuT4wrmTKFKyU
         xOgjTLmuSziTxUliOA2nxEzYHY7NOdEmc1OdIJ8iYCAkB7c08uYLxNwiTQ0cXJN4sWRZ
         bvfrhi1koSvOl4RyB9t3B668ze57lpJRcHdeyxyd2jEd4Taqda8LkNn61IAL1PCJM/K9
         VRMQ==
X-Gm-Message-State: AHQUAuZG+IWC16j0pC5KcmxuCgYPDG9kVzjb2vVVqgygjqgTEvlIEC9b
        X/wQ8TXe2bPeiNgX2CmYSzCNlE0=
X-Google-Smtp-Source: ALg8bN7GIo6rcUJLlxqyQVPcQbaky85pXakiLgVyqeB2KRkUoohl12i6nrKXwrYzDlQQuRPtRJHl4w==
X-Received: by 2002:aca:4e92:: with SMTP id c140mr12812748oib.97.1548874593551;
        Wed, 30 Jan 2019 10:56:33 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s66sm1035963oia.55.2019.01.30.10.56.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 10:56:32 -0800 (PST)
Date:   Wed, 30 Jan 2019 12:56:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Can Guo <cang@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        liwei <liwei213@huawei.com>, linux-kernel@vger.kernel.org,
        Subhash Jadavani <subhashj@codeaurora.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 1/9] dt-bindings: ufs: Add #reset-cells for Qualcomm
 controllers
Message-ID: <20190130185632.GA23483@bogus>
References: <20190123221137.41722-1-evgreen@chromium.org>
 <20190123221137.41722-2-evgreen@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123221137.41722-2-evgreen@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2019 14:11:29 -0800, Evan Green wrote:
> Enable Qualcomm UFS controllers to expose the PHY reset via a reset
> controller.
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>
> 
> ---
> Fixing up this aspect of it made me notice that this patch [1]
> hasn't landed yet. It really ought to.
> 
> [1] https://lore.kernel.org/lkml/20181012213926.253765-1-dianders@chromium.org/T/#u
> 
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
