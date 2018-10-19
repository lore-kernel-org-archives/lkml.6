Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181C9ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0182064A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="w9gHLqVu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD0182064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbeJTARS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 20:17:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:59170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727197AbeJTARR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 20:17:17 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D90CE21476;
        Fri, 19 Oct 2018 16:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539965432;
        bh=XxhNLthymnIFPnHMwqFaCxA9IGCUpdnIUE4qhaivIQ4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=w9gHLqVuqNPsctDlQ7tHtR6+vC16XXFbnwa3C/88PX6VU6kx7a3wOxSFriZvWNMvt
         d1RhducvH+/F81OdvtQ9YSTqH6XlJy9ZoQMgxn+APlZlCX5tSC2IDw5Oa7lgvM8roP
         qPzsTkU9VkeMFaZYCffuqorh3fOsjJMvJYYWfD5M=
Received: by mail-qk1-f172.google.com with SMTP id g13-v6so1711531qke.8;
        Fri, 19 Oct 2018 09:10:31 -0700 (PDT)
X-Gm-Message-State: ABuFfoiT/3oAqZp/qQQGcNc04RXcW/zjizRVgXvVXgXOILioWyE+HsTl
        bEUhnf9nXmaFwkeYeT2uAnSUPPXRNxSbRRqp7g==
X-Google-Smtp-Source: ACcGV61NyC1iT4WkxZa+hGw+8Yzd3BndnZqnyVQXo1Vcv93kCbCrqb6NwE05BgZz5YSW+7+HZwkBCdrpzIBcFM0I7jI=
X-Received: by 2002:a37:9201:: with SMTP id u1-v6mr31342061qkd.29.1539965430939;
 Fri, 19 Oct 2018 09:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
 <1539657458-24401-5-git-send-email-frowand.list@gmail.com>
 <20181018170931.GC15557@bogus> <780fb659-29e8-1ef4-4f62-97dacf36f6c8@gmail.com>
In-Reply-To: <780fb659-29e8-1ef4-4f62-97dacf36f6c8@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 19 Oct 2018 11:10:19 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ+WW2kMHzExMrQvUCAODvOrDW3gTrJzvSUd_3n55oCwA@mail.gmail.com>
Message-ID: <CAL_JsqJ+WW2kMHzExMrQvUCAODvOrDW3gTrJzvSUd_3n55oCwA@mail.gmail.com>
Subject: Re: [PATCH v4 04/18] powerpc/pseries: add of_node_put() in dlpar_detach_node()
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 2:09 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 10/18/18 10:09, Rob Herring wrote:
> > On Mon, Oct 15, 2018 at 07:37:24PM -0700, frowand.list@gmail.com wrote:
> >> From: Frank Rowand <frank.rowand@sony.com>
> >>
> >> "of: overlay: add missing of_node_get() in __of_attach_node_sysfs"
> >> added a missing of_node_get() to __of_attach_node_sysfs().  This
> >> results in a refcount imbalance for nodes attached with
> >> dlpar_attach_node().  The calling sequence from dlpar_attach_node()
> >> to __of_attach_node_sysfs() is:
> >>
> >>    dlpar_attach_node()
> >>       of_attach_node()
> >>          __of_attach_node_sysfs()
> >
> > IIRC, there's a long standing item in the todo (Grant's) to convert the
> > open coded dlpar code. Maybe you want to do that first?
>
> I'd like to avoid extra delays to getting the current (with necesary
> fixes) series accepted because the series is rather intrusive and
> could have conflicts with other patches.
>
> I'm also worried that I don't have access to any of the systems that
> use the dynamic overlay code, and I don't have any way to test the
> changes.

Mainly I was thinking you are asking them to test changes now, so I
was thinking better to do that once than twice.

Either way is fine though.

> Can we encourage the users of this code to convert the open coded
> dlpar code?

That would be ideal...

Rob
