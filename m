Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D38C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 18:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853F220882
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 18:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3ZJKLW+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853F220882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbeG2Two (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 15:52:44 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33814 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeG2Two (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 15:52:44 -0400
Received: by mail-wm0-f66.google.com with SMTP id l2-v6so6494705wme.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 11:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g2iINn5UC2jWNst8ibfLjal91Q56LI9H+h5gS5WeOvk=;
        b=k3ZJKLW+3CzjKd20W5GCAs4vIS+/ByhmDyvULAUJtlWMJDOSG5lQTXU1JoHgEqmDNI
         sFrkaQE6RAJSERPjye3TtBJ/M3d3WTSqfainzRFRJMP24LKqmpIk2VeHhov2KIl9htRQ
         hOXYbrdVC0PUk6z7DgObvMnOHF1YLQ8oAyaHSRVG1CtH6pzclWUhEfcdi9nCF5cbybqe
         aDl57+e6EhpQAqgMmfLflw74XMAqaDa6J+x7y0VoyhmF/JRBkNdHy74/Q4vx2Bu6Kkxw
         YhTiqH+bk3G7MK5p7ehsq42E2jJcB7PsaXwaOFjP6WzS4nQ4lJoG7ky6WZyUUgrF9nYV
         lqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g2iINn5UC2jWNst8ibfLjal91Q56LI9H+h5gS5WeOvk=;
        b=m7utDgRnoOBF8UoiPJy63LymyngfrTWwZMCw6hvbDXsj+Vueg2n8Ow0rZNi01vFGPO
         wjBfWIEhu3gj3MkcKfFpaFJqfYgWcGaMfDtWV09kB6yYVfb45alTel7A65/EOWyO52nw
         jcFHBwXVSMkreOBL2UTfeX0kC3FkHY+4At090OMVa750RkijuwjRYB3J7pwdTS19KEG5
         be1DCgVHTH08AecThepBRdgwICJ8Ss93seFezy5HCF/u6Fa1zmH+vQYWLxvP+MOmEhzn
         hSG9Z1s00mSjyopbSNq1/PGRT1oyw5srJY6inGn2GRMHGt+IR6YG0n7IE70rpNcgmDzv
         nFGQ==
X-Gm-Message-State: AOUpUlFV/52vA1mRNcwP/jIyWcldJl5TOyk+DLu9uARwI0Jwl1RUOgYU
        hfN0xE1+YfXP1EtMgxITkuV0HNtS
X-Google-Smtp-Source: AAOMgpcmOBeRW05PdkTUzkfWNuYqXljhYXQ/o55sVkkAjJWebmHAEDVFoDPLdsgtpNC72hYMxV5rBQ==
X-Received: by 2002:a1c:369c:: with SMTP id y28-v6mr11919398wmh.34.1532888484394;
        Sun, 29 Jul 2018 11:21:24 -0700 (PDT)
Received: from ?IPv6:2a02:8108:85c0:57c8:32db:916d:97a2:c4eb? ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id k4-v6sm12150837wrv.4.2018.07.29.11.21.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 11:21:23 -0700 (PDT)
Subject: Re: [PATCH 8/8] staging: rtl8188eu: use is_broadcast_ether_addr
To:     Joe Perches <joe@perches.com>, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20180729170851.2581-1-straube.linux@gmail.com>
 <20180729170851.2581-8-straube.linux@gmail.com>
 <07a456ef0b1163115ef9aeb717120c191263fe28.camel@perches.com>
 <90fb5087-22df-0480-548a-7658881181c8@gmail.com>
 <12e1804800e490aa57b51a0e64c6da573d32a3a4.camel@perches.com>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <85e40925-21aa-1030-24ed-9dce498b98f6@gmail.com>
Date:   Sun, 29 Jul 2018 20:21:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <12e1804800e490aa57b51a0e64c6da573d32a3a4.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/29/18 19:59, Joe Perches wrote:
> On Sun, 2018-07-29 at 19:42 +0200, Michael Straube wrote:
>> On 07/29/18 19:21, Joe Perches wrote:
>>> On Sun, 2018-07-29 at 19:08 +0200, Michael Straube wrote:
>>>> Use is_broadcast_ether_addr instead of checking each byte of the
>>>> address array for 0xff. Shortens the code and improves readability.
>>>
>>> You should show in the commit log that sta_addr is __aligned(2)
>>> as required by is_broadcast_ether_addr, otherwise you could be
>>> introducing runtime alignment defects.
>>>
>>
>> Ok, sta_addr is used from following structs.
>>
>> struct ieee_param {
>>           u32 cmd;
>>           u8 sta_addr[ETH_ALEN];
>>           union {
>>           ...
>>           ...
>>           }; u
>> };
>>
>> struct ieee_param_ex {
>> 	u32 cmd;
>> 	u8 sta_addr[ETH_ALEN];
>> 	u8 data[0];
>> };
>>
>> Well, looking at it now, I'm not sure about the alignment anymore
>> in the struct that contains the union. Is sta_addr in the first
>> struct __aligned(2)?
>>
>> Should I include the snippets in the commit message, or is just
>> writing that sta_addr is __aligned(2) enough? (if it is in the
>> first case...)
> 
> It's enough to just state that the uses are properly aligned
> as long as you looked and understand that it's required.
> 

Ok, thank you.

I looked at it and understand that it's required.
But, as mentioned, at second look I'm not sure about the union.

I guess I need to read a little more about the alignment of unions.
Any hints are welcomed. :)

Michael
