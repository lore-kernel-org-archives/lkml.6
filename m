Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F236C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA9A8217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549987405;
	bh=8EGT0xdqv/il9De3JSWzQU2nJqNAtwyLjjBNu8h/6wQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=l+9qp5mVFQiUAbAUdboROz/mBLJzNNaNpT9p7d7aMoIlB3InPKs5z1dNhfwyzy553
	 6ewhcDoa0r03BAdbzzEOFyCSiaaYp7EV+OTX4O4zKs+aMZSa3AUVtzWFBd77oUZU1a
	 sJ1jHEqHakjepuckHd5SZm/P4sGQLh/hGt3ogdHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730790AbfBLQDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:03:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:33790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728347AbfBLQDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:03:23 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0754A218E0;
        Tue, 12 Feb 2019 16:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549987402;
        bh=8EGT0xdqv/il9De3JSWzQU2nJqNAtwyLjjBNu8h/6wQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tQiN/Qytw60Dcmpei9FRnTzBJku7+K9W5/vPuqSxbb8eVfc8CHpRwAkB45P+a/LW5
         RlcfsvrvsK225TKIvu78MCv/IyNlA9PRKU6EQ5nJu9ZACg+54hg9sKpgqi9VBQlWpX
         D/4JGFAdL5NMQxXgWj+g3VN3tmFNf6iKnQYow7Rw=
Received: by mail-qt1-f182.google.com with SMTP id v10so3494421qtp.8;
        Tue, 12 Feb 2019 08:03:21 -0800 (PST)
X-Gm-Message-State: AHQUAuZCD5OV6ZnDlBbA5BJ9tJQ1QxqW4itlrr/4pa8OLt26jgzwfB39
        VwJqsX19jcGyL/zdFq1nGZt/RhbTfR3VrWfNKA==
X-Google-Smtp-Source: AHgI3Iam+6/yVnFxn0GKbiSQFfFEr74tEcIazYgDBBeUE5oT6H0niNc0WT76LVJw3bCIV+arGJN8D7RrJghxPHLsbzw=
X-Received: by 2002:ac8:25d1:: with SMTP id f17mr3315819qtf.38.1549987401158;
 Tue, 12 Feb 2019 08:03:21 -0800 (PST)
MIME-Version: 1.0
References: <d4facdc2-0581-929f-caa2-b9efa9bd8f97@arm.com> <CAL_JsqKFT8J6g02gxeBiTfBb_XHhp2-ZNB6DgaLPK85kNZGRig@mail.gmail.com>
 <20190121143704.GE29504@arrakis.emea.arm.com> <CAL_JsqKQb34zVNTzo9DLNiDwmWGxkrKezSOjwCUPAvgzUoLYjg@mail.gmail.com>
 <20190121174234.GC26461@rapoport-lnx> <2bb30550-435a-046c-4f45-21dd594aa695@free.fr>
 <3c886941-bf9d-f040-b568-ee7a8eba9a04@free.fr> <CGME20190123055509epcas3p18a6d66fa08412f2308cb2c1997328ea8@epcas3p1.samsung.com>
 <20190123055414.GA4747@rapoport-lnx> <78f4ea8a-996d-038e-9e33-5ff02fa2c43f@samsung.com>
 <20190123123143.GE4747@rapoport-lnx> <4b8f82c4-7f8f-b814-c1ec-9902e43963f6@free.fr>
 <617e0d57-342d-4162-bd21-ece18e481d87@free.fr>
In-Reply-To: <617e0d57-342d-4162-bd21-ece18e481d87@free.fr>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 12 Feb 2019 10:03:09 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKbCg-rGmLoA3mPv54=LMuQBfevfzL8f2QPVyjN-sNk8w@mail.gmail.com>
Message-ID: <CAL_JsqKbCg-rGmLoA3mPv54=LMuQBfevfzL8f2QPVyjN-sNk8w@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] of: fix kmemleak crash caused by imbalance in
 early memory reservation
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Prateek Patel <prpatel@nvidia.com>,
        DT <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 10:47 AM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
>
> On 04/02/2019 15:37, Marc Gonzalez wrote:
>
> > Cc: stable@vger.kernel.org # 3.15+
> > Fixes: 3f0c820664483 ("drivers: of: add initialization code for dynamic reserved memory")
> > Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Acked-by: Prateek Patel <prpatel@nvidia.com>
> > Tested-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> > Resend with DT CCed to reach robh's patch queue
> > I added CC: stable, Fixes, and Prateek's ack
> > Trim recipients list to minimize inconvenience
>
> Mike, Stephen,
>
> I'm confused over commit 3532b3b554a216f30edb841d29eef48521bdc592 in linux-next
> "memblock: drop __memblock_alloc_base()"
>
> It's definitely going to conflict with the proposed patch
> over drivers/of/of_reserved_mem.c
>
> Rob, what's the next step then?

Rebase it on top of what's in linux-next and apply it to the tree
which has the above dependency. I'm guessing that is Andrew Morton's
tree.

Rob
