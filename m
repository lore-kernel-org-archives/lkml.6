Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E267C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC14E20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Jrgs/aa4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC14E20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbeIKRcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 13:32:48 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45286 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbeIKRcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 13:32:48 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8BCXKcA028644;
        Tue, 11 Sep 2018 07:33:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536669200;
        bh=aMSWdj1tV3JoW8hH7FwkYBjUd6oJfJSiGyo7lPa/yP0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Jrgs/aa4PVmHB7kuv0lu4xUXLV09xVZFSUTWoND31Ig2JmjxSTiaKKQ9k/aWQQXlc
         DVRDx6tLC7TmXEbMxnf9gGn1Pe5y98ZAF0t0nULAMkWxaV6z+2d8bDXGjLSdfoZy74
         fDkh7WU6BtRSJAmq/UDp+hKmxb430oe+ko4M60o0=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8BCXKER008960;
        Tue, 11 Sep 2018 07:33:20 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 11
 Sep 2018 07:33:18 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 11 Sep 2018 07:33:18 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8BCXFj4025237;
        Tue, 11 Sep 2018 07:33:16 -0500
Subject: Re: [PATCH v2 1/2] dmaengine: Add metadata_ops for
 dma_async_tx_descriptor
To:     Vinod <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lars@metafoo.de>,
        <radheys@xilinx.com>
References: <20180830121910.16005-1-peter.ujfalusi@ti.com>
 <20180830121910.16005-2-peter.ujfalusi@ti.com>
 <20180911073307.GK2634@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <6ba92876-899f-5bf2-e494-259e1e680750@ti.com>
Date:   Tue, 11 Sep 2018 15:33:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180911073307.GK2634@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vinod,

On 2018-09-11 10:33, Vinod wrote:
>> +int dmaengine_desc_attach_metadata(struct dma_async_tx_descriptor *desc,
>> +				   void *data, size_t len)
>> +{
>> +	int ret;
>> +
>> +	if (!desc)
>> +		return -EINVAL;
>> +
>> +	ret = desc_check_and_set_metadata_mode(desc, DESC_METADATA_CLIENT);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (!desc->metadata_ops || !desc->metadata_ops->attach)
>> +		return -ENOTSUPP;
>> +
>> +	return desc->metadata_ops->attach(desc, data, len);
>> +}
>> +EXPORT_SYMBOL(dmaengine_desc_attach_metadata);
> 
> EXPORT_SYMBOL_GPL ?

Sure, I think I have looked at
dma_async_tx_descriptor_init/dmaengine_get_unmap_data/dma_issue_pending_all/etc
they have EXPORT_SYMBOL()

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
