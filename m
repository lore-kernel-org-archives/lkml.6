Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3481772-1522279518-2-8170533599480143399
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522279518; b=EwqNnkWyUZrGmztT2MnilOQfDKrkYQDJuY5KSlU+ngXtx1l
    dkJ7HvS6hENko5ncyvvSs9VGw6llF4LDt3ca5O7TrAr3tui3FmqNax8RtQQ91Pln
    aRfH6NABHTRhNaDoEqtGwjXh6WWqc4LV8Laea+xt2lqQfS7LJAX9p6ETDx1pVFuP
    QjXs/g/TaGZC8zI/w1MyvLgfVjMNZldNxJFJzcWgfB70zm+sUOanGcESD9PBN/iS
    7q+SlDAR6D6NUqY5hTJfhnL1+DsIGujrIWNtD+4/jTb2OuGuJkgFcYT+BzsN1Uxw
    fpilpawlyuhvFg1F/HSApI8JTAXkD3qIIPgdepg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:references:in-reply-to:subject
    :date:message-id:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1522279518; bh=3qkfpTwRSCTLWmdZzfftyRB7cgfAhiAyaZJSg6NRTDM=; b=X
    8iMkEu573zoSFS0n3wxDpU5ZCxZXOWnxCpRyu07HvImC7uTOym57OHGGn7Y1Gco5
    5KBINsB4Nse0dLkwIFWnP2PxFBlRjf5ad2a0rtPISeGDDDYkEewD/RbhNlu/SpgV
    qKkocJ+Te75igqaEsQRmBBnUxO0Xax3g4PF/nQLtT2Zt3m68UWiBUGA86nyLUDLd
    +QymxkZ/vZhxsRf6xJQk+ILOW1eyA6i0Lr0Y6w6lzAwRdwIXy0RUjGrIGxtyQsPn
    +/pV61lRIAWzfLIENXuIS7/gEFdlVgwVolO07xq45IuS5No24AdY6mLuEOZQeNo8
    Ld4CYDPoC3L1Pm0mniDfA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b=bvAy1nzW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=networkplumber.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=VZGw34KV;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=networkplumber.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b=bvAy1nzW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=networkplumber.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=VZGw34KV;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=networkplumber.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfImhgKQXAX1JaoMFdMhmS9ey/sR0HFzDY9wIpZJUxbkkGl5XB8XeJuASm9i5Mx48WpWHRxTVSU4AYDyCIYeW1DkZtlsfAa5/nhOKdsYofBy6Qa+1IIuR
    Hmk7PYRAVKzDqjSUb8rO392eDS/trfa2rFWIdX4LQzSWeroVk8frM3Jer3EQoQkybaZqNH+kUxISXVVi6NWLN4W4XALSlM+DHm827XeGaqy18mSS/z/xzMVe
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=m8AHRWq2AAAA:8 a=jZVsG21pAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=VwQbUJbxAAAA:8 a=DDOyTI_5AAAA:8 a=DfNHnWVPAAAA:8 a=20KFwNOVAAAA:8
    a=UqCG9HQmAAAA:8 a=E0xmm0h-2aahDCBKT0QA:9 a=QEXdDO2ut3YA:10
    a=K0Orbs2h8twofKcyOGf_:22 a=3Sh2lD0sZASs_lUdrUhf:22 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=AjGcO6oz07-iQ99wixmX:22 a=_BcfOz0m4U4ohdxiHPKc:22 a=rjTVMONInIDnV1a_A2c_:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750774AbeC1XZQ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 19:25:16 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:40099 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbeC1XZP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Mar 2018 19:25:15 -0400
