Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBB5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16D6720855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/vy+0M9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16D6720855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbeK0FHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 00:07:05 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38237 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725723AbeK0FHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 00:07:04 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so16507578wrw.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 10:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iIKSO8/YRhnqRduLumuo4fxN26Rd1LZMuMFf8dl3n+E=;
        b=H/vy+0M9duvtaiVX2wBzdbdb6VxtM5pnSiyKy+ZcTo0FRp1RhVyqaueJPS5ePnahWp
         tJqg19rEPZNLIHq+i7pTb6Iz0o7+5KV3iHfjJLkfv2HF42ck8ll/CdvcoUl+F6WhBuXm
         Jep8MEihDJ9BE17r7rHINvF6MmtnwmEIze4V6PqzGsckxGk/P406R+zqdeolM9+HWAUb
         i/tAGfi9HEW1aNPrtdovUDBaBtSnTSMt3oKbPElpOGkY2eGPoAYgmwTY8HWbNLl2sX6v
         QxC+D1fI7ITizLHyjouzxc7cUgLSlrg/JpznsKYjTidv8AgdFTuazUCtOYjjmv7whKlx
         RncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iIKSO8/YRhnqRduLumuo4fxN26Rd1LZMuMFf8dl3n+E=;
        b=q1VN0wmU39CyHIB/Z2YmYxPtx7fxvnHurBMue8d+CK6ayb9I2bhfKET1+1GCNd6EGa
         tmjsQo7sJRinhNepz/sDP/XcQwvbKEWJQNVQC16Nm2RQ1lt7GvYs2YYDM0rG7ivZ5JpU
         nUY+bhXYRxYqaRqnGMqkNssXodhuBa7wYcWVxj2GlhdD163R1+FnN5u6tshP+GAbtE5Y
         ZYrVS9LObVtzhWSjfo+Ai2dPcfvDEwROLohH1MBQAtuZUmj3ITVu1gq9ZrmT2IDh/5Jf
         VcCuInSdYC0ZcLNQbUZqlPDl+A4DU8RG53swGxXSrxVNsUdhh4lQg+mK5hQtW85PsL6V
         v6qw==
X-Gm-Message-State: AA+aEWb9p6rksEFNSbkPUAWe6RVxh2n6hZgYowDhjpEbwUVB2dvgaisE
        mqR7/uKXIYI09m88j+O5tyAiSOY0
X-Google-Smtp-Source: AFSGD/VZpo6029DeNMOWE/dG21hQu2b5g7cXHGtNyP+9zhUe3DlUhO4Ca/9xoIR/Y5uRp1DPlD8wcg==
X-Received: by 2002:a5d:4b01:: with SMTP id v1mr23624432wrq.5.1543255929425;
        Mon, 26 Nov 2018 10:12:09 -0800 (PST)
Received: from ?IPv6:2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba? ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id q14sm1344499wrw.39.2018.11.26.10.12.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 10:12:08 -0800 (PST)
Subject: Re: [PATCH] staging: pi433: add missing call to cdev_del()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, linux@wolf-entwicklungen.de,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20181126175355.18800-1-straube.linux@gmail.com>
 <20181126180105.GM2970@unbuntlaptop>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <b3f1023b-1df2-9748-3514-eb601697c725@gmail.com>
Date:   Mon, 26 Nov 2018 19:12:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181126180105.GM2970@unbuntlaptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/18 7:01 PM, Dan Carpenter wrote:
> On Mon, Nov 26, 2018 at 06:53:55PM +0100, Michael Straube wrote:

>>   	retval = cdev_add(device->cdev, device->devt, 1);
>>   	if (retval) {
>>   		dev_dbg(device->dev, "register of cdev failed");
>> +		cdev_del(device->cdev);
>>   		goto cdev_failed;
> 
> No no...  That's not the right thing.  Do "goto del_cdev;" and add a
> label at the end.
> 
> del_cdev:
> 	cdev_del(device->cdev);
> 
> regards,
> dan carpenter
> 

Ah ok, I thought about that but was not sure. Thanks,
Michael
