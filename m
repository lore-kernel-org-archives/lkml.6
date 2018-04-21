Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2970889-1524273728-2-9681023708544240891
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
    1524273727; b=B3BGs/accWH2pBPiJhWs2DNPcRtK4ZQIfD6oZ+4nKj3BebAVMk
    XpXlE/nQ9b7ulY3l4SwsqUM+9UP2dEYd15pBJ9PStEzORdfmA9dq4okD0wbqhP8u
    fKh3NDEn9bUaaQBAlD3HNXOMlfY4j3iS2v7ABtH7aO5o4Ls51vmjoT5L0WR1Z4Uq
    BuQIPkIDdF2EjAGGQFcceUevRuksaP80Oo7CLo7FS0RKVqZ1C7Yqa5UesubDrCdJ
    pdenD+3a8ZPN7CN+R9O42bQEF7GYAWcrbKq7KOsq/UnLZDMOm4FWclG17W/dZnWj
    Kh+4+TWEGmHTZlB56e5mpYVfsE6ntVn/1Reg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1524273727; bh=+zKgZqB/fT
    v/5Bj18P+CSIBZOxfunRk0t4MvqlAT6g0=; b=M4vxjpp8roNTShYZzPInDwLQxO
    5AZMJf3Qnb+K5SIKOM895EEDWM0qcLwdGyBhy3V0xmkcvyUbRCl4KBRq26n0lVDA
    BdX4uBSGgTYP7rWMkxKxI/Lh487yDu2WR3242ewhp6+rgstHsRCTnHIof/xpW/xA
    fzKpWfO+xp/f/CYnu8oZVCQIn+srvifnruXzFXIZ+g96KppUQQF5Mrcw9sgk/EzE
    S7H5soFhdiq/VxGmHuaUzEcunF4TZDtZtt/CykTJY18YYsWv6vUX6gmfda4CcQ5s
    LxUwLCx7figxDsAW7WbtzCrybrChrYNut7+e4iUiYhSeKMFN/KmqaOkVmA5g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfOniUIsa+yg/DTBQbpjK+DXPnD7vg7p0usxUPX0Uzpmw+nBMJboadq/dsfmPNhq0neuoCr/jon3QI5Q2mgjnEQCL+MuS3bSQBg/83K0MVEZWj8UEsdfM
    S17h3FLqRQoGR/o7QkhAIzKiBbnSbpmTHYk9eupj3Vv/MeWea66AVSTZA3M1hs4ziRhuOuE7UNoXSY6B3xxKoN3/pITesIMUktwtF+jgox+Sx1hvCWUn6BXC
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=MsiYDRJF7IgA:10 a=kj9zAlcOel0A:10
    a=Kd1tUaAdevIA:10 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8 a=ag1SF4gXAAAA:8
    a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=y7AYohu5axt5313rgSUA:9 a=CjuIK1q_8ugA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=Vxmtnl_E_bksehYqCbjh:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbeDUBWD convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Fri, 20 Apr 2018 21:22:03 -0400
