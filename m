Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DE90EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ABC120693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:13:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ABC120693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754333AbeFLJM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 05:12:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34061 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754154AbeFLJM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 05:12:56 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fSfME-0005FY-9f; Tue, 12 Jun 2018 09:12:54 +0000
Subject: Re: [PATCH] [media] cx18: remove redundant zero check on retval
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Walls <awalls@md.metrocast.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-media@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180611151045.22535-1-colin.king@canonical.com>
 <20180612090745.2k6jmljl73bwj6lm@mwanda>
From:   Colin Ian King <colin.king@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=colin.king@canonical.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <341f5097-1c15-21b4-7e58-bab62f9ea913@canonical.com>
Date:   Tue, 12 Jun 2018 10:12:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180612090745.2k6jmljl73bwj6lm@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/18 10:07, Dan Carpenter wrote:
> You accidentally committed several changes...

Sheesh, I was on some strong pain killers yesterday for a slipped disc,
I think they are impacting on my ability to think straight.

Colin

> 
> regards,
> dan carpenter
> 
> On Mon, Jun 11, 2018 at 04:10:45PM +0100, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> The check for a zero retval is redundant as all paths that lead to
>> this point have set retval to an error return value that is non-zero.
>> Remove the redundant check.
>>
>> Detected by CoverityScan, CID#102589 ("Logically dead code")
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>  drivers/media/firewire/firedtv-fw.c  | 3 +++
>>  drivers/media/pci/cx18/cx18-driver.c | 2 --
>>  drivers/regulator/vctrl-regulator.c  | 2 +-
>>  3 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/media/firewire/firedtv-fw.c b/drivers/media/firewire/firedtv-fw.c
>> index 92f4112d2e37..eed55be21836 100644
>> --- a/drivers/media/firewire/firedtv-fw.c
>> +++ b/drivers/media/firewire/firedtv-fw.c
>> @@ -271,6 +271,9 @@ static int node_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
>>  
>>  	name_len = fw_csr_string(unit->directory, CSR_MODEL,
>>  				 name, sizeof(name));
>> +	if (name_len < 0)
>> +		return name_len;
>> +
>>  	for (i = ARRAY_SIZE(model_names); --i; )
>>  		if (strlen(model_names[i]) <= name_len &&
>>  		    strncmp(name, model_names[i], name_len) == 0)
>> diff --git a/drivers/media/pci/cx18/cx18-driver.c b/drivers/media/pci/cx18/cx18-driver.c
>> index 8f314ca320c7..0c389a3fb4e5 100644
>> --- a/drivers/media/pci/cx18/cx18-driver.c
>> +++ b/drivers/media/pci/cx18/cx18-driver.c
>> @@ -1134,8 +1134,6 @@ static int cx18_probe(struct pci_dev *pci_dev,
>>  free_workqueues:
>>  	destroy_workqueue(cx->in_work_queue);
>>  err:
>> -	if (retval == 0)
>> -		retval = -ENODEV;
>>  	CX18_ERR("Error %d on initialization\n", retval);
>>  
>>  	v4l2_device_unregister(&cx->v4l2_dev);
>> diff --git a/drivers/regulator/vctrl-regulator.c b/drivers/regulator/vctrl-regulator.c
>> index 78de002037c7..044e5a5ca163 100644
>> --- a/drivers/regulator/vctrl-regulator.c
>> +++ b/drivers/regulator/vctrl-regulator.c
>> @@ -340,7 +340,7 @@ static int vctrl_init_vtable(struct platform_device *pdev)
>>  		}
>>  	}
>>  
>> -	if (rdesc->n_voltages == 0) {
>> +	if (rdesc->n_voltages <= 0) {
>>  		dev_err(&pdev->dev, "invalid configuration\n");
>>  		return -EINVAL;
>>  	}
>> -- 
>> 2.17.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

