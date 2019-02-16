Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BB0C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 02:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5017A222D9
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 02:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+dncHvt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391253AbfBPCfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 21:35:44 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41180 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390786AbfBPCfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 21:35:43 -0500
Received: by mail-pg1-f193.google.com with SMTP id m1so5677367pgq.8;
        Fri, 15 Feb 2019 18:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yEy/+YbDQbGxxA2qYRx3mjiGQKjjfBhoBcUP0nyLTSw=;
        b=H+dncHvtFMJzDUAtZi6nDtSNVgOSAJW3JOMWM9P39YucfMNqev14XmPf4Ke4grJix7
         aucQNcGkNCE1N0iRu30zPJS8JwSF35aSVqks93bK6x4cDdAAezB25DJso6+p1GQXquKh
         PlCLuo22VYIGJw4hJCNB33lxjQjQz+S/2Y6RFm8SOhd+1hmbdAAekiTyNHudFdgpOM4K
         9XkUWNy5/oFcC1TYjpb9byUo0I9LmofuBmLUOyIM4DoSUdRFAsGxlxP7GwCxzyNWHTmE
         uk7hWjaWWxeygMqVFG/TgOw+p5vP0TvrsELHLaFfCQ1wF9db4deAMV94iByJNPsLtlRw
         HG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yEy/+YbDQbGxxA2qYRx3mjiGQKjjfBhoBcUP0nyLTSw=;
        b=GftGh9GdukmrAv3nPTtpb67+qnYFitgs1rJVmO50dX3975OAq5MNdg91t4HaXRL0fq
         wS4KzqGwO7Tm+IcFZxr5BHZGgINCn61D/n6WNZgOLmCoOYzIyAz3nTC99TxPBP2XZ4Lb
         z4/vf8GKkNDmt0N0EBAAhBtJ+5QLztxpulOIyelzem1/2KX7gByUGtufeul6UNgObwIn
         Z32+S8hXRln1wdJhzO38e6wdeYb8XkSANKczYybnmTCN9UwQVnKlruWei4GCkVgHGnCl
         oj/wv/Lg7NZS54HlneCzwv0YWtph3PiXdsr3KE7hINUvLlvHaVuryx3I7+ZnHw47Ay1C
         8IJQ==
X-Gm-Message-State: AHQUAuZ/GQV9yAI8IaGEYGpwumQvSR+Eb51TeZ+IGiBxBfCKUyJ8tS4w
        w8FTE63K4Y3Vw0Ihmv+NOPg=
X-Google-Smtp-Source: AHgI3IZXWkG48rdrmUkFGOdpQP0cc1OGlqnUsB8oJaLAPgf9rsE8If46WFaPvyrBkfbJlvML3y6a+g==
X-Received: by 2002:a63:2c8c:: with SMTP id s134mr8383805pgs.269.1550284542515;
        Fri, 15 Feb 2019 18:35:42 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id s6sm1111820pgm.90.2019.02.15.18.35.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 18:35:42 -0800 (PST)
Subject: Re: [PATCH v2] of: unittest: unflatten device tree on UML when
 testing
From:   Frank Rowand <frowand.list@gmail.com>
To:     Brendan Higgins <brendanhiggins@google.com>, robh+dt@kernel.org,
        mcgrof@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190216004647.206431-1-brendanhiggins@google.com>
 <eabdd156-62f4-fadb-bfa4-ecbb5ba65527@gmail.com>
Message-ID: <fcb92f73-f49b-03b8-32ca-ee89b962a765@gmail.com>
Date:   Fri, 15 Feb 2019 18:35:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <eabdd156-62f4-fadb-bfa4-ecbb5ba65527@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/19 6:18 PM, Frank Rowand wrote:
> On 2/15/19 4:46 PM, Brendan Higgins wrote:
>> UML supports enabling OF, and is useful for running the device tree
>> tests, so add support for unflattening device tree blobs so we can
>> actually use it.
>>
>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>> ---
>>  drivers/of/unittest.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
>> index 84427384654d5..6de34d5fa0e85 100644
>> --- a/drivers/of/unittest.c
>> +++ b/drivers/of/unittest.c
>> @@ -2527,6 +2527,9 @@ static int __init of_unittest(void)
>>  	}
>>  	of_node_put(np);
>>  
>> +	if (IS_ENABLED(CONFIG_UML))
>> +		unittest_unflatten_overlay_base();
>> +
> 
> This is still the wrong location.  It should be at the top of the function.
> 
> I'll try moving it to the top and see if it still works -- should only
> take me a few minutes.

Yep, see below.


> -Frank
> 
>>  	pr_info("start of unittest - you will see error messages\n");
>>  	of_unittest_check_tree_linkage();
>>  	of_unittest_check_phandles();
>>
> 
> 

This is probably white space damaged because I used cut and paste,
but this is what I meant above.

Tested on 5.0-rc3.

Applied patches 1-14 of series:

   [RFC v4 00/17] kunit: introduce KUnit, the Linux kernel unit testing framework

booted uml, saw the expected 219 pass, 1 fail.

Applied the following patch, saw the expected 224 pass, 0 fail.

I did not apply patch 15 of the other series, but applying patch 15
should still result in errors on boot, as I reported in the mail
thread for that patch series.

---
 drivers/of/unittest.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: b/drivers/of/unittest.c
===================================================================
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -2514,6 +2514,10 @@ static int __init of_unittest(void)
 	int res;
 
 	/* adding data for unittest */
+
+	if (IS_ENABLED(CONFIG_UML))
+		unittest_unflatten_overlay_base();
+
 	res = unittest_data_add();
 	if (res)
 		return res;
