Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336FBC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047292087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:31:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 047292087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbeJLTDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 15:03:49 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38006 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbeJLTDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 15:03:49 -0400
Received: by mail-ot1-f65.google.com with SMTP id l1so12043861otj.5;
        Fri, 12 Oct 2018 04:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BJrWnIuWqsL0GyRzItQea9ay5SebeXreVPtelM0Lj8s=;
        b=QqaYp+WYatG5krClabAPhkVgYmgKd4lePCn1jIHHRYyLFtt7yD6s4lUUaLoZbg9aI4
         yIhTDe6hJlxkq8U7eoYG+oewBlOVui0z2O6sxSks+OooSv1C3r+NO1WrUu3HtM+tyisf
         XsHc+IZcKpSncnmdwH+4KxsI+CbsB8yFs0L2A8IrkmFtfrCV4hMqesWqAtVW4o9YoVR7
         isVRpB1KIjEFAPIpYA1/lBwS6OLpxV+6CW0hWoRbuzQGEtqkYWYE4wgkVdW+3NSgmhYu
         XzKyq4GJlb+FC+seV05H6h5VT2Y9OQ4VQknhjVGr34sUXWjFLh/2kZswYA0jiQkTw0IQ
         KJNQ==
X-Gm-Message-State: ABuFfohhgavArnC3i6vZJkvkj6v1MKpCC3oP3fAMMEZymo0ypEGjyz5g
        c8TTwT5MWTg2N6nlY3VOag==
X-Google-Smtp-Source: ACcGV61F9ih45Wa5Y4LO8+oNwKPFzDcRFkm6v60KZI6dwzG3KBHuMSiKUCCbUtIL7N4NeRBPVSb3+w==
X-Received: by 2002:a9d:155b:: with SMTP id z27mr3619890otz.271.1539343908379;
        Fri, 12 Oct 2018 04:31:48 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y135-v6sm201994oie.25.2018.10.12.04.31.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 04:31:47 -0700 (PDT)
Date:   Fri, 12 Oct 2018 06:31:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     "vkoul@kernel.org" <vkoul@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "zw@zh-kernel.org" <zw@zh-kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Jiafei Pan <jiafei.pan@nxp.com>
Subject: Re: [PATCH 7/7] dt-bindings: fsl-qdma: Add NXP Layerscpae qDMA
 controller bindings
Message-ID: <20181012113146.GA11432@bogus>
References: <20181011094655.45707-1-peng.ma@nxp.com>
 <20181011094655.45707-7-peng.ma@nxp.com>
 <20181011220845.GA20860@bogus>
 <VI1PR04MB44310889ACCA73AFB29CAEEFEDE20@VI1PR04MB4431.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI1PR04MB44310889ACCA73AFB29CAEEFEDE20@VI1PR04MB4431.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 02:25:25AM +0000, Peng Ma wrote:
> Hi Rob,
> 
> > -----Original Message-----
> > From: Rob Herring [mailto:robh@kernel.org]
> > Sent: 2018年10月12日 6:09
> > To: Peng Ma <peng.ma@nxp.com>
> > Cc: vkoul@kernel.org; Leo Li <leoyang.li@nxp.com>; mark.rutland@arm.com;
> > shawnguo@kernel.org; dan.j.williams@intel.com; zw@zh-kernel.org;
> > dmaengine@vger.kernel.org; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [PATCH 7/7] dt-bindings: fsl-qdma: Add NXP Layerscpae qDMA
> > controller bindings
> > 
> > On Thu, Oct 11, 2018 at 05:46:55PM +0800, Peng Ma wrote:
> > > Document the devicetree bindings for NXP Layerscape qDMA controller
> > > which could be found on NXP QorIQ Layerscape SoCs.
> > >
> > > Signed-off-by: Peng Ma <peng.ma@nxp.com>
> > 
> > What happened to the version from Wen He that was on v7 and that I already
> > gave my Reviewed-by on?
> 
> [Peng Ma] the dma owner is changed and qdma driver made some changes, so I need send those patch again to review!

That's no reason to make changes or drop the original author. You should 
also indicate this is v9 and provide revision history.

Rob
