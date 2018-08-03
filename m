Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2072C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7457A2170D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sQYPZIyb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7457A2170D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbeHCOu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:50:56 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:46080 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbeHCOu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:50:56 -0400
Received: by mail-ed1-f51.google.com with SMTP id o8-v6so2103425edt.13;
        Fri, 03 Aug 2018 05:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1s6qi5wMjOSyF38bEAh6b7T18pBgztO8OnWZI1S68r0=;
        b=sQYPZIybV7QtUEh+tgC3jNHe0ehEzjnUmuGJQ1Ra0q5BW8AGT9P5Cu/+A/nfXNJr2m
         d0XZUjOKxM/VWiT+zbyIFCnb+r4qrPh63lpNYlSCIv4gMImZNV/DDyWloViHcs8FciQM
         XZr5c9sb/XClULcJS5Ap2p6YCptcPi2kWCP+wO8HIsAMWpsClV0R6s3KcGVMLMQmHi36
         0tQBNuAyQn8j0nihUMUXFTZgVlbXpcIuZcjkLpHkZkBI61ZAffVWfhfWREhzrhhu6SZj
         3v14r3Wqg2AZ27L2iXkMPAW5hTPmzVoLL9/c5LvJcEaKxhoN5XoUvb6hS5jSyUHU5p6c
         OHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1s6qi5wMjOSyF38bEAh6b7T18pBgztO8OnWZI1S68r0=;
        b=o1F0A0Mw7g/iBofK6lIYwQ/hUFtMh0dxjere9klOLosn5QV9WuhiyB8BpTtgm5L+OL
         tTL6RGfE7vtFBSIXgRxEyuCq0yLv/AlJYYRM9U41YBoEiqaEd6WkKb8t4tw5Q4Bgaxyo
         I8Nf0Y6GVE60addkhkHm9OaSB02YzLcicyyZZ+BWYSg+mgJklVVvfOIaaKbWlagOUfpP
         b9PZcfMRFJ+hDdVSbP7zAJBNY46e/STHlbUu7O3wAmgH8MZjJv3atj0zZkNx37zfL+mT
         clyp4LyjmbnNnyCEVZ9WN3xgTtbUsZHVX9q9Mezhh1X08x+2xd5pTbzqf85CrpFb3fWc
         e3Vg==
X-Gm-Message-State: AOUpUlHsqoEtw5K8JM3Ji7jegvsNlJqssEIYGYHyvGS4tCdDdwg3ETVG
        mlRPD24CMWegvWzlhuqxoRV9ltaKc3IzRdfMfoc=
X-Google-Smtp-Source: AAOMgpfN0r2E0XPfJg9kSJHUc++h7dbFWcg3TZmwst/cKFp2ioDvKX1qnSurWkO9mUVfgX88vdV+2o0GccrO9Y5OeVM=
X-Received: by 2002:a50:96c4:: with SMTP id z4-v6mr7461180eda.14.1533300881450;
 Fri, 03 Aug 2018 05:54:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:f68b:0:0:0:0:0 with HTTP; Fri, 3 Aug 2018 05:54:41 -0700 (PDT)
In-Reply-To: <20180702114033.15654-4-mperttunen@nvidia.com>
References: <20180702114033.15654-1-mperttunen@nvidia.com> <20180702114033.15654-4-mperttunen@nvidia.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Fri, 3 Aug 2018 18:24:41 +0530
Message-ID: <CABb+yY0_dKC_cYFwwb-aeRgrx=sjv=8VLP=C6DJEecFf=v+mkQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] mailbox: Add transmit done by blocking option
To:     Mikko Perttunen <mperttunen@nvidia.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
        ", linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 5:10 PM, Mikko Perttunen <mperttunen@nvidia.com> wrote:
> Add a new TXDONE option, TXDONE_BY_BLOCK. With this option, the
> send_data function of the mailbox driver is expected to block until
> the message has been sent. The new option is used with the Tegra
> Combined UART driver to minimize unnecessary overhead when transmitting
> data.
>
1) TXDONE_BY_BLOCK flag :-
        Have you tried setting the flag mbox_chan->mbox_client->tx_block ?

2) Implementing TEGRA_HSP_MBOX_TYPE_SM :-
       In mailbox framework, a controller is a collection of identical
channels. That is, instances of the same class.
       So ideally, in probe you should populate a controller for each
type of channel, i.e, DB, SM, SS and AS.
