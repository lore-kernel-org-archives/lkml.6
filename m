Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074A9C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B834E21571
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ri9as459"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B834E21571
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbeI1EGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 00:06:32 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39135 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbeI1EGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 00:06:32 -0400
Received: by mail-ot1-f66.google.com with SMTP id c12-v6so4074088otl.6;
        Thu, 27 Sep 2018 14:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=THYWGhLO41z/+J0uqmBPqJ8ik0BoST7EKDVnPFEVwsk=;
        b=ri9as459/nRkuLRLRws8xciYNh+i80C87lhOTqbmh1LaifwK+mIlKqTOZldLuEBFbE
         hnq4T7Noil711f20ml7GKOOpceHY+r29+ajW/qRmK9eM6BJl6iToBXajeHaP+526bU92
         l/iaaj1OWe02/fYwQdJ6TgoUua8rLtcf5E2fM9xr9VB2LzgW2DLUq++Hxa6yprUjHK3k
         lhfAtPGfwHCkjApThVONNFlhNzaf7iJQCYsy6X7OrHiIFf30en0gy+wPo/8F08di44iD
         Kkp0aamCsdDSS2jpxwhBpNkOkRCp70l6wuqGkX5upA3Kzi7xg+AxBkEESsJJx7G9qMpw
         dMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=THYWGhLO41z/+J0uqmBPqJ8ik0BoST7EKDVnPFEVwsk=;
        b=BpQ6KqcOKam7fu4LaFNHysqhttyTWZCD8DTOCAabdobiht2fHXq2xrIb7580sAoIfD
         wLqP5nJ7MtrANXmOYYVDCqAHoFCGRrVbhsNEmTlUIKDixkRTADRxppk6ufvHXeduUbeD
         SiZrHiwbKwBaOvJ7UcGAYdotTotsJUgjuJFmFRsSHlHR15Qw2O6CTzvARjkMy4VoF01h
         JXiHVfSy5JMAkl0SZooSil8Zj1vb2USBLQpGTmPl5qvyul1Vxfm6gUuS0Efo7lzCls5t
         3Bfjk9bGFG5e4f0e0524q3y98wyjem+YCB1ruSm1YizVT/Rzscly7PWp7oeEY7pngyb7
         aboQ==
X-Gm-Message-State: ABuFfoiP/vCgZD2FPA1w2kEdFoC+eM0fSG7+9zb8JLljSZwJAPMQMSam
        8scQfshG7C+PuucEDmm1t88C2tMbFetev7R7YTE=
X-Google-Smtp-Source: ACcGV602wL2J9nsPBp03Qxyk72vt65owABp+vj4OqMqjVDFrz+nxfVhgimXUZaArX8N7UpZPX6RzWSqBoOgmKh06aDw=
X-Received: by 2002:a9d:7c3:: with SMTP id 61-v6mr7209801oto.156.1538084770686;
 Thu, 27 Sep 2018 14:46:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:59c3:0:0:0:0:0 with HTTP; Thu, 27 Sep 2018 14:45:30
 -0700 (PDT)
In-Reply-To: <CADVatmNwDEvdtpzvwo2ppCaLXgiyweLJStRBu_+ieyCz91eR1Q@mail.gmail.com>
References: <20180927090249.801943776@linuxfoundation.org> <CADVatmNwDEvdtpzvwo2ppCaLXgiyweLJStRBu_+ieyCz91eR1Q@mail.gmail.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Thu, 27 Sep 2018 22:45:30 +0100
Message-ID: <CADVatmNrfhM6RdokTGtD1jn6ABxXDxTzy7qUwjLpp8doLECo7g@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/64] 4.14.73-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org, Stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, Sep 27, 2018 at 9:56 PM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
> Hi Greg,
>
> On Thu, Sep 27, 2018 at 10:03 AM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>> This is the start of the stable review cycle for the 4.14.73 release.
>> There are 64 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Sat Sep 29 09:02:21 UTC 2018.
>> Anything received after that time might be too late.
>
> My kvm guest had this:
>

<snip>

> [    8.585076] RIP: drm_debugfs_init+0x183/0x370 [drm] RSP: ffff88002b1bf5e8
> [    8.585404] ---[ end trace 62728db3ac408aba ]---
>
> And I had to revert 7e58fe2a97bc ("drm/atomic: Use
> drm_drv_uses_atomic_modeset() for debugfs creation") to make it work.
> I am looking more into why it failed.

update:

Backporting 57078338b2e4 ("drm: fix drm_drv_uses_atomic_modeset on non
modesetting drivers.") fixed the issue. But 7e58fe2a97bc ("drm/atomic:
Use drm_drv_uses_atomic_modeset() for debugfs creation") changed the
functionality of the check. If this has to be applied, it will also
need an additional patch to keep the check same as linus tree.

But looking at the other mails now, and you have already dropped the patch.


-- 
Regards
Sudip
