Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D54BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD2C72086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ImVsISrK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD2C72086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbeIJNCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:02:12 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50955 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbeIJNCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:02:12 -0400
Received: by mail-wm0-f67.google.com with SMTP id s12-v6so20532350wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 01:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q07PyOKIk8CQfsWY5q6zv9cHBwK4Th+z1ytvJK8mbpc=;
        b=ImVsISrK4jf3r+H9eNttGAQodbS9ZadOBeHbMCGE+tZP9P43kAw11i4mByPiS0xaw3
         90e+p42BKtlZFfzh1dzIIRod4CIQ6WMuksudj3rz1QXxjHUtwraI60q6tw1+O3FbO2X7
         cD2TsjuZiYUEdcjFE7Q2ZbKUT0baz4UY2Imt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q07PyOKIk8CQfsWY5q6zv9cHBwK4Th+z1ytvJK8mbpc=;
        b=OJIpcnlpxmzyWWG9CCP5ctlWyFUcNt4Ujn3k85Kto3NCqg/MkD51wTUuLfzD5uKJhU
         H++ryVvdsiS5bEogmigsT8xcUwrBjZNVYMFcgQ7Gxw0ugTgtwveB9eStlu84V2fkFfxN
         tKM+f0s9FEJ96t3QNTjxO3942qC6Bz8zwB+QWpBXQD7zSllR5A4LSv1wyy22Y3SOjkyH
         vfcePayv8SnoCLWHk0WXc2aUlv1HRlgdIPfqYg15f/gQXsOmffEBUZcAWSq+lPGeIYa6
         5NJIpVOELscH0H5QzLBxkirb6sep9C1IUphl4RRUStiwUQiqluWAU0mB/LkFwKsS5u5O
         o1IQ==
X-Gm-Message-State: APzg51CXNM1BWM6vAmDHe6CD1v9oMeAzS6jH8t2uxK4SOpVnHmPLEvr8
        QIKn+JxA3st932yRibho7OT5Eg==
X-Google-Smtp-Source: ANB0Vdaq3//OT89+xbB0cZbdNdD2H3iuo9wQ2hryyd53FnNsa4NOpX3EW0JtBcukkh4AAV9q9P+z1w==
X-Received: by 2002:a1c:9ac9:: with SMTP id c192-v6mr11779934wme.47.1536566962800;
        Mon, 10 Sep 2018 01:09:22 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id o3-v6sm18678891wrn.58.2018.09.10.01.09.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 01:09:22 -0700 (PDT)
Subject: Re: [PATCH v2 01/16] nvmem: remove unused APIs
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Alban Bedel <albeu@free.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180907100750.14564-1-brgl@bgdev.pl>
 <20180907100750.14564-2-brgl@bgdev.pl>
 <c0b0c411-65f6-62f9-6d6d-2884e5a17250@linaro.org>
 <CAMRc=MfO01EQAfY4Uu3UwzzvhVOMF7_BpCOPVz2yVXqDgpb0AA@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <7e138142-8161-3646-4daf-619995baf395@linaro.org>
Date:   Mon, 10 Sep 2018 09:09:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAMRc=MfO01EQAfY4Uu3UwzzvhVOMF7_BpCOPVz2yVXqDgpb0AA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/09/18 08:58, Bartosz Golaszewski wrote:
> 2018-09-10 9:32 GMT+02:00 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>:
>>
>>
>> On 07/09/18 11:07, Bartosz Golaszewski wrote:
>>>
>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>
>>> Remove all APIs dealing with nvmem_cell_info. There are no users and
>>> this part of the subsystem will be reworked.
>>>
>>> This patch temprarily disables support for non-DT users.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>> ---
>>>    drivers/nvmem/core.c           | 212 ++-------------------------------
>>>    include/linux/nvmem-consumer.h |  26 ----
>>>    include/linux/nvmem-provider.h |  13 --
>>>    3 files changed, 12 insertions(+), 239 deletions(-)
>>
>>
>> This looks totally un-necessary, Other patches in this series adds them
>> back.. Consider updating these in those respective patches.!
>>
> 
> While this may not be entirely necessary, it's very useful. There's
Yes, thats exactly what am saying if it not necessary please do not do it.

> almost nothing common between this API and the new one added later in
There is more than 60%-70% of the code reused in new patches, which is 
unnecessary churn to me!

> this series. Later patches are MUCH cleaner thanks to this removal and
> I believe it makes them easier for review.
Am not sure about that, it definitely did not help me!

--srini
> 
> Best regards,
> Bart
> 
