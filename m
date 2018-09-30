Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9F2C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 04:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007BC206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 04:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8rPTu6l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007BC206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbeI3Kxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 06:53:48 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34653 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbeI3Kxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 06:53:48 -0400
Received: by mail-ot1-f68.google.com with SMTP id i12-v6so9825158otl.1;
        Sat, 29 Sep 2018 21:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=bk9jvyuzPplde5TaMpIyFRx2JbKiIWgpAozgxYbq2ak=;
        b=b8rPTu6lq5GqJPANw+MaYFrvLTQYEt93wAF7hrxhkRm50NHcOegDur5lcB7HV7FHD7
         7iZxnPt1fOOtdnpJqPJUTSsWfUpVfNet8IvQF4fCTPYNLz5vMvOdPevsHwKVrrKQXJPw
         5vBfMLffmhwS4Fl+H5PtFr1xWjy9F+j0qQ3qbapMzj+54/91SIDDqi2JzdZ65VsxjGIO
         zqeW96Egl1lxLpfHymOw2LrnQBA/6CEOQco2ZYg8lgTBMrs7ft5RbuZyrgJ5DrYEzqMY
         ozHZxGtiSHpugWyaHM3pXpeA4xohKTsiJvx3/bWqyD42+TficKg+XF9iMdlah58Vzo9g
         7NQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=bk9jvyuzPplde5TaMpIyFRx2JbKiIWgpAozgxYbq2ak=;
        b=uKbN41Gx6Ih3dsV6D3qJi+Vek1FrksL8TKCZNPYYFFyuLcNYYV9qVgWAP0b44+kU6u
         8MZrbU8VtIjph1Kn908WaVJxE/E6n4xud712TB5RRXR5YFyVpMVzCLl1/e1bpDwRsPTd
         EjFHTk2ezPdmrEQCZXa/cWOV1fEXwQ4UkOPgeZuWrDGA354V1vWgTyYhSToSdq/kzXR7
         0H1h11Y7n9WTDTv96nmyf7tnItbSsVs0HaxZKobNYXrF5IvJwopMHiQUuscmtr8WGAL2
         r+WveUoWb0Ksm2FZfo/NHB2nSRVMYR9+m2pvqaquYN9ib6TFDYHhP0cbtyFK8j0K2Cjg
         GydA==
X-Gm-Message-State: ABuFfoghqPI465Ekhf24bpy0D275uK3EdC+YQu0t6E505Qz2laD7YU7H
        7xKCt6bD9b6QQfiDMaX+fKI=
X-Google-Smtp-Source: ACcGV624b67eVg0y+ziA3/Wjr0t/1KcvDDpziSpp+k+6Mnbyyyv4Oa0fYqeNHq2j4jDC5jvagZ/pVg==
X-Received: by 2002:a9d:9a1:: with SMTP id q30-v6mr3082010otd.351.1538281346658;
        Sat, 29 Sep 2018 21:22:26 -0700 (PDT)
Received: from nexus5x-flo.lan (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id l13-v6sm3405935otk.25.2018.09.29.21.22.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 21:22:25 -0700 (PDT)
Date:   Sat, 29 Sep 2018 21:22:19 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <31fa33d5-afc2-b388-95f7-103451e9df3e@kernel.dk>
References: <20180920191646.18198-1-f.fainelli@gmail.com> <7b6e1671-8efe-20d2-d3a2-51a521ce7f22@gmail.com> <fa91f7eb-3405-4607-9391-f043b73e7af6@ti.com> <3d4b406b-4fa4-9248-a0ab-d4eeea808034@gmail.com> <58d4992a-a06e-60e7-1856-5cd87741a771@gmail.com> <20180929085622.GD270328@devbig004.ftw2.facebook.com> <31fa33d5-afc2-b388-95f7-103451e9df3e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/9] AHCI and SATA PHY support for BCM63138
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Al Cooper <alcooperx@gmail.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <CB3DCBF1-3ABB-41F1-8D5B-7444093BA927@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On September 29, 2018 7:35:14 PM PDT, Jens Axboe <axboe@kernel=2Edk> wrote=
:
>On 9/29/18 2:56 AM, Tejun Heo wrote:
>> On Fri, Sep 28, 2018 at 03:41:23PM -0700, Florian Fainelli wrote:
>>> On 09/25/2018 09:12 AM, Florian Fainelli wrote:
>>>> On 09/24/2018 11:19 PM, Kishon Vijay Abraham I wrote:
>>>>> On Friday 21 September 2018 12:49 AM, Florian Fainelli wrote:
>>>>>> On 09/20/2018 12:16 PM, Florian Fainelli wrote:
>>>>>>> Hi Kishon, Tejun,
>>>>>>>
>>>>>>> This patch series adds support for the SATA AHCI and PHY found
>on the
>>>>>>> ARM-basd BCM63138 DSL SoCs=2E
>>>>>>>
>>>>>>> It would probably make sense for patches 1-3 to go through
>Kishon's
>>>>>>> tree, patches 4-7 through Tejun's tree, and I would be merging
>the last
>>>>>>> two patches through the Broadcom ARM-SoC tree=2E
>>>>>>>
>>>>>>> Let me know if this is not a workable plan, thank you very much!
>>>>>>
>>>>>> Looks like I had left patches with the incorrect subject, please
>>>>>> disregard the following patches:
>>>>>>
>>>>>> [PATCH 2/9] phy: broadcom: allow PHY_BRCM_SATA driver to be built
>for
>>>>>> DSL SoCs
>>>>>> [PATCH 5/9] ata: sata_brcmstb: Allow optional reset controller to
>be used
>>>>>> [PATCH 6/9] ata: ahci_brcmstb: Match 63138 compatible strings
>>>>>>
>>>>>> since they have incorrect/inconsistent titles, the other patches
>are
>>>>>> fine though=2E Sorry about that=2E
>>>>>
>>>>> merged the first 3 patches to linux-phy tree=2E
>>>>
>>>> Thanks a lot Kishon!
>>>
>>> Tejun, are you good with picking up patches 4-7 and I take the last
>two?
>>> Can you make sure you pick up the ones that contain "ahci_brcm" in
>their
>>> subject, I had incorrectly formatted them initially, sorry again
>about that=2E
>>=20
>> Jens is running the libata tree now=2E  Jens?
>
>I looked over them, but the series seems somewhat messed up=2E Can you
>resend 4-7?

Certainly, I accidentally sent duplicates that I had left in the directory=
=2E

--=20
Florian
