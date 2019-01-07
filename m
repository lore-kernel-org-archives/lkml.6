Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583C7C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2527A218AE
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yzt4AabK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfAGRy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 12:54:29 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33809 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbfAGRy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 12:54:29 -0500
Received: by mail-qk1-f193.google.com with SMTP id q8so781328qke.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 09:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3iMoKa5mgyYNhb+Hi+wOr0xD+cKf+0AbXyCt5WIaRsc=;
        b=Yzt4AabK2DsKkXh33vjh54x+dvj2n7NuxgP74X9rnY+f6IWi57gh8A7n+k3kjsbEn6
         IedTeKT6ygS0GmNIAiRi2RzO3i1MD0KrqQYbMLNTwPOWiDRMQYws94SJvfjRh+FrSzj5
         lp4xoQGyJvm1WzPmeSMS249oZ6jV92ijiP841hXeds2oJQwa/Ts6i297zeYxXHW8P9hV
         r6UEZ6lxIFgR54irua91WHj2a8HKACG6aSJX6MLcaSyGGopqG8ZEhC2SzLkHGCRbxZ8i
         XwxHkL3ctSVQ/sFPQUFdnz7tazo+DQ+zbBpB0yH9a1llfJ8ctWBogwfbHJ2I6vYiZklk
         6PuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3iMoKa5mgyYNhb+Hi+wOr0xD+cKf+0AbXyCt5WIaRsc=;
        b=UdIJRTG/kldmpmFKr5f/JsxQPqcoHnI29Xcqx2UcytW8IB8j1EO6zzlY81TcswwjFO
         paoxcltORW3qwX30B07GbLRPW7CLFfIvxNAC8Ze4+b/ALZFPsh9dXxj6A9yn7dfdh5Vw
         s1aQMX/BnosFEz7+rTK7iWmNNsE1/eK41i8249V3DTdhdrjvi5sHn/SkULJAx0IH6INi
         ia+gN1GyANvWaAUVmgF/+MPFyTmYUFbLsHzivgId9QdM3XCqjbNhU6SAoT1Fe3GxlQ/E
         hJh7K4mWCpzvzpUDKfSwztiq9TCDflXaejDoJL+fyzkHwhqd17KigIiHCF8oMONcyfi7
         w6mQ==
X-Gm-Message-State: AJcUukf1aF08zmrhFpIDuzi6BRygPEXVV1qz386M41k2wTsbujivCyAe
        JFrua/MfAKYQbwZDhveXhS5x+dB61VCygobyciEmsijUKS8=
X-Google-Smtp-Source: ALg8bN4rHpU/N4BTqDT38bzIQts+qkFau6jtM397HfxQclLTDktyzP9RuCMgEQBxP/WjsyEm/OZwILK/Mh79xd2Miqw=
X-Received: by 2002:a37:be02:: with SMTP id o2mr58272598qkf.133.1546883668251;
 Mon, 07 Jan 2019 09:54:28 -0800 (PST)
MIME-Version: 1.0
References: <CANMdSOztZu2bsG+g=T-pThiHK9cNaMVq=tvTJ6kn2Tvu4CXJCQ@mail.gmail.com>
 <20190107133440.GO20097@intel.com>
In-Reply-To: <20190107133440.GO20097@intel.com>
From:   Daniel Kamil Kozar <dkk089@gmail.com>
Date:   Mon, 7 Jan 2019 18:54:16 +0100
Message-ID: <CANMdSOxCFbf3tbdNY4UMrs0voJ2as_Sq9UfWwdMt+Rttpg=fWg@mail.gmail.com>
Subject: Re: "flip_done timed out" messages causing huge increase in boot time
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, azhar.shaikh@intel.com,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I submitted the bug report at
https://bugs.freedesktop.org/show_bug.cgi?id=3D109245 . The dmesg log is
attached to the bug report.

Daniel

On Mon, 7 Jan 2019 at 14:34, Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Sat, Jan 05, 2019 at 12:47:12AM +0100, Daniel Kamil Kozar wrote:
> > Hello.
> > After upgrading the kernel to 4.20, I noticed that the boot time
> > increased from about 5 seconds to 25 seconds. My machine is an Asus
> > K53SV with an Intel i7-2630QM, i.e. Sandy Bridge. I have an external
> > display connected to it via HDMI. If the display is unplugged when
> > booting the machine, the boot time stays at its old value.
> > The kernel log shows two messages like this :
> >
> > [   15.747206] [drm:drm_atomic_helper_wait_for_flip_done
> > [drm_kms_helper]] *ERROR* [CRTC:39:pipe A] flip_done timed out
> > [   26.198968] [drm:drm_atomic_helper_wait_for_dependencies
> > [drm_kms_helper]] *ERROR* [CRTC:39:pipe A] flip_done timed out
>
> Hrm. With SNB I would be tempted to blame the LP3 watermarks, but
> 4.20 already has commit 21556350ade3 ("drm/i915: Disable LP3 watermarks
> on all SNB machines").
>
> Can you file a bug at
> https://bugs.freedesktop.org/enter_bug.cgi?product=3DDRI&component=3DDRM/=
Intel
> and attach the full dmesg from the boot with drm.debug=3D0xe passed to th=
e
> kernel cmdline?
>
> --
> Ville Syrj=C3=A4l=C3=A4
> Intel
