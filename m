Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D668C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77A320645
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z73EMD6z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C77A320645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbeK2JRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:17:48 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39511 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbeK2JRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:17:48 -0500
Received: by mail-lf1-f65.google.com with SMTP id n18so20595745lfh.6;
        Wed, 28 Nov 2018 14:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ma2kuY4Upb4liZwD/eLcCRbX5Kh1WniUyL+f8kdAQMk=;
        b=Z73EMD6zE7fxOPzmQxNZIV6vZqW1VNY1BbuGbFzE1hZTeTQrx0MGZPysxHNwmxe6fl
         dQhij6FrRUzma7tNxSx36ZYWi3NU0hsNimqFLMJivcHywuIlQOoJJw6pxFhiOUcTEAM5
         m39xeVHYdjtQD4x4ifS2VPb9DpAfBHuVUH1Fia1ck80e+0yxQtSdmzURJ3xukBs+LBT+
         KhZe8+ERe8EmnupN50K9a9TEiAKNR+jbHRtNih6K8FkNKV3HHWfTFcLzvbtl3ev9r10o
         ti1MvVkSL8Rjn8/h2G9VBNdJpBsRbIgdq9H7bPEfDPO5ftQeFpSQ9eYQgfmJLe2haItW
         39Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ma2kuY4Upb4liZwD/eLcCRbX5Kh1WniUyL+f8kdAQMk=;
        b=D/vCQziNZ3p8NmC+l8Bw6l+peqbeG5Yg+ZRkgGgbBx7tiHuH1k6an5V9XUVlM+vqcY
         13e+QI6AAk0+UlzA3n/9KnVSLbD2+jxvjluYlLGGvvIjrNJn07jt98RlfYjfFQJj8fMJ
         9m0gcDEmL3O/+qWL3lxyNlfKxhM1U50oBHAzuubNyJstNSDyr4S3xZLWep4aKooJxhIH
         oiEnNwmNVZyl3BjmXv3EoMt+03KS46/9sJOalJZKuIKJwvaBh7PhsBSL0Qv5S5JVDZjU
         KANZOKdm6yLeLIS75XupztlwOfxZjYOHv8QoBar3pkPLv+DSM8oU+s6UxiifVuCms5y8
         PMnQ==
X-Gm-Message-State: AGRZ1gIWxY51RcZ2I91TSSnU+jkVT+NHRurNns0i8a20W/Q5JsxO2zbr
        yKTE01+GmNfWX2Q+1zAqIQfbvNlztT2tyV8R1Iw=
X-Google-Smtp-Source: AJdET5cIC1yj9RCcmN1/858+xkH9Zdun6gFU9eDDD2gUof4ynRsKm4TsvTMpwEKehUI0K+g9r3asfayqibU2FE5ncJI=
X-Received: by 2002:a19:7d42:: with SMTP id y63mr21707255lfc.47.1543443277951;
 Wed, 28 Nov 2018 14:14:37 -0800 (PST)
MIME-Version: 1.0
References: <BYAPR02MB431115EC4735AE5B7E29F2CEF6DC0@BYAPR02MB4311.namprd02.prod.outlook.com>
 <BYAPR02MB43110062F32BFDEA712AB371F6DC0@BYAPR02MB4311.namprd02.prod.outlook.com>
 <CAChUvXMp6S6MBY_LmrfgdPcctQw70FoyxbiHeFqK+5fQx5omCw@mail.gmail.com>
 <CAChUvXP6eu76xqEZNspooUMb+311mmDH8=St=awCL77hJPus9Q@mail.gmail.com>
 <20181117140513.GA4944@zn.tnic> <CAChUvXNO_8Frw1igaEAHSxmdtTy7MJVm8W1NpUqZ6tFD0hXwhA@mail.gmail.com>
 <0BF2A47F-7F33-4E4D-A566-23AF2F4CCD52@theinkpens.com> <CAChUvXMVHxhawLFPFzz_0+iFxjQ+dRwpTsCGo95oc8Y+7a-2DQ@mail.gmail.com>
 <AM0PR04MB3971FBCF6CB23BE778D39EED9AD80@AM0PR04MB3971.eurprd04.prod.outlook.com>
 <CAChUvXPCfwfHrntJHWpsydYZE=P692Axd0pFE+GjZCXtx1fgog@mail.gmail.com>
 <CAChUvXMWZ-LYyqnczM-bt9cDP0r1XT+F1dcYuRHiVcx=QR7_Jw@mail.gmail.com>
 <AM0PR04MB3971768EA5D50D7045B462619AD10@AM0PR04MB3971.eurprd04.prod.outlook.com>
 <CAChUvXN8rZqxBaV2qbdR8uymsmZAk_Jnc2kxSUf+kBf76QHV9A@mail.gmail.com> <AM0PR04MB3971FFCCDAF29E7DF0F0EE159AD10@AM0PR04MB3971.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB3971FFCCDAF29E7DF0F0EE159AD10@AM0PR04MB3971.eurprd04.prod.outlook.com>