Received: from mga12.intel.com ([192.55.52.136]:61456 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752605AbeDUBWC (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 20 Apr 2018 21:22:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,304,1520924400";
   d="scan'208";a="43512815"
From: "Botello Ortega, Luis" <luis.botello.ortega@intel.com>
To: "Srivatsa, Anusha" <anusha.srivatsa@intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        "Martinez Monroy, Elio" <elio.martinez.monroy@intel.com>,
        "Vega, Ricardo" <ricardo.vega@intel.com>
CC: Ian W MORRISON <ianwmorrison@gmail.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Greg KH <gregkh@linuxfoundation.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Wajdeczko, Michal" <Michal.Wajdeczko@intel.com>
Subject: RE: [RESEND PATCH 1/1] drm/i915/glk: Add MODULE_FIRMWARE for
 Geminilake
Thread-Topic: [RESEND PATCH 1/1] drm/i915/glk: Add MODULE_FIRMWARE for
 Geminilake
Thread-Index: AQHT2NWgWvpJYzBMUEC0wyp8I7qceKQKadNw
Date: Sat, 21 Apr 2018 01:22:01 +0000
Message-ID: <F53FA74E706C9843B0288AE81EB4F4A35152EC4E@fmsmsx107.amr.corp.intel.com>
References: <20180411044213.383-1-ianwmorrison@gmail.com>
 <871sfmhz88.fsf@intel.com>
 <CAFXWsS_SvkLvJcibx9LoUw+onN-AAzSLMrRgx3U3hsbMVyty2g@mail.gmail.com>
 <87lgdugc85.fsf@intel.com>
 <83F5C7385F545743AD4FB2A62F75B073338FD128@ORSMSX108.amr.corp.intel.com>
 <87r2nefbnn.fsf@intel.com> <20180420180331.GE3304@intel.com>
 <83F5C7385F545743AD4FB2A62F75B0733390B83D@ORSMSX108.amr.corp.intel.com>
In-Reply-To: <83F5C7385F545743AD4FB2A62F75B0733390B83D@ORSMSX108.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTUzOTc3MjktMWNjYS00NDc5LWE1ODItOTRhMzFiMDNiZWQ2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJwSm9OZnNXUUpGZHJaaWFkek00QWFiNGpVVkhBUDhkZWNtckNRUkNxdVdyaUp0UUFYWlBkeGl6UDFhNnZGUkJLIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.1.200.108]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi all:

We tested GLK DMC 1.04 FW in last week of September 2017, using the latest drm-tip version for that time (4.14.0-rc2) and according to our results we could declare this FW as acceptable and healthy to be used with kernel version 4.14 . 
However, we cannot guarantee quality and healthy of this FW if it is used in top of current drm-tip kernel (4.17-rc0).

Best Regards
Luis Botello


-----Original Message-----
From: Srivatsa, Anusha 
Sent: Friday, April 20, 2018 1:30 PM
To: Vivi, Rodrigo <rodrigo.vivi@intel.com>; Jani Nikula <jani.nikula@linux.intel.com>; Botello Ortega, Luis <luis.botello.ortega@intel.com>; Martinez Monroy, Elio <elio.martinez.monroy@intel.com>
Cc: Ian W MORRISON <ianwmorrison@gmail.com>; airlied@linux.ie; Greg KH <gregkh@linuxfoundation.org>; intel-gfx@lists.freedesktop.org; linux-kernel@vger.kernel.org; stable@vger.kernel.org; dri-devel@lists.freedesktop.org; Wajdeczko, Michal <Michal.Wajdeczko@intel.com>
Subject: RE: [RESEND PATCH 1/1] drm/i915/glk: Add MODULE_FIRMWARE for Geminilake



>-----Original Message-----
>From: Vivi, Rodrigo
>Sent: Friday, April 20, 2018 11:04 AM
>To: Jani Nikula <jani.nikula@linux.intel.com>
>Cc: Srivatsa, Anusha <anusha.srivatsa@intel.com>; Ian W MORRISON 
><ianwmorrison@gmail.com>; airlied@linux.ie; Greg KH 
><gregkh@linuxfoundation.org>; intel-gfx@lists.freedesktop.org; linux- 
>kernel@vger.kernel.org; stable@vger.kernel.org; dri- 
>devel@lists.freedesktop.org; Wajdeczko, Michal 
><Michal.Wajdeczko@intel.com>
>Subject: Re: [RESEND PATCH 1/1] drm/i915/glk: Add MODULE_FIRMWARE for 
>Geminilake
>
>On Tue, Apr 17, 2018 at 12:02:52PM +0300, Jani Nikula wrote:
>> On Mon, 16 Apr 2018, "Srivatsa, Anusha" <anusha.srivatsa@intel.com> wrote:
>> >>-----Original Message-----
>> >>From: Jani Nikula [mailto:jani.nikula@linux.intel.com]
>> >>Sent: Wednesday, April 11, 2018 5:27 AM
>> >>To: Ian W MORRISON <ianwmorrison@gmail.com>
>> >>Cc: Vivi, Rodrigo <rodrigo.vivi@intel.com>; Srivatsa, Anusha 
>> >><anusha.srivatsa@intel.com>; Wajdeczko, Michal 
>> >><Michal.Wajdeczko@intel.com>; Greg KH <gregkh@linuxfoundation.org>; 
>> >>airlied@linux.ie; joonas.lahtinen@linux.intel.com; 
>> >>linux-kernel@vger.kernel.org; stable@vger.kernel.org; 
>> >>intel-gfx@lists.freedesktop.org; dri- devel@lists.freedesktop.org
>> >>Subject: Re: [RESEND PATCH 1/1] drm/i915/glk: Add MODULE_FIRMWARE 
>> >>for Geminilake
>> >>
>> >>On Wed, 11 Apr 2018, Ian W MORRISON <ianwmorrison@gmail.com> wrote:
>> >>> <snip>
>> >>>
>> >>>>
>> >>>> NAK on indiscriminate Cc: stable. There are zero guarantees that 
>> >>>> older kernels will work with whatever firmware you throw at them.
>> >>>>
>> >>>
>> >>> I included 'Cc: stable' so the patch would get added to the v4.16 
>> >>> and
>> >>> v4.15 kernels which I have tested with the patch. I found that 
>> >>> earlier kernels didn't support the 'linux-firmware' package 
>> >>> required to get wifi working on Intel's new Gemini Lake NUC.
>> >>
>> >>You realize that this patch should have nothing to do with wifi?
>> >>
>> >>Rodrigo, Anusha, if you think Cc: stable is appropriate, please 
>> >>indicate the specific versions of stable it is appropriate for.
>> >
>> > Hi Jani,
>> >
>> > The stable kernel version is 4.12 and beyond.
>> > It is appropriate to add the CC: stable in my opinion
>>
>> Who tested the firmware with v4.12 and later? We only have the CI 
>> results against *current* drm-tip. We don't even know about v4.16.
>>
>
>I understand your concerns, but the problem was that our old process 
>was a bit
>(lot?) messed and there was the unreliable time until the firmware 
>really lands on linux-firmware.git. So MODULE_FIRMWARE call was only 
>added after firmware was really there on firmware repository but it wasn't about the testing.
>
>In other words, the bump version patch was merged after tested, but 
>MODULE_FIRMWARE was left behind because firmware blob took a while to 
>get pulled into linux-firmware.git and we end up forgetting to add it there.
>
>In my opinion it should be safe to add the MODULE_FIRMWARE there based 
>on the tests from when the version was bumped.

Luis, Elio, can you guys confirm that this firmware is tested and healthy? And also, give a tested-by to this patch please?

Thanks,
Anusha 
>> I'm not going to ack and take responsibility for the stable backports 
>> unless someone actually comes forward with credible Tested-bys.
>>
>> BR,
>> Jani.
>>
>>
>> >
>> > Anusha
>> >>BR,
>> >>Jani.
>> >>
>> >>>
>> >>>>
>> >>>> PS. How is this a "RESEND"? I haven't seen this before.
>> >>>>
>> >>>
>> >>> It is a 'RESEND' for that very reason. I initially sent the patch 
>> >>> to the same people as a similar patch
>> >>> (https://patchwork.kernel.org/patch/10143637/) however after 
>> >>> realising this omitted required addresses I added them and resent 
>> >>> the
>patch.
>> >>>
>> >>> Best regards,
>> >>> Ian
>> >>
>> >>--
>> >>Jani Nikula, Intel Open Source Technology Center
>>
>> --
>> Jani Nikula, Intel Open Source Technology Center 
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
