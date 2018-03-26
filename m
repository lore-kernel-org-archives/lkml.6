Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752053AbeCZNYp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 09:24:45 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:33107 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751980AbeCZNYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 09:24:43 -0400
X-Google-Smtp-Source: AG47ELu6uSbDe8HRlV1wR869EU8TkUDMLPhECKk9Z3X7NWwSykVbnsXSvxeHz8k99OjoH+bb2Yy2jEOIskd8/TjzU5Q=
MIME-Version: 1.0
In-Reply-To: <C8603108370B1949BF3CC7742DDE5D35B8B42988@GSJPTKYDCEMBX32.service.hitachi.net>
References: <5AAFA682.2080901@hitachi.com> <5AB0E4F3.8090108@easystack.cn>
 <C8603108370B1949BF3CC7742DDE5D35B8B39FD9@GSjpTKYDCembx31.service.hitachi.net>
 <CAOi1vP8eLcc6u-XhpSu33+3eDygy3Mp+_tJXT7ygdwsnUs-RmQ@mail.gmail.com>
 <CAOi1vP_7La=nCs71wG3=HbYLaxM3uBFytv8pjGJLuR_uuB0GLg@mail.gmail.com> <C8603108370B1949BF3CC7742DDE5D35B8B42988@GSJPTKYDCEMBX32.service.hitachi.net>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 26 Mar 2018 15:24:41 +0200
Message-ID: <CAOi1vP_qFkDK00-_KJpbrnC3PbP371=R4wxBH8gk2s47qwfrhg@mail.gmail.com>
Subject: Re: Re: Re: [PATCH 1/2] rbd: RBD_DEV_FLAG_THICK rbd_dev_flags bit
To: =?UTF-8?B?5LqA5LqV5LuB5b+XIC8gS0FNRUnvvIxISVRPU0hJ?=
        <hitoshi.kamei.xm@hitachi.com>
Cc: Dongsheng Yang <dongsheng.yang@easystack.cn>,
        "sage@redhat.com" <sage@redhat.com>,
        "elder@kernel.org" <elder@kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2QDOnJF000797

On Mon, Mar 26, 2018 at 2:31 PM, 亀井仁志 / KAMEI，HITOSHI
<hitoshi.kamei.xm@hitachi.com> wrote:
> Hi Ilya,
>
> I think your patch fully completes our purpose and I confirmed
> that the kernel with the patch could work well by testing in my environment.
>
> I added the notrim option to rbd map command in accordance with
> your kernel rbd driver patch, and I pushed the patch to GitHub
> (https://github.com/hitoshikamei/ceph/tree/rbdmap-notrim).

Change the man page text to say

* notrim - Turn off discard and write zeroes offload support to avoid
  deprovisioning a fully provisioned image (since 4.17).  When enabled, discard
  requests will fail with -EOPNOTSUPP, write zeroes requests will fall back to
  manually zeroing.

and merge it into the first patch.

>
> So, could you please merge your patch to the kernel? If your patch is merged,
> then my patch can work, so I will send the Pull Request.

https://github.com/ceph/ceph-client/commit/7ddd22f2dd1d82da9a4cc0c54dc10760a53964f0

You can open the PR right now, we just won't merge it until the
kernel patch is in.

Thanks,

                Ilya
