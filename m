Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C9CC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF886206BA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549628477;
	bh=GZ6AW5wIgM6oIvut/pjc/9ktHQtvkXmjNEUFLZCaFGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nYyknGjobAbd+zMZCdRBEwmIWUpnyNbDDytmiCKvsS4yK1ITwEPx32dbjyoTUbk2r
	 AnYZGwpbBh6dq9NUX8TChUljRh0euUl6UcZOa6rMOULUTut6P0RAnPgISg04T4mzgR
	 0qtVxXb0pA7xLmDZ9N2/x3kppLCs3jpM06MZHlQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfBHMVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:21:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:33280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfBHMVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:21:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 262222086C;
        Fri,  8 Feb 2019 12:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549628475;
        bh=GZ6AW5wIgM6oIvut/pjc/9ktHQtvkXmjNEUFLZCaFGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yHw6YcBZetX3TLrXnEF+nn7Ziasajufud4NDOGULycAY5lRzyyH3JDRpX6nEAFQei
         5o2NRbB+NkCNowXB3ZPRSE9LPthSGATF89Okjg7PfTqfGajMsa1xNCGYt3zAocMY6q
         B/SegHhU4JD1LuNz6VVa3XZHseIpGG9p04caAFZU=
Date:   Fri, 8 Feb 2019 13:21:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     arnd@arndb.de, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        bkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org,
        Thierry Escande <thierry.escande@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 1/5] misc: dt-bindings: Add Qualcomm Fastrpc bindings
Message-ID: <20190208122113.GG23483@kroah.com>
References: <20190201130925.27066-1-srinivas.kandagatla@linaro.org>
 <20190201130925.27066-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201130925.27066-2-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 01:09:21PM +0000, Srinivas Kandagatla wrote:
> The FastRPC driver implements an IPC (Inter-Processor Communication)
> mechanism that allows for clients to transparently make remote method
> invocations across DSP and APPS boundaries. This enables developers
> to offload tasks to the DSP and free up the application processor for
> other tasks.
> 
> Co-developed-by: Thierry Escande <thierry.escande@linaro.org>
> Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/misc/qcom,fastrpc.txt | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.txt

What changed from v4?  v2?  v3?

That needs to be somewhere in here, below the --- line or in the 00
email at the least to give us some idea of what is different.

v6 please?

thanks,

greg k-h
