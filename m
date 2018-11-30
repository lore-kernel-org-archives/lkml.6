Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25192C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D955A2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gg0QTN/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D955A2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbeK3SPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 13:15:52 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35383 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbeK3SPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 13:15:52 -0500
Received: by mail-lj1-f194.google.com with SMTP id x85-v6so4060710ljb.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 23:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=4z4Zl/LOsxc1sy3yp5yW/Ng9/mWPVR4OkXBYaR7AnTQ=;
        b=gg0QTN/8ecszgNNCHGB3QTM/QSHe3p/AIKy8qotGNKVdp7igg1C4QY25XXuhfy7SR8
         cQV9zXRM/RBTcRoKpcdi5E25fndLBcN0G8vReVGYIiZ+pinigGGSC0bPwyyhWrr758ul
         808ebSgLPWiekg9hOISXF4uGwukxLkDFRo4rbmveCDnxkfpb1mDRskHVWreUO4nS2gNh
         tQMyvRepeFpKuFKiIH/WDTf+lPsWnNHdhVpI82PuHFtAQ12TNacCbkVVL+aWLXHFnW/v
         jYs/67OzaQYW3qmyRQNdBKoyoGTExsmfAhSGuVTcog/mNGwvDEG/EUbWeBIxCHIBhlTQ
         d3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4z4Zl/LOsxc1sy3yp5yW/Ng9/mWPVR4OkXBYaR7AnTQ=;
        b=acms7yCY5z/m+cUWK6cJHPbAzHKdpKAjZmbA3gG0GJ4MoIGL5Rlna6je7tBMsBmCL/
         sG9Jk1QnWnWUYRQNcTMoPjRMz043jb7MCH9Lb3YFgSHHf0FimLzZ7fKRs7uHqLGWu7VN
         +kEaD5xieFqe6cN6xwx2dlvMcwMeWOSrsaNx7aD5bpAMl+Km+6sgWYU6Tl/vI4izUWyQ
         WWow5TtNkUl5Kh4Im+i6iWF0CKySYg4/BzRLRXIDZS89y6DJxLICRHyNA5XvvRPI/eQ1
         ooS8Q91l4esZrkl+xy8XCrSL5A4i837kMlMYWV+vNsKQodsbzjgoj45NwRYPE0fuG8qI
         O2xg==
X-Gm-Message-State: AA+aEWbpLcQ7urjnllcINmlTbzQFfITgpbO88PRi1wcYWnCkLB+V9Nqh
        MAvsfqmJfdUzeB1mfQsfwAU=
X-Google-Smtp-Source: AFSGD/V37GKKlyDQ04fAPp35tBHoyyitenalR2Te1Bmr2j6lVdAZ/ydKVmiKxW4OXIwiIN44DxYjmg==
X-Received: by 2002:a2e:a202:: with SMTP id h2-v6mr3041893ljm.72.1543561651214;
        Thu, 29 Nov 2018 23:07:31 -0800 (PST)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id 4-v6sm620493ljw.84.2018.11.29.23.07.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 23:07:30 -0800 (PST)
Subject: Re: [Xen-devel][PATCH 1/3] xen: Introduce shared buffer helpers for
 page directory...
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        alsa-devel@alsa-project.org, boris.ostrovsky@oracle.com
Cc:     Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20181122100230.14976-1-andr2000@gmail.com>
 <133b948f-fc31-4505-0b85-5fc7a7beb559@gmail.com>
 <f802385f-3c78-2804-9e47-b590a9580955@suse.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <ee394331-282e-9942-a576-73cf714b620e@gmail.com>
Date:   Fri, 30 Nov 2018 09:07:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <f802385f-3c78-2804-9e47-b590a9580955@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/18 8:50 AM, Juergen Gross wrote:
> On 29/11/2018 12:22, Oleksandr Andrushchenko wrote:
>> ping
>>
>> On 11/22/18 12:02 PM, Oleksandr Andrushchenko wrote:
>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>
>>> based frontends. Currently the frontends which implement
>>> similar code for sharing big buffers between frontend and
>>> backend are para-virtualized DRM and sound drivers.
>>> Both define the same way to share grant references of a
>>> data buffer with the corresponding backend with little
>>> differences.
>>>
>>> Move shared code into a helper module, so there is a single
>>> implementation of the same functionality for all.
>>>
>>> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> In general I'm fine with this approach.
>
> With the concerns raised for one of the other patches I wanted to wait
> for V2 of the series.
Ah, I waited for any comments before rolling v2 out ;)
>   Or won't the resulting change require a
> modification of this patch?

This patch won't change, it is only DRM related

The concern for the DRM patch is already resolved

and the corresponding patch is on review now [1]

>
> It would be nice if you could point out in the commit message whether
> you are doing code movement (with some renames) only, or if there are
> any functional changes involved (and which ones).
Sure, this is pure code movement, no functional changes
>   This would make the
> review much easier and less time consuming.
>
>
> Juergen

Thank you,

Oleksandr

[1] https://lkml.org/lkml/2018/11/27/811

