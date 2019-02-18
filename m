Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F6EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2073D2177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550518587;
	bh=ZvFpuo8yxbK9Lb1YuTttOjDQkuDjesO1cZ30CazJOXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mMWGrb5GYraqFhJC7Ewv5SEbb5nnEAPgX1FZc+5/CMavMppTwYJfli8DVJcQpXO4V
	 m1OES6Dcj914w1K2U96lhs85yrQFwABtZjcqso1NAxfP37Ku+BpavFC6/a5lu28n4A
	 WgIRS8ZTgFKiUG3o7zBVZm0l2H9RE5Tbmf8WAzBU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbfBRTg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:36:26 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45234 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbfBRTgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 14:36:25 -0500
Received: by mail-ot1-f67.google.com with SMTP id 32so30129940ota.12;
        Mon, 18 Feb 2019 11:36:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4K7KDuRYtIvhl2snQihDjXZOuHeXi3FzdlCTfwjthsY=;
        b=VN0/X0iJoZy0DzVVcgKMpsoy88EvfEPVHMdoD5g5wRctlzE0t1z0QqYZ17E5KRLAvP
         JwQM1xkdsqxFfNFemrkVYKda0wBTVyStKmJFNu7gA19VlZnbT2weFhbYwzjy6isl9F1Z
         pzs/xoiKVkOg9RRydPYFqSCUoNYA39q0noCbznLny5fpber0th4wuOcl3+c4KL98r3hw
         w6z2Xp1yzaijoONNanrTxOFstSmkMwn8IUa4n3Xl8fek8kvZ4c3VyK+WZG/HJFEXTfSF
         hNRK4rmCp94ZBXUEtpHse4Rk0NZKfWCYjxg7uQg4IID/NXo0oIXfujNUYuDWsCc56iaN
         JJrg==
X-Gm-Message-State: AHQUAuZJ/+oibCFTuvH/8ZvQ1+9wKjO/D9nf8GTwYm1AGUUhvuPjo+/v
        t38v2g4V3UyFBLbxv6G8kg==
X-Google-Smtp-Source: AHgI3IaLf0kpH5v/HmMcoltLTzt3NwLIuxzVX15eZjRPOdOm8AjN6lDkPRgrWE990i8/u02mcZZI+A==
X-Received: by 2002:a9d:7dcb:: with SMTP id k11mr16144651otn.192.1550518584581;
        Mon, 18 Feb 2019 11:36:24 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f127sm6596125oih.31.2019.02.18.11.36.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 11:36:23 -0800 (PST)
Date:   Mon, 18 Feb 2019 13:36:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Roger Quadros <rogerq@ti.com>
Cc:     tony@atomide.com, ohad@wizery.com, bjorn.andersson@linaro.org,
        s-anna@ti.com, david@lechnology.com, nsekhar@ti.com,
        t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com,
        m-karicheri2@ti.com, woods.technical@gmail.com,
        linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        rogerq@ti.com
Subject: Re: [PATCH v2 09/14] dt-binding: remoteproc: Add binding doc for PRU
 Cores in the PRU-ICSS
Message-ID: <20190218193623.GA20566@bogus>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
 <1549290167-876-10-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549290167-876-10-git-send-email-rogerq@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Feb 2019 16:22:42 +0200, Roger Quadros wrote:
> From: Suman Anna <s-anna@ti.com>
> 
> The Programmable Real-Time Unit Subsystem (PRUSS) consists of
> dual 32-bit RISC cores (Programmable Real-Time Units, or PRUs)
> for program execution. This patch adds a remoteproc platform
> driver for managing the individual PRU RISC cores life cycle.
> 
> Add DT binding documentation for that.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  .../bindings/remoteproc/ti,pru-rproc.txt           | 56 ++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
