Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAE1C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605202098A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aaBcBV1c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 605202098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbeJPE1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 00:27:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbeJPE1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 00:27:39 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E8502145D;
        Mon, 15 Oct 2018 20:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539636046;
        bh=AScWQ7JjECJI5tiAKAKvTFA03/wmmvxb7nDYO7ki3WQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aaBcBV1ctUgCDIfG+3DiQ6ZYUfR9Bq8BzHJRqPLxBltKeHOioCOIsEyyBPQNDeckM
         FybBtQqBfQWCjTZ6mnQZ85SLGyomzaZD+m0/ou38SIIrF33WjVCYyVFrm+ToVyOgUG
         OS4iz3NEu4FIcu5ssWmTRMnZRJeMgZAssoAaJL+8=
Received: by mail-ed1-f45.google.com with SMTP id l14-v6so10179329edq.0;
        Mon, 15 Oct 2018 13:40:46 -0700 (PDT)
X-Gm-Message-State: ABuFfogiNdJcwOEhv/zoxoDcF+Ra1jxkgatL1tfuQTeeVKiiyFq3LEgy
        Zk8o53nuU8NSCw8Qo0rbjvq4vGH89eCZzd6BNNM=
X-Google-Smtp-Source: ACcGV607lPoA1njn2HOnfQOaWB76Rw6qUyX4rg9MCo2z0G10xdG9tOcSW1qdnI6+kR5R60h/8+IciGbJ0CoB604XyfE=
X-Received: by 2002:a05:6402:14da:: with SMTP id f26mr26909955edx.224.1539636044512;
 Mon, 15 Oct 2018 13:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <1537978342-17697-1-git-send-email-atull@kernel.org>
 <1537978342-17697-5-git-send-email-atull@kernel.org> <CAJYdmeNdBbJBVGjLkk03PpGERA2j=D__BVsb9_FBXwWFkMXR_Q@mail.gmail.com>
In-Reply-To: <CAJYdmeNdBbJBVGjLkk03PpGERA2j=D__BVsb9_FBXwWFkMXR_Q@mail.gmail.com>
From:   Alan Tull <atull@kernel.org>
Date:   Mon, 15 Oct 2018 15:40:08 -0500
X-Gmail-Original-Message-ID: <CANk1AXQxX8_AMkJhSbuNgxb1972dRqv-6niqU3V63FzKE8=wtQ@mail.gmail.com>
Message-ID: <CANk1AXQxX8_AMkJhSbuNgxb1972dRqv-6niqU3V63FzKE8=wtQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] docs: fpga: document programming fpgas using regions
To:     Moritz Fischer <moritz.fischer.private@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Federico Vaga <federico.vaga@cern.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fpga@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 3:11 PM Moritz Fischer
<moritz.fischer.private@gmail.com> wrote:
>
> On Wed, Sep 26, 2018 at 9:12 AM Alan Tull <atull@kernel.org> wrote:
> >
> > Clarify the intention that interfaces and upper layers use
> > regions rather than managers directly.
> >
> > Rearrange API documentation to better group the API functions
> > used to create FPGA mgr/bridge/regions and the API used for
> > programming FPGAs.
> >
> > Signed-off-by: Alan Tull <atull@kernel.org>
> > Suggested-by: Federico Vaga <federico.vaga@cern.ch>
>
> Acked-by: Moritz Fischer <mdf@kernel.org>

Thanks Moritz!

Alan
