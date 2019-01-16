Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328DCC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008A420675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar-org.20150623.gappssmtp.com header.i=@fooishbar-org.20150623.gappssmtp.com header.b="1/hniUxF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393804AbfAPQgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:36:50 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34158 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfAPQgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:36:49 -0500
Received: by mail-lj1-f193.google.com with SMTP id u89-v6so6013115lje.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 08:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vz/wwLMqVzygZmAEdfCKG2TFVw8PuXQMQNORL0z+e4o=;
        b=1/hniUxFo0bJObKTii0mYRVx5MEXRR9HTwNEcm/U5eSrSXvs/81CWj9ovSX948FIC+
         XXRbJ32dGaPIVLUxQ++/2MEKT/kT3UR3Q/h0nwl0IWpoI0Rqr/q46EPsiEQHdRECk7Kz
         VAuqL5RHOqPiNx0yb2XxpHpfzlDCHGNLs2VvPE6MAqgacrIuVXRh8eA054OJuQVvVY7c
         n9GyF2G4P+nxXqdI7WrnnpiiKQPMa3GyqvAWSR4Hji5YxWjQw/x3b5D3ySIgWNn3T+g+
         CFlxcDz3IHf4M5ZxSdqcGoUW1EvxcEzlsxhd3PUMqzt/iiawuX1LvBL92Xc3e+lZOwQi
         9vIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vz/wwLMqVzygZmAEdfCKG2TFVw8PuXQMQNORL0z+e4o=;
        b=tlHLq7wonOZpbz5xbqTDv8W73HX3S/zqLmp1lLENYldi0NShupExJGnSYMP4jNemUg
         J9kvU8mIx/kIrN82O5cwYZqvTY3zaCDpUNyfkNbxVIjYAvy+bFIvqxKk+c7k0O1vROLq
         kYRMMnT4pmkSP3F1S2UGeluWeu7z/TLxXu+hf9oCFTR1Xq++a1YYPFu+HM7//JmFCOm8
         uQXTPUbBbZpbOSSgdluRjYYaATJ7Jb+yPloWky1KlvgiCAMa5wimXGIznZoq43K+e/Bj
         KKCJ18Kb51IU6uhIhh3wKBjeM7VauAQTz8nwEsKjfA/4XtPfDUF/gf2qHTN3oev7AuB3
         ZGFA==
X-Gm-Message-State: AJcUukfjLY6+22ifOyJDEARusjkK4V2bDrn3f+JhqDaNQV33oRhOi4qH
        3McYpThcO6RKagtn3Iovi9ET9KD/m08aZI2x8zdeLg==
X-Google-Smtp-Source: ALg8bN79YOQsr9DFPYLz9IqmQTee2fF+FhI4z2zf97SsvgvlQIfaHjpGpe7WpdjmZ1UgyLtNacBBbETN4tnj58eTx1c=
X-Received: by 2002:a2e:302:: with SMTP id 2-v6mr6961969ljd.137.1547656606814;
 Wed, 16 Jan 2019 08:36:46 -0800 (PST)
MIME-Version: 1.0
References: <20190114094856.GB29604@lst.de> <1fb20ab4b171b281e9994b6c55734c120958530b.camel@vmware.com>
 <2b440a3b-ed2f-8fd6-a21e-97ca0b2f5db9@gmail.com> <20190115152029.GB2325@lst.de>
 <41d0616e95fb48942404fb54d82249f5700affb1.camel@vmware.com>
 <20190115183133.GA12350@lst.de> <c82076aa-a6ee-5ba2-a8d8-935fdbb7d5ca@amd.com>
 <20190115205801.GA15432@lst.de> <01e5522bf88549bfdaea1430fece23cb3d1a1a55.camel@vmware.com>
 <8aadac80-da9b-b52a-a4bf-066406127117@amd.com> <20190116160639.GA28619@lst.de>
In-Reply-To: <20190116160639.GA28619@lst.de>
From:   Daniel Stone <daniel@fooishbar.org>
Date:   Wed, 16 Jan 2019 16:36:33 +0000
Message-ID: <CAPj87rNAhGsGwNWRM1iO4rruVjQ+Yu=bDXS39Om9rL6PesuQYg@mail.gmail.com>
Subject: Re: [PATCH] lib/scatterlist: Provide a DMA page iterator
To:     "hch@lst.de" <hch@lst.de>
Cc:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yong.zhi@intel.com" <yong.zhi@intel.com>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "bingbu.cao@intel.com" <bingbu.cao@intel.com>,
        "jian.xu.zheng@intel.com" <jian.xu.zheng@intel.com>,
        "tian.shu.qiu@intel.com" <tian.shu.qiu@intel.com>,
        "shiraz.saleem@intel.com" <shiraz.saleem@intel.com>,
        "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2019 at 16:06, hch@lst.de <hch@lst.de> wrote:
> On Wed, Jan 16, 2019 at 07:28:13AM +0000, Koenig, Christian wrote:
> > To summarize once more: We have an array of struct pages and want to
> > coherently map that to a device.
>
> And the answer to that is very simple: you can't.  What is so hard
> to understand about?  If you want to map arbitrary memory it simply
> can't be done in a coherent way on about half of our platforms.
>
> > If that is not possible because of whatever reason we want to get an
> > error code or even not load the driver from the beginning.
>
> That is a bullshit attitude.  Just like everyone else makes their
> drivers work you should not be lazy.

Can you not talk to people like that? Even if you think that is an OK
way to treat anyone - which it isn't, certainly not on dri-devel@ with
the fd.o Code of Conduct, and not according to the kernel's either - I
have absolutely no idea how you can look at the work the AMD people
have put in over many years and conclude that they're 'lazy'.

If this makes you so angry, step back from the keyboard for a few
minutes, and if you still can't participate in reasonable discussion
like an adult, maybe step out of the thread entirely.
