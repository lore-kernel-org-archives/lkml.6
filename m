Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2222762-1524247428-2-15909201974209662771
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524247427; b=vxgf53XZ8AZCsrCnY2f3Ty+YZnmdal81Z4SiGF58vEVNKmj6wR
    AyDekWNaPNPk4qiFDfVpYJpcgGdwzn2/T9V1NVEd/diJ5DISYhFD5+oyZ4DGIzaE
    he7Og5/Z7HOJ6dzp81ATH/5iHwDgPJCzeNZqR5h715ubSw9BgE4eQ/WDitkhlu1C
    vG8Ctdoiy/+kLSRwrPaaE+lMzZZBWho1cvAbQ32J4pSd/kmWljDwsuI2DB2cwyH1
    oFznIQjkR8TOn8qQLQ6QK3uk8BVLA0oBWbzlfv+yX1zGhMQjdeCWHIit9PIH81ii
    MtR8YPnEuNb7AhlwOWsRIOAJ+AuXO2EvCZxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524247427; bh=ZnwcqJpoqMJQWx363E5PxRWHOmWVNc
    Iqc0Z7iLmaMvE=; b=HmEIOMmSTOZtMjU6G1XgVyFV84BVs9xjO+fyEHM5qe9hLO
    PdNUbG9HF6k0b8BGY18k9QbtEbrLYd+NlOIC0x33fBpeLD2tQVkCbDF/sQJAnmIm
    dacyitD8ep6YZQH8EBosS2Ty7sNZphUaF9YjSBwsNR44ZlVujq994xQMhLZ2BCG0
    eO/4uGXxoE52J5b+cPZRoxv/tPGjlPvpdUMBoof7Dsbpt66NvaC7j9UsLkRus8ro
    wIC31qfpcoNUp79kuYaa9xVdfEdHrcD7OTr96lWDFNTqkRMSO0STNm475gHnRswE
    Vnr40i9JpJTOMAMmkQJSwTfjZCOGOWLRYwe3NT0g==
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
X-CM-Envelope: MS4wfDEmsUjScvXx0ZAVcHljGnPS3WFpvpHpN/PtWtubi/tQZR/cnkxbd7yp4+iQ/Kl9+/Y76HeS6REdO4/u0CU0aQkglHKTkX4P4Saxqozdpfa/pYJfTTBS
    lpmiB8YfiXUYTG/n7lxmJTK/Fqe45g2+jxtJus9lnkaSg+1usDtPDb7sRgPGMAyxFadlaR9L5UXTn0iEctP/QS8QhjaUtPsi3cTy37VzDddr9JPgaAa3Rjgg
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8
    a=e5mUnYsNAAAA:8 a=823g-tNlgnTRFbieJmkA:9 a=CjuIK1q_8ugA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22 a=Vxmtnl_E_bksehYqCbjh:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753475AbeDTSDq (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 14:03:46 -0400
Received: from mga03.intel.com ([134.134.136.65]:58650 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753499AbeDTSDp (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 20 Apr 2018 14:03:45 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,302,1520924400";
   d="scan'208";a="49523907"
Date: Fri, 20 Apr 2018 11:03:32 -0700
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: "Srivatsa, Anusha" <anusha.srivatsa@intel.com>,
        Ian W MORRISON <ianwmorrison@gmail.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Greg KH <gregkh@linuxfoundation.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Wajdeczko, Michal" <Michal.Wajdeczko@intel.com>
Subject: Re: [RESEND PATCH 1/1] drm/i915/glk: Add MODULE_FIRMWARE for
 Geminilake
Message-ID: <20180420180331.GE3304@intel.com>
References: <20180411044213.383-1-ianwmorrison@gmail.com>
 <871sfmhz88.fsf@intel.com>
 <CAFXWsS_SvkLvJcibx9LoUw+onN-AAzSLMrRgx3U3hsbMVyty2g@mail.gmail.com>
 <87lgdugc85.fsf@intel.com>
 <83F5C7385F545743AD4FB2A62F75B073338FD128@ORSMSX108.amr.corp.intel.com>
 <87r2nefbnn.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r2nefbnn.fsf@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 17, 2018 at 12:02:52PM +0300, Jani Nikula wrote:
> On Mon, 16 Apr 2018, "Srivatsa, Anusha" <anusha.srivatsa@intel.com> wrote:
> >>-----Original Message-----
> >>From: Jani Nikula [mailto:jani.nikula@linux.intel.com]
> >>Sent: Wednesday, April 11, 2018 5:27 AM
> >>To: Ian W MORRISON <ianwmorrison@gmail.com>
> >>Cc: Vivi, Rodrigo <rodrigo.vivi@intel.com>; Srivatsa, Anusha
> >><anusha.srivatsa@intel.com>; Wajdeczko, Michal
> >><Michal.Wajdeczko@intel.com>; Greg KH <gregkh@linuxfoundation.org>;
> >>airlied@linux.ie; joonas.lahtinen@linux.intel.com; linux-kernel@vger.kernel.org;
> >>stable@vger.kernel.org; intel-gfx@lists.freedesktop.org; dri-
> >>devel@lists.freedesktop.org
> >>Subject: Re: [RESEND PATCH 1/1] drm/i915/glk: Add MODULE_FIRMWARE for
> >>Geminilake
> >>
> >>On Wed, 11 Apr 2018, Ian W MORRISON <ianwmorrison@gmail.com> wrote:
> >>> <snip>
> >>>
> >>>>
> >>>> NAK on indiscriminate Cc: stable. There are zero guarantees that
> >>>> older kernels will work with whatever firmware you throw at them.
> >>>>
> >>>
> >>> I included 'Cc: stable' so the patch would get added to the v4.16 and
> >>> v4.15 kernels which I have tested with the patch. I found that earlier
> >>> kernels didn't support the 'linux-firmware' package required to get
> >>> wifi working on Intel's new Gemini Lake NUC.
> >>
> >>You realize that this patch should have nothing to do with wifi?
> >>
> >>Rodrigo, Anusha, if you think Cc: stable is appropriate, please indicate the specific
> >>versions of stable it is appropriate for.
> >
> > Hi Jani,
> >
> > The stable kernel version is 4.12 and beyond.
> > It is appropriate to add the CC: stable in my opinion
> 
> Who tested the firmware with v4.12 and later? We only have the CI
> results against *current* drm-tip. We don't even know about v4.16.
> 

I understand your concerns, but the problem was that our old process
was a bit (lot?) messed and there was the unreliable time
until the firmware really lands on linux-firmware.git. So MODULE_FIRMWARE
call was only added after firmware was really there on firmware repository
but it wasn't about the testing.

In other words, the bump version patch was merged after tested, but
MODULE_FIRMWARE was left behind because firmware blob took a while to get
pulled into linux-firmware.git and we end up forgetting to add it there.

In my opinion it should be safe to add the MODULE_FIRMWARE there
based on the tests from when the version was bumped.

> I'm not going to ack and take responsibility for the stable backports
> unless someone actually comes forward with credible Tested-bys.
> 
> BR,
> Jani.
> 
> 
> >
> > Anusha
> >>BR,
> >>Jani.
> >>
> >>>
> >>>>
> >>>> PS. How is this a "RESEND"? I haven't seen this before.
> >>>>
> >>>
> >>> It is a 'RESEND' for that very reason. I initially sent the patch to
> >>> the same people as a similar patch
> >>> (https://patchwork.kernel.org/patch/10143637/) however after realising
> >>> this omitted required addresses I added them and resent the patch.
> >>>
> >>> Best regards,
> >>> Ian
> >>
> >>--
> >>Jani Nikula, Intel Open Source Technology Center
> 
> -- 
> Jani Nikula, Intel Open Source Technology Center
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
