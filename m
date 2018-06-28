Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D1CC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BFCB270E4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:04:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BFCB270E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965446AbeF1LEa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 07:04:30 -0400
Received: from smtprelay0070.hostedemail.com ([216.40.44.70]:35969 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934222AbeF1LE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 07:04:28 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 95FE81803F08F;
        Thu, 28 Jun 2018 11:04:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hope64_7e1305543153c
X-Filterd-Recvd-Size: 1825
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Thu, 28 Jun 2018 11:04:26 +0000 (UTC)
Message-ID: <fc15913c3800923ef35e9db9508cbb9f67d0525f.camel@perches.com>
Subject: Re: [PATCH v2 2/5] net: emaclite: Simplify if-else statements
From:   Joe Perches <joe@perches.com>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        davem@davemloft.net, michal.simek@xilinx.com, andrew@lunn.ch
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 28 Jun 2018 04:04:24 -0700
In-Reply-To: <1530171584-20673-3-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1530171584-20673-1-git-send-email-radhey.shyam.pandey@xilinx.com>
         <1530171584-20673-3-git-send-email-radhey.shyam.pandey@xilinx.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-06-28 at 13:09 +0530, Radhey Shyam Pandey wrote:
> Remove else as it is not required with if doing a return.
> Fixes below checkpatch warning.
[]
> diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
[]
> @@ -1052,13 +1051,13 @@ static bool get_bool(struct platform_device *ofdev, const char *s)
>  {
>  	u32 *p = (u32 *)of_get_property(ofdev->dev.of_node, s, NULL);
>  
> -	if (p) {
> -		return (bool)*p;
> -	} else {
> +	if (!p) {
>  		dev_warn(&ofdev->dev, "Parameter %s not found,"
>  			"defaulting to false\n", s);

Please coalesce the format onto a single line
and add the missing space after the comma.

>  		return false;
>  	}
> +
> +	return (bool)*p;
>  }
>  
>  static const struct net_device_ops xemaclite_netdev_ops;
