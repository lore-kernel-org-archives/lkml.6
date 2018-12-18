Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F178C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA7121850
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545144949;
	bh=mh7OkBO95Rn69GbrlVm+Fqb2kjEv2Z1GSEkRaAfd1N0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ozo4e3yVcuvVyhDFo7c1mjvidIHTQmqIAYtdM5LzN0gcAOxuebUmZbhOXMqBRiHAX
	 JPoypAWIUxpC2NTMfKYPGlUL6l5KvXbTppcSHKfIoXOHqrWfIsgVRHQ5J7E8MykyLH
	 VZm+xshkPjKvMbbtUpd/Z3wVvptmMHwJEw2CNKTc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbeLROzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:55:48 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44100 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbeLROzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:55:46 -0500
Received: by mail-oi1-f196.google.com with SMTP id m6so2116161oig.11;
        Tue, 18 Dec 2018 06:55:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XNo+xfeLKpZ7p1RAguM4dLaj0ps/izgGSQU3tD962pk=;
        b=VFdVuyQtUyNbbRTLJeQtxJvq+OlVX5b3gUCPVIrVkPPXf2DWq6fltStVBPgAKxbfjy
         Iu+FdsU89adLOQ7TrQVUKBmyYwnvKlxZOBFba/410FJinb8/2QMhwdozEyHQoWIjFKrh
         sM7prGgGB4VHttrKRRj5bMJX/eUXMGo014RKLPns5WlXjfL2flQhSnyzA8cNkhI3Ekzu
         yLybM7/KzvU9penUFiVczE0uLT6j21o0priAObBk4Behzbl0xX8VqMl9/oD0+YQRMo9h
         fwjFhOfHGq54+klcFec1f3NoRQ6b5YugmPWwko+CPA3wOJvnbBmKsG4mQk5SS/LYFbgG
         J/zQ==
X-Gm-Message-State: AA+aEWajqo5ekRerkXVNvn0BytYoxkrV9/JOrr61hbuFWJDlzA6eJB0J
        OWtownxemlWx4uk06ADzrg==
X-Google-Smtp-Source: AFSGD/VrEEejvB+fJAQP/JTMx9m1hSbXd+yu9GkvtxdoNwV4eFYJd5+L3828ehkxFt48QjjQTx3HLA==
X-Received: by 2002:aca:f389:: with SMTP id r131mr8229963oih.58.1545144945120;
        Tue, 18 Dec 2018 06:55:45 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 62sm7556507otu.42.2018.12.18.06.55.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 06:55:44 -0800 (PST)
Date:   Tue, 18 Dec 2018 08:55:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, bjorn.andersson@linaro.org,
        marc.w.gonzalez@free.fr, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>
Subject: Re: [PATCH v4] clk: qcom: smd: Add support for MSM8998 rpm clocks
Message-ID: <20181218145543.GA10329@bogus>
References: <1545099336-5615-1-git-send-email-jhugo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545099336-5615-1-git-send-email-jhugo@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018 19:15:36 -0700, Jeffrey Hugo wrote:
> Add rpm smd clocks, PMIC and bus clocks which are required on MSM8998
> for clients to vote on.
> 
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
> v4
> -Fix compile issue
> 
> v3
> -Ensure Marc's hang was addressed by GCC fixes
> -Renamed the bb clks to ln_bb to match the schematics
> 
> v2
> -fix compatible ordering nits per Stephen 
> 
>  .../devicetree/bindings/clock/qcom,rpmcc.txt       |  1 +
>  drivers/clk/qcom/clk-smd-rpm.c                     | 63 ++++++++++++++++++++++
>  include/dt-bindings/clock/qcom,rpmcc.h             | 10 ++++
>  3 files changed, 74 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