X-Google-Smtp-Source: AIpwx4+jQlN5+UBE1w4TBN2lago7BmrOwVaNjtaZy8v3jog9JN8eozj//imgB3qsC/aScpFeP9fYFQ==
From: "Stephen Hemminger" <stephen@networkplumber.org>
To: "'Joshua R. Poulson'" <jrp@pun.org>
Cc: "'K. Y. Srinivasan'" <kys@exchange.microsoft.com>,
        "'KY Srinivasan'" <kys@microsoft.com>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <devel@linuxdriverproject.org>, <olaf@aepfle.de>,
        "'Andy Whitcroft'" <apw@canonical.com>,
        "'Vitaly Kuznetsov'" <vkuznets@redhat.com>, <jasowang@redhat.com>,
        "'Leann Ogasawara'" <leann.ogasawara@canonical.com>,
        "'Marcelo Henrique Cerri'" <marcelo.cerri@canonical.com>,
        "'Stephen Hemminger'" <sthemmin@microsoft.com>,
        "'Michael Kelley'" <mhkelley@outlook.com>,
        "'Stable'" <stable@vger.kernel.org>
References: <20180305052408.19475-1-kys@exchange.microsoft.com> <20180328120142.7ba72aa2@xeon-e3> <CABHrTi+pMjYX4jqaaXS=X02o7CbWBqdMMwcyrxo=BywV18n7WQ@mail.gmail.com>
In-Reply-To: <CABHrTi+pMjYX4jqaaXS=X02o7CbWBqdMMwcyrxo=BywV18n7WQ@mail.gmail.com>
Subject: RE: [PATCH 1/1] Drivers: hv: vmbus: Fix ring buffer signaling
Date: Wed, 28 Mar 2018 16:25:11 -0700
Message-ID: <03e101d3c6ec$05828e20$1087aa60$@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIXJVKPxVxvEmfw2GlV/rYeOH2oWgLJIZd1A4wSEfCjLOO1MA==
Content-Language: en-us
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True; MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47; MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=sthemmin@microsoft.com; MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-28T23:25:11.5486283Z; MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General; MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure Information Protection; MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic; Sensitivity=General
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Thanks, I hadn't updated to rc7 yet


-----Original Message-----
From: Joshua R. Poulson <jrp@pun.org>=20
Sent: Wednesday, March 28, 2018 12:18 PM
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: K. Y. Srinivasan <kys@exchange.microsoft.com>; KY Srinivasan =
<kys@microsoft.com>; gregkh@linuxfoundation.org; =
linux-kernel@vger.kernel.org; devel@linuxdriverproject.org; =
olaf@aepfle.de; Andy Whitcroft <apw@canonical.com>; Vitaly Kuznetsov =
<vkuznets@redhat.com>; jasowang@redhat.com; Leann Ogasawara =
<leann.ogasawara@canonical.com>; Marcelo Henrique Cerri =
<marcelo.cerri@canonical.com>; Stephen Hemminger =
<sthemmin@microsoft.com>; Michael Kelley <mhkelley@outlook.com>; Stable =
<stable@vger.kernel.org>
Subject: Re: [PATCH 1/1] Drivers: hv: vmbus: Fix ring buffer signaling

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?h=3Dv4.16-rc7&id=3D655296c8bbeffcf020558c4455305d597a73bde1

On Wed, Mar 28, 2018 at 12:01 PM, Stephen Hemminger
<stephen@networkplumber.org> wrote:
> On Sun,  4 Mar 2018 22:24:08 -0700
> kys@exchange.microsoft.com wrote:
>
>> From: Michael Kelley <mhkelley@outlook.com>
>>
>> Fix bugs in signaling the Hyper-V host when freeing space in the
>> host->guest ring buffer:
>>
>> 1. The interrupt_mask must not be used to determine whether to signal
>>    on the host->guest ring buffer
>> 2. The ring buffer write_index must be read (via =
hv_get_bytes_to_write)
>>    *after* pending_send_sz is read in order to avoid a race condition
>> 3. Comparisons with pending_send_sz must treat the "equals" case as
>>    not-enough-space
>> 4. Don't signal if the pending_send_sz feature is not present. Older
>>    versions of Hyper-V that don't implement this feature will poll.
>>
>> Fixes: 03bad714a161 ("vmbus: more host signalling avoidance")
>>
>> Cc: Stable <stable@vger.kernel.org> # 4.14 and above
>> Signed-off-by: Michael Kelley <mhkelley@outlook.com>
>> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
>
> What ever happened to this patch? It doesn't seem to be in char-misc, =
upstream,
> or stable kernel tree yet.
>
>
