Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6282BC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE1BC21479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bofh-nu.20150623.gappssmtp.com header.i=@bofh-nu.20150623.gappssmtp.com header.b="TjDFnUAn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE1BC21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bofh.nu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbeJIOMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 10:12:21 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40216 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeJIOMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 10:12:20 -0400
Received: by mail-ot1-f65.google.com with SMTP id w67so522958ota.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 23:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bofh-nu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yLDyTJ0l+yhuImVImpXRNttTOfHH+I0Y9Wrhad9b5+4=;
        b=TjDFnUAn5XCdUwFDioOt3pfIKL2+yM9ueMH5l8cAHisAE8oxwCIcN1aBS/l0zF1Sg9
         EBeda4j8W/It5pQPTw3cj12mYsn87gI9V1rnh/F0EV+C57hb4jHDHnNIoavvx6cVRWOg
         07xmRybhuHVl2mXlgQK7fMcF9pXCf/v6KEqVTkvc9QNjT3Jgd7Geey2vMvd3gjNcecKr
         VMnBWOCKAc64KInwe2kDL1mf8tSQ3JHMlm2GKvOF2hfqpvlO9cF/SKu7woAV40SIROwZ
         izlkCQ/j3wS0ItowZm0lTqA+IuTYaNZVyj/cWqbCeXUfZe/UAYHsKLH7giCKUDUvVJwD
         EC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yLDyTJ0l+yhuImVImpXRNttTOfHH+I0Y9Wrhad9b5+4=;
        b=OiN+qlav1nH+qLtfHsRoKXezp2SMu8n5RFqqCZ4N/FkGSmObP0JmnW5D8zYz02Gjjr
         E7v3wY2N34akYWq1yUaIjMYP5IPtZzo1C31lBYqUJBb/ZoPd1OLZUSijdrhaUqPt+vjk
         dwIEWG6Q0Ze01R62TcWCK7YHuiWRDCrJqghhHj7zuvXPib22FBm/DJyL7VMx5dq4SMdQ
         eCdFSSwYaXKdSpW04rHaFOSpKMB4480jgGguOqtuCeawZB62tF+tjUk1jXVykFG2QrWS
         qm5h/bouxCJX0yealQXyWPoAxTZ+W/NiD+uIWZEIp8+3VakhvkQO34xu6qjj7d9zzxgP
         xblA==
X-Gm-Message-State: ABuFfoi0liSgQGYoqmXS1XPjgUrlsHvlprxnAJXV42VYeBORmZ7eEd+H
        x/8WlRd81ccapIHAzbu3SPvF08Zfj+zcnBdZQQ9m1w==
X-Google-Smtp-Source: ACcGV63ury5m+Drjkxr8p626z74lwdRDV9ebzZsbDFaN4PPvbL0UQNzsElVIVr6dMOHhIjhdg0MvEpJqoPpKyt3mqLg=
X-Received: by 2002:a9d:6456:: with SMTP id m22-v6mr15350368otl.222.1539068214288;
 Mon, 08 Oct 2018 23:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180701160757.138608453@linuxfoundation.org> <2076412.mQRaXglRsh@blindfold>
 <CADnJP=sJE6hpG6inp5Yu+5P2F-d0=6GP-2dAXJTmBOb_rPzgvw@mail.gmail.com> <1657546.ePJIJPgWtA@blindfold>
In-Reply-To: <1657546.ePJIJPgWtA@blindfold>
From:   Lars Persson <lists@bofh.nu>
Date:   Tue, 9 Oct 2018 08:56:43 +0200
Message-ID: <CADnJP=tP8ZFi7krNqVwHZeNF8ot+cbY5egTHOs55qYaTKd6J+A@mail.gmail.com>
Subject: Re: [PATCH 4.9 069/101] ubi: fastmap: Correctly handle interrupted
 erasures in EBA
To:     richard@nod.at
Cc:     linux-kernel@vger.kernel.org, Martinbayern@outlook.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 8:32 AM Richard Weinberger <richard@nod.at> wrote:
>
> Lars,
>
> Am Sonntag, 23. September 2018, 15:49:42 CEST schrieb Lars Persson:
> > Hi Richard
> >
> > Sorry, I assumed this omission from -stable was a mistake.
> >
> > The timing for our boot increased from 45 seconds to 55 seconds on one
> > chip and 42 seconds to 48 seconds on another chip. The regression was
> > completely fixed by applying the extra patches. The way I see it the
> > first patch is a significant slow-down so the second patch is required
> > to restore performance.
>
> okay, this is not good. Let's put the performance patch also into -stable
> to get rid of that regression.
> Usually I'm rather conservative with adding non-trivial material to -stable.
> As history has shown, Fastmap is special. ;-)
>
> Out of interest, what flashes are these? I'm interested in page vs. erase size.
> Did you give UBIFS bulk-read try?
>

Richard, sorry for the late follow-up. Below are the NAND chips that
we use on the affected products.
The products have different NAND timings, some ONFI mode 0 and some
ONFI mode 2, so not lightning fast access to the NAND.

nand: Toshiba NAND 256MiB 3,3V 8-bit
nand: 256 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 128

nand: Micron MT29F2G08ABAFA 2G 3.3V 8-bit
nand: 256 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 128

nand: AMD/Spansion S34ML04G2
nand: 512 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 128

- Lars
