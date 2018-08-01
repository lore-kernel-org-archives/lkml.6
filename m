Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC1BC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA37A208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="Z98mM7qp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA37A208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390260AbeHAS1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 14:27:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37361 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390171AbeHAS1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 14:27:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id n7-v6so11095134pgq.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 09:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=35d7lKbuAZ9endhMKeZQR5ys9e1m/xpDKCONkB1fCnM=;
        b=Z98mM7qpo7HG1o1fRdbho1TtjnasaN6NdnyVq68GF4XvEVCsia1ONaBoR2UZp6cM1z
         XlnyD/UvIVjeoNQwCAaTO79Yrqi1jCTayUdybXAQJJbkWg1rUDXfx7ec77NDFpwyV4b6
         5uds3n0hEnNapTLN/q8+yvekzs14SF5Is1mC2kk6F0CTszQYPYl5EBOLicong9RFO6el
         GlH+qHiYWhd3sdLQ818c6H6WCZkt9polY0plW4jFUmyDIlmaQwtI+pOr6rxi2i91qmUN
         PDp2v09uNTlqgB64MJhg0m7gwzDGHBeIDhRDAhPGRQMQ9yQ67JWv41Q4zhf5mQm/12j0
         9o3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=35d7lKbuAZ9endhMKeZQR5ys9e1m/xpDKCONkB1fCnM=;
        b=RxsfJSfnSHbPou8rpAv41Nz99shuiRPB0kwttfypOLK3s9ek34nN631WRZ3WQa6Mnl
         BBOzB20Wy3pkoF8RdO7HHWdkQU4K0X/uzPd7wlFvkE10jhkD2GInwgdg2q5Z0eH2xiU8
         QQJ1hSiRJsCoSHIGHDiZ/4c4QknHb4rIVxKZW8J4zi9n4rTGP8F01pNU6RBPHIg+iGrD
         F0EMm7Ftbc1cE3vTvQXOGnxLv7pEwK9LJ5FLHgyZQTUYlZNxM51z+Rieaze95vH0leBs
         b2AoyFYwnAKf7N/IRKOp3bVG+2BMPmLBdx31ySvPBAH0GMaunOkf79N8dXQCBTWer7Y8
         +ETA==
X-Gm-Message-State: AOUpUlFSp1Z590kTnRyTOED9wVCIwISu8ED8R5WzOvjBYK6vVs0YS48S
        KxlkgUrpGdXVBab+VH+ACQWyeA==
X-Google-Smtp-Source: AAOMgpcIYcLpfIIMLIpePgQLBeY4e4dO8V+ADpLpERU7vn7gRNyDqwAh0j1RStRaWhqm8ZJkRAvWyQ==
X-Received: by 2002:a63:4a07:: with SMTP id x7-v6mr25581280pga.34.1533141665949;
        Wed, 01 Aug 2018 09:41:05 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1611:8fc3:703d:7635:5997])
        by smtp.googlemail.com with ESMTPSA id 84-v6sm44617430pfj.33.2018.08.01.09.41.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 09:41:05 -0700 (PDT)
Subject: Re: [PATCH] HID: Bluetooth: hidp: buffer overflow in
 hidp_process_report
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        stable <stable@vger.kernel.org>, kernel-team@android.com,
        Jiri Kosina <jkosina@suse.cz>
References: <20180731220225.159741-1-salyzyn@android.com>
 <20180801163703.GA6994@kroah.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <6f6c3e63-0847-b0b6-98a3-7ad62fd2697c@android.com>
Date:   Wed, 1 Aug 2018 09:41:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180801163703.GA6994@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/2018 09:37 AM, Greg KH wrote:
> On Tue, Jul 31, 2018 at 03:02:13PM -0700, Mark Salyzyn wrote:
>> CVE-2018-9363
>>
>> The buffer length is unsigned at all layers, but gets cast to int and
>> checked in hidp_process_report and can lead to a buffer overflow.
>> Switch len parameter to unsigned int to resolve issue.
>>
>> This affects 3.18 and newer kernels.
>>
>> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
>> Fixes: a4b1b5877b514b276f0f31efe02388a9c2836728 ("HID: Bluetooth: hidp: make sure input buffers are big enough")
>> Cc: Marcel Holtmann <marcel@holtmann.org>
>> Cc: Johan Hedberg <johan.hedberg@gmail.com>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>> Cc: linux-bluetooth@vger.kernel.org
>> Cc: netdev@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: security@kernel.org
>> Cc: kernel-team@android.com
> Nit, you only need to bother security@ if you do not have a fix and need
> to figure out one.

Thanks, I thought anything with a CVE was to go there according to 
netdev FAQ (dropped security from response list).
> Also, you forgot to cc: stable@vger.kernel.org to be included in older
> kernel releases :(
netdev FAQ said to _not_ copy stable, I am so confused ;-{ (added stable 
to response list b/c patch is now taken into bluetooth-next)
> thanks,
>
> greg k-h


