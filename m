Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53ACC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A135224017
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uZeVnOhI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A135224017
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753859AbeGERtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 13:49:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37840 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753453AbeGERtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 13:49:18 -0400
Received: by mail-pg1-f196.google.com with SMTP id n15-v6so82663pgv.4;
        Thu, 05 Jul 2018 10:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HrI1fzElgphA1CoiSKN2fMUzJjiIC7pCwytKlQi2TbI=;
        b=uZeVnOhI04Q+RUImbE73BGz02HAb08zw8Kvwy8RWtQ8A+RAA1l4HU7EQC+3hlY//Nt
         uKsd1pGAH6M/+GKvX6khQQVCKv/CU6yztkYj1xgm+6679fUP8hpD9/CDgAsDpjD/SkAz
         EES2hpCGzIywjaDnJ/aJg8EKyBIQh8K50rCc81jbyeiBV57w+bz2gFAyKclnDYq5h/DK
         0WUUWY5hMnrrly6fJgUHnu/kzKGV0Ezmt/xThT7rP4HgvJeR1vIGOwRaqSO12QjhSmRz
         AHJUP99RXPhvzP9pNOtCS6/SF2fvNCrGrSwwGhDcRwj0BtnTScaLOrjnp3LPW0ww7xLE
         JPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HrI1fzElgphA1CoiSKN2fMUzJjiIC7pCwytKlQi2TbI=;
        b=TeGSJsZTv6nUyAHIjP8GNeUpCpZLlWZA6Jj/0FS7NcGWB8SHiBjQaOnxtzHGxHvQth
         aBqXxqq5TcZKjS+je/eGYRzAZGFLmcRD/EKBPGMztXrmom1SFgqxZgkh1+QuV9koSkj7
         vSyD9rVPBclHk+BYDrGYCum2Gve+SeA++xS/MfYsJjsn1aigM/tfY5z/Ciur1jTDTZWL
         mcCre0KaEF+lN9Kq7H84fcn0CIrDM2bu3hIWc1CtdvJQXZbsJkCjp2QU/7qwFKbGvrnH
         JKeG//kP4s8VT0kMXsap5M0PkiMjpADr2ue4aUbSL3df07Q1T3mZDuw4fBjihygjYiPm
         ndJQ==
X-Gm-Message-State: APt69E2bIt50jBq8pJD1y7EKRSVWwg+WDbnvEcB5c0qxrz7490GsAlya
        dBABDuFh+h8ZaJWXVajCWrY=
X-Google-Smtp-Source: AAOMgpdh58ZewwKWtRw+LrUdHkA7tJIUbKArOayKSYUDollN7/oK2JPidq8QwO2fqrG+Nw/7KiFRHg==
X-Received: by 2002:a62:d39b:: with SMTP id z27-v6mr7531926pfk.182.1530812958032;
        Thu, 05 Jul 2018 10:49:18 -0700 (PDT)
Received: from [10.111.67.248] (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id a11-v6sm1143444pfl.66.2018.07.05.10.49.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 10:49:17 -0700 (PDT)
Subject: Re: [PATCH 1/4] scsi: aacraid: remove AAC_STAT_GOOD define
To:     Dave Carroll <david.carroll@microsemi.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        Raghava Aditya Renukunta 
        <RaghavaAditya.Renukunta@microsemi.com>
References: <20180705110140.19545-1-jthumshirn@suse.de>
 <20180705110140.19545-2-jthumshirn@suse.de>
 <4cd9a8cb64dc4d8aa1e10c3b008c3ba0@microsemi.com>
From:   Bart Van Assche <bart.vanassche@gmail.com>
Message-ID: <e0a3470a-6e52-5585-602e-0e515194b26d@gmail.com>
Date:   Thu, 5 Jul 2018 10:49:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <4cd9a8cb64dc4d8aa1e10c3b008c3ba0@microsemi.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/18 10:42, Dave Carroll wrote:
>> Remove the AAC_STAT_GOOD definition and open code it in the places it was
>> used.
>>
>> This will make subsequent refactoring in this area easier.
>>
> Please don't ... the definition itself was added to make refactoring easier.

That's a vague statement. Which kind of refactoring do you plan to make?

Bart.
