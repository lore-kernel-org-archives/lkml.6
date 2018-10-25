Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EFEC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B8E2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FemoavDm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32B8E2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbeJZC4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 22:56:01 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44469 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbeJZC4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 22:56:00 -0400
Received: by mail-lj1-f193.google.com with SMTP id v6-v6so9132354ljc.11;
        Thu, 25 Oct 2018 11:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LtnuS6YFbUcH8Dc65n3b8cqE/xtgarqQX7+T4ypZq9w=;
        b=FemoavDmOgAlv6mJzbA0vGVb+YzYvAdgCIXvdbuBlg2flSUFQbtpSOxEWBHiUnw/9Y
         BBiSjq2xkBr7dFzuoiDzgCMIrwU38VhFUoihAcP7aG6A6abqShkh8uU9DiQvaPAmRooR
         t90NMlP+W2a/MqW3sdXIkXO7tioX9WtVX0qB7kcBo3ONKeURyJXvvWVIXopjE8QT5X5c
         yNsodDMh4fvXwleAdUc6uMCRiDz3jhe7Q947YCxrCHOqOkqVVjX+BN+IH/mnaC1EaJOZ
         1i5VMHXddAZz5jJJzWxiV/nrbSxSd62NLtSoNzb0P55XwkHNEvCP1a/MpBXtpM5cClbS
         QIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LtnuS6YFbUcH8Dc65n3b8cqE/xtgarqQX7+T4ypZq9w=;
        b=TavzXdi9spZsaW8ORYPN73dai2frjct7a5WSNHFhe+PHvOv2CB0fw0yDZDFkwg4Uti
         S5JaCiAlKuq0buF8Ee8OqwyqX8a5C2DyQfQ5HZb3JduUALhb9H57yy2TgRUP5kiHSgvv
         qE61UOc8vY56OhUMCPbKBXIBAsItXvDJzTFil4NyW4Vb5dGYPI9Oz3ovr9XT0R+ACGxT
         4n/77+sJ+W6W+ex7cPXBnKB5og2N2MCGxkQxsIwxGFsWio2cFoKsj2z/EdsTWJ6fC6J9
         I7kgdUOw9d8JSczBLdH084UAdUe6crJBPlIdi43sKkIuwh709D9xfSMzdVmNIluc7sSW
         fAQg==
X-Gm-Message-State: AGRZ1gIgFXG42K1bYNtiu/faa1XJAhWT31NEuDUIeGLFhYgqw4fXPIky
        P2Tj2o4Ia/mpfTJFbr7sagWNOGHh
X-Google-Smtp-Source: AJdET5fYCU2M4os/ZRRrrgVlXQQ82xzG0CSoHliQyIYnUFQj3zSLWswzpF+NJcPm+cyPydktTNL4VA==
X-Received: by 2002:a2e:4e01:: with SMTP id c1-v6mr198810ljb.157.1540491727078;
        Thu, 25 Oct 2018 11:22:07 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-118.nat.spd-mgts.ru. [109.252.91.118])
        by smtp.googlemail.com with ESMTPSA id a14-v6sm1377924lfb.22.2018.10.25.11.22.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 11:22:06 -0700 (PDT)
Subject: Re: [PATCH v1] hwmon: Fix double-free in __hwmon_device_register()
To:     linux@roeck-us.net
Cc:     Jean Delvare <jdelvare@suse.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181025001502.Horde.ohnOCUflLESPXB4_wIk6s0-@cp2.active-venture.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <531d2ac7-b081-8d6f-e331-711d16c8c73b@gmail.com>
Date:   Thu, 25 Oct 2018 21:22:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181025001502.Horde.ohnOCUflLESPXB4_wIk6s0-@cp2.active-venture.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/18 3:15 AM, linux@roeck-us.net wrote:
> 
> Quoting Dmitry Osipenko <digetx@gmail.com>:
> 
>> Fix double-free that happens when thermal zone setup fails, see KASAN log
>> below.
>>
> 
> Good catch. I'll apply this as soon as I manage to convince AT&T to restore
> my internet service.

Cool, thanks!
