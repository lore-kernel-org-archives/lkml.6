Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A16C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 09:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE162073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 09:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C2pWtDep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbfACJQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 04:16:11 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35618 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbfACJQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 04:16:11 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so32932125wrb.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 01:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ktfmb/swmrFc338pd362DALxj/Fjlo/hTcPE4UjWSQQ=;
        b=C2pWtDepfEGB2Eb/4zpmkpGkAhulK7muBfmYzlWmgBH9V3/ZepEnF5MgyqVLzI1XaI
         UVY3vlvThcTxpm2nDNGWGOE5H72aJT+OyDfxF8aHJzgg1xVoeN+n9MuT3ipZu7JaKcWJ
         nCbgc895CkUUtDHZXEWrboAq3ESHztULwLpDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ktfmb/swmrFc338pd362DALxj/Fjlo/hTcPE4UjWSQQ=;
        b=B0UxvZ405+tddroDjLbjeQwMYRjVk6/+Bq8RBbGlfAjBO1FAuCWj97uz4n8KfD1nPx
         aOiu8bmK3AN9jlI+Fiy+k1NrKu/VE4gy2dPh0JwzLoWxeYBN84mnr4yLpC23kwESzjeV
         HhYaftHWuRHqRzR7amopShHZlbIH5NwNMeRCsK06RVx5gd9aOpHykqzJipGlhPh0WI4q
         juwlTNLkNegMToOavK1k59sYID3TZHaGXKV0PQzwy3bkVcxTWvPVkdncj+vUDmHRSphB
         zXw09J1TNvpRym0xZSY4t/0aaOYjeEdl9f8xcrQGiXBDVRWYNT8ORDDhhR8gysSICJkQ
         vOMg==
X-Gm-Message-State: AJcUukeUIbopNHPmDXkxvnZvulWKj9lf7QveqwaUgw0sw/UuxF8DK5XE
        FmgNidUx3bTLTMULz+jBH5kOvg==
X-Google-Smtp-Source: ALg8bN4EC710abf4BFkEUaeh4rXPzpNlBryqjRLFNDXeHOqme1tjZuoU6tdcSLx7I5rm29PGTjzYqw==
X-Received: by 2002:adf:9123:: with SMTP id j32mr43131579wrj.122.1546506969480;
        Thu, 03 Jan 2019 01:16:09 -0800 (PST)
Received: from apalos (athedsl-4482683.home.otenet.gr. [94.71.50.131])
        by smtp.gmail.com with ESMTPSA id r12sm52593514wrq.3.2019.01.03.01.16.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 01:16:08 -0800 (PST)
Date:   Thu, 3 Jan 2019 11:16:05 +0200
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc:     PO LIU <po.liu@nxp.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "haustad@cisco.com" <haustad@cisco.com>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>
Subject: Re: [PATCH] net: tsn: add an netlink interface between kernel and
 application layer
Message-ID: <20190103091605.GA4597@apalos>
References: <1545968772-7237-1-git-send-email-Po.Liu@nxp.com>
 <1545968945-7290-1-git-send-email-Po.Liu@nxp.com>
 <87r2e14fgr.fsf@intel.com>
 <VI1PR04MB51359EB3614797A89185C9D292B00@VI1PR04MB5135.eurprd04.prod.outlook.com>
 <87k1jm51ey.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1jm51ey.fsf@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Po,

> > Hi Vinicius,
> >
> > Thank you very much for your feedback.
> >
> > I know the CBS is used to be most important part of AVB. And qdiscs is good tool to configure qos. 
> >
> > But as you know, the TSN family is a cluster of protocols and much extending the AVB. The protocols have different  functionalities and they may have more than hundred  parameters. For example NXP ls1028a support Qbv/Qci/Qbu/Qav and also the 8021CB (not included in this patch yet).
> >
> > Some protocols target to configure the traffic class(like Qav CBS).
> > Some to config the port(like Qbv). But some for the whole ethernet
> > controller(like Qci, the control entries for the whole controller,
> > which input ports and which output ports).
> 
> Reading your email, now I understand your point a little better. You are
> interested in multi-port devices. I admit that I am not too familiar
> with how multi-port devices are exposed in Linux, I was only focused on
> the end-station use cases, until now.

Have you considered a switchdev-based driver for multi-port devices?
What you ask of TSN configuration is currently doable with switch switchdev for
VLANs and other similar networking functionality. 

Instead of rewriting this from scratch, we not extend the currect TC and
switchdev functionality for that ?


Regards
/Ilias
