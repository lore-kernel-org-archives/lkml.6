Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2226753-1524729431-2-14520155979590677217
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524729430; b=scKO2+7EYkKQwmuDZ8S/hbOgRLYB3ZImPHVVmFOV5bU4kIox2C
    T7Go/Nh0kSwsNOFSBUskJ7H8yacbTd749sJPBFIWpT5mXOU9Z2TFolVTcqnUhvrz
    ZG240fZ7EwUwv7iS8i9qKyic6EAlLRKaNyIOkP6VBYjPDmyl7a5RXhfg8tmkPbq5
    UXHtI4HdjArstsiOkcqS8osStaB0RNd9syE8dnddZ8sR+uyCNjr9ebeO7tf/TmJ4
    DInSx82bGMy0y4zTjutgE/7Fw8BNSBll0VxKvI3O9a4Z1jl/UL7Wu36TMJHPRpxV
    Av9QUhldakGta5yqeOLTt4y3v8Bl691KnTKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524729430; bh=kfn407Uomx5IasPFI+QZpUFbjDmBNQqB2WgfYo6AIY
    Y=; b=n+Zt4Y71cK+3rI/u0knIDtYIxqdnbtQmRFbQ9anm/4yqGtIXeHMftPMcQ5
    3ahkOZiOggGLlfJwQf/YFd5Kk7BuYwPerxGVQaO474UWDXYqVycV1yhf/jRqGLpB
    vq8/fhqhefmhZ1+6+qg/Z0+AxHOzJdzHrKofhGa9dzy/SOxvcVCZ6FY+33kq/MYU
    XgP6/rGYznYpLn1+wwz4qezEvPE4a8KZMjDlQq7K05KTYU5fFExIWUTCL7akRTuC
    LAHs+StlMfDwjqDVs6miasOW6S2jhXfYtJfcLaeXhPJ13Ky7A/wbmfmnviNV0bHU
    vLf0b49bHEprMUi0JgbJxkF3i9qA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAKMoB7PLx0Q1UvpLQ1gkx65trOiWjTptelqwhBI6gVzD7NNNwIwlotXfSGZ5Kxpzvng7jxKs2T+6yJdluq/HrgcvCWuXgsH1FsyrMBXAqp2dZCSD9ID
    e378gko2K/R7zlJ8rH5dHOJLFBqjxjD3g515QjSMugIhvOnlobHqnEVJoqNKu3n3XPQ6FsAJo8eEfGmlWRkEolpoZMvrOpp2TL0m1Fo22ZQkNAIXt0zHJB4l
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=J1Y8HTJGAAAA:8 a=Oh2cFVv5AAAA:8
    a=bCupZFHGyneaY0O7Q_wA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=7KeoIwV6GZqOttXkcoxL:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754479AbeDZH5G (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 03:57:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:32826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754410AbeDZH47 (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 26 Apr 2018 03:56:59 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0964521745
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
X-Google-Smtp-Source: AB8JxZop5XXC4pF9BmtCDL7oQLCwf1w8mefHtIj5AEBybg8R5dUi5OT4kLYScdp6QmrRL4XF6zgw+R6HmWZrNMzqLcQ=
MIME-Version: 1.0
In-Reply-To: <CANEJEGsTh671Gezgq6dAMu5e1PT_J3GiJ1ypDPPORt86N3VH=g@mail.gmail.com>
References: <1524650077-13270-1-git-send-email-krzk@kernel.org> <CANEJEGsTh671Gezgq6dAMu5e1PT_J3GiJ1ypDPPORt86N3VH=g@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 26 Apr 2018 09:56:56 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcD2O8KhyrNj58fMRishdscVf9VoybWfMjezuZdETuibQ@mail.gmail.com>
Message-ID: <CAJKOXPcD2O8KhyrNj58fMRishdscVf9VoybWfMjezuZdETuibQ@mail.gmail.com>
Subject: Re: [PATCH stable v4.4+] r8152: add Linksys USB3GIGV1 id
To: Grant Grundler <grundler@chromium.org>
Cc: Oliver Neukum <oliver@neukum.org>,
        "David S. Miller" <davem@davemloft.net>, linux-usb@vger.kernel.org,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 2:40 AM, Grant Grundler <grundler@chromium.org> wrote:
> On Wed, Apr 25, 2018 at 2:54 AM, Krzysztof Kozlowski <krzk@kernel.org>
> wrote:
>>
>> commit 90841047a01b452cc8c3f9b990698b264143334a upstream
>>
>> This linksys dongle by default comes up in cdc_ether mode.
>> This patch allows r8152 to claim the device:
>>    Bus 002 Device 002: ID 13b1:0041 Linksys
>>
>> Signed-off-by: Grant Grundler <grundler@chromium.org>
>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>> Signed-off-by: David S. Miller <davem@davemloft.net>
>> [krzk: Rebase on v4.4]'
>
>
> thanks krzk!
>
> FTR, to support RTL8153B (HW ID 0x6010), the follow patch series to bring
> r8152 v1.09.9 driver from 4.14 kernel.org to 3 (of 5) older Chrome OS
> kernels:
>
> 3.14:
> https://chromium-review.googlesource.com/q/topic:%22update_r8152-3.14%22+(status:open%20OR%20status:merged)
> 3.18:
> https://chromium-review.googlesource.com/q/topic:%2522update-r8152-3.18%2522+(status:open+OR+status:merged)
> 4.4:
> https://chromium-review.googlesource.com/q/topic:%2522update_r8152-4.4%2522+(status:open+OR+status:merged)
>
> caveat: These series are not suitable directly for kernel.org submission
> (extraneous stuff in the commit messages, order is different). Using the
> original SHA1 (in each commit message), this can all be fixed up by
> hand/simple scripts.

Hi Grant,

These are regular feature/patch backports so they do not fit into
stable process. Only new quirks and IDs are accepted for stable.

Best regards,
Krzysztof
