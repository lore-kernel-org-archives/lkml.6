Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2306C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB0E1206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbfBZSrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 13:47:39 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35252 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728641AbfBZSri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 13:47:38 -0500
Received: by mail-wr1-f68.google.com with SMTP id t18so15151154wrx.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 10:47:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9FIi0A4lJIfsIvA1slgC1zwFHSYh+R2Rf3MYqXxTpps=;
        b=aPwmZvQUItJ3ybt6IZuQhL4N7kwdvEo/SsOYTajC1s16hlpO2Vk2NpP9KUjXmYwAgk
         hzZ/Yo+CVHZEIpdaZYMZrMokVnPefiOghiIJMJa9GT/Iif02ZMvAuNDjTwlzer2/HW4g
         puU1GQi7dUwQNIQdSfR0Obz5NabvG6skxlfsKi9P/Z6P5UJ64zCoMUR7/cmB4pm3C1lP
         WjkeUs1zue9129pQBfTXF43aZfSN+Rtsuxu3xhaKtYe2IbJ9Cr4/u6pc4QwVKo7mlJYb
         TU0qiidXM5N6+LFI8yuf2naRWr3sEE1C2tdCPyjzxUo8NoQ/b2PaJjqQsSg11k7OSUTv
         TQMQ==
X-Gm-Message-State: AHQUAuZPPtxtmSpTyjFPzSQuTv+s4VoJcuMaKA0Jc14gaG2CtFxzRVVv
        le/TeerTdNWgT9uKKGqy2SxVj6tUShny4Q==
X-Google-Smtp-Source: AHgI3IYwbyWCTEamFcYjFAcx7PgRbZLzFBVJAxP5Ya9OMrHkY9oeKJLdwhqMR+r9QXsKZn6sy/eKGA==
X-Received: by 2002:adf:f543:: with SMTP id j3mr16837508wrp.220.1551206856499;
        Tue, 26 Feb 2019 10:47:36 -0800 (PST)
Received: from [192.168.1.37] (43.red-88-25-181.staticip.rima-tde.net. [88.25.181.43])
        by smtp.gmail.com with ESMTPSA id v10sm7975343wrn.26.2019.02.26.10.47.35
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 10:47:36 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] fw_cfg: use __ATTR_RO_MODE to define rev
 sysfs
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Wei Yang <richardw.yang@linux.intel.com>
Cc:     somlo@cmu.edu, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org
References: <20190226073159.13434-1-richardw.yang@linux.intel.com>
 <20190226110934-mutt-send-email-mst@kernel.org>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <683d6fc9-bfdc-b2e5-e1b7-cd2d2711268e@redhat.com>
Date:   Tue, 26 Feb 2019 19:47:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190226110934-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/19 5:10 PM, Michael S. Tsirkin wrote:
> On Tue, Feb 26, 2019 at 03:31:59PM +0800, Wei Yang wrote:
>> Leverage __ATTR_RO_MODE to define rev sysfs instead of using open code
>> to define the attribute.
>>
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  drivers/firmware/qemu_fw_cfg.c | 13 ++++---------
>>  1 file changed, 4 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
>> index 039e0f91dba8..a1293cbd7adb 100644
>> --- a/drivers/firmware/qemu_fw_cfg.c
>> +++ b/drivers/firmware/qemu_fw_cfg.c
>> @@ -296,18 +296,13 @@ static int fw_cfg_do_platform_probe(struct platform_device *pdev)
>>  	return 0;
>>  }
>>  
>> -static ssize_t fw_cfg_showrev(struct kobject *k, struct attribute *a, char *buf)
>> +static ssize_t fw_cfg_rev_show(struct kobject *k, struct kobj_attribute *a,
>> +			       char *buf)
>>  {
>>  	return sprintf(buf, "%u\n", fw_cfg_rev);
>>  }
>> -
>> -static const struct {
>> -	struct attribute attr;
>> -	ssize_t (*show)(struct kobject *k, struct attribute *a, char *buf);
>> -} fw_cfg_rev_attr = {
>> -	.attr = { .name = "rev", .mode = S_IRUSR },
>> -	.show = fw_cfg_showrev,
>> -};
>> +static const struct kobj_attribute fw_cfg_rev_attr =
>> +	__ATTR_RO_MODE(fw_cfg_rev, 0400);
>>  
>>  /* fw_cfg_sysfs_entry type */
>>  struct fw_cfg_sysfs_entry {
> 
> 
> Looks like this will change the name from "rev" to "fw_cfg_rev".
> That's a userspace visible change which we should not do lightly.

We could name the function rev_show but this stay fragile, we'd also
need a comment "don't rename this".

>> -- 
>> 2.19.1
> 
