Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D807C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E892150E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMYiAP5e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23E892150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387601AbeHBPWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 11:22:30 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:43923 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387569AbeHBPWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 11:22:30 -0400
Received: by mail-io0-f194.google.com with SMTP id y10-v6so1777460ioa.10;
        Thu, 02 Aug 2018 06:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0pHMjIl6Vb3EaDIrGcHCh8h5y95IxbFQUCGvk51MQuA=;
        b=aMYiAP5eD+YvuS/s6Mym/DoyDbW7LlcDVkyKTegf6Tzbj/iPz7LOL9tAzeVlz30inR
         itdAbYPaQxOTlS4LjdLg/Agrd8eykgpe2xsUVPBo/VBmsGeLADPwvK85DkAoLnBaFIf4
         lFZVIcjOjlq3XOA2q13xHqKGzRnW9n/Q+m37/YVQheljeN9uYAljq+qvmVX6Flfg4Pzf
         ndbyw6Z0YwyWK7xprvxxkXkWqMfPoKCX/Dqn0Fek0RGdG7MZk1hBEZsYu4RXZrQU9WBt
         8+NDF1tNyb7MtLuze0ElJFg8hSOO1JBO0e0hKIrkCvp9R7IzuCi4qrJ6JrRVtNOOJAYI
         PIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0pHMjIl6Vb3EaDIrGcHCh8h5y95IxbFQUCGvk51MQuA=;
        b=VMxrF/yWeJdBCwk6bQa9Y0dQ7CT3R+busCXMZSEzyYsBT+JUsa4QY9lAsRndtnWk+n
         EPHNXW6kEPEUAET5mCzxTIoKHVhekNiBQJkyI4A0Mr2TbbTk/Lj6WsGZfeNKg6mNxJql
         CO8Xmie88soD7gy9k0HU+BOFuuPzirr5Ma/mDsn6o11DZrXt62wWZP2vmOppuua0qZpB
         /CNZNMV9ba/jL7UEhTIgKgsxWBl7kE3ppKy/qXaOhSouiv1sx0TzHWuSJ5j9jkyaqiHJ
         viO+HThzf0hUJgg18ilK6UUEYsQxq9Qi3F4aLTfb6hQclsN2c10s/Um31wduqBC1C/mC
         xROQ==
X-Gm-Message-State: AOUpUlEw/4V3t7+KJWwAeQJdvn3nDxsBjWVigvYGqU5C3NjFAPNz3XeY
        uZg0lmBzRfG8WhB+nTmocWMzadEt+wfczih+RiY=
X-Google-Smtp-Source: AA+uWPwD1Y8d67O6AK1SPI4au+aKG/ADzPy2RwHC5UpDNFEGHljRv7C4bgYSQ56GfI1T2atrwaSIts7rlgl0XFJkI+8=
X-Received: by 2002:a6b:b5ca:: with SMTP id e193-v6mr2332128iof.153.1533216676133;
 Thu, 02 Aug 2018 06:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <226835ba-2197-b850-6e5b-8ba14f7fd016@torlan.ru>
In-Reply-To: <226835ba-2197-b850-6e5b-8ba14f7fd016@torlan.ru>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Thu, 2 Aug 2018 15:31:05 +0200
Message-ID: <CAOi1vP_tYG77e71CdDiOcszSSEWrp9Vfi+KB7yFAXVQChkjP5A@mail.gmail.com>
Subject: Re: LVM snapshot broke between 4.14 and 4.16
To:     wgh@torlan.ru
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 2, 2018 at 2:26 PM WGH <wgh@torlan.ru> wrote:
>
> (I originally reported this problem here:
> https://bugzilla.kernel.org/show_bug.cgi?id=200439)
>
> When I updated from 4.14 to 4.16, my LVM snapshotting script broke for
> no apparent reason.
>
> My script has the following line, and it fails like this:
> + lvcreate --size 5G --snapshot --name snap0 --permission r
> /dev/mapper/vg0-lvol_rootfs
>   device-mapper: create ioctl on
> vg0-snap0-cowLVM-sDdIeh9cecWdaNyRfZC31mxgfwTa4sOeHMJXVOykGVRtfP6Aii7IHvwS066AOLOM-cow
> failed: Device or resource busy
>   Failed to lock logical volume vg0/lvol_rootfs.
>   Aborting. Manual intervention required.
>
> At the same time, some errors appear in dmesg as well:
> [   26.145279] generic_make_request: Trying to write to read-only
> block-device dm-3 (partno 0)
> [   26.145288] device-mapper: persistent snapshot: write_header failed
> [   26.145847] device-mapper: table: 253:4: snapshot: Failed to read
> snapshot metadata
> [   26.145851] device-mapper: ioctl: error adding target to table
>
> I bisected the vanilla kernel, and the first bad commit is
> [721c7fc701c71f693307d274d2b346a1ecd4a534] block: fail op_is_write()
> requests to read-only partitions

Adding Mike and dm-devel.

From a quick look, --permission r sets DM_READONLY_FLAG, which makes dm
mark the disk read-only with set_disk_ro(dm_disk(md), 1) in do_resume().
A bit later it tries to write to the disk from write_header():

  return chunk_io(ps, ps->header_area, 0, REQ_OP_WRITE, 0, 1);

Thanks,

                Ilya
