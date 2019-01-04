Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23998C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD13217F5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dmtknSJz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfADJTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 04:19:22 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39515 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfADJTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 04:19:22 -0500
Received: by mail-wr1-f68.google.com with SMTP id t27so35991363wra.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 01:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9JVkkInrU1bNd2cI2v93yNfg1Rgt7ON+1xe56srkMuY=;
        b=dmtknSJzbEoQXe/azDOCC51ZOWJhprHI+v5pm7bK2cNU7TyM+sYRNpMwPtVqoXKQC7
         74Z5MNiruiZE1XXarmFVtdzMcjdOYH4CVkAbduHQOhOOAyD+ip+CnkX8O0/owgnOeV/B
         eUZLhOsyGhu6sctLHy0yWY9oBweNDngJ3ALSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9JVkkInrU1bNd2cI2v93yNfg1Rgt7ON+1xe56srkMuY=;
        b=mZXS7Wne9KS+feR87vvqeqqefU98Xgq5MzLyQYhky5U/cdV8+V7hU52HI/qPRmZXNk
         rj+F1qgUA+tVNdrdbUupCSssA8YxUB18Xr2V3eOIbIiqpq0jowHqkWiRRcD7TdHRse0X
         AwMMlGJcorZsQqSOHjh9pbX2JdVmbtx3Qyl0b0564jtLBDFzh30y6Ll87PH5vHfh5pFm
         DuF4OGbIPfDzn36RM5yAOWfExE5VJjsJ/bSZpImWoOQX8zhoJOPrFo3UYAVLoUeunt0v
         25muFdvjqm75mUVdCowoXrLb7Y5rR6zMoondVweG22f6aW0emnkpKT2p2dXS1Y/FRsi2
         uojQ==
X-Gm-Message-State: AJcUukfPOoq6599WyR4vsm1Z6bSJMai7gdHI0qaxxKugP8c+qW0e0+P3
        9x+Ukq0AeFps5k+tLdZCBr6NCQ==
X-Google-Smtp-Source: ALg8bN5ptw3Q0vY2RV9L3NrCYzDp+hVoRGn10wKKaLQnjxmJC5tknp2eCszg8jMNGCnqQgI2AP+aBw==
X-Received: by 2002:adf:e78f:: with SMTP id n15mr44946449wrm.115.1546593559870;
        Fri, 04 Jan 2019 01:19:19 -0800 (PST)
Received: from apalos (athedsl-4482683.home.otenet.gr. [94.71.50.131])
        by smtp.gmail.com with ESMTPSA id t4sm11609290wrb.64.2019.01.04.01.19.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 01:19:19 -0800 (PST)
Date:   Fri, 4 Jan 2019 11:19:16 +0200
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Po Liu <po.liu@nxp.com>
Cc:     Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "haustad@cisco.com" <haustad@cisco.com>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>
Subject: Re: [PATCH] net: tsn: add an netlink interface between kernel and
 application layer
Message-ID: <20190104091916.GA3360@apalos>
References: <1545968772-7237-1-git-send-email-Po.Liu@nxp.com>
 <1545968945-7290-1-git-send-email-Po.Liu@nxp.com>
 <87r2e14fgr.fsf@intel.com>
 <VI1PR04MB51359EB3614797A89185C9D292B00@VI1PR04MB5135.eurprd04.prod.outlook.com>
 <87k1jm51ey.fsf@intel.com>
 <20190103091605.GA4597@apalos>
 <VI1PR04MB51351DDF26EB43FEDC9094B6928D0@VI1PR04MB5135.eurprd04.prod.outlook.com>
 <20190103113854.GA10968@apalos>
 <VI1PR04MB51357307440F6B89831741F5928E0@VI1PR04MB5135.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB51357307440F6B89831741F5928E0@VI1PR04MB5135.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Po,
> > >
> > > [Po] Ya, there are operations of switchdev. You may think that to add the TSN
> > configurations ops into switchdev operations. But  we need to consider the end-
> > station devices and switch all in the devices or in the TSN domain. The TSN
> > domain is the devices include TSN capabilities ports, for up layer, we need to
> > provide a formal interface. So tsn configure can be standalone.
> > > In this patch, we treat two kinds of ports when registering the ports, end-
> > station or switch. This may treat them in some minor differences in TSN spec
> > and drivers.
> > >
> > 
> > Why are switches different than end-stations configuration wise?
> 
> Minor differences but still have mentioned in spec.
> 
> > I understand that you may need to support different TSN IEEE standards per
> > device, but adding support for different capabilities shouldn't affect a 'common'
> > configuration path.
> > That's the actual advantage of switchdev based drivers. switches and end
> > stations will have a very similar way of confiration via iproute2/bridge/tc utils.
> > Am i missing something?
> > 
> I guess I start to getting your advise. Do you mean to add operations in struct switchdev_ops ? Is it proper include end station? I used to add structure tsn_ops in net_device. But I think there are some information and status of devices maintain in the kernel from drivers. So I create structure tsn_port standalone. 
> Yes,  iproute2/bridge/tc is one choice for user space. I would think of the possible. But the too many parameters are still the problem. For example to create Qbv gate list.

Well iproute2 is already used to configure an 802.1Qbv software scheduler which
is already merged into net-next [1]. 

The netdevice operations already have a callback to configure hardware 
schedulers used for CBS currently [2]. We should be able to configure the 
hardware (at least the basics) for 802.1Qbv, using those callbacks. 

Try to include switchdev maintainers in the next RFC and have a discussion on
what's the best approach to move forward on that and how to add missing
features.

I am not really sure i have all the bits and pieces correctly, but i did make a
presentation a few months ago on this [3].

Since switchdev is creating 1 ethernet interface per switch port and provides
you with a way of configuring the switch 'cpu' port individually we should be
able to fit everything in there by extending the current API's (but i might be 
missing something).

[1] Look into net/sched/sch_taprio.c for the software scheduler.
[2] .ndo_setup_tc() is the ndo callback. Look for TC_SETUP_QDISC_CBS and you'll
    get the idea. I know intel i210 and TI's cpsw driver are using it. 
[3] https://connect.linaro.org/resources/yvr18/sessions/yvr18-212/


/Ilias
