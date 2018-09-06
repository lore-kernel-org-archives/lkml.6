Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8986DC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C542064D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFPouwoG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14C542064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730542AbeIFX1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 19:27:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727043AbeIFX1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 19:27:11 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3479620861;
        Thu,  6 Sep 2018 18:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536259824;
        bh=tmMm7eVA0zGd3cTvdEC/8cNW4aOFfHy8SpZxDZPRmzc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hFPouwoGLBOaKZ0KKdNCsSZ/M3i1UG+AsclfPT+XjHRn7JNrlGdZJ4WptrIGkoPoB
         jn5rovBAVi9oLjSxKPYp9We8Rhu21spzh4IDwZ6i+7ge5rBfN6b0VX6TAAOkXTgnRl
         7zcnBR+Hw/7kuSsED/8c9UHwZMyJhT/Y/QWy9YV8=
Received: by mail-yb1-f182.google.com with SMTP id k5-v6so4518355ybo.10;
        Thu, 06 Sep 2018 11:50:24 -0700 (PDT)
X-Gm-Message-State: APzg51BeZSxGZqyfh9UfJL04zAVOnF9VIrsXXlW6NDBHlRcsqKimntAw
        iRClNeekMqnS4e1STIfEu8SgS2GJP7MESFUxZms=
X-Google-Smtp-Source: ANB0VdZ8FlNtVpyjSeA+QZGgUQEWQNwMTMxRbY357DaptaWNy5pHmXdzZGT/moF9BQSF/MTS/k+lIdZ8Vv5IahodRz4=
X-Received: by 2002:a25:9884:: with SMTP id l4-v6mr2341944ybo.255.1536259823418;
 Thu, 06 Sep 2018 11:50:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180904212237.3078-1-atull@kernel.org> <20180904212237.3078-4-atull@kernel.org>
 <CAJYdmeO0RegP4q1tVow1U0=Zc42GEHMuqsHsvHvMqp89zZ6Wpw@mail.gmail.com>
 <CANk1AXQaSLziycCv4X50xufehu7AgV34pxydxs8H14uFREy4YQ@mail.gmail.com> <20180906181918.GA20419@archbook>
In-Reply-To: <20180906181918.GA20419@archbook>
From:   Alan Tull <atull@kernel.org>
Date:   Thu, 6 Sep 2018 13:49:47 -0500
X-Gmail-Original-Message-ID: <CANk1AXSvDf=kDRdGq-VkFxFZvLTYkfNKqPCDau=9K5e8BjvTuA@mail.gmail.com>
Message-ID: <CANk1AXSvDf=kDRdGq-VkFxFZvLTYkfNKqPCDau=9K5e8BjvTuA@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] fpga: bridge: add devm_fpga_bridge_create
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Moritz Fischer <moritz.fischer.private@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fpga@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 1:19 PM Moritz Fischer <mdf@kernel.org> wrote:
>
> Hi Alan,
>
> On Wed, Sep 05, 2018 at 10:38:53AM -0500, Alan Tull wrote:
> > > > - * fpga_bridge_unregister - unregister and free a fpga bridge
> > > > - * @bridge:    FPGA bridge struct created by fpga_bridge_create
> > > > + * fpga_bridge_unregister - unregister a FPGA bridge
> > > > + *
> > > > + * @bridge: FPGA bridge struct
> > > > + *
> > > > + * This function is intended for use in a FPGA bridge driver's remove function.
> > > > + * If the bridge was created with devm_fpga_bridge_create(), the bridge struct
> > > > + * will be automatically freed.  If the bridge was created with
> > > > + * fpga_bridge_create(), the caller is responsible for freeing the bridge with
> > > > + * fpga_bridge_free().
> > >
> > > I find the formulation somewhat confusing, since it could be
> > > interpreted as if you
> > > used the devm_() functions you don't have to call unregister().
> >
> > Yes I'm being too verbose and it's making things muddled.  How about
> > if I take out the part that starts with "If bridge was created..."?
> > That just leaves "This function is intended for use in a FPGA bridge
> > driver's remove function."
>
> Sounds good.

OK, for v3 I'll make a similar change in patches 2 and 4.

Alan

>
> Moritz
