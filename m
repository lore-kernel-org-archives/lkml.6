Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7C0C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F5C20666
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skLVDnbw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F5C20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbeLCJjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:39:09 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42295 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeLCJjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:39:09 -0500
Received: by mail-lf1-f67.google.com with SMTP id l10so8560628lfh.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 01:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=TjMaD2IUUfMqVaX8qqPSQKTnBjrLeZKhDp0BgEc5BQI=;
        b=skLVDnbwvdZyWFfHTlJjVI5pq2+wcn1uyZ6VwfKEWoNEoI7cdhqdcGxIuMdDSFt424
         ZY5chKFI6sSFe8TVQJNgpDskxLRr6C6HbWRHJbHHDjdChqnDrkGbojSYoKZCC5Qig9T+
         VWx3Gf2ku28B+W01mTxuqmKyKVe560yDLhGWDDpr4SAKs81ANaCwBh1/ePWSdCs1ZYZV
         I4MTNL2vO0k7gWnK1csVGM7UY/nMdwv7GiYNgIsw3gerXMW+Tzcl7txJqb9sBwfbXjCN
         +YJULCeeipVcovI+uxXbf7IolbtBKBGUL0/xfMALNqJsGEpNf3edVaf2BD7pSf+9WXL3
         9qnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=TjMaD2IUUfMqVaX8qqPSQKTnBjrLeZKhDp0BgEc5BQI=;
        b=HqwFiDvEsQHI/gvQAT5I1jq1xBLEK4JveNRGG18YcKQ/MyaIUmsTmJu/NXS59v5Kzx
         kwy8N/2L0VZb7GguykBEaYFx8r0mnZBHW1Uig6lHi4DIz6LaHZPHuAb1W7PBrrjBpZt1
         Q44zMpItORgn3rABDnohZiOvi27qUBa6oGMfwjUczknFrBqS1iVc/UyXzW6TWOYpMkEr
         PievdYXBsc2ShKckVvRfk9XU1pgCh1XfuK1D2WQEedxxiQ/WdhbdIWues8VgHeaRfBCC
         Wsza5dNIvq2bWaFvDutdrWIcVvLA6qeDejsl9xO1TvhyBpmYjwLXrfMUGC8MppnrTVvh
         hiKw==
X-Gm-Message-State: AA+aEWYcHJTNw8nRWWk1fo2czJoRU8eBnTRgufj0ub9myOTtwCSJCBNk
        6+m8JxWx/twFLtGcJvldl42uLxDg
X-Google-Smtp-Source: AFSGD/XmNaZ1eqbPC7DGQaXWAVCgvN1Y+8kQiwwHikBGpLA6Qfjfvlf3HH0o6AWSuHd0XhLpTsmqxg==
X-Received: by 2002:a19:be16:: with SMTP id o22mr8443642lff.22.1543829931224;
        Mon, 03 Dec 2018 01:38:51 -0800 (PST)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id s127sm2263523lfe.8.2018.12.03.01.38.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 01:38:50 -0800 (PST)
Subject: Re: [alsa-devel] [Xen-devel][PATCH v2 3/3] ALSA: xen-front: Use Xen
 common shared buffer implementation
To:     Takashi Iwai <tiwai@suse.de>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org,
        jgross@suse.com, boris.ostrovsky@oracle.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20181130074205.20496-1-andr2000@gmail.com>
 <20181130074205.20496-3-andr2000@gmail.com> <s5htvjvvtng.wl-tiwai@suse.de>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <ab0405f7-6f77-14d6-7b18-8378488a3211@gmail.com>
Date:   Mon, 3 Dec 2018 11:38:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <s5htvjvvtng.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/18 11:36 AM, Takashi Iwai wrote:
> On Fri, 30 Nov 2018 08:42:05 +0100,
> Oleksandr Andrushchenko wrote:
>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>
>> Use page directory based shared buffer implementation
>> now available as common code for Xen frontend drivers.
>>
>> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> For the sound bits,
>    Reviewed-by: Takashi Iwai <tiwai@suse.de>
Thank you
>
> I suppose the whole patchset will be taken through xen or other tree?
Xen tree
>
> thanks,
>
> Takashi

Thank you,

Oleksandr

