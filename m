Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E2CC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 102322192C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dev-mellanox-co-il.20150623.gappssmtp.com header.i=@dev-mellanox-co-il.20150623.gappssmtp.com header.b="x9RyghVd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfBQQvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 11:51:07 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38694 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfBQQvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 11:51:07 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so15623214wrw.5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 08:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=SJbT7ufd3FmlzPu6Oxgbsa30XHQohpMofSF2GIXdxWE=;
        b=x9RyghVdPj8vl/k9Pl6ic1HC3OcX3LU1+CWS5Nq4LqQdSSK4BkMN6k0e+2ti31L1l7
         YXVX76Gm35wymeBMP8mtC5tGE2CBqutiFnVS2IoQn5JuOC9sIwVpCP436C/jvLCJqLrZ
         daU+dQuuSA0hagXRlJPfQGqhg6L5mjpRjQXqHfRFRZixl2w8P3U+IwKyBUM1hpO1fysp
         kgxrXq+iCAc2HuabxWEoz1D45+57xfFobTK8llHznqp++itdOlp8ADcZZ/BCIoKJTL1+
         iK8pkL86HE4xEhSpHmmi6YHp0cm2/0M5NRgomZ7ikPs/+onLOByMlic5HA96sv/x5QPw
         kH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=SJbT7ufd3FmlzPu6Oxgbsa30XHQohpMofSF2GIXdxWE=;
        b=FhnXF/XStIv425TelcVbH90W5IYcD+LSLJmyA1S7fRAmzXO+f2JckFhMzoCFLIJ8Or
         +2p9Y19/trs5DiY7CWY6mSmOBYUR87POHKc9WyH7vrUnljcLmG8Q5KtE2cqmJ30PxnZT
         Fu+4oqcgJ4LKmfFR1yzJ7v8mOwEYkTglbMZ3gYx1vJCa4/4L90+WbA3CiTa5V/t8TN3Y
         1gpgF3rOeMhgc6OcJYuaLCZ0OgkprUnuPqL+ElInLyEMjWfmcMW3kd7zsn6vBs6f3zz0
         uP+qd1icBunm9+QaTEtwPT1SbYMZKOZeooETJgQfUDEnWehqhug/JxJfN9t2EWeg9wb7
         qX7A==
X-Gm-Message-State: AHQUAuZav659BjyFna0HovB3Zz1budyDlzWAMJ+uFZmKGAMWvqRU4Mbr
        sLn2Xlyd/K5zVJfMXTvCXm7gdg==
X-Google-Smtp-Source: AHgI3IZXgcQEZB56nEo+HvLaBG95B95eO30Or+X589LoEakX3o3oqIvb4gxS3BqRa/7pV1fz0LOCew==
X-Received: by 2002:adf:eb85:: with SMTP id t5mr13241400wrn.157.1550422265083;
        Sun, 17 Feb 2019 08:51:05 -0800 (PST)
Received: from localhost ([5.102.238.15])
        by smtp.gmail.com with ESMTPSA id o18sm40428636wrg.40.2019.02.17.08.51.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Feb 2019 08:51:04 -0800 (PST)
Date:   Sun, 17 Feb 2019 18:51:00 +0200
From:   jackm <jackm@dev.mellanox.co.il>
To:     =?ISO-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, majd@mellanox.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] IB/mlx4: Increase the timeout for CM cache
Message-ID: <20190217185100.00002c83@dev.mellanox.co.il>
In-Reply-To: <20190217144512.1171546-1-haakon.bugge@oracle.com>
References: <20190217144512.1171546-1-haakon.bugge@oracle.com>
Organization: Mellanox
X-Mailer: Claws Mail 3.15.0 (GTK+ 2.24.31; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Feb 2019 15:45:12 +0100
H=E5kon Bugge <haakon.bugge@oracle.com> wrote:

> Using CX-3 virtual functions, either from a bare-metal machine or
> pass-through from a VM, MAD packets are proxied through the PF driver.
>=20
> Since the VF drivers have separate name spaces for MAD Transaction Ids
> (TIDs), the PF driver has to re-map the TIDs and keep the book keeping
> in a cache.
>=20
> Following the RDMA Connection Manager (CM) protocol, it is clear when
> an entry has to evicted form the cache. But life is not perfect,
> remote peers may die or be rebooted. Hence, it's a timeout to wipe out
> a cache entry, when the PF driver assumes the remote peer has gone.
>=20
> During workloads where a high number of QPs are destroyed
> concurrently, excessive amount of CM DREQ retries has been observed
>=20
> The problem can be demonstrated in a bare-metal environment, where two
> nodes have instantiated 8 VFs each. This using dual ported HCAs, so we
> have 16 vPorts per physical server.
>=20
> 64 processes are associated with each vPort and creates and destroys
> one QP for each of the remote 64 processes. That is, 1024 QPs per
> vPort, all in all 16K QPs. The QPs are created/destroyed using the
> CM.
>=20
> When tearing down these 16K QPs, excessive CM DREQ retries (and
> duplicates) are observed. With some cat/paste/awk wizardry on the
> infiniband_cm sysfs, we observe as sum of the 16 vPorts on one of the
> nodes:
>=20
> cm_rx_duplicates:
>       dreq  2102
> cm_rx_msgs:
>       drep  1989
>       dreq  6195
>        rep  3968
>        req  4224
>        rtu  4224
> cm_tx_msgs:
>       drep  4093
>       dreq 27568
>        rep  4224
>        req  3968
>        rtu  3968
> cm_tx_retries:
>       dreq 23469
>=20
> Note that the active/passive side is equally distributed between the
> two nodes.
>=20
> Enabling pr_debug in cm.c gives tons of:
>=20
> [171778.814239] <mlx4_ib> mlx4_ib_multiplex_cm_handler: id{slave:
> 1,sl_cm_id: 0xd393089f} is NULL!
>=20
> By increasing the CM_CLEANUP_CACHE_TIMEOUT from 5 to 30 seconds, the
> tear-down phase of the application is reduced from approximately 90 to
> 50 seconds. Retries/duplicates are also significantly reduced:
>=20
> cm_rx_duplicates:
>       dreq  2460
> []
> cm_tx_retries:
>       dreq  3010
>        req    47
>=20
> Increasing the timeout further didn't help, as these duplicates and
> retries stems from a too short CMA timeout, which was 20 (~4 seconds)
> on the systems. By increasing the CMA timeout to 22 (~17 seconds), the
> numbers fell down to about 10 for both of them.
>=20
> Adjustment of the CMA timeout is not part of this commit.
>=20
> Signed-off-by: H=E5kon Bugge <haakon.bugge@oracle.com>
>=20
> ---
>=20
> v1 -> v2:
>    * Reworded commit message to reflect the new test-setup using
>      multiple VFs
> ---
>  drivers/infiniband/hw/mlx4/cm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
