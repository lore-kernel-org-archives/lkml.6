Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-220864-1523918831-2-7860113560444473085
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523918830; b=Uz/bo5IxQwe/nWFxJsW8W9TKWMd5MsYzcWO8zVdzTWzUxp4z21
    KCztm/haRcjfwTnc8CS8eNie8yX8NP1uNLALxKd8XP3v1IlFMlEtr/BVDS8NdO0U
    SscUVNVHN/cKhYJtE1Hue9eE/7iPYzuBxtJyKRmhTEM33lgtIBeU//KErkCBVnQQ
    Pae87Yb/vOuEOpDJbww2GBQDQDZTTnvjdkWqK2EV82IWTZxu0OoWLm3nFGmn9H9a
    b1f+vN1Tp8fGXo1V7N74PwETthVqf+Fo9hL4p6qIhN2Fhxy8rXxVEBOe2I3y4mvA
    dI+mnSdyV8VDhL3T9IaM3Pk09loafQ51OwXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523918830; bh=H902M7EN67
    fqeFE/C/ZpbDPnvc85XRHvlsDLGwBmHoM=; b=oVLptB9V0WRbKCHfoONBcFuf3Y
    ojLbOAy6iEVG4Ts3mbLNyRw09k3wBWoiMnIbr5HShp4pYunCkXPNXnDKq22fWGk5
    RAz70d1024MdCQpzFE7+i47bFdKM6Q2/EAs8wxCViUGPjwSKW7CbDmD5+IMs4bYU
    At753Hw9Amz0CQ2QDtBsozEyNYYv+Q8NxstHx1qYoh1jHf2AjW4slIZhvfRvt6Wh
    wyuPW4x08JA/Iql58RnURCU5gZKvbOo79J3R1MspPVsdF209whrSOddkDWZQhVtP
    BmrWljQAY315UEBSUdQGEMk0gEGK6FjdsgZ7Mw/YliKzqz2mABYY9D1aE9SQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPUPtvXmU0B5lvfOIoKmvtnE5UBp8XdVdlcCE4EbLAPjjc89hfSt2ZCIEL0x5R+2HWPy0exz7J8qcEwZHaSocCoSNI+Cuxjeq6+I0EBhbEhQoI1e47Sw
    p8cM3EHfZVKtk3k3wds9FQWKSyfofjSKoMnuRf/LIfS9FJyhCcDgJyvpmL5ZMzpksjIKJGuzp/LO1GgU8dfXVit/gJb6zAAObgWKwlGK4pYoSNf/VUAwIavT
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=MJJdeXxr-TQA:10 a=kj9zAlcOel0A:10
    a=Kd1tUaAdevIA:10 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8 a=ag1SF4gXAAAA:8
    a=VwQbUJbxAAAA:8 a=e5mUnYsNAAAA:8 a=riMJuovTzz6P4l8tzVkA:9 a=CjuIK1q_8ugA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22 a=Vxmtnl_E_bksehYqCbjh:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751211AbeDPWrI convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Mon, 16 Apr 2018 18:47:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:65167 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750972AbeDPWrH (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 18:47:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,460,1517904000";
   d="scan'208";a="33859095"
From: "Srivatsa, Anusha" <anusha.srivatsa@intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
        Ian W MORRISON <ianwmorrison@gmail.com>
CC: "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        "Wajdeczko, Michal" <Michal.Wajdeczko@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: RE: [RESEND PATCH 1/1] drm/i915/glk: Add MODULE_FIRMWARE for
 Geminilake
Thread-Topic: [RESEND PATCH 1/1] drm/i915/glk: Add MODULE_FIRMWARE for
 Geminilake
Thread-Index: AQHT0U+MMfUZJD2+9UaqWtmyL0or/6P7wKGAgAAVhACAAB1iAIAID5cA
Date: Mon, 16 Apr 2018 22:47:05 +0000
Message-ID: <83F5C7385F545743AD4FB2A62F75B073338FD128@ORSMSX108.amr.corp.intel.com>
References: <20180411044213.383-1-ianwmorrison@gmail.com>
 <871sfmhz88.fsf@intel.com>
 <CAFXWsS_SvkLvJcibx9LoUw+onN-AAzSLMrRgx3U3hsbMVyty2g@mail.gmail.com>
 <87lgdugc85.fsf@intel.com>
In-Reply-To: <87lgdugc85.fsf@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiM2M1OWRiYzktZTllNS00YzM4LWI3N2MtYTAxYWMyNDM0NjhmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJkNzNDYjBTbXZ3SVc4OWFWclJJdThmNHp1YnI2WExpSWlIcjRzYXV4Tjc5azBTRTZHNkhKZElqVjF3VG1nUm85In0=
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



>-----Original Message-----
>From: Jani Nikula [mailto:jani.nikula@linux.intel.com]
>Sent: Wednesday, April 11, 2018 5:27 AM
>To: Ian W MORRISON <ianwmorrison@gmail.com>
>Cc: Vivi, Rodrigo <rodrigo.vivi@intel.com>; Srivatsa, Anusha
><anusha.srivatsa@intel.com>; Wajdeczko, Michal
><Michal.Wajdeczko@intel.com>; Greg KH <gregkh@linuxfoundation.org>;
>airlied@linux.ie; joonas.lahtinen@linux.intel.com; linux-kernel@vger.kernel.org;
>stable@vger.kernel.org; intel-gfx@lists.freedesktop.org; dri-
>devel@lists.freedesktop.org
>Subject: Re: [RESEND PATCH 1/1] drm/i915/glk: Add MODULE_FIRMWARE for
>Geminilake
>
>On Wed, 11 Apr 2018, Ian W MORRISON <ianwmorrison@gmail.com> wrote:
>> <snip>
>>
>>>
>>> NAK on indiscriminate Cc: stable. There are zero guarantees that
>>> older kernels will work with whatever firmware you throw at them.
>>>
>>
>> I included 'Cc: stable' so the patch would get added to the v4.16 and
>> v4.15 kernels which I have tested with the patch. I found that earlier
>> kernels didn't support the 'linux-firmware' package required to get
>> wifi working on Intel's new Gemini Lake NUC.
>
>You realize that this patch should have nothing to do with wifi?
>
>Rodrigo, Anusha, if you think Cc: stable is appropriate, please indicate the specific
>versions of stable it is appropriate for.

Hi Jani,

The stable kernel version is 4.12 and beyond.
It is appropriate to add the CC: stable in my opinion

Anusha
>BR,
>Jani.
>
>>
>>>
>>> PS. How is this a "RESEND"? I haven't seen this before.
>>>
>>
>> It is a 'RESEND' for that very reason. I initially sent the patch to
>> the same people as a similar patch
>> (https://patchwork.kernel.org/patch/10143637/) however after realising
>> this omitted required addresses I added them and resent the patch.
>>
>> Best regards,
>> Ian
>
>--
>Jani Nikula, Intel Open Source Technology Center