From:   Tracy Smith <tlsmith3777@gmail.com>
Date:   Wed, 28 Nov 2018 16:14:24 -0600
Message-ID: <CAChUvXNz=XR37EeVRJFnF195BGgjPgCeFv6nbjR3yV2_mQwxBQ@mail.gmail.com>
Subject: Re: edac driver injection of uncorrected errors & utils
To:     york.sun@nxp.com
Cc:     linux-edac@vger.kernel.org, util-linux@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing appears in the logs or from the edac-util indicating there was
a multi-bit UE (uncorrected error). Just a crash and even then I'm not
100% certain it is caused by multi-bit errors without debugging the
crash. It happened when writing a 1 to inject_data_lo/inject_data_hi
and 0x100 to inject_ctrl.

Is there another way of creating an uncorrected error without crashing
Linux using the layerscape driver? I would like to see a UE error
collected without a Linux crash scenario because I need to validate
UEs are being collected.

Does the AMD platform, or other memory controllers crash Linux on
multi-bit errors and fail to collect uncorrected errors?  This is a
concern in the field since there is no way of knowing that multi-bit
errors occurred and that multi-bit errors caused the crash.

For production and in the field, can't have the Linux kernel or
layerscape driver crashing the kernel when there are multi-bit errors
and not giving any information on what caused the crash in the kernel
log. First, it could cost millions in high critical use cases.
Second, it is should be preventable.

So two concerns/questions:

1. Need a way to validate UE errors are captured without crashing the kernel
2. On multi-bit errors need a way to catch a UE before a kernel crash
and ideally prevent the kernel from crashing on multi-bit errors

Any recommendations?

Scenario produced on an ARM layerscape board.

echo 1 > /sys/devices/system/edac/mc/mc0/inject_data_lo
echo 1 > /sys/devices/system/edac/mc/mc0/inject_data_hi
echo 0x100 > /sys/devices/system/edac/mc/mc0/inject_ctrl

