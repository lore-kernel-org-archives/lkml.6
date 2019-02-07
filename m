Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4F1C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 00:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C6B02075D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 00:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="k8tnarCT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfBGAWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 19:22:30 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:42871 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfBGAW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 19:22:29 -0500
Received: by mail-ot1-f43.google.com with SMTP id v23so15328486otk.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 16:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N9lRRqnsHDT7GDO+v7XW7/VJ5v3X9tiPM2p9vi+qGY8=;
        b=k8tnarCT7do6m4YClkIf2+OB/cSXl05ZHqWyDLOAoSSB9nAV6GR7IOivzKXDJizJie
         p+38ESxiMKxx8gLcOsFJUqbLhF88jqW94mz6D55BGtR9Uj7xdHLNf1XxqvgLkYl/9M8A
         TPIzwWGe56Pi0cx6OdmhIAzJqLRWF/6icRk+DuBoGPG5UjFlitPyQYJbSL3g0aZYoSoO
         vOgQrVay97ebCs4OHx3tcX1mxEaaYMljmc2PyA3njJmuo6TP1JJH7qsXkEaa487WK+qP
         rEwesohUJbI4NidP95LSmAQ0iNbB5lrGzrY5kEqLLhWOb7KpJBtjqL6aFn2O36hh2qUR
         WQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N9lRRqnsHDT7GDO+v7XW7/VJ5v3X9tiPM2p9vi+qGY8=;
        b=k47GT50aGtymfbIln3MgNXLdAHt+hB7chRcIaxBkR+nGrMsAYwKpHd6Nxmqp2JtTVA
         WKx3c19+kOl7oSjyswQYLO0iZ5cNFFWe3Hec7bMzPIG+mrfJjctNdhlY5ZREdRJW6Sq9
         oL7uob6hmC/LzcOB20Fzy8gSegPD0QnwZ99aTGkBf2Oz2vNG+czOLkgCAnxK9E1LrPAB
         Aru652m76+WgLtoSkiPFh9sQ4p8+xiWxZSdmeQVGF2M+GuW+jvyH0+wl44XsFbnKDZsd
         RHLKrUMKS2OcWrEYMX4WAHl4J1lOqd9cUuMtzsstO1jryktYll6RrxrRWuesSgRpZpVW
         elAw==
X-Gm-Message-State: AHQUAuaMczI3yg8HHJK17e/Bq3H4r6088hf6Pb9rtdHIHKvnbgNv9VTE
        Y5rBUNXgqffMksjMhNddxpHXQ6u6ql6RxWGjcndjiQ==
X-Google-Smtp-Source: AHgI3Ibqjhw/vsUKHyjILXNjBnifndhwYQTmHR5DdOu3tq7tqHjwpj5Yu5rjPWEExLu7zymchHLui7jCBzPdS3wEE4s=
X-Received: by 2002:a05:6808:344:: with SMTP id j4mr1089747oie.149.1549498948442;
 Wed, 06 Feb 2019 16:22:28 -0800 (PST)
MIME-Version: 1.0
References: <20190206173114.GB12227@ziepe.ca> <20190206175233.GN21860@bombadil.infradead.org>
 <47820c4d696aee41225854071ec73373a273fd4a.camel@redhat.com>
 <01000168c43d594c-7979fcf8-b9c1-4bda-b29a-500efe001d66-000000@email.amazonses.com>
 <20190206210356.GZ6173@dastard> <20190206220828.GJ12227@ziepe.ca>
 <0c868bc615a60c44d618fb0183fcbe0c418c7c83.camel@redhat.com>
 <CAPcyv4hqya1iKCfHJRXQJRD4qXZa3VjkoKGw6tEvtWNkKVbP+A@mail.gmail.com>
 <20190206232130.GK12227@ziepe.ca> <CAPcyv4g2r=L3jfSDoRPt4VG7D_2CxCgv3s+JLu4FQRUSRWg+4Q@mail.gmail.com>
 <20190206234132.GB15234@ziepe.ca>
In-Reply-To: <20190206234132.GB15234@ziepe.ca>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 6 Feb 2019 16:22:16 -0800
Message-ID: <CAPcyv4h1=GTAqHBw+Zsp9eNYR3HFbB_qjmhntwnO-jyGun4QNA@mail.gmail.com>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Christopher Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Ira Weiny <ira.weiny@intel.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 6, 2019 at 3:41 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
[..]
> > You're describing the current situation, i.e. Linux already implements
> > this, it's called Device-DAX and some users of RDMA find it
> > insufficient. The choices are to continue to tell them "no", or say
> > "yes, but you need to submit to lease coordination".
>
> Device-DAX is not what I'm imagining when I say XFS--.
>
> I mean more like XFS with all features that require rellocation of
> blocks disabled.
>
> Forbidding hold punch, reflink, cow, etc, doesn't devolve back to
> device-dax.

True, not all the way, but the distinction loses significance as you
lose fs features.

Filesystems mark DAX functionality experimental [1] precisely because
it forbids otherwise typical operations that work in the nominal page
cache case. An approach that says "lets cement the list of things a
filesystem or a core-memory-mangement facility can't do because RDMA
finds it awkward" is bad precedent. It's bad precedent because it
abdicates core kernel functionality to userspace and weakens the api
contract in surprising ways.

EBUSY is a horrible status code especially if an administrator is
presented with an emergency situation that a filesystem needs to free
up storage capacity and get established memory registrations out of
the way. The motivation for the current status quo of failing memory
registration for DAX mappings is to help ensure the system does not
get into this situation where forward progress cannot be guaranteed.

[1]: https://lists.01.org/pipermail/linux-nvdimm/2019-February/019884.html
