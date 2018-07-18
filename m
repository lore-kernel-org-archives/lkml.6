Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5227ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 946AF2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ska-ac-za.20150623.gappssmtp.com header.i=@ska-ac-za.20150623.gappssmtp.com header.b="PVU+yO40"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 946AF2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ska.ac.za
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbeGRTXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 15:23:08 -0400
Received: from mail-ua0-f181.google.com ([209.85.217.181]:40179 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeGRTXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 15:23:08 -0400
Received: by mail-ua0-f181.google.com with SMTP id p22-v6so3570341uao.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 11:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ska-ac-za.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Zox/LxPuy1Wwd5olaW7xrHv+qdgkRg9m4UimavprYLg=;
        b=PVU+yO40LPebBgldyuAAqa0O+lUer82GUVvlh0D3hECLptnXEmUqpcGx5+eaLQrIqw
         zdyEcNNDXQWNXJ+w/+XLps/hNWO9wTex7XC03uMvUFmtaXB/2SVa/b283d5WcjMhy50K
         kCut3OuXkGicR9HEUiVGx4+zThGaGCm5/Y4OSPzjaPLqYgwAXTs+Ktb++vQK8xW1EX4/
         shDPGrrgYoLVYr0ytOx/Qt4W1+RT7UVRFtcYT4Ap2vNAU2flaFA5uQaouLTOhZGV9frO
         VaLppW4onJYw9+/1n84iK7QlPo279wjwrmPOtTKopVru4M3zSVKAxADVxDIjwVPzjaYf
         r5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Zox/LxPuy1Wwd5olaW7xrHv+qdgkRg9m4UimavprYLg=;
        b=jCOATHmcJWHgqtSGrB1Zqgl2wY8SwAYNVB43vbaPL3StGOA5wWgAPr/DJaztSO0qhH
         MscdxjTDNtdWRBF+AG7q/4thCUDTLeYnPwmY+LqylFyBIT63XlBTUhPbtwDqwV3Rvp6c
         g1OLN46grKkj9kfZW36g8tOvuSiC6dPZkEJ8+ri4XMfNe1Iu/GRp9Heopz9zupFLK1OO
         nVEy5TDzaea8FG/2nO5gT7DRqDtFyeH38NGH4uXaOnOX0I5S85i/gwV/skV09lgv9aDP
         NWAaanExqVNhDXPecSD/0UbaBGCyoungYqPD/Rpmfd3rRUcEGxf2meLX3CUmG/o0cBzU
         xtRg==
X-Gm-Message-State: AOUpUlESwIV42m67UGhfhk2Ggjvk39VZknVT6JuveC3XC+w87MzVKHSX
        2HBmR4nLJv7RDSTFG9Q+hH2LFSrci+fOKNwliPEwGw==
X-Google-Smtp-Source: AAOMgpe7GY8VaOFon8+Bto24HzM2PzvRQ/yjwCw0OKU9zQGB7xZ9W9De7BFCT5NUFavrVmMnVEp/QsRVVpv5Rqq+Nc8=
X-Received: by 2002:ab0:210b:: with SMTP id d11-v6mr4676120ual.108.1531939436403;
 Wed, 18 Jul 2018 11:43:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:d97:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 11:43:55 -0700 (PDT)
In-Reply-To: <CALvZod77dzc2qxQ4=Xc8P-Yup7fks37Nron0WHV_-q9PyoDaBg@mail.gmail.com>
References: <CAOm-9arwY3VLUx5189JAR9J7B=Miad9nQjjet_VNdT3i+J+5FA@mail.gmail.com>
 <20180717212307.d6803a3b0bbfeb32479c1e26@linux-foundation.org>
 <20180718104230.GC1431@dhcp22.suse.cz> <CAOm-9aqeKZ7+Jvhc5DxEEzbk4T0iQx8gZ=O1vy6YXnbOkncFsg@mail.gmail.com>
 <CALvZod7_vPwqyLBxiecZtREEeY4hioCGnZWVhQx9wVdM8CFcog@mail.gmail.com>
 <CAOm-9aprLokqi6awMvi0NbkriZBpmvnBA81QhOoHnK7ZEA96fw@mail.gmail.com>
 <CALvZod4ag02N6QPwRQCYv663hj05Z6vtrK8=XEE6uWHQCL4yRw@mail.gmail.com>
 <CAOm-9arxtTwNxXzmb8nN+N_UtjiuH0XkpkVPFHpi3EOYXvZYVA@mail.gmail.com>
 <CALvZod5UsYzNs_FJqy2U4HiZ+SdKzKZtzdK1OYcV7v_91kqn8A@mail.gmail.com>
 <CAOm-9aocfOOFODdGn2Gz236_PKaff++6S0U0bTj9eOPnRwM-_w@mail.gmail.com> <CALvZod77dzc2qxQ4=Xc8P-Yup7fks37Nron0WHV_-q9PyoDaBg@mail.gmail.com>
From:   Bruce Merry <bmerry@ska.ac.za>
Date:   Wed, 18 Jul 2018 20:43:55 +0200
Message-ID: <CAOm-9apU_qYR+nmRur-hdPneuv_Y8v2f_Rub6Tsxc98+AuSiZg@mail.gmail.com>
Subject: Re: Showing /sys/fs/cgroup/memory/memory.stat very slow on some machines
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 July 2018 at 20:13, Shakeel Butt <shakeelb@google.com> wrote:
> On Wed, Jul 18, 2018 at 10:58 AM Bruce Merry <bmerry@ska.ac.za> wrote:
> Yes, if there is no memory pressure such memory can stay around.
>
> On your production machine, before deleting memory containers, you can
> try force_empty to reclaim such memory from them. See if that helps.

Thanks. At the moment the cgroups are all managed by systemd and
docker, but I'll keep that in mind while experimenting.

Bruce
-- 
Bruce Merry
Senior Science Processing Developer
SKA South Africa
