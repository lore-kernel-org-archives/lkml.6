Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E94C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF472148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJx6ZZY7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfA1W1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 17:27:15 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45018 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfA1W1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 17:27:14 -0500
Received: by mail-lj1-f194.google.com with SMTP id k19-v6so15706673lji.11;
        Mon, 28 Jan 2019 14:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9ZtWCkYjFys16slwcmTYDVFw0ffF3H6Epb/ByOOg9iw=;
        b=HJx6ZZY7X0QDyo5otvUFiCScnRDehAlqthAxZ0ZO6rmKbkgk4jH7mdNkA3s1HlnwYD
         QAjwRvnPYYFpGRcPwm+QvMzg2KUbdiZ0325kmnVJYX3VOwWpfyHHNgJslPWwutAi8nD3
         MP3P4gOAD5M1Tf3R5ftjWgRqKzbxg0LYRT0FcBF1UmChQBVtjoiwudSdMbEgYJ6MVUS7
         ZHWCVoYsZbYOQlEt33Qi5NOfQ7Clk4lNK2QZvhYYYbBcEcHs1Cka5r9icEiXzYOuIvN+
         LdAohRMtiDXlsRozJdByKODNv+SZ53v4olBAcW8lB6THmQXeGEOXQ8Wr3rD7AQYpRCVY
         6fUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9ZtWCkYjFys16slwcmTYDVFw0ffF3H6Epb/ByOOg9iw=;
        b=dvANKPIw7g98Qc+qEtv4gj+TUONL4owqvybeSgoVIDeVJVhE00cCBtAsf8g5jYkIlq
         d0jLxuLzrb+1l5HItMeGsZo6gcnmhFz+gCTEui0G+LoFOA/d5imaVrKW8W0w7Ph3yWhq
         WzsBCP4IyC4Uya4YBqf6JOnRCzAaTtJnCvdbu67MXikNQAzGSmZeRMdcH8ndGg0P/ufq
         S6aeLJ5+Tdj3tMunUo1kfy/9Q5EVmc+mkxdXZr5kRrSUZalvfHRX+U+ajLqQaxzDSZ0Q
         RHX2CE/lNs6GdrT1V2m8/Hbh1NV8zsLEWawJ8k1O2MZyYfzI1K/rMnV82qvzt2+Tko0w
         GWAg==
X-Gm-Message-State: AHQUAuZoux4yk9wHm7gdkliSwcYzXo1W5/bgcydCWQovO4WXZ07Z9TRg
        +8AL0M2egwLzrrXWoBv9VS1Ioa+s
X-Google-Smtp-Source: AHgI3IbD7swbzihmtLez53xUuQOt0dEy32mVCAi/HozkwUsKvSgTm1CUEA+l6TboGB0Z6uV1zk4YdA==
X-Received: by 2002:a2e:1603:: with SMTP id w3-v6mr208327ljd.33.1548714432087;
        Mon, 28 Jan 2019 14:27:12 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id q2sm3324954lfa.63.2019.01.28.14.27.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 14:27:11 -0800 (PST)
Subject: Re: [PATCH V3 2/3] i2c: tegra: Update transfer timeout
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
Cc:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
References: <1548475073-12408-1-git-send-email-skomatineni@nvidia.com>
 <1548475073-12408-2-git-send-email-skomatineni@nvidia.com>
 <0cf91475-f77d-7453-deb6-3dd91b63aeb6@gmail.com>
 <BYAPR12MB3398E9D32B57B0E2FC2A6466C2960@BYAPR12MB3398.namprd12.prod.outlook.com>
 <c0b36535-6767-7327-5dc5-612e6957a769@gmail.com>
 <BYAPR12MB339837E896774531B0D11A98C2960@BYAPR12MB3398.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <2f3cab66-7424-1b33-976f-826877623726@gmail.com>
Date:   Tue, 29 Jan 2019 01:27:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB339837E896774531B0D11A98C2960@BYAPR12MB3398.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

29.01.2019 1:15, Sowjanya Komatineni пишет:
> 
> 
>>>>> Update I2C transfer timeout based on transfer bytes and I2C bus rate 
>>>>> to allow enough time during max transfer size based on the speed.
>>>>
>>>> Could it be that I2C device is busy and just slowly handling the transfer requests? Maybe better to leave the timeout as-is and assume the worst case scenario?
>>>>
>>> This change includes min transfer time out of 100ms in addition to computed timeout based on transfer bytes and speed which can account in cases of slave devices running at slower speed.
>>> Also Tegra I2C Master supports Clock stretching by the slave.
>>
>> Okay, I suppose in reality this shouldn't break anything.
>>
>> Please explain what benefits this change brings. Does it fix or improve anything? The commit message only describes changes done in the patch and has no word on justification of those changes. Transfer timeout is an extreme case that doesn't happen often and > > when it happens, usually only the fact of timeout matters. If there is no real value in shortening of the timeout, why bother then?
> 
> Original transfer timeout in existing driver is 1Sec and incases of transfer size more than 10Kbytes at STD bus rate, timeout is not sufficient.
> Also Tegra194 platform supports max of 64K bytes of transfer and to allow full transfer size at lowest bus rate it takes almost ~5.8 Sec.
> In cases if large transfer at low bus rates 1 Sec timeout is not enough and in those cases transfers will timeout before it waits for complete transfer to happen.
> 
> So this patch uses transfer time based on transfer bytes and bus rate.
> 

Please add that to the commit message.

And then seems you also need to set I2C adapter timeout to a some larger value. Currently Tegra's I2C doesn't explicitly specify the "adapter.timeout" and I2C core sets it to 1 second if it is 0.
