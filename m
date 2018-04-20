Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-718383-1524203241-2-18124594181811596254
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524203240; b=lFYWxTDizMuGiwLE1efq9TBwrSg6LmdxQst1fi7CSSv2BiZfhw
    O7U+1xTbFomjRKsIxr1Eawze9hx2S9udTvGMu5qyyusqnk50ZynKPoLEXiEbFcFq
    7UQIuJpXPt9m0Jegd91l6WIfwEruCkmW+L/YC3mQrT77r3KnW9IwhsfGbZvmPIW8
    2niWXrZ4xdZeYSHgvMlS18RUk6iU+h7yPbsEAHpqfrKObi7hwsr2p7qd+tNT4/vJ
    560EtszXO8vyfYaGiVn0sUv+FY1tFEe1E6vT5Ag2x4MyDynI7amPJ4JrV6JpGetn
    KaKZeNkJ3ZpBqkbP7/f8ncOdlG89jGTIJAHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524203240; bh=iVbxfeeWkennfMMt4G/fRidWFkDN4TP3SELjHNa0Ae
    Q=; b=H4cqDZ24s/B1e4VjpuGw6UWdrLCGkxtrd5HzbQznWFB44SYL3uAyqIweJf
    harCMUZI4IZQXNpHyvwovWETmMy95xH4dHY4U8L1A/aXQ6u8HGmTyVHbyabDlEw2
    NkK4GWkEM9VCz6+EYLVx5U+nYjCdkbmfzbUx/6oiySLuhVQiMOnkzV7rNUMxdV9A
    aW45V+MwwZvxe1qt//JtbK5Y30ZghAYxqA8TDLyl2Qjd3P8ak0xKVdIC3y9JxdWy
    nOs31VoS8Vz4SNHjnk3NsWjj8DHUMHqXkobD7FXVshyNcgkmsG4UywG3ebY6ke6+
    BW+ov+2MAn+YeEeI1wa15FpgYEYw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ovi3DIu2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eiQgCLcy;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ovi3DIu2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eiQgCLcy;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEAf6mOf1bZb2ZjGm7IBO67R/A+KaXXYE/9yL8GUlCjCKNKJWS1EDrdH5DZjGCY2zJXApA9XzKtPvQTw66cMUsFJNrZzdlWJlzof/YdI38MvubpAC6r+
    9vNHnExnb7KeWCLX0h9FOKtBPX9M5o7Lr+ejPPbZGJ+jbXvGheQmbQFwQ1ORcJmhJyjpklvTMDwiYSFr8Nb8Li5tAdDs6Lp0AW8wQ1XaNrMSI3S3B95ZCtPf
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=unD1LOn5OY8A:10 a=Kd1tUaAdevIA:10 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8
    a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=e5mUnYsNAAAA:8 a=i3X5FwGiAAAA:8
    a=PGTrnsUqLBghMRNlhlcA:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=AjGcO6oz07-iQ99wixmX:22 a=Vxmtnl_E_bksehYqCbjh:22 a=mmqRlSCDY2ywfjPLJ4af:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753443AbeDTFrS (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 01:47:18 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:44956 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751467AbeDTFrR (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Apr 2018 01:47:17 -0400
X-Google-Smtp-Source: AIpwx48w97wUHxWRgwDJZd1920uDD5iFhRBTdPuCuf23LozE8jeeEn979QuuE6ibw232OwS50kdwK1v8EQ6fIPIHJas=
MIME-Version: 1.0
In-Reply-To: <152397448099.13647.3490065625139821046@jlahtine-desk.ger.corp.intel.com>
References: <20180411044213.383-1-ianwmorrison@gmail.com> <871sfmhz88.fsf@intel.com>
 <CAFXWsS_SvkLvJcibx9LoUw+onN-AAzSLMrRgx3U3hsbMVyty2g@mail.gmail.com>
 <87lgdugc85.fsf@intel.com> <83F5C7385F545743AD4FB2A62F75B073338FD128@ORSMSX108.amr.corp.intel.com>
 <87r2nefbnn.fsf@intel.com> <152397448099.13647.3490065625139821046@jlahtine-desk.ger.corp.intel.com>
From: Ian W MORRISON <ianwmorrison@gmail.com>
Date: Fri, 20 Apr 2018 15:47:15 +1000
Message-ID: <CAFXWsS8o72qgO419muew4ei3VgorYWmGq0k=xPNe1es3DmD0gw@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/1] drm/i915/glk: Add MODULE_FIRMWARE for Geminilake
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: "Srivatsa, Anusha" <anusha.srivatsa@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        "Wajdeczko, Michal" <Michal.Wajdeczko@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 18 April 2018 at 00:14, Joonas Lahtinen
<joonas.lahtinen@linux.intel.com> wrote:
> Quoting Jani Nikula (2018-04-17 12:02:52)
>> On Mon, 16 Apr 2018, "Srivatsa, Anusha" <anusha.srivatsa@intel.com> wrote:
>> >>-----Original Message-----
>> >>From: Jani Nikula [mailto:jani.nikula@linux.intel.com]
>> >>Sent: Wednesday, April 11, 2018 5:27 AM
>> >>To: Ian W MORRISON <ianwmorrison@gmail.com>
>> >>Cc: Vivi, Rodrigo <rodrigo.vivi@intel.com>; Srivatsa, Anusha
>> >><anusha.srivatsa@intel.com>; Wajdeczko, Michal
>> >><Michal.Wajdeczko@intel.com>; Greg KH <gregkh@linuxfoundation.org>;
>> >>airlied@linux.ie; joonas.lahtinen@linux.intel.com; linux-kernel@vger.kernel.org;
>> >>stable@vger.kernel.org; intel-gfx@lists.freedesktop.org; dri-
>> >>devel@lists.freedesktop.org
>> >>Subject: Re: [RESEND PATCH 1/1] drm/i915/glk: Add MODULE_FIRMWARE for
>> >>Geminilake

<snip>

In summary so far:

Jani:
> NAK on indiscriminate Cc: stable. There are zero guarantees that
> older kernels will work with whatever firmware you throw at them.
> Who tested the firmware with v4.12 and later? We only have the CI
> results against *current* drm-tip. We don't even know about v4.16.
> I'm not going to ack and take responsibility for the stable backports
> unless someone actually comes forward with credible Tested-bys.

Anusha:
> The stable kernel version is 4.12 and beyond.
> It is appropriate to add the CC: stable in my opinion

Joonas:
> And even then, some distros will be surprised of the new MODULE_FIRMWARE
> and will need to update the linux-firmware package, too.

I've performed backport testing and some additional analysis as follows:

The DMC firmware for GLK was initially included in 4.11
  (commit: dbb28b5c3d3cb945a63030fab8d3894cf335ce19).
Then the firmware version was upgraded to 1.03 in 4.12
  (commit: f4a791819ed00a749a90387aa139706a507aa690).
However MODULE_FIRMWARE for the GLK DMC firmware
was also removed in 4.12
  (commit: d9321a03efcda867b3a8c6327e01808516f0acd7)
together with the firmware version being bumped to 1.04
  (commit: aebfd1d37194e00d4c417e7be97efeb736cd9c04).

The patch below effectively reverts commit d9321a03 because the GLK
firmware is now available in the linux-firmware repository.

To test stable backports I've used Ubuntu 18.04 (Beta 2) userspace with
both Ubuntu (generic) and self-compiled mainline (patched) kernels.
The conclusion was that the patch works across 4.12 to 4.17-rc1 kernels
additionally displaying a 'Possible missing firmware' message when
installing a kernel with the expected firmware missing.

The following are abridged backport test results:

Scenario: No DMC (glk_dmc_ver1_04.bin) firmware installed in
'/lib/firmware/i915'
  Test:Kernel installation ('grep -i dmc' output from 'apt install'):
    4.12-generic and 4.15-generic:
      No output # as expected
    4.12 to 4.17-rc1-patched:
      W: Possible missing firmware
/lib/firmware/i915/glk_dmc_ver1_04.bin for module i915
  Result: The effect of the patch is to add a 'Possible missing
firmware' message.
  Test: Booting ('grep -i dmc' output from 'dmesg'):
    4.12-generic:
      No output # as expected
    4.15-generic:
      i915 0000:00:02.0: Direct firmware load for
i915/glk_dmc_ver1_04.bin failed with error -2
      i915 0000:00:02.0: Failed to load DMC firmware
i915/glk_dmc_ver1_04.bin. Disabling runtime power management.
      i915 0000:00:02.0: DMC firmware homepage:
https://01.org/linuxgraphics/downloads/firmware
    4.12-patched:
      No output # as expected
    4.13 to 4.14-patched:
      i915 0000:00:02.0: Direct firmware load for
i915/glk_dmc_ver1_04.bin failed with error -2
      i915 0000:00:02.0: Failed to load DMC firmware
[https://01.org/linuxgraphics/downloads/firmware], disabling runtime
power management.
    4.15 to 4.17-rc1-patched:
      i915 0000:00:02.0: Direct firmware load for
i915/glk_dmc_ver1_04.bin failed with error -2
      i915 0000:00:02.0: Failed to load DMC firmware
i915/glk_dmc_ver1_04.bin. Disabling runtime power management.
      i915 0000:00:02.0: DMC firmware homepage:
https://01.org/linuxgraphics/downloads/firmware
  Result: The effect of the patch does not change existing
(non-patched kernel) messages.

Scenario: DMC (glk_dmc_ver1_04.bin) firmware installed in '/lib/firmware/i915'
  Test:Kernel installation ('grep -i dmc' output from 'apt install')
    All kernels:
      No messages # as expected
  Result: The effect of the patch does not change existing messages.
  Test" Booting ('grep -i dmc' output from 'dmesg'):
    4.12-generic:
      No output # as expected
    4.15-generic:
      i915 0000:00:02.0: Direct firmware load for
i915/glk_dmc_ver1_04.bin failed with error -2
      i915 0000:00:02.0: Failed to load DMC firmware
i915/glk_dmc_ver1_04.bin. Disabling runtime power management.
      i915 0000:00:02.0: DMC firmware homepage:
https://01.org/linuxgraphics/downloads/firmware
    4.12-patched:
      No output # as expected
    4.13 to 4.17-rc1-patched:
      [drm] Finished loading DMC firmware i915/glk_dmc_ver1_04.bin (v1.4)
  Result: The effect of the patch is to remove the 'Failed to load' message.

Regards,
Ian
