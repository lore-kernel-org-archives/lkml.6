Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7D6C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 21:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E78AB2098B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 21:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePzXtZgM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E78AB2098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732425AbeGJV2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 17:28:00 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45765 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732258AbeGJV2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 17:28:00 -0400
Received: by mail-lj1-f193.google.com with SMTP id q5-v6so17832751ljh.12;
        Tue, 10 Jul 2018 14:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ujz4uCqvy2C3RwVtFydCQSKJ7JZKcbcdcnhq17P3a0E=;
        b=ePzXtZgMi+JSFYkv/X/deOSMpG7NTa5LYkhrvb461j2jdixS1DYPMNKNmlg0yElgsj
         NoyuStNN5vKYzg7yS+TXizvAc3a1bvbA/cqAxxnqZNcUGeXoc1reC0Y0XmLhWwKpWxZ/
         l7BLS20e23/ESbrHCwqlXy1LVYsnJ3ZPUTAOedXEzVyFH6uK1eDLnZNI3EF1gH5zvaUL
         vw5PNIEcIa4byqDNtWv6JxVcnewloZBpg33tHHslNG+irhatIB10/3PjuIuZw4VCtQ1V
         JiA6pPstjUU3HkNwx8x6109Vs7GM34/9yXbiVOJyT3JD3XGo26O8Ix9jDB477SDQKk8a
         cIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ujz4uCqvy2C3RwVtFydCQSKJ7JZKcbcdcnhq17P3a0E=;
        b=Vi8zJaps3lz3xoZRN1mWOQo3DOc3dnb7CLRvTRZaJzIYFkFJbPBDlxX+SqlDXV3Caf
         tpfUJimpnohZuc/PRLye5zxGJ4kSCd2vgICEtjRigLQLscoP5M/6c3QPPdeN8bhVLSvW
         n9pDvLCN82OZtXiTml1aCGNyX9DGyHP7hlQVHj+ihvrOoLEgaggBJSTfSA0YuKL+y21t
         ejvpwuOjjfTYiKni7KKFiyVTzI2/YoG8a3jqJsc5KJJXK/4Cpp7Zgt+IntOfoNco8IUC
         da4+xG17vbwIzZS+x3yh9Xmkmtj4JkxhjNNESAAG/GFhJslgV/hOVrTrixe1RymR49gj
         8jUw==
X-Gm-Message-State: APt69E08O2ywU3MyyRo4N40+c6NH7VeLFZB/SArnU9tCzLIt27rrnzeT
        keBUf+S0toXGPT0PtGTdIkNQ/YuzEcTsgSluLg8=
X-Google-Smtp-Source: AAOMgpeevHYoFZC0GNDUkauNvAFSMzm95S1mSfBipxsHyMGsPmHs+A0jpN3yF6q3kfOGj5QwqAJ02DpaDcpgSO0GFi8=
X-Received: by 2002:a2e:1207:: with SMTP id t7-v6mr16731651lje.129.1531258021307;
 Tue, 10 Jul 2018 14:27:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 14:27:00
 -0700 (PDT)
In-Reply-To: <20180710204736.GU20303@art_vandelay>
References: <20180618153959.2169325-1-arnd@arndb.de> <20180710204736.GU20303@art_vandelay>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 10 Jul 2018 23:27:00 +0200
X-Google-Sender-Auth: nfKAjk8a7L9cIxkLNDRRU2SeE4s
Message-ID: <CAK8P3a0j7O8MdpxiGNKfrRB5Sdx0UJzH_=4diRw6a-0TKoUAdw@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: avoid using 'timespec'
To:     Sean Paul <seanpaul@chromium.org>
Cc:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 10:47 PM, Sean Paul <seanpaul@chromium.org> wrote:
> On Mon, Jun 18, 2018 at 05:39:42PM +0200, Arnd Bergmann wrote:
>> The timespec structure and associated interfaces are deprecated and will
>> be removed in the future because of the y2038 overflow.
>>
>> The use of ktime_to_timespec() in timeout_to_jiffies() does not
>> suffer from that overflow, but is easy to avoid by just converting
>> the ktime_t into jiffies directly.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  drivers/gpu/drm/msm/msm_drv.h | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
>> index b2da1fbf81e0..cc8977476a41 100644
>> --- a/drivers/gpu/drm/msm/msm_drv.h
>> +++ b/drivers/gpu/drm/msm/msm_drv.h
>> @@ -353,8 +353,7 @@ static inline unsigned long timeout_to_jiffies(const ktime_t *timeout)
>>               remaining_jiffies = 0;
>>       } else {
>>               ktime_t rem = ktime_sub(*timeout, now);
>> -             struct timespec ts = ktime_to_timespec(rem);
>> -             remaining_jiffies = timespec_to_jiffies(&ts);
>> +             remaining_jiffies = ktime_divns(rem, NSEC_PER_SEC / HZ);
>
> Do you need to wrap rem in ktime_to_ns() just to be safe?

The ktime_t interfaces are still defined to use an opaque type,
as previously it was a union that could be a seconds/nanoseconds
pair depending on the architecture. These days, ktime_t is just
a 64-bit integer, so div_u64() would work just as well as ktime_divns(),
but this is the documented way to do it.

      Arnd