[495.327720] CPU: 3 PID: 1239 Comm: sh Not tainted 4.1.35-rt41#1
[  495.327723] EDAC FSL_DDR MC0: Err Detect Register: 0x80000008
[  495.327725] Hardware name: LS1043A Board (DT)
[  495.327735] task: ffff800063dd3300 ti: ffff800073358000 task.ti:
ffff800073358000
[  495.327740] PC is at 0x42cf80
[  495.327742] LR is at 0x42d20c
[  495.327745] pc : [<000000000042cf80>] lr : [<000000000042d20c>]
pstate: 20000000
[  495.327746] sp : ffff80007335bff0
[  495.327751] x29: 0000ffffd1f0b6e0 x28: 00000000004e0000
[  495.327756] x27: 000000003cdf81b0 x26: 00000000004d8000
[  495.327760] x25: 00000000004aea80 x24: 00000000004aea88
[  495.327764] x23: 00000000004e1000 x22: 00000000004c0e10
[  495.327768] x21: 00000000004aed98 x20: 00000000004ae868
[  495.327772] x19: 00000000004ae868 x18: 0000000000000015
[  495.327776] x17: 0000ffff7a24fb48 x16: 00000000004d8638
[  495.327781] x15: 002372c270000000 x14: ffffffffffffffff
[  495.327785] x13: 0000000000000018 x12: 0000000000000028
[  495.327789] x11: 0000000000000038 x10: 0101010101010101
[  495.327793] x9 : fefefefefefefeff x8 : 000000003ce19f50
[  495.327797] x7 : 0000ffffd1f0b9e8 x6 : 0000000000000000
[  495.327801] x5 : 00000000004e1dd0 x4 : 000000003ce19e50
[  495.327805] x3 : 0000000000000000 x2 : 0000ffffd1f0b7f0
[  495.327809] x1 : 0000ffffd1f0b7e0 x0 : 00000000004ae868
[  495.327810]
[  495.327817] Unhandled fault: synchronous external abort
(0x96000210) at 0xffff800000e1ec10
On Wed, Nov 28, 2018 at 1:24 PM York Sun <york.sun@nxp.com> wrote:
>
> Tracy,
>
> This DDR controller doesn't have the capability to inject limited
> errors. As soon as you enable the error injection, all memory
> transactions will carry the error. Since multi-bit errors are not
> correctable. I don't expect Linux to work properly with these errors.
>
> York
>
>
> On 11/28/18 1:11 PM, Tracy Smith wrote:
> > Thanks York. Why will injecting multi-bit errors crash linux?  Is this
> > the case only for layerscape?  Is there a way to harden against this?
> >
> > On Wed, Nov 28, 2018 at 1:06 PM York Sun <york.sun@nxp.com> wrote:
> >>
> >> Tracy,
> >>
> >> You can inject multiple-bit errors. You will crash the system for doing
> >> that. I can't comment on edac-util.
> >>
> >> York
> >>
> >>
> >> On 11/28/18 12:49 PM, Tracy Smith wrote:
> >>> Can I inject a uncorrected error or only corrected errors using the
> >>> layerscape edac driver injection via sysfs?
> >>>
> >>> Is this the expected output for the edac-util on layerscape when
> >>> injecting errors?
> >>>
> >>> root@ls1043ardb:~# edac-util -v
> >>> mc0: 0 Uncorrected Errors with no DIMM info
> >>> mc0: 0 Corrected Errors with no DIMM info
> >>> mc0: csrow0: 0 Uncorrected Errors
> >>> mc0: csrow0: mc#0csrow#0channel#0: 643 Corrected Errors
> >>>
> >>> root@ls1043ardb:~# edac-util -vs
> >>> edac-util: EDAC drivers are loaded. 1 MC detected:
> >>> mc0:fsl_mc_err
> >>>
> >>> root@ls1043ardb:~# edac-util
> >>> mc0: csrow0: mc#0csrow#0channel#0: 2700 Corrected Errors
> >>>
> >>> Does edac-ctl function on ARM based platforms or only on x86 and why
> >>> might it show 0MB for the memory layout for DDR4 as below?
> >>>
> >>> /run/media/nvme0n1p1/tls/neo_mcu-kernel/drivers/edac-utils# edac-ctl
> >>> --layoutreadline() on closed filehandle IN at /usr/sbin/edac-ctl line
> >>> 514.
> >>> Use of uninitialized value $size in sprintf at /usr/sbin/edac-ctl line 533.
> >>> Use of uninitialized value $size in sprintf at /usr/sbin/edac-ctl line 533.
> >>> Use of uninitialized value $size in sprintf at /usr/sbin/edac-ctl line 533.
> >>> Use of uninitialized value $size in sprintf at /usr/sbin/edac-ctl line 533.
> >>>           +-----------------------------------------------+
> >>>           |                      mc0                      |
> >>>           |  csrow0   |  csrow1   |  csrow2   |  csrow3   |
> >>> ----------+-----------------------------------------------+
> >>> channel0: |     0 MB  |     0 MB  |     0 MB  |     0 MB  |
> >>> ----------+-----------------------------------------------+
> >>>
> >>
> >
> >
> > --
> > Confidentiality notice: This e-mail message, including any
> > attachments, may contain legally privileged and/or confidential
> > information. If you are not the intended recipient(s), please
> > immediately notify the sender and delete this e-mail message.
> >
>


-- 
Confidentiality notice: This e-mail message, including any
attachments, may contain legally privileged and/or confidential
information. If you are not the intended recipient(s), please
immediately notify the sender and delete this e-mail message.
