Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751133AbeEBGAz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 02:00:55 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:38595 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbeEBGAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 02:00:54 -0400
X-Google-Smtp-Source: AB8JxZrbJuvCPLYldcSMnMSlpVOkJi1vKPZYbrcgJh2HqoQ2tRmnlsAZteGX8o0jq3XMrL2QSy3GrDmvBghmRZpm0FA=
MIME-Version: 1.0
In-Reply-To: <DM3PR12MB0873246BA4A3462050AC10E299800@DM3PR12MB0873.namprd12.prod.outlook.com>
References: <CA+7wUszgY3uFVfMe4T-_5x9KuzWNSgKHXcRKgfcmpE+Keo73Vg@mail.gmail.com>
 <fefee930-1eca-4819-4e02-7ba4a7487dee@amd.com> <DM3PR12MB0873246BA4A3462050AC10E299800@DM3PR12MB0873.namprd12.prod.outlook.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Wed, 2 May 2018 08:00:33 +0200
X-Google-Sender-Auth: wgFbauXSZA4py4IfP_V6wG-M8FM
Message-ID: <CA+7wUswikSEhxoovvsVR7P4m5ju6Jy1G2ZNCV1CsT=acXhDUGw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=E7=AD=94=E5=A4=8D=3A_Tracking=3A_radeon_0000=3A00=3A10=2E0=3A_ring_0_st?=
        =?UTF-8?Q?alled_for_more_than_10240msec?=
To: "Qu, Jim" <Jim.Qu@amd.com>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4261148003917

Hi all,

On Wed, May 2, 2018 at 4:39 AM, Qu, Jim <Jim.Qu@amd.com> wrote:
> Hi ,
>
> If you are sure that the HW worked fine before. I think you should:
>
> 1. Be sure that HW works fine now.
> 2. recall the driver to the point at where it works well, and then replace them one by one to confirm component which causes the issue.
> 3. try to update the last VBIOS to adapt new driver.
>
> Thanks
> JimQu
>
> ________________________________________
> 发件人: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> 代表 Christian König <christian.koenig@amd.com>
> 发送时间: 2018年4月30日 1:16:14
> 收件人: Mathieu Malaterre; Deucher, Alexander
> 抄送: David Airlie; Zhou, David(ChunMing); dri-devel; amd-gfx@lists.freedesktop.org; LKML
> 主题: Re: Tracking: radeon 0000:00:10.0: ring 0 stalled for more than 10240msec
>
> Am 23.04.2018 um 20:50 schrieb Mathieu Malaterre:
>> Hi there,
>>
>> I am pretty sure I was able to run kodi on an old Mac Mini G4 (big
>> endian) with AMD RV280. Today it is failing to start with:
>
> Well, that is rather old hardware. I suggest to make sure first that the
> hw isn't broken in some way.
>
>> How should I go and debug this (other than plain git-bisect) ?
>
> You first need to figure out what's the failing component. Either Mesa,
> DDX or the Kernel are possible candidates.
>
> Another possibility is that you updated kodi and kodi is now doing
> something the hw doesn't like.

That was my mistake, I forgot about AGP vs PCI on radeon. Should be
fixed in next release:

https://patchwork.kernel.org/patch/10360887/

> Regards,
> Christian.
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
