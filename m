Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AE856C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59ECF2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lg3ntcc/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59ECF2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934176AbeFMG2n (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 02:28:43 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:37129 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933618AbeFMG2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 02:28:41 -0400
Received: by mail-lf0-f66.google.com with SMTP id g21-v6so2099800lfb.4;
        Tue, 12 Jun 2018 23:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=MzaKL60d2B3Kum7T9n6n+UoFR/n4pUQR9CcAx7Lqnvc=;
        b=Lg3ntcc/q2cIy2J8vBRDaiAHh8303+Mv1OmeE1xqspUkMga0Tho3Vz784QskfwSK85
         WWVpbbfpRcr8L1nVDJaTuRt5C48Vgaq6pfHRMBOgXXiW02ea1knmADKJ+oM2qyFQ39dw
         /QFErVcQMQw+zJOc7Y2kyCkhMaCHYQBBp03ZlaJrvHgRG6Q+AoK1nXkz4fttBqoMtTlM
         YbtR7h54LuL1B2z5NIYVMefcOSSmNy2U7vJ9LbsonCLqFkiPC27MmbZUNIVxzRwZF8Wk
         qTVhJuQ+MyHuth85KFlj5JiKgxG2xDS6T5LQzhNazXTskf7qTlOfqQBb7vN10e5HPoH3
         HCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=MzaKL60d2B3Kum7T9n6n+UoFR/n4pUQR9CcAx7Lqnvc=;
        b=hxhOfKDCsX6lwmxEsNa/pO67aLRuc5UecZuWpi14ZP5lGl+uyBvNfakwMCI2sRzjyl
         UQ7VNnJ1aWb6giCFjDhmYrcKk7dn+BNUEakmabcqJ/qVjedQAEQhKqmM+5oEy9CYl343
         hV8n6EgiAO8ozwtOiLBjK+Wof6EB/c6mi8RVIWOsYxSjGtF3u/YzdeXL2pwd3TmENwbX
         PVyyRRaWQTuvyjl9O7zph8PxUx2Yb36CpjbTzDvHMPiL1Wy8TA2x9cYbRyqMXCOMCJT7
         UGEo58dP5p8uMQ5osWwR1PkMUfBM0LdthPOG+sFxEtTKmf55bjaniRHpDNsoyFRVwra3
         5jXQ==
X-Gm-Message-State: APt69E1eaJnD+MhR8wl6YsVfhcg+hGoHhsne23fUucNIXBBNp28klBWH
        lAQ1JV1SUH9ngVf4sSdkBSY=
X-Google-Smtp-Source: ADUXVKIVunmGXLY9vlfX+NKm8+P7bibqD0MaP6YPwJ9oEEqJNjfh6kzBsC71RWQVag1H8AFjBH0wdQ==
X-Received: by 2002:a19:f86:: with SMTP id 6-v6mr1948762lfp.15.1528871319890;
        Tue, 12 Jun 2018 23:28:39 -0700 (PDT)
Received: from [10.17.182.9] (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id j78-v6sm393226ljb.10.2018.06.12.23.28.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 23:28:39 -0700 (PDT)
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
 <e1d62036-708d-5087-83f2-0ea32f3a6e74@gmail.com>
 <800B1B3B-795F-4D0D-8B61-B66FC77A11A8@gmail.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <33e9793d-e903-c046-31e5-78841c7aa3c1@gmail.com>
Date:   Wed, 13 Jun 2018 09:28:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <800B1B3B-795F-4D0D-8B61-B66FC77A11A8@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/13/2018 09:25 AM, Dmitry Torokhov wrote:
> On June 12, 2018 11:13:40 PM PDT, Oleksandr Andrushchenko <andr2000@gmail.com> wrote:
>> On 06/13/2018 09:11 AM, Dmitry Torokhov wrote:
>>> On June 12, 2018 10:49:31 PM PDT, Oleksandr Andrushchenko
>> <andr2000@gmail.com> wrote:
>>>> On 06/13/2018 02:40 AM, Dmitry Torokhov wrote:
>>>>> On Tue, Jun 12, 2018 at 03:46:10PM +0200, Juergen Gross wrote:
>>>>>> On 12/06/18 09:48, Oleksandr Andrushchenko wrote:
>>>>>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>>>>>
>>>>>>> This is the sync up with the canonical definitions of the input,
>>>>>>> sound and display protocols in Xen.
>>>>>>>
>>>>>>> Changes to kbdif:
>>>>>>> 1. Add missing string constants for {feature|request}-raw-pointer
>>>>>>>       to align with the rest of the interface file.
>>>>>>>
>>>>>>> 2. Add new XenStore feature fields, so it is possible to
>>>> individually
>>>>>>>       control set of exposed virtual devices for each guest OS:
>>>>>>>         - set feature-disable-keyboard to 1 if no keyboard device
>>>> needs
>>>>>>>           to be created
>>>>>>>         - set feature-disable-pointer to 1 if no pointer device
>> needs
>>>>>>>           to be created
>>>>>>>
>>>>>>> 3. Move multi-touch device parameters to backend nodes: these are
>>>>>>>        described as a part of frontend's XenBus configuration
>> nodes
>>>>>>>        while they belong to backend's configuration. Fix this by
>>>> moving
>>>>>>>        the parameters to the proper section.
>>>>>>>
>>>>>>> Unique-id field:
>>>>>>> 1. Add unique-id XenBus entry for virtual input and display.
>>>>>>>
>>>>>>> 2. Change type of unique-id field to string for sndif to align
>> with
>>>>>>> display and input protocols.
>>>>>>>
>>>>>>> Signed-off-by: Oleksandr Andrushchenko
>>>> <oleksandr_andrushchenko@epam.com>
>>>>>>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>>>>> Reviewed-by: Juergen Gross <jgross@suse.com>
>>>>>>
>>>>>> I'm fine with this patch being added via the input tree with the
>>>> other
>>>>>> patches. In case I should take it via the Xen tree, please send me
>> a
>>>>>> note.
>>>>> Juergen,
>>>>>
>>>>> I created an immutable branch off v4.17 with these 3 patches in
>> case
>>>> you
>>>>> would want to merge them into your tree without waiting for them to
>>>>> appear in mainline:
>>>>>
>>>>> git pull
>> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
>>>> ib/4.17-xen-kbdfront-runtime-config
>>>>> Thanks.
>>>>>
>>>> Thank you,
>>>> I would prefer the fastest path of course
>>> It will be part of 4.19 pull request; the immutable branch is for
>> Juergen if he does not want to wait till 4.19 merge window to get the
>> changes.
>> Ah, I see. Juergen, can we please merge this via Xen tree then which
>> I assume will be faster?
> We are in the tail end of 4.18 merge window so it should not make it in 4.18 no matter what tree the patches will go through.
Hm, but these are updates and fixes (besides the last patch which adds 
some more
functionality), so I thought this is still good to go in 4.18?
>
> Thanks.
>

