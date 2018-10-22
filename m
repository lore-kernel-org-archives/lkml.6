Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA5FC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 22:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0DDE20652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 22:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mendozajonas.com header.i=@mendozajonas.com header.b="l6pK1ZCL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yBbHd3K6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0DDE20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mendozajonas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbeJWGoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 02:44:54 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:54513 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728737AbeJWGoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 02:44:54 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id BA28021E59;
        Mon, 22 Oct 2018 18:24:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 22 Oct 2018 18:24:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        mendozajonas.com; h=message-id:subject:from:to:cc:date
        :in-reply-to:references:content-type:mime-version
        :content-transfer-encoding; s=fm1; bh=/STV6m5lml6u66OR2D+3PM54GN
        hw26kp2x3ETmhX0Zk=; b=l6pK1ZCLM8iTgVW0I3ZvmPxoit8m2Czag7/DuzJFjn
        wOqSsUcPSNLzHyhtEaWEpMxMKrMg6+S+UK98Ej3mXJ6fP1wUHrB5W0I2/RE7aA0j
        Sick7+7aIRwD3O11mRqM6ArZSn3Pp3ExTUgW3MMcsb+SRnIuzQyn+R30BGyP8KzT
        FeVn3JIysIpKfp7R3/BKMJXr+Jd524rrGIBnfmQbfakI+IGuxjDD0ncZLYjsIjGk
        PF9Nv+ADchUU5fgSKG/oqG6+/GuNXAR4n4TuaykmrxDgH0cOoR97NirbrP4iArVU
        oZHWNHWF7LVFwoJGHsyvpI+/YZPbJtIKttbROnHxB84g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=/STV6m5lml6u66OR2D+3PM54GNhw26kp2x3ETmhX0
        Zk=; b=yBbHd3K67R9DKUrJUjIDmM6PW/hoqLZUrZjoSAgcdIDQTa1uwRcjCubls
        XahpcG25mojx4jfsfkPRBDP03AjaiEPqrQmAg5ZSmBdxj1w/tgiJ6ZF5YST3koi0
        UZGfIHIhc0QQYcWNOEaiWGGy5+nNTEPjGDWj5bFq205RnaEyHrRzc3BKJKLN9Kus
        k2saajFpEs6vLmhXQvtK8p7hz1p+afIN3yuXJ8b1M0rwaWatKgShceyBvgNSDjHn
        pPcV4JZcAzt1igFDONyE1nMcKfMZ+CfNbgLAcAHnbQxS2eCyTYO2fJn02r97Ehdr
        MQs6amzhCb3/+3yz5CSvTCZXT/Hww==
X-ME-Sender: <xms:G07OWw3LZ3u31O_lEcGgrHWO003szExC75I9PIpBGujNUI8EVz9qqw>
X-ME-Proxy: <xmx:G07OWy4j_zX95XyPgwUBm2QU3hd5Sdd35LKpAG6L36UUiCEKg3UJ8g>
    <xmx:G07OWyw10qQcriQSUZzks82dba9m31I2JaLLGDFqOYZexB3Yav_C6A>
    <xmx:G07OW5y-6NgwzdmK-gbM0up-KUY8psro845S-FaPqXunSr5t61IOYA>
    <xmx:G07OW6x6yvtsOMSuJsw5erqcYr99lzU00TyodSxO7hTSWrBaIOvcQQ>
    <xmx:G07OWzaAEpPzuGqT27FYZPvBH1OEPXRdjlDOj8u1Dc4eDbXAvR7Acw>
    <xmx:G07OW6zkasV6wa-CV_b3mAJr649GPw9QhmEVJV7ULKzyxz4kligxtw>
Received: from v4 (unknown [121.99.135.216])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7F3B8102EE;
        Mon, 22 Oct 2018 18:24:25 -0400 (EDT)
Message-ID: <06fb083313b8547f0c0951a5d5baa1cc3f6c8d6d.camel@mendozajonas.com>
Subject: Re: [PATCH net-next 0/6] net/ncsi: Allow enabling multiple packages
 & channels
From:   Samuel Mendoza-Jonas <sam@mendozajonas.com>
To:     Justin.Lee1@Dell.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Date:   Tue, 23 Oct 2018 09:24:22 +1100
In-Reply-To: <79ee8c9befaa40e781bfeba4ba25d396@AUSX13MPS302.AMER.DELL.COM>
References: <20181018035917.19413-1-sam@mendozajonas.com>
         <20181018.155647.1045018243241594303.davem@davemloft.net>
         <79ee8c9befaa40e781bfeba4ba25d396@AUSX13MPS302.AMER.DELL.COM>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-10-19 at 21:38 +0000, Justin.Lee1@Dell.com wrote:
> Hi Sam,
> 
> When I run the testing (enable multi-package (package 0 and 1) and 
> multi-channel (channel 0 and 1 on both packages)), I see there are two channels
> with TX enable.
> 
> When I unplug/plug network cable, it seems the behavior is to keep one TX per
> package, is it the behavior you expect? All channels are behind the same eth2,
> I would expect there is only one active TX.
> 
> I create the below file to expose driver's status. RX and TX are printing 
> from the follow variables.
> nc->modes[NCSI_MODE_ENABLE].enable,
> nc->modes[NCSI_MODE_TX_ENABLE].enable,
> 
> cat /sys/kernel/debug/ncsi_protocol/ncsi_device_status;
> IFIDX IFNAME NAME   PID CID RX TX MP MC WP WC PS RU CR NQ
> =========================================================
>   2   eth2   ncsi0  000 000 1  1  1  1  1  1  1  1  1  0 
>   2   eth2   ncsi1  000 001 1  0  1  1  1  1  1  1  1  0 
>   2   eth2   ncsi2  001 000 1  1  1  1  1  1  1  1  1  0 
>   2   eth2   ncsi3  001 001 1  0  1  1  1  1  1  1  1  0 
> =========================================================
> M:  Multi-mode      P:  Package ID
> W:  Whitelist       C:  Channel ID
> PS: Poll Status
> RU: Running
> CR: Carrier OK
> NQ: Queue Stopped

Hi Justin,

Thanks for testing; this is probably an oversight in
ncsi_channel_is_tx(), where channels from a package other than the
current one could be ignored when checking for the current channel's link
status. I'll update this to be more robust.

Sam

> 
> Thanks,
> Justin
> 
> 
> From: Samuel Mendoza-Jonas <sam@mendozajonas.com>
> Date: Thu, 18 Oct 2018 14:59:11 +1100
> 
> > This series extends the NCSI driver to configure multiple packages
> > and/or channels simultaneously. Since the RFC series this includes a few
> > extra changes to fix areas in the driver that either made this harder or
> > were roadblocks due to deviations from the NCSI specification.
> > 
> > Patches 1 & 2 fix two issues where the driver made assumptions about the
> > capabilities of the NCSI topology.
> > Patches 3 & 4 change some internal semantics slightly to make multi-mode
> > easier.
> > Patch 5 introduces a cleaner way of reconfiguring the NCSI configuration
> > and keeping track of channel states.
> > Patch 6 implements the main multi-package/multi-channel configuration,
> > configured via the Netlink interface.
> > 
> > Readers who have an interesting NCSI setup - especially multi-package
> > with HWA - please test! I think I've covered all permutations but I
> > don't have infinite hardware to test on.
> 
> 


