Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648D7FC6183
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 05:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B50D20882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 05:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNUZ7TUi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B50D20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbeINKS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 06:18:27 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:39346 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbeINKS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 06:18:27 -0400
Received: by mail-yb1-f194.google.com with SMTP id c4-v6so4291473ybl.6;
        Thu, 13 Sep 2018 22:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JqrUnWv+B9rhHeVo/BJaqiQgDnER2A9r2DoAn6ut9yk=;
        b=QNUZ7TUinjYP8RU2Qjur9IwmdlI+p3aJfiCBFFRZ2Ng0QXIAhfpR+RMR75c2lq2p+e
         Hfu4N6GJ6QAX1zJAaM/pldrot/yK5EEDWuD2HpXaYDWiHQb46rcddGyZE3W7Dxw1/rvl
         zet7Fb2d5Ez3LQbguijwDRJK0u9ZCjmYXPIfwKql1Kkz2jgkdS8GjSN1HWIVehXUi2sJ
         fL5Juc3iigGhGM5+MFYzusNKiIN+aIa9JCrxK9zxxzHFlICoeDnpcUdrYveJGDGM4GHs
         Uw8Cs1yto0DeUMYxcrcZ2uMwSXkS/ovZJRSP88doEyktIejG3fKLcZWgzESgUUGUkWsL
         5UJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JqrUnWv+B9rhHeVo/BJaqiQgDnER2A9r2DoAn6ut9yk=;
        b=g0ldfsmp4anoepQwFa3ABxG5O7+JR+fzxQ3/wg0NKOfQOF94NF8xVFbeMHYjaSkSy6
         lNkTChNDDDMEBhkxQMiSiEWWojTR7bDa5qse6eXmFArEEhl3ChCMTrV3eMjIQjzt1pz4
         E0oZhdm0P9RsdzwKKXIDuvPc380SSboC78KTA8ahhIgSEJsD/tUaqaKFdVz336x5rozD
         /jZBsMZKe1prbhQv942FGMsN0gRMYG62JPA7qCEmKf9tShSZck/fBMLTNIVKNHfgsHPZ
         FNjUTANCDAqBMJkaHbidqmoqz0IHptYQWavxRws8Wl8ROf69tMDpHtEVB8jXYCAL7Ma5
         lLCw==
X-Gm-Message-State: APzg51DzXmHNeJtawpuUUJh+b1ot//rtQ4XZxHwP8lGz2z71nTY7on8E
        1wIKyyALGzNcHO4DtZWxaOhWvRg/5y+93xcabbQ=
X-Google-Smtp-Source: ANB0VdbgwpTUHYN6vkd1sQlGs9mu6y60ukjpN21Qwzy8VvlCmS5rbOuL/8nJ2UtTKBrlVYh38Evodt/1v15RX+dNn+8=
X-Received: by 2002:a5b:40c:: with SMTP id m12-v6mr4812828ybp.53.1536901542741;
 Thu, 13 Sep 2018 22:05:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:74d6:0:0:0:0:0 with HTTP; Thu, 13 Sep 2018 22:05:42
 -0700 (PDT)
In-Reply-To: <20180909115205.GA17732@ming.t460p>
References: <20180906203719.209399-1-xueweiz@google.com> <20180909115205.GA17732@ming.t460p>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Date:   Thu, 13 Sep 2018 22:05:42 -0700
Message-ID: <CAHo-OozTguSTmLv=eCsKysSMdphRDKo=eiD69URJ6MV_mrm_GQ@mail.gmail.com>
Subject: Re: [PATCH] scsi: sd: Contribute to randomness when running
 rotational device
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Xuewei Zhang <xueweiz@google.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aditya Kali <adityakali@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 9, 2018 at 4:52 AM, Ming Lei <ming.lei@redhat.com> wrote:
> On Thu, Sep 06, 2018 at 01:37:19PM -0700, Xuewei Zhang wrote:
>> Currently a scsi device won't contribute to kernel randomness when it
>> uses blk-mq. Since we commonly use scsi on rotational device with
>> blk-mq, it make sense to keep contributing to kernel randomness in these
>> cases. This is especially important for virtual machines.
>>
>> commit b5b6e8c8d3b4 ("scsi: virtio_scsi: fix IO hang caused by automatic
>> irq vector affinity") made all virtio-scsi device to use blk-mq, which
>> does not contribute to randomness today. So for a virtual machine only
>> having virtio-scsi disk (which is common), it will simple stop getting
>> randomness from its disks in today's implementation.
>>
>> With this patch, if the above VM has rotational virtio-scsi device, then
>> it can still benefit from the entropy generated from the disk.
>>
>> Reported-by: Xuewei Zhang <xueweiz@google.com>
>> Signed-off-by: Xuewei Zhang <xueweiz@google.com>
>> ---
>>  drivers/scsi/sd.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
>> index b79b366a94f7..5e4f10d28065 100644
>> --- a/drivers/scsi/sd.c
>> +++ b/drivers/scsi/sd.c
>> @@ -2959,6 +2959,9 @@ static void sd_read_block_characteristics(struct s=
csi_disk *sdkp)
>>       if (rot =3D=3D 1) {
>>               blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
>>               blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, q);
>> +     } else {
>> +             blk_queue_flag_clear(QUEUE_FLAG_NONROT, q);
>> +             blk_queue_flag_set(QUEUE_FLAG_ADD_RANDOM, q);
>>       }
>>
>>       if (sdkp->device->type =3D=3D TYPE_ZBC) {
>> --
>> 2.19.0.rc2.392.g5ba43deb5a-goog
>>
>
> Look reasonable, especially the disk randomness is added by SCSI itself.
>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
>
> Thanks,
> Ming

Also, see: https://bugzilla.redhat.com/show_bug.cgi?id=3D1572944
where we're having randomness starvation problems on FC28
running 4.18.5 due to lack of virtio-rng device in VM.
(VM boot takes 9+ hours or 2 haswell VMs)

I'd kindly request we get this not only into 4.19 but also stable trees.
(along with Ted's other randomization fixes)

Reviewed-by: Maciej =C5=BBenczykowski <maze@google.com>
