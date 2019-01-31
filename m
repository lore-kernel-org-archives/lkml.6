Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6770EC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BFF7218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bYwTU2Ed"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfAaRzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 12:55:22 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33289 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbfAaRzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 12:55:21 -0500
Received: by mail-wr1-f68.google.com with SMTP id p7so4369053wru.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 09:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vDxdNZAx4ju52jhpLVnV52D2tNreBV7TT/ASB6g87tw=;
        b=bYwTU2Ed3szn+Sgsk60ONp9Asu+m3sbluDqxbFUyGWkmNbYgs2IvaQ6Ng8IP43BLUi
         yllGFQ/j7Q3u2By/JOIZU6qSBudZ/zbdAQCdGNuuQPbLb+UlnsPnL6uLokIXqgULYo53
         ikSVMmzUC7viFIyiMS3FmXHQrM0NJxo8SorYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vDxdNZAx4ju52jhpLVnV52D2tNreBV7TT/ASB6g87tw=;
        b=YpdwAYPqGv3N9l0+b2cknyZjNTAMyCiDXeyhO7m4WLjX3spW1GIg5FR/v6juDJ13/4
         TXHwIMpwINjT8ogQJFuOzcQg8llMctZRSUpsHVlNDzy5pLqCc+5u+J19GRJzYbKPc/Xx
         rNGslXmCxM/kaDj8Hlvvq25fkgUYCmvhD9lSOUQYWSfUqZpR4GUtfIE0mlG1VXP7Nikn
         DZuqx3V6rLjd6g56OmfbyOANneTe+rseF893xIZmG1CsUH/VaB8tXFt7eTDFFkvxRIn8
         t7Xqa1TobKjA4U8pgRyWAcIVhf96jU6GT77SsKix4h00Wy+2wvUMwVYU52ijW+ZJ+GAM
         453g==
X-Gm-Message-State: AHQUAuZVNrb/sBuOEClm/NLL//ykmdkZI5O8tQpyiAImVOnNH2Epcohh
        EbFA6YdjnfGHIvYVGQ/eprbdAw==
X-Google-Smtp-Source: AHgI3Ib8fqnLmufO36b6pzlFWrNneD8P9Q7w2zFVEIRCePcUwYtoeKnZDh1qgkqnUA4IqdJPaXR3Og==
X-Received: by 2002:adf:a743:: with SMTP id e3mr12238243wrd.56.1548957319006;
        Thu, 31 Jan 2019 09:55:19 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id j24sm5038546wrd.86.2019.01.31.09.55.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 09:55:18 -0800 (PST)
Subject: Re: [PATCH v4 3/5] misc: fastrpc: Add support for context Invoke
 method
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, arnd@arndb.de, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, bkumar@qti.qualcomm.com,
        linux-arm-msm@vger.kernel.org, thierry.escande@linaro.org
References: <20190124152412.10503-1-srinivas.kandagatla@linaro.org>
 <20190124152412.10503-4-srinivas.kandagatla@linaro.org>
 <20190131153419.GA18667@kroah.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <c60cd4ba-af1c-537a-2ee4-b80b61408625@linaro.org>
Date:   Thu, 31 Jan 2019 17:55:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131153419.GA18667@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review,

I will fix them and send new version!

On 31/01/2019 15:34, Greg KH wrote:
> On Thu, Jan 24, 2019 at 03:24:10PM +0000, Srinivas Kandagatla wrote:
>> This patch adds support to compute context invoke method
>> on the remote processor (DSP).
>> This involves setting up the functions input and output arguments,
>> input and output handles and mapping the dmabuf fd for the
>> argument/handle buffers.
>>
> 
> This says _what_ this code does, but not why.  What about all of that
> explaination you had in the 0/5 patch, shouldn't that be here, or on
> patch 2/5?
> 
Yes, I will add more details in to the log.

