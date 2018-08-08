Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759D3C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F2B821729
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axWqKc8h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F2B821729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbeHHMLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 08:11:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38433 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbeHHMLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 08:11:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id v14-v6so1450380wro.5;
        Wed, 08 Aug 2018 02:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A8yLcxaCPaT069JC4qDdsZR2uX9fNkFRWfb6akJmdtc=;
        b=axWqKc8hK0Ks/h2fUu3fM1+3xkq3ApIhpfn6pxDpaKQ1fPDwTNRSEX0FQMlztWxyzc
         hRUW4soPwiwQjsZg2J6nO04dnVNIn1ljYon4cTpqinOqNbm37ju0OfHtkzbVYF30aNwf
         FoKrPLvX6cQUofiOrevFSFem2ylEYb/0NuaZ51/hftpd1rq+nlbKw7e7ZGO9J7RausY2
         4QZUqo4YCgi34OnpihvU/DRQSu3TNe0EVV2aur3G4alehnFO5xwKMgE7ZZC0YH8u7P5W
         PQgumE9ZNsKIcZCkGEW0uepRYWuzlI2hk+LzpvlFhtwvk0ltLz/XRUcB5MOJvR0bkNmN
         k8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A8yLcxaCPaT069JC4qDdsZR2uX9fNkFRWfb6akJmdtc=;
        b=BL18b/PjVFHwdOpmOLnDBF/PsoUFvoyLGf3gjUpjX5ctuxvSSf1y8FhZBhGdGjJBKD
         KtWD8U7622uJ9Z+g2gebbArZOrqgoQq589tDj4hqTROkhAOzg+Ya5KXqfhlxICGVVXbH
         FjUAzyRsnTrLB2GSqx+YO7VzRBW7ud3cGjDK+wRzK+60uXMDjA05szFVQtXT7xEjejLe
         gJGZAGohWnicVPFEP1i/k+eO+9NRxog855wrBuXT5ASZDcxATNXJD5kr3klcpTCsGFBp
         KXE758vKqCMWq1Lg4hqygILE4AgLau0zTqJ6dvpB6x6sHn1fPvF31wpCgGahBFD7q6Ry
         a7iw==
X-Gm-Message-State: AOUpUlFZUXSzeueXhRCh0nXktuEzfQ8QgWPWy5f72Uk9BHhAmLD3uR3b
        znAOJdd4kPVsPWGpgmh3PRbTIYs+
X-Google-Smtp-Source: AA+uWPzfh0XjbJyxrJm1YVgkDWc8v9AwFMV1aYbE+8KQUD74PQita/+/1FDrcg7KfmiE72rXAaKKQw==
X-Received: by 2002:adf:c98d:: with SMTP id f13-v6mr1406780wrh.148.1533721935437;
        Wed, 08 Aug 2018 02:52:15 -0700 (PDT)
Received: from [192.168.1.18] (chs174.neoplus.adsl.tpnet.pl. [83.31.16.174])
        by smtp.gmail.com with ESMTPSA id o14-v6sm7028757wmd.35.2018.08.08.02.52.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 02:52:14 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] dt: bindings: lm3697: Add bindings for lm3697
 driver
To:     =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
        Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20180807160442.8937-1-dmurphy@ti.com>
 <5b8f8622-a5a5-4c54-c1ab-334db75dce83@ysoft.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <9908f71b-0881-8aca-9e59-009eecdb598c@gmail.com>
Date:   Wed, 8 Aug 2018 11:52:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <5b8f8622-a5a5-4c54-c1ab-334db75dce83@ysoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal.

Thanks for the heads-up.
"dt-" prefix is indeed more preferred than "dt: ".

Dan - I will fix it by myself, no need to resend.

Best regards,
Jacek Anaszewski

On 08/08/2018 09:56 AM, Michal Vokáč wrote:
> On 7.8.2018 18:04, Dan Murphy wrote:
>> Add the device tree bindings for the lm3697
>> led driver for backlighting and display.
> 
> Hi Dan,
> it seems like you missed to fix part of the subject as Jacek suggested.
> 
> I think it should be: "dt-bindings: leds: Add bindings for lm3697 driver"
> 
> Best regards,
> Michal
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>
>> v2 - Fixed subject and patch commit message -
>> https://lore.kernel.org/patchwork/patch/971326/
> 
> 
