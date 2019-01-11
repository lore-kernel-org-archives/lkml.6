Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACD2C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 952D720879
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3QEIaJq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbfAKCrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 21:47:15 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:46742 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729919AbfAKCrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 21:47:15 -0500
Received: by mail-ot1-f50.google.com with SMTP id w25so11876209otm.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 18:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RkfDT/DdamgeXmHsKiNqXvMWEuq5XHT1H7rozNSeh3E=;
        b=R3QEIaJqT540aMDIkEFhsf1ijyROofZNrBk70LpQYtdlaqte4BlzMxzQZCVWO62EjD
         9ma3sI29VX3cLtpcvSsJ3Sk7krwx1L2rozOcg+YWsqEL740h7n9X431LIv34r8VgBVce
         4RxJVD3fajtZiFTeMzx9fvENAN0HzvymEg1uCWZ984w9xz9N2O95ASiaLWexmRBi5fPJ
         RFuUlAxM2xQlY3gh6SrGijvbqfdvw/WNEe1d/+OFAM3xuJ4tDrYv6Hm/YrncEHhw3vTa
         4Gghsuew/XoHKh/R5MBGcM3N3IBzlWR4++i8gmPEhaFbJwp/jDEIBY/CsLsQHm9SxIxh
         hBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RkfDT/DdamgeXmHsKiNqXvMWEuq5XHT1H7rozNSeh3E=;
        b=LiRgWzyRWIgJeaFqfSnmMIvw/L+HZKty+kewb+4MKiZT5h4JoffYzrTb1HPc6ux/ax
         qjIBGsFdkapiJlVOulVgqa6wYCSzKaEv2ohdak9HZDUraTKBcU8+oOMV3gMraiKzycqK
         Lu9qFWTvkPUH+vbTV3M7nxWVKeQ6PFnA97NLKHfPPpJohifjsel9C+ewjQrFZafUyqb0
         lcP2o/mBuK5ap/s31ZHSKk3TDkwg7m3dHM5dKX7xCmE5rYWUUljYB5/cu2WiZEv5BOtg
         8ivg6cWbYalnrBumLP+zFKFsj0OypdeXMIvIGGPIr9uwsdiuabXny/QahBFlY393CUZB
         6T8Q==
X-Gm-Message-State: AJcUukdIovzvKfmPm3gvg4BfB1Xogoiqr8xAEF1nn0IcBYYA4QXKg/ds
        hrfGODk7a4t1jUNe8lcKXAN9M2H/cwsrwB3FMBs=
X-Google-Smtp-Source: ALg8bN4dhBWW206SuWstFhNs5TiGjps02KdUyIADHSvo9z19fom4scujlWT71wMW+CILkVjzXrO/wz8tnmXR2KlTx2A=
X-Received: by 2002:a9d:4f0e:: with SMTP id d14mr8868786otl.259.1547174834364;
 Thu, 10 Jan 2019 18:47:14 -0800 (PST)
MIME-Version: 1.0
References: <CA+X5Wn4s2_zEvAHzT+dXToht=TBCyqBxVVnOPCrSTa_=_sxV6g@mail.gmail.com>
 <yq14lag12pa.fsf@oracle.com>
In-Reply-To: <yq14lag12pa.fsf@oracle.com>
From:   james harvey <jamespharvey20@gmail.com>
Date:   Thu, 10 Jan 2019 21:47:03 -0500
Message-ID: <CA+X5Wn5LH149=sDXqL-O9j1qMjNUVTrucnfyGyN_=ujPOun2dQ@mail.gmail.com>
Subject: Re: Interpreting /sys/block/<disk>/{,<partition>}/discard_alignment
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>, jaxboe@fusionio.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 7:04 PM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
> James,
>
> > Q1 - I'm hoping you can clarify how this should be interpreted.
> >
> > I originally took this to mean the number of bytes into the first
> > discard_granularity block that the partition resides at.  i.e.  If
> > discard_granularity_block is 128MB, and partition 1 starts at sector
> > 2048 with 512 byte sectors, that this should return 2048*512=1048576
> > (1MB.)
>
> The alignment offset is the offset for the given block device. It
> doesn't matter whether the block device in question is a partition, DM
> device or a full device. A block device is a block device.
>
> The common alignment scenario is 3584 on a device with 4K physical
> blocks. That's because of the 63-sector legacy FAT partition table
> offset. Which essentially means that the first LBA is misaligned and the
> first aligned HBA is 7.

If I can double check I'm understanding you correctly, if:

* Block device "A" has 512 byte sectors
* A has a partition table with partition A1 starting at sector 2048
(1048576 bytes)
* A and A1 have discard_granularity of 128MB (134217728 bytes)
* A has discard_alignment of 0

Then A1 should have a discard_alignment of 1048576, not 133169152
(128MB - 512 bytes/sector * 2048 sectors)?

> Many of the first 512e drives shipped with that intentional misalignment
> as default. And you could switch it to 0-aligned via a jumper. These
> days all drives are 0-aligned.
>
> > Q2 - At https://lkml.org/lkml/2018/12/5/1693 --- I saw you recently
> > said "... there are not many devices that actually report a non-zero
> > discard alignment..."  Does this mean that every filesystem needs to
> > look at the partition table to determine its correct value on its own,
> > rather than using discard_alignment?
>
> No, it needs to look at the device topology for the block device it is
> on. I don't believe we ever wired up an ioctl for the discard alignment
> so you'll have to find your device in sysfs. There's an alignment ioctl
> for the "regular" block alignment, though.

Ahh, good.  I took that the wrong way, originally worried you were
saying the value of discard_alignment couldn't be trusted.
