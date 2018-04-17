Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1413928-1523955625-2-6619129709265150005
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523955624; b=cNap9PmwSD4oiP3iOcSaWXBH0lk4HiCvabpIC3MSWNDVVGJQGA
    GuYgKVaVquR7knQs+Vy+d3P0+PdDmqdlDM/0PFGRO2JZtiYnmyfmgCC4wNnH4Vz7
    UgZHggl0K7vxr8H5pPo3NgkohtM5QxO46JyFVL8zMs39rkp5B549sTUT3hYVqU3B
    29nwMq5Mhj71k8OCi8FAZDy9Z7+qPdqruY+FZFS0UozbPz0vuqcyVpJ1kEUdaDGN
    k5oLqyDpHyLkGD2YIYf5UzQ+GUvhIZMX8rS5Mfrd18CR5IAFg2+ltbz+eNvxF7Uy
    1oeY3UW3CDGf47xXwWy8Yzczg1jv2EFBTAsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    fm2; t=1523955624; bh=hmsyEgWpggKfaWmN0WK9nge6SjnCLoyFD/h+HAyKo8
    Q=; b=s2k1GZH6N78TzsIgUYuzWJpgyhIJjsvyT8v0jhR4eb3oOqejNxhwS7eFb1
    jOb+S8jt/thIZKsTIHtBARKK5pWyYBCJk2pMYJo1dFiGCQbyUIf1CIbMlreSVVhH
    HYOom9UeUjj2Y9TS2vkDNTHyW9RvwmivjdTPMCgoGblEBJ7UMrdkzZNZUbwX59+g
    /Htueg71oA7urWgmorM2DTpOrnkVFcuH1zOPqEiVDoMzUK3pAtw3clv2GFAUU29J
    Mi3he7YPAdK3UE4iXBtzIrNgyqIC/A70mG8BUg3MtrAA1UwXFrnrKIH+Ok166uMi
    aiNmBiPJ3lrT4IRgsQSw8kGM6bxA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAzZoZuWqRBsMY+zbpoV8o6GIsBsxhjHPztzqr46j3e62oQ2CXWGhy+iPnOZMuM6WaYEZ0x8aSVoAy/iQZmeXr8SJJlKwokV5p8fHEmMZPRvOSyALHmd
    WgS9HD1Nb8gBRi4/aaVX1RNqjer4rv7r3C+lpY5zHMme+tTSjK/RvhXYemAR5OX/0SB/dnyVbSR7fgAbjmc95DLv1uhiVNl24JZTXTw/1YW1X8U7tju5iBCZ
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=QyXUC8HyAAAA:8
    a=pGLkceISAAAA:8 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=e5mUnYsNAAAA:8
    a=JLIaYPEpVCIE-WG8l_gA:9 a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Vxmtnl_E_bksehYqCbjh:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752510AbeDQJAM (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 05:00:12 -0400
Received: from mga12.intel.com ([192.55.52.136]:43363 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752427AbeDQJAK (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 17 Apr 2018 05:00:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,463,1517904000";
   d="scan'208";a="47556342"
From: Jani Nikula <jani.nikula@linux.intel.com>
To: "Srivatsa\, Anusha" <anusha.srivatsa@intel.com>,
        Ian W MORRISON <ianwmorrison@gmail.com>
Cc: "Vivi\, Rodrigo" <rodrigo.vivi@intel.com>,
        "Wajdeczko\, Michal" <Michal.Wajdeczko@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "airlied\@linux.ie" <airlied@linux.ie>,
        "joonas.lahtinen\@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable\@vger.kernel.org" <stable@vger.kernel.org>,
        "intel-gfx\@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "dri-devel\@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: RE: [RESEND PATCH 1/1] drm/i915/glk: Add MODULE_FIRMWARE for Geminilake
In-Reply-To: <83F5C7385F545743AD4FB2A62F75B073338FD128@ORSMSX108.amr.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180411044213.383-1-ianwmorrison@gmail.com> <871sfmhz88.fsf@intel.com> <CAFXWsS_SvkLvJcibx9LoUw+onN-AAzSLMrRgx3U3hsbMVyty2g@mail.gmail.com> <87lgdugc85.fsf@intel.com> <83F5C7385F545743AD4FB2A62F75B073338FD128@ORSMSX108.amr.corp.intel.com>
Date: Tue, 17 Apr 2018 12:02:52 +0300
Message-ID: <87r2nefbnn.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 16 Apr 2018, "Srivatsa, Anusha" <anusha.srivatsa@intel.com> wrote:
>>-----Original Message-----
>>From: Jani Nikula [mailto:jani.nikula@linux.intel.com]
>>Sent: Wednesday, April 11, 2018 5:27 AM
>>To: Ian W MORRISON <ianwmorrison@gmail.com>
>>Cc: Vivi, Rodrigo <rodrigo.vivi@intel.com>; Srivatsa, Anusha
>><anusha.srivatsa@intel.com>; Wajdeczko, Michal
>><Michal.Wajdeczko@intel.com>; Greg KH <gregkh@linuxfoundation.org>;
>>airlied@linux.ie; joonas.lahtinen@linux.intel.com; linux-kernel@vger.kernel.org;
>>stable@vger.kernel.org; intel-gfx@lists.freedesktop.org; dri-
>>devel@lists.freedesktop.org
>>Subject: Re: [RESEND PATCH 1/1] drm/i915/glk: Add MODULE_FIRMWARE for
>>Geminilake
>>
>>On Wed, 11 Apr 2018, Ian W MORRISON <ianwmorrison@gmail.com> wrote:
>>> <snip>
>>>
>>>>
>>>> NAK on indiscriminate Cc: stable. There are zero guarantees that
>>>> older kernels will work with whatever firmware you throw at them.
>>>>
>>>
>>> I included 'Cc: stable' so the patch would get added to the v4.16 and
>>> v4.15 kernels which I have tested with the patch. I found that earlier
>>> kernels didn't support the 'linux-firmware' package required to get
>>> wifi working on Intel's new Gemini Lake NUC.
>>
>>You realize that this patch should have nothing to do with wifi?
>>
>>Rodrigo, Anusha, if you think Cc: stable is appropriate, please indicate the specific
>>versions of stable it is appropriate for.
>
> Hi Jani,
>
> The stable kernel version is 4.12 and beyond.
> It is appropriate to add the CC: stable in my opinion

Who tested the firmware with v4.12 and later? We only have the CI
results against *current* drm-tip. We don't even know about v4.16.

I'm not going to ack and take responsibility for the stable backports
unless someone actually comes forward with credible Tested-bys.

BR,
Jani.


>
> Anusha
>>BR,
>>Jani.
>>
>>>
>>>>
>>>> PS. How is this a "RESEND"? I haven't seen this before.
>>>>
>>>
>>> It is a 'RESEND' for that very reason. I initially sent the patch to
>>> the same people as a similar patch
>>> (https://patchwork.kernel.org/patch/10143637/) however after realising
>>> this omitted required addresses I added them and resent the patch.
>>>
>>> Best regards,
>>> Ian
>>
>>--
>>Jani Nikula, Intel Open Source Technology Center

-- 
Jani Nikula, Intel Open Source Technology Center
