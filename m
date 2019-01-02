Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D202C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 06:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59FF9218AE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 06:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546409190;
	bh=BQ93DFbzP2Zxm/ldqKxh03ATtrSskB7FLnZGi8tJDKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Uljy3PHNdUjalwWUQolWnO+vNVRrAUP2bfTQsSULjf+8ZV9XY09dF9k8vJL7rwDk1
	 d/aDmfh0X7bTtkbr6S3fpF0N/9a2sd1HTweKKXjTEBEx0jRAEvD0nEmIzcV2wd5hIO
	 gnL+ATQ8bjBr+9ST8wwNmTeXE8kIWzvsrUUDdIiU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbfABGG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 01:06:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:59100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbfABGG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 01:06:29 -0500
Received: from localhost (unknown [171.76.109.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D259B2089F;
        Wed,  2 Jan 2019 06:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546409188;
        bh=BQ93DFbzP2Zxm/ldqKxh03ATtrSskB7FLnZGi8tJDKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fGQ9hDfo/MinpeN0p5GzH2XvT7WjiBpURRQ0mFs5XruVdLUYDRxkYwHGW7xaWkkDf
         ZfTkFqTiNvI1v+DHEBbb/L5Kon75EbEEnnpuT4EjIfx9ysL/YBsAIuFGMay/+VK4jA
         Aj3U/J8aynf20oN1yZ6/LM4T+Mna1/0ICZqZOnu0=
Date:   Wed, 2 Jan 2019 11:34:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        kernel-janitors@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/20] dmaengine: at_hdmac: drop useless LIST_HEAD
Message-ID: <20190102060455.GJ7581@vkoul-mobl>
References: <1545555435-24576-1-git-send-email-Julia.Lawall@lip6.fr>
 <1545555435-24576-8-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545555435-24576-8-git-send-email-Julia.Lawall@lip6.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-12-18, 09:57, Julia Lawall wrote:
> Drop LIST_HEAD where the variable it declares is never used.
> 
> tmp_list has been declared since the introduction of the driver
> and has never been used.  The two declarations of list were
> introduced with the containing functions but were also not used.
> 
> The semantic patch that fixes this problem is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> identifier x;
> @@
> - LIST_HEAD(x);
>   ... when != x
> // </smpl>

Applied with Ludovic's ack, thanks

-- 
~Vinod
