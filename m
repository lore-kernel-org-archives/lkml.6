Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD0DC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC3D2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tg8SnKN2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC3D2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbeKCDjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:39:43 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35590 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbeKCDjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:39:43 -0400
Received: by mail-qk1-f195.google.com with SMTP id v68-v6so4597936qka.2;
        Fri, 02 Nov 2018 11:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wqzgs+F0hY7K8xAcw83hHNnWx01TKifagw51GGPrFSM=;
        b=Tg8SnKN2mAmHPjAFLVibAuepFvy9Y8cZJ8natvhMD70Wf85NXlbpfUT59geH74D/lY
         jdSjBS2A7IKITR1dqgZlxkAEg04IkgLKQTxSfydSxXdS5/an1e0G5SiMtfkoQ+YXzurA
         qx/Sxvok/o0woQ4trKxHEbvpIqGnRCSxaI+Xk3VlKgRZeK19U8z/C12AgFnrCtwdb9ES
         L+D3ZRXCPQbl+C9de8rULOAasimeZMbtqsMd00MIupNKtvf+tsaNspafqNnfRkheqea3
         jACyEjoHT/9AVwvoRb9pCgYNeX1NinPIZ3LkfH0ZirjeUZwMuzjSpEEwfuHF/zm/2w59
         xIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wqzgs+F0hY7K8xAcw83hHNnWx01TKifagw51GGPrFSM=;
        b=pkeVfxR51thPhDh6DMTp5M3jGhALkTnsmDvdKhvevflSqMzikcg/L1VfFf9NUlOxWN
         dlyq5mPiV+I9Omz3SI1K6DH1oheTMwlKQ1aqbcJCVkNpF8zZaIJcdJLeRT+SH5M1KIR1
         nMDUioGpil1VoJw61x/VkBk9K6ugtCWApW8aBBJoCaiLwHskAwg+rcdMnze0tVlQ3jzZ
         9Uh60qn0tuDnLzokTSvJ+B66P2NHtqBENiCl7fQhw0RTVy/iA7KyWJpspELYVKpOAsbV
         ad4Rj0mZArJ3z4xelpUfukUv/6ygxY+PnArXHU3j55Qy97x0tAthvzF1L5zNnj8C4EOo
         LQTQ==
X-Gm-Message-State: AGRZ1gI0XJk86RrT6RkkWf3whanpqhLVq6fsaLijPsJ0qkrk5tXJMOhj
        VhuO+aVPVRJGGCsm1EXtvgM53SfPS/IqUvM+j0A=
X-Google-Smtp-Source: AJdET5dsRwf3WWzDSsk0ju5Y8NinDATsHApuV2GgCO69GghanlNAj06SeFBStuyspAlmSShP3L0SmSdnjm7t3IcsF1Y=
X-Received: by 2002:a0c:a802:: with SMTP id w2mr9274696qva.198.1541183493707;
 Fri, 02 Nov 2018 11:31:33 -0700 (PDT)
MIME-Version: 1.0
References: <20181102182123.29420-1-v.mayatskih@gmail.com> <20181102142446-mutt-send-email-mst@kernel.org>
In-Reply-To: <20181102142446-mutt-send-email-mst@kernel.org>
From:   Vitaly Mayatskih <v.mayatskih@gmail.com>
Date:   Fri, 2 Nov 2018 14:31:21 -0400
Message-ID: <CAGF4SLgVoktAqWHKBbcwJ9+efaGnLpmUEohGi4YOKyGrwpY97Q@mail.gmail.com>
Subject: Re: [PATCH 0/1] vhost: add vhost_blk driver
To:     "Michael S . Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sure! It needs a new QEMU driver (vhost-blk-pci), I'm preparing it to
be sent out.
On Fri, Nov 2, 2018 at 2:26 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Nov 02, 2018 at 06:21:22PM +0000, Vitaly Mayatskikh wrote:
> > vhost_blk is a host-side kernel mode accelerator for virtio-blk. The
> > driver allows VM to reach a near bare-metal disk performance. See IOPS
> > numbers below (fio --rw=randread --bs=4k).
> >
> > This implementation uses kiocb interface. It is slightly slower than
> > going directly through bio, but is simpler and also works with disk
> > images placed on a file system.
> >
> > # fio num-jobs
> > # A: bare metal over block
> > # B: bare metal over file
> > # C: virtio-blk over block
> > # D: virtio-blk over file
> > # E: vhost-blk bio over block
> > # F: vhost-blk kiocb over block
> > # G: vhost-blk kiocb over file
> > #
> > #  A     B     C    D    E     F     G
> >
> > 1  171k  151k  148k 151k 195k  187k  175k
> > 2  328k  302k  249k 241k 349k  334k  296k
> > 3  479k  437k  179k 174k 501k  464k  404k
> > 4  622k  568k  143k 183k 620k  580k  492k
> > 5  755k  697k  136k 128k 737k  693k  579k
> > 6  887k  808k  131k 120k 830k  782k  640k
> > 7  1004k 926k  126k 131k 926k  863k  693k
> > 8  1099k 1015k 117k 115k 1001k 931k  712k
> > 9  1194k 1119k 115k 111k 1055k 991k  711k
> > 10 1278k 1207k 109k 114k 1130k 1046k 695k
> > 11 1345k 1280k 110k 108k 1119k 1091k 663k
> > 12 1411k 1356k 104k 106k 1201k 1142k 629k
> > 13 1466k 1423k 106k 106k 1260k 1170k 607k
> > 14 1517k 1486k 103k 106k 1296k 1179k 589k
> > 15 1552k 1543k 102k 102k 1322k 1191k 571k
> > 16 1480k 1506k 101k 102k 1346k 1202k 566k
> >
> > Vitaly Mayatskikh (1):
> >   Add vhost_blk driver
>
>
> Thanks!
> Before merging this, I'd like to get some acks from userspace that it's
> actually going to be used - e.g. QEMU block maintainers.
>
> >  drivers/vhost/Kconfig  |  13 ++
> >  drivers/vhost/Makefile |   3 +
> >  drivers/vhost/blk.c    | 510 +++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 526 insertions(+)
> >  create mode 100644 drivers/vhost/blk.c
> >
> > --
> > 2.17.1



-- 
wbr, Vitaly
