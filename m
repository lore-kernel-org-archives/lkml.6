Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC610C67871
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 16:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5952084D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 16:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="spYkkGUF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E5952084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbeJFXmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 19:42:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38574 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725266AbeJFXmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 19:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9L3PusQtZHJPoFDTUa2lzYEr5j16up4N+qr+FN1KZTc=; b=spYkkGUFNhqGaIwUATrsKk55M
        FE1sYz9cg/XJvMIblDXcG3BffB1NDauyC2Gf8jHIk/C3YbcNajiwhHXwBFYn9t9RfpF0Qq1Y13J8E
        9DvItwm4Ag2vxLm8ub7oMfA/6YJQQbP6ABHxGeAxTxapbeN2Vv1R/9MGuWyslBBc9YsnrC13pV/vP
        mauuatT4o3/DZZaV/GETytLw9+JM7+QGwPULgOxpaSZoQ/SdqFYb5coCGttEmUD4lvzW1TTs82BnZ
        y9iRqfQWWc+KBzYjq76ObMfpZe/YeL8A8pLP2v3N9OgAR4YD9IyOU6TLVmKODJf3WJAVZmBrxAK0V
        vOi2oUd/A==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g8pax-0000He-L9; Sat, 06 Oct 2018 16:38:23 +0000
Subject: Re: [GIT PULL 11/16] stm class: Document the MIPI SyS-T protocol
 usage
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20181005124306.54870-1-alexander.shishkin@linux.intel.com>
 <20181005124306.54870-12-alexander.shishkin@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5e7d8200-d357-4105-b00a-3ca36d375aac@infradead.org>
Date:   Sat, 6 Oct 2018 09:38:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181005124306.54870-12-alexander.shishkin@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
one small typo/spello below...

On 10/5/18 5:43 AM, Alexander Shishkin wrote:
> Add a document describing MIPI SyS-T protocol driver usage.
> 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Tested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  Documentation/trace/sys-t.rst | 62 +++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/trace/sys-t.rst
> 
> diff --git a/Documentation/trace/sys-t.rst b/Documentation/trace/sys-t.rst
> new file mode 100644
> index 000000000000..3d8eb92735e9
> --- /dev/null
> +++ b/Documentation/trace/sys-t.rst
> @@ -0,0 +1,62 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===================
> +MIPI SyS-T over STP
> +===================
> +
> +The MIPI SyS-T protocol driver can be used with STM class devices to
> +generate standardized trace stream. Aside from being a standard, it
> +provides better trace source identification and timestamp correlation.
> +
> +In order to use the MIPI SyS-T protocol driver with your STM device,
> +first, you'll need CONFIG_STM_PROTO_SYS_T.
> +
> +Now, you can select which protocol driver you want to use when you create
> +a policy for your STM device, by specifying it in the policy name:
> +
> +# mkdir /config/stp-policy/dummy_stm.0:p_sys-t.my-policy/
> +
> +In other words, the policy name format is extended like this:
> +
> +  <device_name>:<protocol_name>.<policy_name>
> +
> +With Intel TH, therefore it can look like "0-sth:p_sys-t.my-policy".
> +
> +If the protocol name is omitted, the STM class will chose whichever

s/chose/choose/

> +protocol driver was loaded first.
> +
> +You can also double check that everything is working as expected by
> +
> +# cat /config/stp-policy/dummy_stm.0:p_sys-t.my-policy/protocol
> +p_sys-t
> +
> +Now, with the MIPI SyS-T protocol driver, each policy node in the
> +configfs gets a few additional attributes, which determine per-source
> +parameters specific to the protocol:
> +
> +# mkdir /config/stp-policy/dummy_stm.0:p_sys-t.my-policy/default
> +# ls /config/stp-policy/dummy_stm.0:p_sys-t.my-policy/default
> +channels
> +clocksync_interval
> +do_len
> +masters
> +ts_interval
> +uuid
> +
> +The most important one here is the "uuid", which determines the UUID
> +that will be used to tag all data coming from this source. It is
> +automatically generated when a new node is created, but it is likely
> +that you would want to change it.
> +
> +do_len switches on/off the additional "payload length" field in the
> +MIPI SyS-T message header. It is off by default as the STP already
> +marks message boundaries.
> +
> +ts_interval and clocksync_interval determine how much time in milliseconds
> +can pass before we need to include a protocol (not transport, aka STP)
> +timestamp in a message header or send a CLOCKSYNC packet, respectively.
> +
> +See Documentation/ABI/testing/configfs-stp-policy-p_sys-t for more
> +details.
> +
> +* [1] https://www.mipi.org/specifications/sys-t
> 


-- 
~Randy
