Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA04C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F9C20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbfAaJXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:23:11 -0500
Received: from bmailout1.hostsharing.net ([83.223.95.100]:48837 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfAaJXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 04:23:11 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 62E1230000CDD;
        Thu, 31 Jan 2019 10:23:09 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 25B5710875; Thu, 31 Jan 2019 10:23:09 +0100 (CET)
Date:   Thu, 31 Jan 2019 10:23:09 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        netdev@vger.kernel.org
Subject: Re: [PATCH 09/28] thunderbolt: Cache adapter specific capability
 offset into struct port
Message-ID: <20190131092309.5jfyvo7hgq2ui3ok@wunner.de>
References: <20190129150143.12681-1-mika.westerberg@linux.intel.com>
 <20190129150143.12681-10-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129150143.12681-10-mika.westerberg@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 06:01:24PM +0300, Mika Westerberg wrote:
> --- a/drivers/thunderbolt/tb.h
> +++ b/drivers/thunderbolt/tb.h
> @@ -124,6 +124,8 @@ struct tb_switch {
>   * @remote: Remote port (%NULL if not connected)
>   * @xdomain: Remote host (%NULL if not connected)
>   * @cap_phy: Offset, zero if not found
> + * @cap_adap: Offset of the adapter specific capability. Negative if not
> + *	      present.

Hm, could cap_adap be made zero in the non-presence case for consistency
with cap_phy?

Thanks,

Lukas
