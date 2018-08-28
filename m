Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6BEC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAAC120897
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JbwvFBQO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAAC120897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbeH1QNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 12:13:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:59488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727085AbeH1QNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 12:13:23 -0400
Received: from mail-qt0-f177.google.com (mail-qt0-f177.google.com [209.85.216.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB2AD20897;
        Tue, 28 Aug 2018 12:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535458918;
        bh=fJrF1BpFBl5bpC10bZUH4R0D9z4oA/aIY+VNWYbM1XI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JbwvFBQO+MxKC3+3PLOiwirEKkjTq3fqF/x8XZdMGUPIUNjvRGIMHzlEdqfoMk+zA
         rxeAkEOxnzilESNTrXH6v9B75WVarUsoeInmJmZpjD6WCWNfAK0C2R7MF0MPh0bhSZ
         8pFzH/qc/3ZcOEMSxzg/yxDqDgL2qQ0v/zMBaJuE=
Received: by mail-qt0-f177.google.com with SMTP id g44-v6so1332700qtb.12;
        Tue, 28 Aug 2018 05:21:58 -0700 (PDT)
X-Gm-Message-State: APzg51BI7LIrLUnrWTY5GFdA/7VBJLWTM6hCXtFX4JekaBw5hS7xSQPQ
        6vD3qBswA/aFVf1w+AC0YxplUi4Dunc/8Z9H4Q==
X-Google-Smtp-Source: ANB0VdbJHrfdMmwVod7x8b5fgwSzVMPtS5/7SQrJC9iRTBSilEeIF1bHhTmi2sLy7LaxV3zLcAQz+ySyPAB32irwqPY=
X-Received: by 2002:a0c:e9ce:: with SMTP id q14-v6mr1250401qvo.106.1535458918014;
 Tue, 28 Aug 2018 05:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180828015252.28511-1-robh@kernel.org> <20180828015252.28511-28-robh@kernel.org>
 <2863201.EMhOTYQe29@avalon>
In-Reply-To: <2863201.EMhOTYQe29@avalon>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 28 Aug 2018 07:21:46 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKdLoH9X_ThSr45NOqijWRBJgC7eV_iCrCXf5Jhu-dpkQ@mail.gmail.com>
Message-ID: <CAL_JsqKdLoH9X_ThSr45NOqijWRBJgC7eV_iCrCXf5Jhu-dpkQ@mail.gmail.com>
Subject: Re: [PATCH] media: Convert to using %pOFn instead of device_node.name
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Prabhakar Lad <prabhakar.csengg@gmail.com>,
        Benoit Parrot <bparrot@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 5:06 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Rob,
>
> Thank you for the patch.
>
> On Tuesday, 28 August 2018 04:52:29 EEST Rob Herring wrote:
> > In preparation to remove the node name pointer from struct device_node,
> > convert printf users to use the %pOFn format specifier.
> >
> > Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> > Cc: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
> > Cc: Benoit Parrot <bparrot@ti.com>
> > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > Cc: Hyun Kwon <hyun.kwon@xilinx.com>
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: Michal Simek <michal.simek@xilinx.com>
> > Cc: linux-media@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> Which tree would you like to merge this through ?

Media tree. There's no dependency.

Rob