> Some nits below:
> 
>> +static int fastrpc_invoke(struct fastrpc_user *fl, char __user *argp)
>> +{
>> +	struct fastrpc_invoke_args *args = NULL;
>> +	struct fastrpc_invoke inv;
>> +	u32 nscalars;
>> +	int err;
>> +
>> +	if (copy_from_user(&inv, argp, sizeof(inv)))
>> +		return -EFAULT;
>> +
>> +	nscalars = REMOTE_SCALARS_LENGTH(inv.sc);
>> +	if (nscalars) {
>> +		args = kcalloc(nscalars, sizeof(*args), GFP_KERNEL);
> 
> Yeah, let's not bounds check the input variables and suck up all of the
> kernel memory!
> 
> Remember:
> 	ALL INPUT IS EVIL

I will add more checks here and other such instances in next version....
>> +static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
>> +				 unsigned long arg)
>> +{
>> +	struct fastrpc_user *fl = (struct fastrpc_user *)file->private_data;
>> +	char __user *argp = (char __user *)arg;
>> +	int err;
>> +
>> +	switch (cmd) {
>> +	case FASTRPC_IOCTL_INVOKE:
>> +		err = fastrpc_invoke(fl, argp);
>> +		break;
>> +	default:
>> +		err = -ENOTTY;
>> +		dev_err(fl->sctx->dev, "bad ioctl: %d\n", cmd);
> 
> Don't spam the syslog if someone sends you an invalid ioctl.  That's a
> sure way to DoS the system.
will fix this in next version.
> 
>> +		break;
>> +	}
>> +
>> +	if (err)
>> +		dev_dbg(fl->sctx->dev, "Error: IOCTL Failed with %d\n", err);
>> +
>> +	return err;
>> +}
>> +
>>   static const struct file_operations fastrpc_fops = {
>>   	.open = fastrpc_device_open,
>>   	.release = fastrpc_device_release,
>> +	.unlocked_ioctl = fastrpc_device_ioctl,
>> +	.compat_ioctl = fastrpc_device_ioctl,
>>   };
>>   
>>   static int fastrpc_cb_probe(struct platform_device *pdev)
>> @@ -260,9 +932,25 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>>   	return of_platform_populate(rdev->of_node, NULL, NULL, rdev);
>>   }
>>   
>> +static void fastrpc_notify_users(struct fastrpc_user *user)
>> +{
>> +	struct fastrpc_invoke_ctx *ctx, *n;
>> +
>> +	spin_lock(&user->lock);
>> +	list_for_each_entry_safe(ctx, n, &user->pending, node)
>> +		complete(&ctx->work);
> 
> Why safe?  You aren't deleting the list here.
> 
Not sure why it ended up with safe here, does not make sense unless am 
deleting it.. will fix this in next version.

...>> diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
>> new file mode 100644
>> index 000000000000..a69ef33dc37e
>> --- /dev/null
>> +++ b/include/uapi/misc/fastrpc.h
>> @@ -0,0 +1,23 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +#ifndef __QCOM_FASTRPC_H__
>> +#define __QCOM_FASTRPC_H__
>> +
>> +#include <linux/types.h>
>> +
>> +#define FASTRPC_IOCTL_INVOKE		_IOWR('R', 3, struct fastrpc_invoke)
>> +
>> +struct fastrpc_invoke_args {
>> +	__u64 ptr;
>> +	__u64 length;
>> +	__s32 fd;
>> +	__u32 reserved;
> 
> Are you checking that reserved is all 0 now?

No, I should add the checks!

> 
>> +};
>> +
>> +struct fastrpc_invoke {
>> +	__u32 handle;
>> +	__u32 sc;
>> +	__u64 args;
>> +};
> 
> Do you need packed here?  What about endian issues?
We do not need this packed here, as this is not the actual structure 
that the passed to the DSP.

Thanks,
srini

> 
> thanks,
> 
> greg k-h
> 
