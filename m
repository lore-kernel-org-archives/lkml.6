Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE87C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00B421A53
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIS9ASPS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A00B421A53
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732708AbeHFTec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 15:34:32 -0400
Received: from mail-yb0-f177.google.com ([209.85.213.177]:46982 "EHLO
        mail-yb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbeHFTec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 15:34:32 -0400
Received: by mail-yb0-f177.google.com with SMTP id f10-v6so2019030ybk.13;
        Mon, 06 Aug 2018 10:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NbbWNhoRLQD627I/LTZWEqlFjH5plP1grz/FjDLsPso=;
        b=gIS9ASPSqhXRWa0fGyRGVTU083buqmT4CAedsPt8FVx/asFzJeyfmdBhDilqJqO8y9
         Juzy3gprpnXMelH1Gy2QzLzVOih9xx/GvPO1szGPmLEPgDC1EvWoGZha3QnRF1UyIzI1
         yHHBbtuTTdlzEjsLJsA9gWbbybKpOfH1Z2LAe06+ABUohPl0Y/KMTJcEaqOYg2QhzDct
         Akzs2QsdPKDpbHRH5ZNI2M1tWWzrhsmdtqC5CEuVK0jGQXV6u4wXeaCtYkwytXPotRZ0
         WEDkUK/1HUHUoKjABhk2rad7Z+ksIbqJiqJHOS02ETTJVO1GjISA/NswRzz4i6SMFwMe
         oSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NbbWNhoRLQD627I/LTZWEqlFjH5plP1grz/FjDLsPso=;
        b=K8obG5bwq1V76Ym3zV73Cfchg9i2gkGEkx200XmBS5PzpFIoCoc3D2aqsEpP8mNyjv
         N+pkbpu1hdRD/ktrM8g4dXvn2AMo26Kne8E6+AKnKXhUGazlrji8FXNzySxmHJPFX2hr
         /JmCw0wzYRbfnZ7p1w3/6G/EL3wPFlwGJ2t892R8e0t5rF9988HW5wo7enUMAhV0Kmkn
         rWgv+NHGQEjbnCKz0bnsvRPwyENHo4dwZmiEqG3AT6wDjpdefEiH5fB8aN5NimmgiKFh
         lYAokUGs6UqCwjdjKZ8ipHiRRoOwX9Nxt9CnV6h4FRQyP0n0LDQJUDiUU6iAwUTPGL/H
         3Zvw==
X-Gm-Message-State: AOUpUlGNdKhQtKzAZkR6yoVgohd0YjRUax1k/gyHYToLxMgshVP3NLRR
        KDD4uONo+tamv8i3zlsMmvg=
X-Google-Smtp-Source: AAOMgpfvoRpoK3rMEiSQEEmpS6NkxSnKWsBBUlHXyMc5E6FIQCyVjmHoShufj8eLPFBSjC8WYOF2UA==
X-Received: by 2002:a25:ba4b:: with SMTP id z11-v6mr8167498ybj.427.1533576267290;
        Mon, 06 Aug 2018 10:24:27 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:6f28])
        by smtp.gmail.com with ESMTPSA id 21-v6sm6264367ywb.88.2018.08.06.10.24.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 10:24:26 -0700 (PDT)
Date:   Mon, 6 Aug 2018 10:24:24 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Samuel Morris <samorris@lexmark.com>,
        Tony Lindgren <tony@atomide.com>,
        Roger Quadros <rogerq@ti.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-omap@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, ssantosh@kernel.org,
        Olof Johansson <olof@lixom.net>, Tero Kristo <t-kristo@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: 4.18.0-rc1-next-20180619 boot failed on beagle board x15
Message-ID: <20180806172424.GC410235@devbig004.ftw2.facebook.com>
References: <CA+G9fYuKW_jCFZPqG4tz=QY9ROfHO38KiCp9XTA+KaDOFVtcqQ@mail.gmail.com>
 <20180620102904.GC112168@atomide.com>
 <d5d57b10-facb-d5f7-ad7f-34afae726756@ti.com>
 <CAFY_6qqDcG7+sp7jawhTjuWHizPR75=HUsRJfGPhEPzVE4f5kg@mail.gmail.com>
 <6c15a753-c4a8-ff89-f5c0-0fd19c817c91@ti.com>
 <CAFY_6qq3=+hMLKr0VtCe-witPtV2LTeBSQb3pwqdzysbyiYtMQ@mail.gmail.com>
 <5206d66d-56d0-2edc-8dd0-00eedbaac3db@ti.com>
 <20180702093243.GO112168@atomide.com>
 <CAFY_6qo83Ui6_xRkuTYZUduUJSK2dLKhzd+B_nQ-XW5ciDH-7A@mail.gmail.com>
 <20180806093015.6099ef5c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806093015.6099ef5c@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Aug 06, 2018 at 09:30:15AM +1000, Stephen Rothwell wrote:
> > > So this issue is still happening as of next-20180702. Can you guys
> > > please revert the commit above while working on a better solution?  
> > 
> > That's fine with me. I'm not very familiar with the process here, does
> > this require anything on my end? And would that require the
> > accompanying patch to be reverted: "ata: ahci: rpm_put port on
> > port_stop to match rpm_get in port_start"? There shouldn't be any
> > problem leaving that one in, but I just want to know before submitting
> > my next patch set.
> 
> I am still reverting that commit from linux-next myself.  Has this
> issue been fixed some other way, or is it still ongoing?

Hasn't been resolved yet.  Reverting from libata/for-4.19.

Thanks.

-- 
tejun
