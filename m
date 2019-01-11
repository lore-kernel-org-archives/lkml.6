Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E837CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89D120872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218634;
	bh=AgL2UzyOiDVLK5WrXeEi8UqXN+ktX+8Vun0izwEqTfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BYynywhUdAEnvAvmV/6/M/W6ib9axd468GqJ5/7IoioGsT0AvuBAyRa8BOiIAg+Ut
	 73m02/P++FXi7mHYZFDyBQgQoUdoVYgIqvDH/x8fIsQvNuoc91/T8oAQfo7NRqaD9x
	 T2nbU2DcjVLG7qZXZRdhKjdyePkuyH9KbwiTu2nc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390954AbfAKO5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:57:13 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45724 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389695AbfAKOfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:35:20 -0500
Received: by mail-ot1-f68.google.com with SMTP id 32so13218228ota.12;
        Fri, 11 Jan 2019 06:35:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JQOVdFjdcuNNtWfuTabFCrV74xhSNL7upBycsgWKZ/g=;
        b=HBCza5IuouhQjyBoz4reA/1ZAss/L6e4bW6zhoOXlQSM/az6XsHUhlMe8AG5WM/cfr
         LmZHeq0uAk8PUhLUaTidavnF6IVCO03QQixJgDgMmVffdWBBRNZTBlrsF02YXzHjlmep
         n/h5Flf7XsbPUk9jc7jmg8d5NH27uQ8lYviRq1LTNnmHAQbhnseZ1C/znLJl+oGQJU20
         UmSY3PpJAeW3knLNGhUm7vK+p9JKItOdJpv4HjPkC4DPtHEJ0ZMmBBWllVjbp9deUSUE
         MOnAtISb2MG1rQG6v8xfxkkncj1KDuRbPN6CXzrbuXngXipmWDQ8W5BcahtuULgxoPfI
         oKhQ==
X-Gm-Message-State: AJcUukemwusQnDunGc4twzGG63JE6pql/af87q30eSJHmVAGyaTg5Ztp
        NSYV0HViCF89/LVsrzxnig==
X-Google-Smtp-Source: ALg8bN61PjZw/+SBQz4A89/ksPqeTrywYXPBZmlXnw81CRNukXqXx9Uq6VudtZmhJNMqpf3fEQ52DQ==
X-Received: by 2002:a9d:3a46:: with SMTP id j64mr10389262otc.103.1547217319496;
        Fri, 11 Jan 2019 06:35:19 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v3sm70449155oib.57.2019.01.11.06.35.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 06:35:18 -0800 (PST)
Date:   Fri, 11 Jan 2019 08:35:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jayant Shekhar <jshekhar@codeaurora.org>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, abhinavk@codeaurora.org,
        Jayant Shekhar <jshekhar@codeaurora.org>,
        seanpaul@chromium.org, chandanu@codeaurora.org,
        hoegsberg@chromium.org,
        Sravanthi Kollukuduru <skolluku@codeaurora.org>
Subject: Re: [v5 3/3] dt-bindings: msm/disp: Introduce interconnect bindings
 for  MDSS on SDM845
Message-ID: <20190111143518.GA19187@bogus>
References: <1547056325-1919-1-git-send-email-jshekhar@codeaurora.org>
 <1547056325-1919-4-git-send-email-jshekhar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547056325-1919-4-git-send-email-jshekhar@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 Jan 2019 23:22:05 +0530, Jayant Shekhar wrote:
> From: Sravanthi Kollukuduru <skolluku@codeaurora.org>
> 
> Add interconnect properties such as interconnect provider specifier
> , the edge source and destination ports which are required by the
> interconnect API to configure interconnect path for MDSS.
> 
> Changes in v2:
> 	- none
> 
> Changes in v3:
> 	- Remove common property definitions (Rob Herring)
> 
> Changes in v4:
> 	- Use port macros and change port string names (Georgi Djakov)
> 
> Changes in v5:
> 	- None
> 
> Signed-off-by: Sravanthi Kollukuduru <skolluku@codeaurora.org>
> Signed-off-by: Jayant Shekhar <jshekhar@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/display/msm/dpu.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
