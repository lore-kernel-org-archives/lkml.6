Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD95C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A39220673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="pO0h2rhU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d3JOG2cc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A39220673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbeGZGVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 02:21:33 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54585 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726600AbeGZGVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 02:21:33 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 7AD3C20A41;
        Thu, 26 Jul 2018 01:06:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 26 Jul 2018 01:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=+FI3F7WZ5MKe9cXjHVybxTtNmWnkrlyWzTxeO0+pIec=; b=pO0h2rhU
        lsu28biq1nCFdkHDo72y8AlnEL4ER5ouQasZBxdx8SqZcdPJ44oK1UYfZWV1vtk5
        mv7eA4INVs82C6OejVBl/5hDrFPExvT4vr1XAy3c3Vypt+kSh5IZoeFQJ/GpyHJh
        /mdQHz8FjKIWKO+DVm+8eccSGMEjx4FEGfaFPaWQ82mAU43h40CVb2y+nPBRFQhK
        4AKMubNe2bBuYn0g3h8GIIAR4fjmEdOSP4+gVTG0H6WQPOU2RLyXFripHVUbu43J
        Fr0g7rAuNfK6nOBLTWv/rWasJi2BiXQPob7kfV+S8fR88EG5mE8/vxIPLRw1UpsC
        P5iuXzPphDToog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=+FI3F7WZ5MKe9cXjHVybxTtNmWnkr
        lyWzTxeO0+pIec=; b=d3JOG2ccAVdDK1ZzcvFWIMQFU7v1ei7g3Zt8IV4fB6ZDJ
        RrXbKn3M4rnb0ZRk7pfOjQcErTv+7OF7/MLX5oYm5YtV111rcC5bklJ89sJ4j5QD
        W01xpzR6kOpr3aSm+eTu0QTjAr9tNVR5pZZhTPkX+rSpcKOakVLnl8pIVETtWuf1
        EZK0VMhzLCoNYNkbGyi7a4Kcr3HftXKGLKIo05dTtQlzs6mIj2Ge1gD84IBAEHws
        ikb+OTJgizwdD0xTIDZiPYmqYkWOvI3pLZNMEtKUyHakANe1usw5aSNJV67dEUUp
        +GwTRuurbsX/vZr6VQx8/j8lZ8oVpO8F0JsVdZ4jQ==
X-ME-Proxy: <xmx:11ZZW0vtMTOU0MnyeIVYaePMMXGBwExjegiU_MJu6tjbrok6jy6rKA>
    <xmx:11ZZW21-gvp-yiuR1Q47JX-qmRpTe-nsyYqkAh2XoNQvylx0ttUD1A>
    <xmx:11ZZW_-ozhQoHckxAG9LegUD3nB2X_f4BNVPF2dwN7sGE1JnPZVIFg>
    <xmx:11ZZW3Oh-RfzqwC6XklsWxAzzqwOh8-eJglcn0u-6SEJokVls0D7xA>
    <xmx:11ZZWzc6_JHATVbrLVMS2RzbtkiUMN-E2XUwzWcMmzf2sF9GbYs_oA>
    <xmx:11ZZWxCWwKa3F6SKvXvyjXOCewKQrIX09ynmWyHvIpd1ER5MZhHuwA>
X-ME-Sender: <xms:11ZZW9eBUyKvUBM4bdDIGOGHGnYSKZc7CAIVHiWVVGWzUzRp2ApDXw>
Received: from localhost (ppp121-44-239-245.bras2.syd2.internode.on.net [121.44.239.245])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3C18B1025D;
        Thu, 26 Jul 2018 01:06:29 -0400 (EDT)
Date:   Thu, 26 Jul 2018 15:06:27 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Edward Cree <ecree@solarflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-doc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next 0/3] docs: net: Convert netdev-FAQ to RST
Message-ID: <20180726050627.GH6067@eros>
References: <20180726050226.1980-1-me@tobin.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726050226.1980-1-me@tobin.cc>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 03:02:23PM +1000, Tobin C. Harding wrote:
> Hi Dave,

Sent set twice.  It is hard to get good help eh.


Thanks for your patience,
Tobin.
