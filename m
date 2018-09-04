Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882EBC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CFE02075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tt18FY3S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CFE02075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeIDVeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 17:34:44 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40432 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbeIDVeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 17:34:44 -0400
Received: by mail-yw1-f67.google.com with SMTP id z143-v6so1537746ywa.7;
        Tue, 04 Sep 2018 10:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QARToPw0cAxFn21aaaLHHfl+w0FXVhEnq2K2QJGTU6w=;
        b=Tt18FY3SEzSUBkEtl/lyjvGVBT7n6dFmibY8Ulqr2aTbN5U1pzVHRcjND8H7AzYCoq
         5Q+D4Wo0gxVjcougWfgLaukVZRwLVcEX5pbNT5gb80FtsLkyiboBVWgLEaH/OEAvTHsp
         h7mB1WmFqryudN0wPZsjh+hOllIdclNmYDVy33cmV9XrbuMtHBXfmT3flxi9u9WgV9ft
         2ZLzHjvOKAfEz5zG84kQhxcbrcQlYlFY/AJJujHbuTLn8fRNTTZR+yk7UgKb9CwAS4Yv
         OB7sGdGlz3MJMFgQdFVoKchy7dmRHBY1lq3TMbGAsUeb/KYy37ERooZRdBIJyH01QjTg
         KEiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QARToPw0cAxFn21aaaLHHfl+w0FXVhEnq2K2QJGTU6w=;
        b=pI1oqsnWs+uFRQNzRD8UeVz5nDnMYpFHiZ+LQsZQtUrb5EeZNzGfLXwgtLTDVQCn9h
         2CgE/blR/YNlkOuvcDmjAaBMhisrkKTbdOD2CVGrIr9BcElA3PzLt4yAm4Y+GEHfMpIa
         IVmaQeNDi7DOVUyF6A7nBxSY1t60BReySsJIV8GdEWv6CsgCzJNeyknws89xD/cqCvWJ
         yqB9UoOBAujvPD2P2XgWAjQ4Lc15shrhxJg0lLe0cU6QZnqVsZ4rvxJf9kwVXA7baAO/
         BKzno7YmC6vQfwmAgRJjNBRSUy2pd+gbqzl4lX+dTuPH5Cx3uybJrx4yXAbS+QTP68jV
         Sd2Q==
X-Gm-Message-State: APzg51CYw2nbhfeTtk3cJUXPnbQdIdNxQBVXTVQ5eGTs9TQyFPzmPN0A
        Q3xLPQIlU3OT5yET/Dk96VO2tTF9
X-Google-Smtp-Source: ANB0VdYaQc9tJF7RuP3Qc73SU6erZGqpher8acJU5q4otqU58SCMvNzyfJH49NHf+UIZ7o0wgCsBBQ==
X-Received: by 2002:a81:8245:: with SMTP id s66-v6mr19296937ywf.472.1536080923297;
        Tue, 04 Sep 2018 10:08:43 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a3:10e0::3ed7? ([2620:10d:c091:200::63dd])
        by smtp.gmail.com with ESMTPSA id m1-v6sm7616218ywf.96.2018.09.04.10.08.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 10:08:42 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: Re: [PATCH] rtl8xxxu: Add rtl8188ctv support
To:     Aleksei Mamlin <mamlinav@gmail.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180830140541.31964-1-mamlinav@gmail.com>
 <20180904081619.7353B606AC@smtp.codeaurora.org>
 <53022e37-e9dc-1cf8-ec3c-4df668f3c045@gmail.com>
 <20180904192338.e9be91d4be447e33acefed5a@gmail.com>
Message-ID: <3be649f2-3f55-c11c-f31e-02ba68ed4103@gmail.com>
Date:   Tue, 4 Sep 2018 13:08:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180904192338.e9be91d4be447e33acefed5a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2018 12:23 PM, Aleksei Mamlin wrote:
> On Tue, 4 Sep 2018 11:36:50 -0400
> Jes Sorensen <jes.sorensen@gmail.com> wrote:
> 
>> On 09/04/2018 04:16 AM, Kalle Valo wrote:
>>> Aleksei Mamlin <mamlinav@gmail.com> wrote:
>>>
>>>> The Realtek rtl8188ctv (0x0bda:0x018a) is a highly integrated single-chip
>>>> WLAN USB2.0 network interface controller.
>>>>
>>>> Currently rtl8188ctv is supported by rtlwifi driver.
>>>> It is similar to the rtl8188cus(0x0bda:0x818a) and uses the same config.
>>>>
>>>> Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
>>>
>>> Patch applied to wireless-drivers-next.git, thanks.
>>>
>>> 514502c3a70b rtl8xxxu: Add rtl8188ctv support
>>
>> Looks good to me too - assume it's been tested?
>>
> 
> Yes, tested on my ARM tablet. It successfully connected to my home router
> using wpa_supplicant. There is dmesg output:

Awesome, glad to hear it's working!

Jes

