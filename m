Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C25FC070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 22:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B6A213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 22:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMrPruuW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83B6A213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbeIMDQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 23:16:35 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45289 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbeIMDQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 23:16:35 -0400
Received: by mail-oi0-f68.google.com with SMTP id t68-v6so6851728oie.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 15:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:reply-to:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QESi1UteUokq+ONHv0sotXQTVrOR0tVq8nDZHp4kHzw=;
        b=UMrPruuW+xi9v7EmFDUYc6rj9eYXyjZO31ZJV+o2sO6TZoRLPYcL0ItieuLLpxHVUZ
         sdSqEcy7I/B37cllTSyiDJ6H8MGSIOUu+x7PHK0+8kYgA+N5YK1PJD1JL7HeZ65L97o6
         u0IkaROHMCz+jg4oBqH1MSGKAnZfer9l1ien0edikhXZIo1kMcnkDMnCIIAQBRnF9m5S
         mphcSrxYgT/FlrNJQe84WXzlFr6gGmce9Km0LxYRt0gPjG5MpmsEDcgmWt2YjNLIaPvB
         se6vl4RKuIr98i711gfLxgTXn4a2FcNoMXTxAhAw+KsXBASjtaeoHzCAVzmfrfab8Rut
         +qRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=QESi1UteUokq+ONHv0sotXQTVrOR0tVq8nDZHp4kHzw=;
        b=KNULckw+FyreUpyb2vwil+C1HnbbtUGUp4XlKMbej+yCzoN+uZrgqRDsIARPvzf3Az
         D8v2rQE9e5kUZ9tZg1a+zAVwI9FJvZGUeZ7WwbjbcKw5Vm2l6IulO2XAdkRWkDa5VXIb
         BLq8FiUJ7RBLLeIO+Uw5CgFB6TneOBjC0GJpaAVQKk4tCvV8+g6qg7UQhauSCD8sOekV
         3jc5HSZUpdIkZGL4LanqyxTXfAckYTtOvMymAFkCU14xiE/FKCoSONtTkMO3MAYLuDNB
         mH375rUvKlPnbZy4ZI9eCibu7IsfAX3R48PSWvGACSlWV7wj8+vwK2LroS1ch2vtlHPX
         FuAg==
X-Gm-Message-State: APzg51BhpKDakM8tibamrbXcjj1DVsDCsF3gs103oZMGcb70+YuMRly7
        mB3NnbRl5tMLKG72lzqUa018/0E=
X-Google-Smtp-Source: ANB0Vdby4L7IeNi+IAI7l9i3Bz46RA+l4NKFX5Lzoh/VvKdIQn72JnRjoyZ7J5kCWuMz48dsFhZ0qQ==
X-Received: by 2002:aca:4083:: with SMTP id n125-v6mr3978356oia.167.1536790203288;
        Wed, 12 Sep 2018 15:10:03 -0700 (PDT)
Received: from serve.minyard.net ([47.184.170.128])
        by smtp.gmail.com with ESMTPSA id q124-v6sm1363878oif.8.2018.09.12.15.10.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 15:10:02 -0700 (PDT)
Received: from [10.22.11.145] (50-233-148-155-static.hfc.comcastbusiness.net [50.233.148.155])
        by serve.minyard.net (Postfix) with ESMTPSA id 627648F8;
        Wed, 12 Sep 2018 17:10:00 -0500 (CDT)
Reply-To: minyard@acm.org
Subject: Re: [PATCH v2] ipmi: looped device detection
To:     Patrick Venture <venture@google.com>, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
References: <20180911225630.124502-1-venture@google.com>
From:   Corey Minyard <minyard@acm.org>
Message-ID: <585d1c3a-6121-c20d-f6d6-7567595cd1af@acm.org>
Date:   Wed, 12 Sep 2018 17:09:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180911225630.124502-1-venture@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2018 05:56 PM, Patrick Venture wrote:
> Try to get the device ID repeatedly during initialization before giving up.
> The BMC isn't always responsive, and this allows it to be slightly flaky
> during early boot.
>
> Tested: Installed on a system with the BMC software disabled
> such that it was non-responsive.  The driver correctly detected this
> and gave up as expected.  Then I re-enabled the BMC software unloaded
> and reloaded the driver and it was detected properly.

The patch looks fine, but I wonder if this is something that is really 
valuable.
I have wondered about this before.

The question is: If the BMC is unavailable, what are the chances of it 
becoming
available by the time you do 5 attempts?  I would guess that is a pretty 
small
chance, which is why I haven't done this already.

You could have something that re-tested periodically, but there are so many
systems with IPMI specified in ACPI or SMBIOS that is wrong, and it would
try forever.  Also not really a good thing.

So I've left it to reload the driver or use the hotmod interface.

-corey

> Signed-off-by: Patrick Venture <venture@google.com>
> ---
> v2:
>   - removed extra variable that was set but not used.
> ---
>   drivers/char/ipmi/ipmi_si_intf.c | 23 ++++++++++++++++++++++-
>   1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> index 90ec010bffbd..5fed96897fe8 100644
> --- a/drivers/char/ipmi/ipmi_si_intf.c
> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> @@ -1918,11 +1918,13 @@ int ipmi_si_add_smi(struct si_sm_io *io)
>    * held, primarily to keep smi_num consistent, we only one to do these
>    * one at a time.
>    */
> +#define GET_DEVICE_ID_ATTEMPTS	5
>   static int try_smi_init(struct smi_info *new_smi)
>   {
>   	int rv = 0;
>   	int i;
>   	char *init_name = NULL;
> +	unsigned long sleep_rm;
>   
>   	pr_info(PFX "Trying %s-specified %s state machine at %s address 0x%lx, slave address 0x%x, irq %d\n",
>   		ipmi_addr_src_to_str(new_smi->io.addr_source),
> @@ -2003,7 +2005,26 @@ static int try_smi_init(struct smi_info *new_smi)
>   	 * Attempt a get device id command.  If it fails, we probably
>   	 * don't have a BMC here.
>   	 */
> -	rv = try_get_dev_id(new_smi);
> +	for (i = 0; i < GET_DEVICE_ID_ATTEMPTS; i++) {
> +		pr_info(PFX "Attempting to read BMC device ID\n");
> +		rv = try_get_dev_id(new_smi);
> +		/* If it succeeded, stop trying */
> +		if (!rv)
> +			break;
> +
> +		/* Sleep for ~0.25s before trying again instead of hammering
> +		 * the BMC.
> +		 */
> +		sleep_rm = msleep_interruptible(250);
> +		if (sleep_rm != 0) {
> +			pr_info(PFX "Find BMC interrupted\n");
> +			rv = -EINTR;
> +			goto out_err;
> +		}
> +	}
> +
> +	/* If we exited the loop above and rv is non-zero we ran out of tries.
> +	 */
>   	if (rv) {
>   		if (new_smi->io.addr_source)
>   			dev_err(new_smi->io.dev,


