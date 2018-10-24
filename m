Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2264BC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA03F2084A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IViLfOeB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA03F2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbeJYAC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 20:02:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38666 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbeJYAC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 20:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pN9vCXpTopDi+X/VfX8zpmubWaKsz1bpeWvIUzchoMQ=; b=IViLfOeBupVBag591mgECTkSFe
        SZJzP5BwM+NoBEiZ584JY7jmAg+FpaFDQoNmT7ZxfR23CpgE7KehqUpKaB3cuH2dJQM7JFYHJIIuk
        kFl6Pagn33oSFZUapvfWqj6TL01rRQqgsDS9Vy3QMM2GdXWENAlTESNAvboQ+krfMWkICp6xexyDY
        b4Kx/RvVUkpJf+DbUa0oLTX58/vtXOhXX7xElwXNk0oRKubA/OV48BJjudqK+5NzbqQR47UpC/ZLS
        Jv+puYUmmWgQ1CHMvQN9KckAuUKPC9dXKaMKqgEhpqZE6Peey8+3aI9KDKlutRukCQEKYiHK1Xfj5
        hkg7qubQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gFLAQ-0000fp-0p; Wed, 24 Oct 2018 15:33:54 +0000
Subject: Re: [RFC PATCH 1/5] driver core: Add fwnode member to struct
 device_connection
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181024150525.11552-1-heikki.krogerus@linux.intel.com>
 <20181024150525.11552-2-heikki.krogerus@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a00ff7d0-4cac-2454-7c12-7844aecb68f1@infradead.org>
Date:   Wed, 24 Oct 2018 08:33:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181024150525.11552-2-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/18 8:05 AM, Heikki Krogerus wrote:
> This will prepare the device connection API for connections
> described in firmware.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  include/linux/device.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 90224e75ade4..a964a0d614fa 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -753,11 +753,17 @@ struct device_dma_parameters {
>  
>  /**
>   * struct device_connection - Device Connection Descriptor
> + * @fwnode: The device node of the connected device
>   * @endpoint: The names of the two devices connected together
>   * @id: Unique identifier for the connection
>   * @list: List head, private, for internal use only
> + *
> + * NOTE: @fwnode is not used together with @endpoint. @fwnode is used when
> + * platform firmware defines the connection. When the connection is registeded

for your next version:)                                                registered

> + * with device_connection_add() @endpoint is used instead.
>   */
>  struct device_connection {
> +	struct fwnode_handle	*fwnode;
>  	const char		*endpoint[2];
>  	const char		*id;
>  	struct list_head	list;
> 

cheers.
-- 
~Randy
