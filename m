Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE6CC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E726B2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="K7Vv52t7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E726B2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbeH1MXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 08:23:35 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50602 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbeH1MXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 08:23:35 -0400
Received: by mail-wm0-f65.google.com with SMTP id s12-v6so1000314wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 01:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3r0upJM1a33H6EZjsxYQIsd3Nm61vOXOYrevAtFh6Io=;
        b=K7Vv52t7THLvRFvy7jFZeXeSJrD4v9jBEzCvVfhYCSYlWcxKbpGGEKEOuYl/sjWzIL
         gwUUdZudeyItZrR4f48Je24kEyLT0GMG10zGyFr/rAbr1GkInpZThM34eYO/iAvW/Svk
         2QGI13XvYHjQk2BTOVryvBIhOKY1vo6g6VDnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3r0upJM1a33H6EZjsxYQIsd3Nm61vOXOYrevAtFh6Io=;
        b=rLEVvOJzCjZOGyqUFJMM/toJ7BJ1URM/+nJy1d1frLlC4wIAPFJxWrKI5Grvrqphdq
         paANqcJLo1MO68lGNIiPy91EzaNmyvB7F/ftiTXHzlscKirAQT2neL/SWXZBQdOOT4mE
         ETFQdMRnCtFdo9bfkT2CWB56ohKa7dVg5NHNIYa8qeY6kydQjbEhHJTEXzuz4SgnrnlX
         gZadWpgGvsX6hImJhf7Lsz07t/n6z6mQLOVqse2RMZO7bnnayqtDEtcaGzaNZx0E5oTi
         0/9hcMYVUrwWo5joh4PyFuOQjQcsiUbtHiwhmp4smONLm7A6uStuEWnRdSnystlH8Xde
         IvLA==
X-Gm-Message-State: APzg51CLp5bSq90Rps+ei8VW6YB5dqemG44Uot8fJPQp0Em9DVwo4xOo
        hUhurc7ZKQ3UV9/VltT+FazBRA==
X-Google-Smtp-Source: ANB0Vdb/99R5C+mc5VOd6VIjbCPv1kiwRZOfSvxl/9hZ85fOO8/ksuG/BgVuDsY1HiabaK1eNhNuCQ==
X-Received: by 2002:a1c:4887:: with SMTP id v129-v6mr618894wma.129.1535445180499;
        Tue, 28 Aug 2018 01:33:00 -0700 (PDT)
Received: from apalos (athedsl-4445909.home.otenet.gr. [79.129.198.197])
        by smtp.gmail.com with ESMTPSA id u7-v6sm1162338wmd.46.2018.08.28.01.32.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 01:32:59 -0700 (PDT)
Date:   Tue, 28 Aug 2018 11:32:57 +0300
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Petr Machata <petrm@mellanox.com>, netdev@vger.kernel.org,
        jiri@mellanox.com, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFT] net: dsa: Allow configuring CPU port VLANs
Message-ID: <20180828083257.GA10872@apalos>
References: <20180624153339.13572-1-f.fainelli@gmail.com>
 <wih4lhrgrfd.fsf@dev-r-vrt-156.mtr.labs.mlnx>
 <20180625091713.GA13442@apalos>
 <9ce291a4-b40d-81d8-1c1a-c4311e5cc113@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ce291a4-b40d-81d8-1c1a-c4311e5cc113@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 04:58:10PM -0700, Florian Fainelli wrote:
> On 06/25/2018 02:17 AM, Ilias Apalodimas wrote:
> > On Mon, Jun 25, 2018 at 12:13:10PM +0300, Petr Machata wrote:
> >> Florian Fainelli <f.fainelli@gmail.com> writes:
> >>
> >>>  	if (netif_is_bridge_master(vlan->obj.orig_dev))
> >>> -		return -EOPNOTSUPP;
> >>> +		info.port = dp->cpu_dp->index;
> >>
> >> The condition above will trigger also when a VLAN is added on a member
> >> port, and there's no other port with that VLAN. In that case the VLAN
> >> comes without the BRIDGE_VLAN_INFO_BRENTRY flag. In mlxsw we have this
> >> to get the bridge VLANs:
> >>
> >> 	if (netif_is_bridge_master(orig_dev)) {
> >> 		[...]
> >> 		if ((vlan->flags & BRIDGE_VLAN_INFO_BRENTRY) &&
> >> 		[...]
> >>
> >> This doesn't appear to be done in DSA unless I'm missing something.
> > Petr's right. This will trigger for VLANs added on 'not cpu ports' if the VLAN
> > is not already a member. 
> > 
> > This command has BRIDGE_VLAN_INFO_BRENTRY set:
> > bridge vlan add dev br0 vid 100 pvid untagged self 
> > I had the same issue on my CPSW RFC and solved it
> > exactly the same was as Petr suggested.
> 
> Humm, there must be something obvious I am missing, but the following
> don't exactly result in what I would expect after adding a check for
> vlan->flags & BRIDGE_VLAN_INFO_BRENTRY:
> 
> brctl addbr br0
> echo 1 > /sys/class/net/br0/bridge/vlan_filtering
> brctl addif br0 lan1
> 
> #1 results in lan1 being programmed with VID 1, PVID, untagged, but not
> the CPU port. I would have sort of expected that the bridge layer would
> also push the configuration to br0/CPU port since this is the default VLAN:
> 
> bridge vlan show dev br0
> port	vlan ids
> br0	1 PVID Egress Untagged
> 
> But it does not.
> 
> bridge vlan add vid 2 dev lan1
> 
> #2 same thing, results in only lan1 being programmed with VID 2, tagged
> but that is expected because we are creating the VLAN only for the
> user-facing port.
> 
> bridge vlan add vid 3 dev br0 self
> 
> #3 results in the CPU port being programmed with VID 3, tagged, again,
> this is expected because we are only programming the bridge master/CPU
> port here.
> 
> Does #1 also happen for cpsw and mlxsw or do you actually get events
> about the bridge's default VLAN configuration? Or does the switch driver
> actually need to obtain that at the time the port is enslaved somehow?
As long as ports are attached you get the events (one event per attached port
iirc)
if the event is checked against BRIDGE_VLAN_INFO_BRENTRY, the only way to add a
VLAN to the cpu port is via 'bridge vlan add vid 3 dev br0 self'
> 
> Thanks!
> -- 
> Florian
/Ilias
