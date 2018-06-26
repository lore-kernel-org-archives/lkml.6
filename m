Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74657C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299CC25A34
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFHGCOwi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 299CC25A34
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752873AbeFZIG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 04:06:57 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36094 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752169AbeFZIGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 04:06:51 -0400
Received: by mail-wm0-f66.google.com with SMTP id u18-v6so730369wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 01:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8wmp8XuRgee6r0NO95Q/0rN/WmLfc7FHfgZYycPOYgo=;
        b=QFHGCOwiFwp0UeU8mDfDE/sf2rq3ODMB9tqflefUntTUXn0WqayF7PwWeRRexS0LeQ
         9Nkhhlpl+50GHR1erWcFWzI6BBedMv+AC9djTIrUkM+XRQ+O7UKR2VCae3gM9FensgEN
         rxhkRwD9iOaykOAlRVy0Ul2Qp4oLtSlfUe9nt2IiXD6RfNgaShK1jQKHSUuqFIcvgASB
         9GmbZ1OeCcrMVU8htcUlMmqOXFHpZmHR1nbD9OPCJqglsifY8zCVfFwYiJf1oL7V2W1x
         mhgcMaPWrpeJElMSePK3eMnTV7+cIYHi8NqFRLjBJKbo4VK/lcRfpJRRdjrkNpchPzLI
         Jjbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8wmp8XuRgee6r0NO95Q/0rN/WmLfc7FHfgZYycPOYgo=;
        b=IBsINPVCrmha/6qudMEiG93qEkQIEvcYi/kU7VJtMgKzFIPpZiB1GBxoC44z8nqLKV
         pOs5orjKxMEKdZYBob62tTVrSLzoCDr/Q2UPxG0sCwpT3+rIcJOztnTH9W80gz83/xai
         BsQgTbUW+vyjgP4eose3lmct/Vpn9rHv/f0hxfvS3ER0t8WrYmV88OsjPM85i17A4b27
         oS8Bld5F5BN4XpkEiCI810YCEuI11dZ2dfJhrbYR0zwz0r37i/P/68PiTDYJiymHl/0Y
         CiDiLVIUMErQPdGU5iycxvirO6MepjRrPzEgPyFCurdwCP4TumFXcVzAFIDa/U/53fG+
         qHaw==
X-Gm-Message-State: APt69E3ZFBgNk8BC6SKU/PILk6mhlcDBeT/PZ9mAlmmKs/AXN9t+vHwk
        5vMTI9HG6bpxFaxi0y6Fe+j4JqP6
X-Google-Smtp-Source: AAOMgpfBm2U+9xDw5brS9/L9AU6K2+GKyWRKgA+5QcjU3iUPqAvWcsGFMarqh8xpRK889kFGtaTXzw==
X-Received: by 2002:a1c:d8:: with SMTP id 207-v6mr668191wma.99.1530000410203;
        Tue, 26 Jun 2018 01:06:50 -0700 (PDT)
Received: from [192.168.1.4] (x590c812a.dyn.telefonica.de. [89.12.129.42])
        by smtp.gmail.com with ESMTPSA id p10-v6sm891006wmc.17.2018.06.26.01.06.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 01:06:49 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] staging: rtl8723bs: use mac_pton() in
 rtw_macaddr_cfg()
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        joe@perches.com, dan.carpenter@oracle.com,
        andy.shevchenko@gmail.com
References: <20180625151238.23147-1-straube.linux@gmail.com>
 <20180625151238.23147-4-straube.linux@gmail.com>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <a8ce935e-719f-46a9-1095-19be95ae3405@gmail.com>
Date:   Tue, 26 Jun 2018 10:06:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180625151238.23147-4-straube.linux@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/25/18 17:12, Michael Straube wrote:

> +	} else{
> +		/* Use the mac address stored in the Efuse */
>   		ether_addr_copy(mac, mac_addr);
>   	}

} else {

I'll resend the series with this corrected.

Regards,
Michael
