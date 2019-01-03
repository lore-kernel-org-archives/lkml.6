Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92706C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5909320578
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b6hriFBY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731192AbfACLjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 06:39:01 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36947 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730396AbfACLjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 06:39:00 -0500
Received: by mail-wr1-f68.google.com with SMTP id s12so33243738wrt.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 03:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=14cEYofJy5M+Jg+RGLYhiijeN2FQ6vOAKLYjQmnfA+c=;
        b=b6hriFBYvjAhigOo8yknaCCPgNk9zfyz31EFZK/WvYt2MkT9hFVZHC4QVMVfS0vmW3
         UNCVJGuU0h76iXs0TovovYP4IWAncy/hCcyFpGtZwqkf/hKjuMSP9ducz4iStwF+Y5Ss
         owDLptnsEpuRYZ3XTpGPFKib9ta3g0zU2Fwzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=14cEYofJy5M+Jg+RGLYhiijeN2FQ6vOAKLYjQmnfA+c=;
        b=Eg2TrWswMA8e6V9u+dD2yqGwiSNoTnGfXhZ8zdrXh57VmGkpgk3sDwtpeCTI9z313r
         p64hPq7VlW91eN8DL4g3oJEuJqNcWrukrs2vD+vl1H8eWJw/BJCSGiF9s8j5hC9hsTFd
         x55t5EAaMEIy3ENsonyYJHo5Jcw3B7enGLJSYqKWjyg6dVq41586rPySY62D83kfcc85
         g/U4zc+4utb9P1sTnC7oJ87tytyLx4n9v1Hx1M4GA2Zy5ESxx47G6NwS2kFajBdIcBCA
         KLAltS7gjaxur/DrtfezPS7pDkhMnEUAFak1beZqQYX7Ad3hXEcLGA9HfEtqzJCrQ+Vu
         xMmw==
X-Gm-Message-State: AJcUukcVEZGO3ozHsfdZdz1qJVWlOn44Ax5I4Ga20UPar/YNGQdnJcjb
        YoY6WzLBejroHUSvo8Ha49kU+Q==
X-Google-Smtp-Source: ALg8bN5vIxGKwLaIqN6MV/FpCGQp+bzxTS2WRIsOwsY5lxwD+BNWl9tQY799aqebUKTztEhzCmdU+Q==
X-Received: by 2002:adf:e911:: with SMTP id f17mr43537517wrm.126.1546515538942;
        Thu, 03 Jan 2019 03:38:58 -0800 (PST)
Received: from apalos (athedsl-4482683.home.otenet.gr. [94.71.50.131])
        by smtp.gmail.com with ESMTPSA id o5sm67543207wmg.25.2019.01.03.03.38.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 03:38:58 -0800 (PST)
Date:   Thu, 3 Jan 2019 13:38:54 +0200
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
Message-ID: <20190103113854.GA10968@apalos>
References: <1545968772-7237-1-git-send-email-Po.Liu@nxp.com>
 <1545968945-7290-1-git-send-email-Po.Liu@nxp.com>
 <87r2e14fgr.fsf@intel.com>
 <VI1PR04MB51359EB3614797A89185C9D292B00@VI1PR04MB5135.eurprd04.prod.outlook.com>
 <87k1jm51ey.fsf@intel.com>
 <20190103091605.GA4597@apalos>
 <VI1PR04MB51351DDF26EB43FEDC9094B6928D0@VI1PR04MB5135.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB51351DDF26EB43FEDC9094B6928D0@VI1PR04MB5135.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Po,

> > > > Some protocols target to configure the traffic class(like Qav CBS).
> > > > Some to config the port(like Qbv). But some for the whole ethernet
> > > > controller(like Qci, the control entries for the whole controller,
> > > > which input ports and which output ports).
> > >
> > > Reading your email, now I understand your point a little better. You
> > > are interested in multi-port devices. I admit that I am not too
> > > familiar with how multi-port devices are exposed in Linux, I was only
> > > focused on the end-station use cases, until now.
> > 
> > Have you considered a switchdev-based driver for multi-port devices?
> [Po] Yes, the patch is including the switchdev-based driver. In fact, we have driver examples for  ls1028 which include end-station IP and switch ports IP, with this interface driver, it is working. But we need to add base ethernet driver of ENETC(end station) and FELIX(switch) upstream first, then add the TSN driver upstream.
> 
> > What you ask of TSN configuration is currently doable with switch switchdev
> > for VLANs and other similar networking functionality.
> [Po] I think the VLAN configure is not conflict with the TSN. TSN is extending the 8021Q. TSN configure the setting of filter frame or scheduling between TC. But maybe need to consider as whole as you said.  

VLAN was an example of devices already performing complex configuration using
switchdev and configurating 'switch' ports and 'cpu' port(s) individually.
It wasn't related to TSN or its 802.1Qbv importance in any way.

> > 
> > Instead of rewriting this from scratch, we not extend the currect TC and
> > switchdev functionality for that ?
> 
> [Po] Ya, there are operations of switchdev. You may think that to add the TSN configurations ops into switchdev operations. But  we need to consider the end-station devices and switch all in the devices or in the TSN domain. The TSN domain is the devices include TSN capabilities ports, for up layer, we need to provide a formal interface. So tsn configure can be standalone.  
> In this patch, we treat two kinds of ports when registering the ports, end-station or switch. This may treat them in some minor differences in TSN spec and drivers.
> 

Why are switches different than end-stations configuration wise?
I understand that you may need to support different TSN IEEE standards per
device, but adding support for different capabilities shouldn't affect a
'common' configuration path. 
That's the actual advantage of switchdev based drivers. switches and end stations
will have a very similar way of confiration via iproute2/bridge/tc utils. Am i
missing something?

/Ilias
