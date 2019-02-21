Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB337C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 711992084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550766673;
	bh=MEPfSwGULRu6ssMVQ9MlQEY7Wmywvw5mzZxFBdELZs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XcMxQfP/wAD7qzISYBIoWS50tRCyGYEW7GDKWO2iBvPqisCOnUYJUFUmv+NgF3Wk8
	 Zz3PtQxTv4qYrPrec3dVenUM7s2dd8hpSdG24fZD7hH1RvgeoiMV6VVBJEleGQUfM+
	 IQWkctqaQ8wETGKqIOY5T8YmVT+WvProc9fV080c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbfBUQbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:31:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:46398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfBUQbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:31:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8A3E20855;
        Thu, 21 Feb 2019 16:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550766671;
        bh=MEPfSwGULRu6ssMVQ9MlQEY7Wmywvw5mzZxFBdELZs4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s5v/lle1NrZcvhjIB5fgwX7UqlpkH3wJzh9YXamwcmKGEz5ywHXMOCT4+x9ZSBXl/
         +4b15cID8PgFcjlOpIESGC3OOQ2VU2GooZ1RCiU3fZiqIv5XqNPvCiAZxfeXzGe5gq
         hkOLVw75m06MD+LUCEFj7m7HXLl1DhtZunvFLCHU=
Date:   Thu, 21 Feb 2019 17:31:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vaishali Thakkar <vaishali.thakkar@linaro.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, bjorn.andersson@linaro.org, vkoul@kernel.org
Subject: Re: [PATCH v3 1/5] base: soc: Add serial_number attribute to soc
Message-ID: <20190221163107.GB8727@kroah.com>
References: <20190221162419.32384-1-vaishali.thakkar@linaro.org>
 <20190221162419.32384-2-vaishali.thakkar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221162419.32384-2-vaishali.thakkar@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 09:54:15PM +0530, Vaishali Thakkar wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Add new attribute named "serial_number" as a standard interface for
> user space to acquire the serial number of the device.
> 
> For ST-Ericsson SoCs this is exposed by the cryptically named "soc_id"
> attribute, but this provides a human readable standardized name for this
> property.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Vaishali Thakkar <vaishali.thakkar@linaro.org>
> ---
> Changes since v2:
> 	- None
> Changes since v1:
> 	- Make comment more clear for the case when serial
> 	  number is not available

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
