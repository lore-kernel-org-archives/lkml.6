Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 94C9CC07D5D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45CA4208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQfYkXUw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45CA4208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934283AbeFMGNs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 02:13:48 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:42032 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754462AbeFMGNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 02:13:43 -0400
Received: by mail-lf0-f66.google.com with SMTP id v135-v6so2018278lfa.9;
        Tue, 12 Jun 2018 23:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=jJVQipf/WItIiHyLeAVRSa3eR+E8NMKFA3U+VVTjO8I=;
        b=WQfYkXUwExf4AWcQ5yTRzoxZ30DtaN8tpceYuY7QSZTr044su/5QzHtIn3qv2oB4sG
         btrQJ6nKfAW7jbkbJVJjE0vgckPY3PlhcHuqL+CO1A1YS/8xxtW3wLc5zXOePKHB3W2Y
         zr+3klxt+Y4qLFwCIhaTItGQ/nMaIskrxIXQCmvDe/on5Tac9wdufvMlx8a2koBENfIT
         oEQT8nSzh8RY/UQAz9cAkXTlC1TMZWMTOXPUq0Tv1GgbXCORh8S05dzgqEomvRkKP/bd
         sPxfsmoillS3HQlObt3nVl6zOYOhYgi3CU5LrjKfMFPCt1qeCLn9YPsKrRPV0NHA7hho
         twQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jJVQipf/WItIiHyLeAVRSa3eR+E8NMKFA3U+VVTjO8I=;
        b=qjCC1wC/RzuTLkeAB223UYI+lcoru4FHYwLMxVI9cNH3tNFCAfxX85zGIh/rANqyfq
         vweuvbzFNIEiLXmZuQEL2v/YzjOhbmYD24H/zTtrKhjvHG2Gnmz6Rsd37bEeDAbo76Q/
         DZLl33vOjLgL+aFGItPkz+ZGRPGlJ29WbqwOBmChKu1p1Uqo9cUsgGgDQO+TG23LSWBV
         C6cAgEbQtN4TWiej5GnhQeKfrkSCYaBYl53xcOk5r3dE1SHZ2E/Zh4F118dVLvpcOMhK
         9a9TZ9/qQVPYUJ7wo2nUIANC0FQgUcfZH9DRl3EM52S0wtYpAUcFFxv7bRxLa6g0RU6N
         C0Mg==
X-Gm-Message-State: APt69E1pVb0+vqzzyBPYA0M5lumf2eGqeogL56V//FoeisX2xkEUjQF5
        /qPCxo+Rb71WLawGOuESLHA=
X-Google-Smtp-Source: ADUXVKIWm9zkZWJLT4b2HWHDP+B4ItkDXtJ42GPosCSvfV74H72dtXvTW7zk+mQECinEm7YZBjI79w==
X-Received: by 2002:a19:e497:: with SMTP id x23-v6mr1920192lfi.40.1528870422157;
        Tue, 12 Jun 2018 23:13:42 -0700 (PDT)
Received: from [10.17.182.9] (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id i68-v6sm402041lfh.9.2018.06.12.23.13.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 23:13:41 -0700 (PDT)
Subject: Re: [PATCH v5 1/3] xen: Sync up with the canonical protocol
 definitions in Xen
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, lyan@suse.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        andrii_chepurnyi@epam.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180612074856.28451-1-andr2000@gmail.com>
 <20180612074856.28451-2-andr2000@gmail.com>
 <9c579567-ebe2-f465-5443-b3a3e71d34a5@suse.com>
 <20180612234020.GI38773@dtor-ws>
 <3605901d-4a72-3f5a-6d74-cb13d2414a0b@gmail.com>
 <D53587A2-5B1B-4D8F-8772-04D453B93D38@gmail.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <e1d62036-708d-5087-83f2-0ea32f3a6e74@gmail.com>
Date:   Wed, 13 Jun 2018 09:13:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <D53587A2-5B1B-4D8F-8772-04D453B93D38@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/13/2018 09:11 AM, Dmitry Torokhov wrote:
> On June 12, 2018 10:49:31 PM PDT, Oleksandr Andrushchenko <andr2000@gmail.com> wrote:
>> On 06/13/2018 02:40 AM, Dmitry Torokhov wrote:
>>> On Tue, Jun 12, 2018 at 03:46:10PM +0200, Juergen Gross wrote:
>>>> On 12/06/18 09:48, Oleksandr Andrushchenko wrote:
>>>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>>>
>>>>> This is the sync up with the canonical definitions of the input,
>>>>> sound and display protocols in Xen.
>>>>>
>>>>> Changes to kbdif:
>>>>> 1. Add missing string constants for {feature|request}-raw-pointer
>>>>>      to align with the rest of the interface file.
>>>>>
>>>>> 2. Add new XenStore feature fields, so it is possible to
>> individually
>>>>>      control set of exposed virtual devices for each guest OS:
>>>>>        - set feature-disable-keyboard to 1 if no keyboard device
>> needs
>>>>>          to be created
>>>>>        - set feature-disable-pointer to 1 if no pointer device needs
>>>>>          to be created
>>>>>
>>>>> 3. Move multi-touch device parameters to backend nodes: these are
>>>>>       described as a part of frontend's XenBus configuration nodes
>>>>>       while they belong to backend's configuration. Fix this by
>> moving
>>>>>       the parameters to the proper section.
>>>>>
>>>>> Unique-id field:
>>>>> 1. Add unique-id XenBus entry for virtual input and display.
>>>>>
>>>>> 2. Change type of unique-id field to string for sndif to align with
>>>>> display and input protocols.
>>>>>
>>>>> Signed-off-by: Oleksandr Andrushchenko
>> <oleksandr_andrushchenko@epam.com>
>>>>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>>> Reviewed-by: Juergen Gross <jgross@suse.com>
>>>>
>>>> I'm fine with this patch being added via the input tree with the
>> other
>>>> patches. In case I should take it via the Xen tree, please send me a
>>>> note.
>>> Juergen,
>>>
>>> I created an immutable branch off v4.17 with these 3 patches in case
>> you
>>> would want to merge them into your tree without waiting for them to
>>> appear in mainline:
>>>
>>> git pull git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
>> ib/4.17-xen-kbdfront-runtime-config
>>> Thanks.
>>>
>> Thank you,
>> I would prefer the fastest path of course
> It will be part of 4.19 pull request; the immutable branch is for Juergen if he does not want to wait till 4.19 merge window to get the changes.
Ah, I see. Juergen, can we please merge this via Xen tree then which
I assume will be faster?
>
> Thanks.
>
Thank you,
Oleksandr
