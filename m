Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4835C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8885A20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cHx1STwv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8885A20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbeJQCiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 22:38:54 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45461 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbeJQCiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 22:38:54 -0400
Received: by mail-lf1-f68.google.com with SMTP id v22-v6so6000086lfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 11:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ARuNdrw4LF3tXeh34z8Oo7ZWKVz0S91fJDD3+IU4Mc0=;
        b=cHx1STwv1/t2IAT16pzENaovP0h7c+LUA790D4ReGUVJxWkTQBSKgbp52R3Pmw2D6i
         rwvZZi5Vr8RekVXhJ5u07aydRZzjtiYW6BEDrdNFQ30u1Vz1dDGJnUfg+dDD/5CinJAg
         2TNBlxojiKaPfmjgcKwA+EXyUv6OGRsCVUCH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ARuNdrw4LF3tXeh34z8Oo7ZWKVz0S91fJDD3+IU4Mc0=;
        b=iR5+mwoTEaNy/LHKZWAH3i9YPORFErHjlPmWNw17Kb4ygyrZBqGzWOXIPNUW275vZP
         91cDPZLGj6cv/zswLc4/qfV5tixzxn8X2lT+y+16QuZnDv5OOJ2CX/G/UF91Wps1Ps0C
         qwqUDfYwsRX8lznPCxoiRyis/Or61/S58Rxo/tsjsIcEP6xfH4XwV759Dsp/6yZQes39
         x45xywtyhg0aGSvBtMKQYJxLND1/3vB2+dEPMXtSpV5Bc9nP1DCCLxIzYjN6TCUDZKgl
         xqi2imtn52Ae/Zqi5/m4jBm4CJY/rH4yRJ49GtZnz34GahkR+rjtuRxroJKDzuq2kzpJ
         YWvA==
X-Gm-Message-State: ABuFfoiiV0BT6/d5zvfOkL2n+hp5BHGZ9URJr31b0nZ7YxCLpa7Wv4Ah
        ult5PIVKAqRLpUdL55oklxtaAW2hno7EggS/ky4lxw==
X-Google-Smtp-Source: ACcGV62q6pgWK29sH0P8aj3TCcVLkH87Xx3aKmj5qXhrGRFpL/CDwlFMFmChXncTwDl3YOEfCUFpknVEJWRU6lCTPm4=
X-Received: by 2002:a19:cf8d:: with SMTP id f135-v6mr6219804lfg.53.1539715625344;
 Tue, 16 Oct 2018 11:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <20181011152508.885515042@linuxfoundation.org> <20181011152510.156825448@linuxfoundation.org>
 <CADVatmO4qd2D7j9AuVWX29ODMd9xV7-ndMSv+dfFatT60h+mzQ@mail.gmail.com> <20181012110511.GB26625@kroah.com>
In-Reply-To: <20181012110511.GB26625@kroah.com>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Wed, 17 Oct 2018 00:16:28 +0530
Message-ID: <CAMi1Hd2YHYpxohDEa5_vVmsJaH9m4TBbjRy_SUxiDEjT5F6Q8Q@mail.gmail.com>
Subject: Re: [PATCH 4.14 29/45] cgroup/cpuset: remove circular dependency deadlock
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Prateek Sood <prsood@codeaurora.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2018 at 16:35, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Oct 11, 2018 at 08:33:34PM +0100, Sudip Mukherjee wrote:
> > Hi Greg,
> >
> > On Thu, Oct 11, 2018 at 4:54 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > 4.14-stable review patch.  If anyone has any objections, please let me know.
> > >
> > > ------------------
> > >
> > > From: Prateek Sood <prsood@codeaurora.org>
> > >
> > > commit aa24163b2ee5c92120e32e99b5a93143a0f4258e upstream.
> >
> > This has been already reverted in upstream.
> > bdfbbda90aeb ("Revert "cgroup/cpuset: remove circular dependency deadlock"")
> >
> > Might be better to add e8b3f8db7aad ("workqueue/hotplug: simplify
> > workqueue_offline_cpu()") instead which is mentioned in the revert
> > commit.
>
> Good point.  I'm dropping this patch for now.
>
> Amit, can you test the above patch instead and figure out why you wanted
> to add a patch to the tree that ended up being reverted?  :)

Sorry I goofed up here. Thank you Sudip for catching this.

I forgot to look up for the upstream followup fixes for the patches
which I submitted lately and missed out on this Revert.

msm-4.9 tree, which I'm currently looking at, didn't revert this
particular patch either. It did cherry-pick e8b3f8db7aad
("workqueue/hotplug: simplify workqueue_offline_cpu()") as well
though.

About e8b3f8db7aad ("workqueue/hotplug: simplify workqueue_offline_cpu()"):
--------------------------------------------
commit e8b3f8db7aad99fcc5234fc5b89984ff6620de3d
Author: Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Fri Dec 1 22:20:36 2017 +0800

    workqueue/hotplug: simplify workqueue_offline_cpu()

    Since the recent cpu/hotplug refactoring, workqueue_offline_cpu() is
    guaranteed to run on the local cpu which is going offline.

    This also fixes the following deadlock by removing work item
    scheduling and flushing from CPU hotplug path.

     http://lkml.kernel.org/r/1504764252-29091-1-git-send-email-prsood@codeaurora.org
--------------------------------------------
This patch applies cleanly to 4.14.y and 4.9.y. But I'm confused if
this particular patch alone is good enough for these stable kernels,
since the commit message talks about some "recent cpu/hotplug
refactoring" dependency(?).

Regards,
Amit Pundir

>
> thanks,
>
> greg k-h
>
> >
> > --
> > Regards
> > Sudip
