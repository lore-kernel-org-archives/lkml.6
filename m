Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF321C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 18:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 763FB2195D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 18:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="SKQKlZp9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390360AbeLVSGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 13:06:33 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38427 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730265AbeLVSGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 13:06:33 -0500
Received: by mail-oi1-f195.google.com with SMTP id a77so7368431oii.5;
        Sat, 22 Dec 2018 10:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ti/Vp6wkf6ZyGOiieNrE2yfEOFRhZvM6Epz2VnXu5YI=;
        b=SKQKlZp9lFEpWItU9xh9WbtVcS8fsx/TrFYawaXArRZqwv/3rPYwQKILz699+ykZp/
         3QTjdEAJh2PNibB0dK3KSv/ZVbYLqkWkKfYLe7RQraCTqz7HcHllUYqPtZu5gVtyk4v7
         zSWb8wXYMscOYWgy11PfVR+xF693MLk+oEv88XXqJhzEK1QezVLt51JxDpJu1c9sNpVv
         dNUEPsjkpzw3Hzy83x9E2gl8l10rHgMmMNYminLr40N2UptL5tf0ynKkkDiVm0Fjp+Ni
         pSwoFxm9jCaTBC2cBgIh0+hlqW0vAx31RWoBTVPDz9Ni/nET24E1pDNEfDUUI7DdHctF
         sGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ti/Vp6wkf6ZyGOiieNrE2yfEOFRhZvM6Epz2VnXu5YI=;
        b=t7dwpgKu+F/08jZJYdXpSoPcpzMQujNMEB1pXWcvQH3OI//If6yCnKWktnb+jDxRep
         WASmTAGcF/dp52caaYv2+fYDZqQ+ZStPsT2z+Zo6DrMaqLoHt1pfJp3i6KTRVzU/bmQw
         LdmyRAPxPhvw7IqF9K8796t0cCddlMQMWCtwLcngpnUx0r2dmSdsf/oBRdaDt7Lwxc/N
         fxOFIHR8nTIPadrGlaBHejXsgoQUrQRtYEHRe5SO8oUQssomHqWLQQ78I/8STFjiRBN3
         MmHf31QdUcNzVIocDZyPKItxz+72p+yV7Ep5AsQ5xEUJT4QUbCopnzhDKzaok/lLyqsX
         QXrw==
X-Gm-Message-State: AA+aEWZ6b76tDw0ahfYjIkSEyogd1fSKAFzBk2YHFBvoVFquICabaZfv
        fj271OfDG4wf9gz5QpB5pVk/ANXhUjN82onDDTTFz0Fz
X-Google-Smtp-Source: AFSGD/Wii64BT9kDXdQWKsH8m63YO2YoWCdCo+DKm8xadrw8gjYxULW6U8TIU6l++dO2H4S3GnW+tYuqxwK67NQd9jc=
X-Received: by 2002:aca:3586:: with SMTP id c128mr3792475oia.47.1545476944218;
 Sat, 22 Dec 2018 03:09:04 -0800 (PST)
MIME-Version: 1.0
References: <20181221192820.26222-2-martin.blumenstingl@googlemail.com> <201812221401.4m4zuU4G%fengguang.wu@intel.com>
In-Reply-To: <201812221401.4m4zuU4G%fengguang.wu@intel.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 22 Dec 2018 12:08:53 +0100
Message-ID: <CAFBinCA=-st_bM0Cz7mu-Hq6Asv5HAXPMwDZUjMj6GqMb8s=hw@mail.gmail.com>
Subject: Re: [PATCH 1/1] f2fs: fix validation of the block count in sanity_check_raw_super
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, linux-f2fs-devel@lists.sourceforge.net,
        yuchao0@huawei.com, jaegeuk@kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 8:00 AM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Martin,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on f2fs/dev-test]
> [also build test WARNING on v4.20-rc7 next-20181221]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Martin-Blumenstingl/f2fs-fix-sanity_check_raw_super-on-big-endian-machines/20181222-142616
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
> config: i386-randconfig-x006-201850 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386
>
> All warnings (new ones prefixed by >>):
>
>    fs/f2fs/super.c: In function 'sanity_check_raw_super':
> >> fs/f2fs/super.c:2498:46: warning: format '%u' expects argument of type 'unsigned int', but argument 5 has type 'long long unsigned int' [-Wformat=]
>        "Wrong segment_count / block_count (%u > %u)",
>                                                 ~^
>                                                 %llu
I sent a v2 with this fixed and Chao Yu's reviewed by included
