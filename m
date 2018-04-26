Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3094820-1524771282-2-13032415311360756515
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524771282; b=dcjx6VypXOfIR9vx89wuJQoJNVnVEXhdoOXpoUjPS4Uvgd9W8i
    uSnMevTUYPEXVP6HCsgQLFttyeDal7G7cbjLao1akhh1axyE47cXDEze3K/1kD0M
    Nj84mp/pcs094fGWd085KN8HRMVAQQ9uD3ofOdbGrWu+alHZ3nSGCFNE1TvmBmsn
    Xho4zkXzo8i4Y9WKBzpZH9sUNhBLc9cF5JSkn8DbU+NkGsQ45HNfvQqx6LlCrPJK
    xs8v0zZmkux4VHtEddXMobpDN9RK4tKuc02+dM570lcrNgUkE7IQ88vR34jAiTsB
    c0T/5rpvkYDXQdfSBAojtBWvohQqeYH7HXzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524771282; bh=GXL0JXfJfMqQqwDyLQZtd7Yh3kT8j57TJK0lgBuAXZ
    8=; b=Blm2+UKjIT2iVlb6+KD92VU0q4G0urRDklrpW8wWSFw0Du51IAcd17Yg0G
    G+3juZp5RWEZaCYvK3dyXprUBol80DO8sUvCrKHM6vxul4mWzrwIihC78sTaEC73
    uItJ/NxCKWp1cgG6bbLuz4B6KFDuK7ZjI4aVkMgvaPletD9BuU7Od/mz2aSYKtkT
    kOGLqtJGs/Se6mAMPXZwGI6yR7deyJWSl+DU740AgWyu3W8S0LmXBqMty1SCTjCg
    qRHU/DHr1CQitJqpx6SU09d7KBMpNi+rfZIOI6bwFlUYa16TMxDlDZLG1Q3ku0WW
    KuSgFUiO9j2qp/c4Q/Jlqhnx52mQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=hDlBkEPD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=o8hUIjzu x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qxkWwHTB;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=hDlBkEPD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=o8hUIjzu x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qxkWwHTB;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMFuhQ3UynNaqSxqlOQHWmI2zicHkxL/emPvL/nkycekZgoX43v3n93jZ79ATBG4g6OjhkVIVq0okj49NcxwMGEUx3NIjUmiVaLVlla1K+jEIp3Lzgky
    bWDf9w8sWzfw4qs2NwBfP/tmRsS+ZRMABbE7+uLMF5TD2cJ0Rw/E+fRflTR26rs0oscbhbqx+nGr7XqtimTocScVdFJpJC472lK92NvDFTdb9OrMZ95A9elu
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=J1Y8HTJGAAAA:8 a=Oh2cFVv5AAAA:8
    a=_V4o_vk5AqIqhsj2RfsA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=7KeoIwV6GZqOttXkcoxL:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753652AbeDZTeW (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 15:34:22 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:36817 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752826AbeDZTeV (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 26 Apr 2018 15:34:21 -0400
X-Google-Smtp-Source: AIpwx4+CQQPicqf20oZlP5Hc4Usr7pX0Gf9c5E8/SbThwpvUg6e064z2kV/oxO0buJkzGY7ZLrw+3VYwvF5j/wk96r4=
MIME-Version: 1.0
In-Reply-To: <CAJKOXPcD2O8KhyrNj58fMRishdscVf9VoybWfMjezuZdETuibQ@mail.gmail.com>
References: <1524650077-13270-1-git-send-email-krzk@kernel.org>
 <CANEJEGsTh671Gezgq6dAMu5e1PT_J3GiJ1ypDPPORt86N3VH=g@mail.gmail.com> <CAJKOXPcD2O8KhyrNj58fMRishdscVf9VoybWfMjezuZdETuibQ@mail.gmail.com>
From: Grant Grundler <grundler@chromium.org>
Date: Thu, 26 Apr 2018 12:34:19 -0700
X-Google-Sender-Auth: 3F3_v9m2B1bEEEAqJpl0s1CbjZo
Message-ID: <CANEJEGtvz4BErDHuq5VzWsKD92wYCtKtuwyPQ9af=i+VwYLYPQ@mail.gmail.com>
Subject: Re: [PATCH stable v4.4+] r8152: add Linksys USB3GIGV1 id
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Grant Grundler <grundler@chromium.org>,
        Oliver Neukum <oliver@neukum.org>,
        "David S. Miller" <davem@davemloft.net>, linux-usb@vger.kernel.org,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 12:56 AM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Thu, Apr 26, 2018 at 2:40 AM, Grant Grundler <grundler@chromium.org> wrote:
>> On Wed, Apr 25, 2018 at 2:54 AM, Krzysztof Kozlowski <krzk@kernel.org>
>> wrote:
>>>
>>> commit 90841047a01b452cc8c3f9b990698b264143334a upstream
>>>
>>> This linksys dongle by default comes up in cdc_ether mode.
>>> This patch allows r8152 to claim the device:
>>>    Bus 002 Device 002: ID 13b1:0041 Linksys
>>>
>>> Signed-off-by: Grant Grundler <grundler@chromium.org>
>>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>>> Signed-off-by: David S. Miller <davem@davemloft.net>
>>> [krzk: Rebase on v4.4]'
>>
>>
>> thanks krzk!
>>
>> FTR, to support RTL8153B (HW ID 0x6010), the follow patch series to bring
>> r8152 v1.09.9 driver from 4.14 kernel.org to 3 (of 5) older Chrome OS
>> kernels:
>>
>> 3.14:
>> https://chromium-review.googlesource.com/q/topic:%22update_r8152-3.14%22+(status:open%20OR%20status:merged)
>> 3.18:
>> https://chromium-review.googlesource.com/q/topic:%2522update-r8152-3.18%2522+(status:open+OR+status:merged)
>> 4.4:
>> https://chromium-review.googlesource.com/q/topic:%2522update_r8152-4.4%2522+(status:open+OR+status:merged)
>>
>> caveat: These series are not suitable directly for kernel.org submission
>> (extraneous stuff in the commit messages, order is different). Using the
>> original SHA1 (in each commit message), this can all be fixed up by
>> hand/simple scripts.
>
> Hi Grant,
>
> These are regular feature/patch backports so they do not fit into
> stable process. Only new quirks and IDs are accepted for stable.

Hi Krzysztof!
Sorry, I wasn't advocating for -stable inclusion. I shared in case
someone has unusually high USB ethernet requirements similar to Chrome
OS test lab which nearly all dongles I've tested can't provide.

Chrome OS test lab needs a USB ethernet dongle that reliably
negotiates a link (e.g. 10k iterations in a row). RTL8153 in general
are good (> 99.99% gets GigE link speed) but RTL8153B is the first
dongle that meets Chrome OS test lab requirements. The patch series
above is required to support RTL8153B.

cheers,
grant
