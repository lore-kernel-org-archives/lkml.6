Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92949C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394BF20854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNd63gHw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394BF20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbeILXli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 19:41:38 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34759 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbeILXlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 19:41:37 -0400
Received: by mail-wm0-f68.google.com with SMTP id j25-v6so11244891wmc.1;
        Wed, 12 Sep 2018 11:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Tj9xzqEFZ4Va1q4XVSTyvt7pX4K1cW1+oZpKTdlUoMQ=;
        b=jNd63gHw39EywqHv7XJMVW9QD/f6fqaGhgiftAxursVc+lmtRtSyZiTDR6bVgVNNvW
         l3yGn5/mxA5/diZ/lgBBsUkH4jFDC5S14vhOpqrCA15FheGYxJvvxsxXf8VMMrtaZLsC
         7XRi9SvJZLDpm40CZG/Tf+d8TYr4uTkrnYojxb+9/muX8qLU0gpZtMuSh+jm1VG/30n8
         CtGrA2t51Rdl17KQ0J2pXrseVTwmfswDOhbBbGl9XMarRhkq64soGZDUMa/JJsYoE0uf
         KZ4OawEU7Jsf3pYmYOJL2g0fW1K0Yv1sOWiG1sNd45AEIgOxWQFaf5XdkrJzaJvBkjWT
         x1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tj9xzqEFZ4Va1q4XVSTyvt7pX4K1cW1+oZpKTdlUoMQ=;
        b=g2Z33YqcMf/mjpKQtfFf1JzG0M91EKAtv9dlxZ1hTbZ70/TIA3aovH6p7ZvUP7taiN
         uUQ/pgGXFbM3fsCLAvM8b7S7oVJsYaq41wS1zvJU3hg+KBNljDTih7gF0Oa1MeEs4d/c
         ByjGeq/i3gVZNqtCp+/i74odXVFXzeBfVJDid8cw0DRlZTKHvjipDMzvvSOrRkfnj27z
         dhranLaU8umFzuY4eo/tuvYOcvHyZNHuoz7yhaOCbVr5jKrefxBNfThx9wPn9o9V0ByA
         8Zcnvqcd2viTupHpTbzt0pGKVNhX59r0kaD/4TGTpjXTCCAnSu2/aeFpPQeVokCPlEmG
         neOQ==
X-Gm-Message-State: APzg51CYUq4k/+A4PV5v2Z/uLSOorT+34CbqbycY15PFi+1D2aQbvT6x
        SgwZKXi1ThSwxy0QjzjEkfdojuw3
X-Google-Smtp-Source: ANB0VdZBgEga4oz8ZKgUVoDtDJOJrr3/1V8RHhuSDej1pnebQJiQgT9dej/Xcz2TvwYzj/phu5kMIA==
X-Received: by 2002:a1c:ee97:: with SMTP id j23-v6mr2568645wmi.66.1536777348761;
        Wed, 12 Sep 2018 11:35:48 -0700 (PDT)
Received: from [192.168.1.18] (bgu158.neoplus.adsl.tpnet.pl. [83.28.84.158])
        by smtp.gmail.com with ESMTPSA id v46-v6sm2423062wrc.63.2018.09.12.11.35.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 11:35:47 -0700 (PDT)
Subject: Re: [PATCH v7 1/6] dt-bindings: ti-lmu: Remove LM3697
To:     Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lee.jones@linaro.org,
        linux-omap@vger.kernel.org, linux-leds@vger.kernel.org
References: <20180911170825.17789-1-dmurphy@ti.com>
 <20180911170825.17789-2-dmurphy@ti.com> <20180911200530.GA28290@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <7bb0462c-e641-0c58-1f68-bd02d38edab2@gmail.com>
Date:   Wed, 12 Sep 2018 20:35:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180911200530.GA28290@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2018 10:05 PM, Pavel Machek wrote:
> On Tue 2018-09-11 12:08:20, Dan Murphy wrote:
>> Remove support for the LM3697 LED device
>> from the ti-lmu.  The LM3697 will be supported
>> via a stand alone LED driver.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> 
> I'd really like to see better explanation here.
> 
> We have existing binding, for lm3697 and similar devices. With this
> series, different binding is introduced, without documented reason.
> 
> That's bad.
> 
> Now, maybe you are right and the hardware should be handled by
> drivers/leds, not drivers/mfd. But we should have solution for all the
> similar chips, and that still does not mean we have to modify the
> binding. (But maybe we want to move it to different
> directory). Bindings are supposed to describe hardware, not mirror
> structure of our drivers.
> 
> Unless there's something fatally wrong with the binding... but in such
> case we'd like to know what is wrong.

Dangling references ?

> [And yes, I recognize current situation is ... not ideal and I'm
> willing to help. But I'm not sure this is step in right direction.]
> 
> Thanks,


-- 
Best regards,
Jacek Anaszewski
