Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2281868-1524249034-2-678868276779934934
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
    1524249034; b=HTpgPRx32XTq48DvxtdZf9D769+eHd9dWQkBHJsdFcA+rmQlFq
    klM974waMc2G5TxR71XPVSs59HrEalZwuoLA/UcdeUBFpavm3ISBo6DsdDTVNGDL
    vlWxUGDOkNMrlQ4gADZjUtJ8hFFVOs8MDDvzwzvumW3+NLro7M2hk+1Fib4YUKFP
    ar5D88l8pzXh8puQr6CN/NSGve3PQqeQe+SjdSHz4WzMJx2tfn47GqA3PlufsCrR
    7XA+MbJDlUCVDIf2Z1i5qdVoK2KB5v3PD/aAR57pbIWdxsh77k38dIgJqUkgaJB3
    U5T++I8cA0P5+ACzM4M5hT3F5opc+IvzYZjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1524249034; bh=9IQL6DAALW
    RPboqj9exWl0tFm8dQOOTMlPksZgtiCK4=; b=DbVQ4RSg6EmEYJkmt09UNpKXDW
    bu/y7Z1BfsKfiVtTOn0F3yM7m+s+IeppWt1ExI8S8VV1awO0jcVz18YozvO5u/Fs
    p7vdjezWpEus9cquObRPtGlFOrgCetBZgwfxynpqfMhh9L21DebRgeTJLs9Tt64n
    IbOOZsYQ+dyOCTZJJm2T7ERszYBl14tPousbzW7xxNMfq0T9Qmc3amsQg1dmKgwA
    +Gy+UaopfLo9B5Iu7UI+2rxiN5bAz8LXkuu+0V+nb7H3wpjR7wWkCXou69EnX297
    SdxC+nGtt2MrjchjrAdTV7IL7WTfqaUXLifTY/4npLy6/nL2UdSCcTXTiE7Q==
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
X-CM-Envelope: MS4wfECz/gyN+hT08MyFmp7V2E8yn7Q5fPMI6fEd3WYCIyGMzO/NQ52PpLWPVGBcCYDKLjsH2RDtb3Ge1nLpkiTWvf8ut6L83yQLus8w//AO/nHSRS1DT7a4
    hYclESabXrQsuNvvQr0DhCC2nVQfJkxjv6iLwbqRVBVZYbnJzd1WwVs1E/93O1+OFd00PYAVerVolC4N+ivMUSHGTzVy8tUSaFlZfI0oH1W0CoM+NbLKGXjr
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=EbVHfS3oRaoA:10 a=kj9zAlcOel0A:10
    a=Kd1tUaAdevIA:10 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8 a=ag1SF4gXAAAA:8
    a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=RErSChz6tyAgKuOrxjMA:9 a=CjuIK1q_8ugA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=Vxmtnl_E_bksehYqCbjh:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753909AbeDTSaV convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Fri, 20 Apr 2018 14:30:21 -0400
Received: from mga04.intel.com ([192.55.52.120]:11926 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753587AbeDTSaU (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 20 Apr 2018 14:30:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,302,1520924400";
   d="scan'208";a="44846526"
From: "Srivatsa, Anusha" <anusha.srivatsa@intel.com>
To: "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        "Botello Ortega, Luis" <luis.botello.ortega@intel.com>,
        "Martinez Monroy, Elio" <elio.martinez.monroy@intel.com>
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
Thread-Index: AQHT0U+MMfUZJD2+9UaqWtmyL0or/6P7wKGAgAAVhACAAB1iAIAID5cAgAElVwCABU4NAP//jD5w
Date: Fri, 20 Apr 2018 18:30:13 +0000
Message-ID: <83F5C7385F545743AD4FB2A62F75B0733390B83D@ORSMSX108.amr.corp.intel.com>
References: <20180411044213.383-1-ianwmorrison@gmail.com>
 <871sfmhz88.fsf@intel.com>
 <CAFXWsS_SvkLvJcibx9LoUw+onN-AAzSLMrRgx3U3hsbMVyty2g@mail.gmail.com>
 <87lgdugc85.fsf@intel.com>
 <83F5C7385F545743AD4FB2A62F75B073338FD128@ORSMSX108.amr.corp.intel.com>
 <87r2nefbnn.fsf@intel.com> <20180420180331.GE3304@intel.com>
In-Reply-To: <20180420180331.GE3304@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTUzOTc3MjktMWNjYS00NDc5LWE1ODItOTRhMzFiMDNiZWQ2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJwSm9OZnNXUUpGZHJaaWFkek00QWFiNGpVVkhBUDhkZWNtckNRUkNxdVdyaUp0UUFYWlBkeGl6UDFhNnZGUkJLIn0=
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



>-----Original Message-----
>From: Vivi, Rodrigo
>Sent: Friday, April 20, 2018 11:04 AM
>To: Jani Nikula <jani.nikula@linux.intel.com>
>Cc: Srivatsa, Anusha <anusha.srivatsa@intel.com>; Ian W MORRISON
><ianwmorrison@gmail.com>; airlied@linux.ie; Greg KH
><gregkh@linuxfoundation.org>; intel-gfx@lists.freedesktop.org; linux-
>kernel@vger.kernel.org; stable@vger.kernel.org; dri-
>devel@lists.freedesktop.org; Wajdeczko, Michal <Michal.Wajdeczko@intel.com>
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
>I understand your concerns, but the problem was that our old process was a bit
>(lot?) messed and there was the unreliable time until the firmware really lands on
>linux-firmware.git. So MODULE_FIRMWARE call was only added after firmware
>was really there on firmware repository but it wasn't about the testing.
>
>In other words, the bump version patch was merged after tested, but
>MODULE_FIRMWARE was left behind because firmware blob took a while to get
>pulled into linux-firmware.git and we end up forgetting to add it there.
>
>In my opinion it should be safe to add the MODULE_FIRMWARE there based on
>the tests from when the version was bumped.

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
>> >>> realising this omitted required addresses I added them and resent the
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
