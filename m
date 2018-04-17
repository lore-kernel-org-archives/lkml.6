Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1954995-1523974491-2-5344219927579339686
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523974490; b=sD2KgZMQN7YJuuIZtSW4kUKh6OYb/9jxSsEtbpjXAXFV6Qz5Ip
    mREaDkW7r3q3zRfeD2/mmpluKUiXAgYtgNSygRxTcQ+Q2zQ9J2yzKVujvcCpzTV2
    OIGApxqYs6vtfUyJrMElVL+apZQyzzKjOUeyKmy2o8EWKMOtQh5E/bJK4y8QJzEv
    ip7qx7rAOr078GmHQJlx9fVJuzfDhWUuoHHsn+vaccYnFrKNQDmzSWj7YpZTzPEa
    H1aVmJlxHLBFfcpzS2VcnWMggAej79WZWFvSBwCkhD1fQ/innTteWOucgz/5S/B7
    kMFfl/XHN174vZ5w7Et5AvxZSr/Q+ahqT5iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:mime-version
    :content-transfer-encoding:to:from:in-reply-to:cc:references
    :message-id:subject:date:sender:list-id; s=fm2; t=1523974490;
    bh=d2YmRNTM8GQH8HQt2r3IxK/MW52sMwmGtj//v+ojxhA=; b=VaosryvqxIqw
    FZ/Oti5r1y73CPx2EXdG5cIBlInwSDUFYv7QWVMa/L8ghamm1ih/OmYq03/wVuXJ
    kI5Nx7KewjfmOE9ToeovB3+As/THwcDIcMCGDrn6gokd/p/qiZWI8BD25G1DyvYJ
    DBZltQJiWvZYTHeq49VET3z4+eORY9aOhvTWv2oFkHXoCbN35PLUHNV2m6ypYQJ7
    UILThSS5/0Ttd0agVk5CAMDHtxtilsNxlZ1Lmk+79mx7BQclYnotjzkx6LxI3zTD
    uMtaZzU9mtIAPcAR9MH44gQ94n3cyh5qYTSnY8hFaZKcJnmGo9Fpqg2W+LOEJ0NU
    4QhWJECauA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfBNTvIcEunI9w7M+hKMOBxVbLsqnASjM7cXmXwW/DOYQ3Hb49QfBaZsdwsTDJQvgjW7hIRE+AZtiGoC9u9SJVRsbo2zcHAv6ggPtw2gD1bXnKx0dJwIP
    pp4YT0V0/El2eKPU2Hqb8Suq87XcB9fp68EjVEpAZnkp0WnB40v7WoUu/tei/DmzwvIBt5gd6DGvmbOKcdwBjQTQHVY49TyUqKEWYEZuUvH3wlumvid8EuUj
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8
    a=e5mUnYsNAAAA:8 a=9u0RmQqV677Uz6BtlGMA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22 a=Vxmtnl_E_bksehYqCbjh:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752387AbeDQOOq convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Tue, 17 Apr 2018 10:14:46 -0400
Received: from mga02.intel.com ([134.134.136.20]:26325 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751270AbeDQOOq (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 17 Apr 2018 10:14:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,463,1517904000";
   d="scan'208";a="47628603"
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: "Srivatsa, Anusha" <anusha.srivatsa@intel.com>,
        Ian W MORRISON <ianwmorrison@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
In-Reply-To: <87r2nefbnn.fsf@intel.com>
Cc: "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        "Wajdeczko, Michal" <Michal.Wajdeczko@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <20180411044213.383-1-ianwmorrison@gmail.com> <871sfmhz88.fsf@intel.com>
 <CAFXWsS_SvkLvJcibx9LoUw+onN-AAzSLMrRgx3U3hsbMVyty2g@mail.gmail.com>
 <87lgdugc85.fsf@intel.com>
 <83F5C7385F545743AD4FB2A62F75B073338FD128@ORSMSX108.amr.corp.intel.com>
 <87r2nefbnn.fsf@intel.com>
Message-ID: <152397448099.13647.3490065625139821046@jlahtine-desk.ger.corp.intel.com>
User-Agent: alot/0.6
Subject: RE: [RESEND PATCH 1/1] drm/i915/glk: Add MODULE_FIRMWARE for Geminilake
Date: Tue, 17 Apr 2018 17:14:41 +0300
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Quoting Jani Nikula (2018-04-17 12:02:52)
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
> I'm not going to ack and take responsibility for the stable backports
> unless someone actually comes forward with credible Tested-bys.

And even then, some distros will be surprised of the new MODULE_FIRMWARE
and will need to update the linux-firmware package, too.

Regards, Joonas

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
