Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CB3C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A0C2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Zf1roaVN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84A0C2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbeJHXqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:46:33 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:51614 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeJHXqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 19:46:33 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w98GXl70063650;
        Mon, 8 Oct 2018 11:33:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539016427;
        bh=QZb5zFeP2oUOk1KgdUCVFXMPEQEWPKwMv+6YIFzezF4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Zf1roaVN5Yhpza+ArK3u6p6RSSrw6Do0hIhXzhCCVMXup7tvfEo7XcfeSg8pFiue9
         4d1e5Dy0UAS+W88ShrE6GABUI7ul5lhIcomcWUAE9JQtHntfjdcMj5rpXMWnzGb6FG
         n34jI1vIBe+TUm/TFztIXmewydu3UYixIyM8Hvvo=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w98GXkZb008631;
        Mon, 8 Oct 2018 11:33:47 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 8 Oct
 2018 11:33:46 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 8 Oct 2018 11:33:46 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w98GXknU001500;
        Mon, 8 Oct 2018 11:33:46 -0500
Subject: Re: [PATCH] samples/rpmsg: Introduce a module parameter for message
 count
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20180911174643.26199-1-s-anna@ti.com>
 <20181006062231.GF12063@builder>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <d14448ad-21c1-0a1a-0264-2efece209fc6@ti.com>
Date:   Mon, 8 Oct 2018 11:33:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181006062231.GF12063@builder>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 10/06/2018 01:22 AM, Bjorn Andersson wrote:
> On Tue 11 Sep 10:46 PDT 2018, Suman Anna wrote:
> 
>> The current rpmsg_client_sample uses a fixed number of messages to
>> be sent to each instance. This is currently set at 100. Introduce
>> an optional module parameter 'count' so that the number of messages
>> to be exchanged can be made flexible.
>>
> 
> Rather than sending N messages as fast as possible to any sample channel
> that comes up, how about making the sample create a debugfs entry that
> we can write messages to from user space?

This sample demonstrates a kernel-level rpmsg usage, and I would prefer
to maintain the current simplicity, and not add in any userspace
interaction. That perhaps can be done as a different sample. I use this
sample to serve as the basic test for checking the rpmsg transport
functionality with multiple remoteprocs and/or multiple instances per
remoteproc at the same time. The count parameter helps me with both
early Silicon development, as well as exercising increased message
exchanges so that the vring buffers are cycled.

> 
> That would make it possible to improve the handling of multiple
> remoteprocs and would allow for a variation in message lengths etc.

FWIW, this already support multiple instances from the same remoteproc
or different remoteproc.

regards
Suman


> 
> Regards,
> Bjorn
> 
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> ---
>>  samples/rpmsg/rpmsg_client_sample.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/samples/rpmsg/rpmsg_client_sample.c b/samples/rpmsg/rpmsg_client_sample.c
>> index f161dfd3e70a..9b6b27ea504f 100644
>> --- a/samples/rpmsg/rpmsg_client_sample.c
>> +++ b/samples/rpmsg/rpmsg_client_sample.c
>> @@ -22,7 +22,9 @@
>>  #include <linux/rpmsg.h>
>>  
>>  #define MSG		"hello world!"
>> -#define MSG_LIMIT	100
>> +
>> +static int count = 100;
>> +module_param(count, int, 0644);
>>  
>>  struct instance_data {
>>  	int rx_count;
>> @@ -41,7 +43,7 @@ static int rpmsg_sample_cb(struct rpmsg_device *rpdev, void *data, int len,
>>  		       data, len,  true);
>>  
>>  	/* samples should not live forever */
>> -	if (idata->rx_count >= MSG_LIMIT) {
>> +	if (idata->rx_count >= count) {
>>  		dev_info(&rpdev->dev, "goodbye!\n");
>>  		return 0;
>>  	}
>> -- 
>> 2.18.0
>>

