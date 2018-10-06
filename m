Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7013FC677E8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 16:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12BDB2147D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 16:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUHQx5VH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12BDB2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbeJFXcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 19:32:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:41986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725266AbeJFXcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 19:32:25 -0400
Received: from localhost (unknown [171.76.113.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F62B208E7;
        Sat,  6 Oct 2018 16:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538843307;
        bh=Mj1vdcrYCfd/II4Q76BKa0KLI4WS9LUYcbaGyEprkBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RUHQx5VHMZ+9yf+sRIEPY6gnMkwt2zibgJ+gyXziVTxzOI4d4LILgj5L1HKBePLU2
         e9mBiIuHLcexksRtke1qpbXzd+q1nPXCdQxK2U6wJjHlKv22Jgtz3M7b3EGiIuVt4Q
         gDuT059UBNh7iqOoIOBBzPhr+5lz4bzAT+D0xws4=
Date:   Sat, 6 Oct 2018 21:58:18 +0530
From:   Vinod <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Suman Anna <s-anna@ti.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] samples/rpmsg: Introduce a module parameter for message
 count
Message-ID: <20181006162818.GQ2372@vkoul-mobl>
References: <20180911174643.26199-1-s-anna@ti.com>
 <20181006062231.GF12063@builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181006062231.GF12063@builder>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-10-18, 23:22, Bjorn Andersson wrote:
> On Tue 11 Sep 10:46 PDT 2018, Suman Anna wrote:
> 
> > The current rpmsg_client_sample uses a fixed number of messages to
> > be sent to each instance. This is currently set at 100. Introduce
> > an optional module parameter 'count' so that the number of messages
> > to be exchanged can be made flexible.
> > 
> 
> Rather than sending N messages as fast as possible to any sample channel
> that comes up, how about making the sample create a debugfs entry that
> we can write messages to from user space?

Wouldn't it be better to make it sysfs rather than debugfs knob?

-- 
~Vinod
