Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF669C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65BF223F97
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="fm/b+uzv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65BF223F97
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753906AbeFVJ1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:27:02 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55670 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751297AbeFVJ1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:27:00 -0400
Received: by mail-it0-f68.google.com with SMTP id 16-v6so1976285itl.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 02:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Md/910clLWggldptlIQB4OIGYDcDTe6jCwRI0nd4OTA=;
        b=fm/b+uzvjuqs1+/NvXFwd6D2N9lszgiBJKGTKLSCKx1lzR4tU2V6KHFUNn+Lxnfvuf
         yAx4ZNhkOIrASemjak6CZ9j5AMWzJavBhKxyh7FXxPYdqLxb6o+4Sr2DRSCTVLP5OmOX
         HQ33ovaN0ko0n+0ZnYtr4QLd0w04sXd20/4yFrIN8TzUCUMZOksTweELZKYHQG9IiWMY
         Owh8Y0w8osED0oID8jCs5bqFKOwg547p/kcX0ntAiKD3UQFz8bsaCOULYeYbS3odOiUB
         mGu9y+1DLhIHzPmaw5A6OrtiyNT9Q1IcHhC2HyT58Yj7tbpCayj8B/yYTDLFNsewto/A
         9nkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Md/910clLWggldptlIQB4OIGYDcDTe6jCwRI0nd4OTA=;
        b=pQnZLYKuAUlLlmvck6Nx29GAebXtAzCSNlAEDIQK2yXwjXrPUZ0uAJA20kspzPFSoz
         lqnzNy2Wl+XIbmj6Q9FsFE2tcnU4acVgYyKzhrqL2LitX1Z7bTn4AxHeBB1xxUFs1ARE
         2GeF8zESGEeSmee+iXHWIEW7IbdNoMBmeCrkpuj8JBxbm0005ofkjhhVNdDQCJ1fcz0G
         8R7f9PVKurkibpE4FnTO25Z5aRG/mJISxju5GdtLkxLdL2Wz0TkeXVuOm62Ql7zT8i4Y
         rpLtoL/sLZzlTG85xBT1dLLLP14BmZDm23G6B8AwU+ybRwMcdA/SJuV4jwtfKzRrUnQR
         8QoA==
X-Gm-Message-State: APt69E1aQgZHjzSJmts9PptKbHMy0Z58XLqnARU1ceEoMgIjR9QXkjfO
        EYF+sMNsbGNUYJ4idRdEEuGDgnAG1jDrnP9FPwSA6w==
X-Google-Smtp-Source: ADUXVKIpSldEK5YHYTfT6PEgvQoGM8xMxOHasuPCExFRnFgnAt0uTcUh6Q63JNWbckvMNTHthYNaYkejr5NIwVu0l68=
X-Received: by 2002:a24:82c2:: with SMTP id t185-v6mr944280itd.117.1529659619420;
 Fri, 22 Jun 2018 02:26:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:73d5:0:0:0:0:0 with HTTP; Fri, 22 Jun 2018 02:26:58
 -0700 (PDT)
In-Reply-To: <CAPpJ_ee0xxW69GPi8A2RvUUv=O4gesYCbOKiCngLrHi4hk0T7A@mail.gmail.com>
References: <20180525095452.5203-1-jian-hong@endlessm.com> <CAD8Lp456sVtCrC0cMHXQV-PCXq12GfOjtmCpwuguF_=c-1YyaA@mail.gmail.com>
 <CAPpJ_ee0xxW69GPi8A2RvUUv=O4gesYCbOKiCngLrHi4hk0T7A@mail.gmail.com>
From:   Jian-Hong Pan <jian-hong@endlessm.com>
Date:   Fri, 22 Jun 2018 17:26:58 +0800
Message-ID: <CAPpJ_ed-OvXr-hj0yZraKN3ROZPCkAgS8qT3rc9WCJt+mYq3hg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add a new Realtek 8723DE ID 0bda:b009
To:     Daniel Drake <drake@endlessm.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Bluetooth mailing list 
        <linux-bluetooth@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch is already tested and confirmed by our colleagues in Guatemala.

Regards,
Jian-Hong Pan
.........................................................................


Jian-Hong Pan  |  +886 2 7712 8713  |  Endless


2018-05-25 22:05 GMT+08:00 Jian-Hong Pan <jian-hong@endlessm.com>:
> Hi Daniel,
>
> 2018-05-25 21:25 GMT+08:00 Daniel Drake <drake@endlessm.com>:
>> Hi Jian-Hong,
>>
>> On Fri, May 25, 2018 at 3:54 AM, Jian-Hong Pan <jian-hong@endlessm.com> wrote:
>>>
>>> Without this patch we cannot turn on the Bluethooth adapter on HP
>>> 14-bs007la.
>>
>> Please correct me if I'm wrong, but it looks like we are still waiting
>> for the testing of this patch from our colleagues in Guatemala.
>>
>> There are unlikely to be any issues with such a trivial change, but we
>> should probably wait for confirmation that it works before having it
>> included upstream.
>
> Oh, sure!  That will be better.  Thanks for your reminder.
>
> Thanks,
> Jian-Hong Pan
>
>> Thanks
>> Daniel
