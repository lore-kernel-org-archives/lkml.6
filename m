Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD81C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 05:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70712086E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 05:02:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B70712086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbeIZLNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 07:13:42 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53574 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbeIZLNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 07:13:42 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: koike)
        with ESMTPSA id E186E263B51
Subject: Re: [PATCH 0/2] boot to a mapped device
From:   Helen Koike <helen.koike@collabora.com>
To:     dm-devel@redhat.com
Cc:     agk@redhat.com, snitzer@redhat.com, linux-kernel@vger.kernel.org,
        enric.balletbo@collabora.com, wad@chromium.org,
        linux-doc@vger.kernel.org, linux-lvm@redhat.com,
        kernel@collabora.com
References: <cover.1537936397.git.helen.koike@collabora.com>
Openpgp: preference=signencrypt
Autocrypt: addr=helen.koike@collabora.com; keydata=
 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
Message-ID: <610d5f5e-ea07-631d-04d3-18fd3da0fe2a@collabora.com>
Date:   Wed, 26 Sep 2018 02:02:25 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <cover.1537936397.git.helen.koike@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/26/18 2:00 AM, Helen Koike wrote:
> This series is reviving an old patchwork.
> Booting from a mapped device requires an initramfs. This series is
> allows for device-mapper targets to be configured at boot time for
> use early in the boot process (as the root device or otherwise).
> 
> Example, the following could be added in the boot parameters.
> dm="lroot,,,rw, 0 4096 linear 98:16 0, 4096 4096 linear 98:32 0" root=/dev/dm-0
> 
> Enric Balletbo i Serra (1):
>   dm ioctl: add a device mapper ioctl function.
> 
> Will Drewry (1):
>   init: add support to directly boot to a mapped device
> 
>  .../admin-guide/kernel-parameters.rst         |   1 +
>  .../admin-guide/kernel-parameters.txt         |   3 +
>  Documentation/device-mapper/dm-boot.txt       |  63 +++
>  drivers/md/dm-ioctl.c                         |  50 ++
>  include/linux/device-mapper.h                 |   6 +
>  init/Makefile                                 |   1 +
>  init/do_mounts.c                              |   1 +
>  init/do_mounts.h                              |  10 +
>  init/do_mounts_dm.c                           | 475 ++++++++++++++++++
>  9 files changed, 610 insertions(+)
>  create mode 100644 Documentation/device-mapper/dm-boot.txt
>  create mode 100644 init/do_mounts_dm.c
> 

Sorry about sending this email multiple times, my git send-email wans't
properly configured.

Helen
