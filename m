Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDD3C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B95F25D7D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sP8BCMNE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B95F25D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752700AbeGBNRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:17:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:57832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751761AbeGBNRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:17:48 -0400
Received: from localhost (unknown [122.167.89.144])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A26125D2F;
        Mon,  2 Jul 2018 13:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530537468;
        bh=kmboEbABkwQgsEhEafrSQG2CEFutieXu9hykq/IbeJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sP8BCMNEvCO4lDLyi0ZJbQzV50GTsDbfZE/KxVXUKvKJall46arJZzeLaYW0nBDfo
         npDrSrtnytqMzFBxO9hy7jNrPNOSCgjAIpuQzUw5ZqhDM3kvuIibS0xgRyNWtlrXFm
         LnUE8BPTfq3+u1TXXn8KqWVXu4RlCH6MHsjZTRh0=
Date:   Mon, 2 Jul 2018 18:47:37 +0530
From:   Vinod <vkoul@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v5 0/7] add virt-dma support for imx-sdma
Message-ID: <20180702131737.GJ22377@vkoul-mobl>
References: <1529427424-12321-1-git-send-email-yibin.gong@nxp.com>
 <1530025442.9910.44.camel@pengutronix.de>
 <1530527489.15665.22.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530527489.15665.22.camel@nxp.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-07-18, 02:32, Robin Gong wrote:
> Hi Vinod,
> 	Do you have any comment for this patchset? Lucas and Sascha
> acked it and tty patch already merged in.

I was actually waiting for ACK/action on patch 1 :)

I have reviewed the series, some nitpicks nothing major, so I have
applied this good cleanup and conversion :) along with fixes for typos
in code, GFP_ fix and removed unused variable.

My buildchain noticed warns (with W=1) on this file, esp now that
structs are moved around. Pls fix the struct descriptions.

Thanks
-- 
~Vinod
