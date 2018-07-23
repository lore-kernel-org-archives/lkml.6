Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F74ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C6A20881
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rCdI97aE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86C6A20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388608AbeGWQRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:17:02 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43951 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388115AbeGWQRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:17:02 -0400
Received: by mail-pl0-f67.google.com with SMTP id o7-v6so352615plk.10;
        Mon, 23 Jul 2018 08:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JsiGHBYuR0+zpkz1YVrSp6YypJNxVI6YvYA0TVkczs4=;
        b=rCdI97aERt4gFOUOKEf2y0uBQ/AVG/FHGLzahTR82O8JS4BoIiZW7tf3qiuLyXRXdI
         V/qg0eVH9uK4Q6ZjhOYO7eFLtuP7udsiz8Qsk3LF4DG+jA5DLL3ULyqQvGgfnKk9QjCT
         1NewX5s58pFoDkKQ3rnKPBdlFvko42KDIF8W3aQbhCCGBLtKqSG77wZZBTstjyuyX0yd
         KLABjdSA0/bjQGGqAjfmZ9Cc6FHBMeXid0UPuB+fPwySsUtI7QJK9P7tTVUuI86vqXYX
         MQib1p6wH+SoCM/Oy9vGc9r9Dk6OOXwqpOMZoFY0dsk4qL98ZbBGzpPEZGwWLYydkq4f
         FvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JsiGHBYuR0+zpkz1YVrSp6YypJNxVI6YvYA0TVkczs4=;
        b=rrubHy03aVzmivV3uxtuQ61uEtSAWsvaBRY06m+Ym50AiWydHxVkKWbf4QK2ogYyyk
         2C6uiQMA7sQZAvOfpNrEplm9tky7+7Vo25DCu6cVB/f9RhBrutiekVQhwXArC2ZwbuPk
         +QbzFRcGSMsTrrPxWyTHY7ld9BiYC3SiWE4FNXV+6/RvYyt5b/p076iQZ8GTEqTZ+E0N
         9v1foL6eerSZYnSMgKP6bBFZSRM5hfHw3lPkqVsMMKA7np+2Mi8jxH7jjnHvDlBKNSXX
         yLBtwWT93+LN8W23kxPdGB/OwCbR2vIjm1bnI6t5gbQAEZ7T6jnB99DkvHNnISfiJAok
         YalQ==
X-Gm-Message-State: AOUpUlEuIGUTDIJQb3IxrMrGfd04iLLdfaiH/p8IEECCzlvJ3jeTsYH5
        wtTSU4PgNb8m2+rR8HMtHGyFCoe8
X-Google-Smtp-Source: AAOMgpeL1NrqkMd5zbwxXpAqguXnZQpxYybrbLMNb7LJlkJOepwh1qMmED4ko3ofurogQgKpsklnCQ==
X-Received: by 2002:a17:902:2f84:: with SMTP id t4-v6mr13204745plb.87.1532358920691;
        Mon, 23 Jul 2018 08:15:20 -0700 (PDT)
Received: from [192.168.1.5] ([110.78.147.217])
        by smtp.googlemail.com with ESMTPSA id l85-v6sm17040739pfk.34.2018.07.23.08.15.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 08:15:20 -0700 (PDT)
Subject: Re: [PATCH] option: Do not try to bind to ADB interfaces
To:     Romain Izard <romain.izard.pro@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable <stable@vger.kernel.org>
References: <20180723140220.7166-1-romain.izard.pro@gmail.com>
From:   Lars Melin <larsm17@gmail.com>
Message-ID: <73f2233a-cafd-a477-0c0a-260be832777d@gmail.com>
Date:   Mon, 23 Jul 2018 22:15:03 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180723140220.7166-1-romain.izard.pro@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/2018 21:02, Romain Izard wrote:
> Some modems now use the Android Debug Bridge to provide a debugging
> interface, and some phones can also export serial ports managed by the
> "option" driver.
> 
> The ADB daemon running in userspace tries to use USB interfaces with
> bDeviceClass=0xFF, bDeviceSubClass=0x42, bDeviceProtocol=1
> 
> Prevent the option driver from binding to those interfaces, as they
> will not be serial ports.

You are assuming that an interface with these attributes are always a
ADB interface - that is wrong. Vendor specific class (0xff) is not
standardized to be something specific.


> This can fix issues like:
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=781256
> 

You are trying to solve a 4++ years old bug report where it was assumed 
that the option driver was the culprit. The device in question, a 
Qualcomm modem with vid/pid 05c6:9025 has never been included in option.


rgds
Lars


