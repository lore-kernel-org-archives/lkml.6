Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89086C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 554F120818
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550766742;
	bh=ocP01hhMOSOjikZZijca46AzVDUlgsBZjmrvfZCKqdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GFKM4y6oAHu68NzNzt/Y7VUgffQCLvLt7f1xTl+kO2IZSQGCK7E3kVPU8o5M7VpAt
	 KE4EJLGDnpP+wnBSVofAfXH7DyzIxicsJituZ3OIoF7A9b1/pOXT5VI1HtPncounnS
	 Zt58hygM3W1G1CW+Mjsa2raZJFhpot3ntetdVYzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbfBUQcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:32:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:46878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfBUQcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:32:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87E6120818;
        Thu, 21 Feb 2019 16:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550766740;
        bh=ocP01hhMOSOjikZZijca46AzVDUlgsBZjmrvfZCKqdQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oua1lNTsHa4nworFoduNFga8QYzmjy0cG2VXbtK3E9CR6OnsqQf/rWdAJ6bxxWkFW
         pXOL7iGsUfBdw8YiL7ALqvsHPa4GYtem18dwRZlhm5BVaVHBan00YvFTrgmkInzbQ9
         GvTfasHKKYWS1btaiY5+uDjV46+PwWEoghTxAQJo=
Date:   Thu, 21 Feb 2019 17:32:16 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vaishali Thakkar <vaishali.thakkar@linaro.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, bjorn.andersson@linaro.org, vkoul@kernel.org
Subject: Re: [PATCH v3 4/5] soc: qcom: socinfo: Expose custom attributes
Message-ID: <20190221163216.GD8727@kroah.com>
References: <20190221162419.32384-1-vaishali.thakkar@linaro.org>
 <20190221162419.32384-5-vaishali.thakkar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221162419.32384-5-vaishali.thakkar@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 09:54:18PM +0530, Vaishali Thakkar wrote:
> +#else
> +static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo) { return 0; }

I don't think that will actually compile :)

