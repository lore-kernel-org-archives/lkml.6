Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21445C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 23:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD535215E5
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 23:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="PxHQLrs8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD535215E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbeJUIIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 04:08:55 -0400
Received: from mta-p4.oit.umn.edu ([134.84.196.204]:43662 "EHLO
        mta-p4.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbeJUIIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 04:08:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by mta-p4.oit.umn.edu (Postfix) with ESMTP id 1E78D6BE;
        Sat, 20 Oct 2018 23:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=umn.edu; h=
        content-type:content-type:subject:subject:message-id:date:date
        :from:from:in-reply-to:references:mime-version:received:received
        :received; s=20160920; t=1540079798; x=1541894199; bh=8+zehd/zNT
        4jIDMdF7K6N8ws2U5GwQ7ikTn0K1MdtbA=; b=PxHQLrs8doomKFgb/N6pQ4R2gF
        d5XvtsfPpNMRU1VEmcPKPeCqzWUY+Ut8KFNN2tsfDC8RdELfNRPoIh+B0a6E2h6u
        YbSg6wjXQsvircOjvuVpYv+8Z6H/xA6bDd5afWFVkEZpp//y5+73jmXgYe0b35qg
        y4shzMUZuDDRfYllQUgTymKUcRwi7P/3BNMm6xQcg7PZ6hKCWjTRygnWH4hYbWGE
        MKIFmdVNBe3oEN79ixL/oDA/1UnSz6AR7W4CdYc4tqGR2t/i7cgGLroFJ8tTDYJK
        jXwdK22Wh+SO2TOjqijn723PO/0V6+GzQCxe3cJ9PzVPe+JlPTd9Vecr9fcg==
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p4.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p4.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id k94946U5SUB1; Sat, 20 Oct 2018 18:56:38 -0500 (CDT)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wang6495)
        by mta-p4.oit.umn.edu (Postfix) with ESMTPSA id DB61C65C;
        Sat, 20 Oct 2018 18:56:38 -0500 (CDT)
Received: by mail-ot1-f41.google.com with SMTP id p23so36626760otf.11;
        Sat, 20 Oct 2018 16:56:38 -0700 (PDT)
X-Gm-Message-State: ABuFfojGztWxNIUQuTVB6+J0grNQR44JtOJos/09TvDTVnLGxJ1WDiuw
        Xk4L54X8UqchpQ2yh7FShMFQsKHe518I8x4ZvN8=
X-Google-Smtp-Source: ACcGV63FPnhIFrwVNfUCz80QW003Roc0+0HasWW5ISJfPM03R+F8zy8/QUrwRG3qREfnEP0y5MT3inMhlGOWuouFq7Q=
X-Received: by 2002:a9d:f61:: with SMTP id 88mr26626394ott.364.1540079798630;
 Sat, 20 Oct 2018 16:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <1540072741-18856-1-git-send-email-wang6495@umn.edu> <038301d468ca$9d30ca90$d7925fb0$@opengridcomputing.com>
In-Reply-To: <038301d468ca$9d30ca90$d7925fb0$@opengridcomputing.com>
From:   Wenwen Wang <wang6495@umn.edu>
Date:   Sat, 20 Oct 2018 18:56:02 -0500
X-Gmail-Original-Message-ID: <CAAa=b7fPLM-kF+VyZhhj2tzhzuFNnXpv=gPVJ2mCcfQyToew0Q@mail.gmail.com>
Message-ID: <CAAa=b7fPLM-kF+VyZhhj2tzhzuFNnXpv=gPVJ2mCcfQyToew0Q@mail.gmail.com>
Subject: Re: [PATCH] iw_cxgb4: fix a missing-check bug
To:     swise@opengridcomputing.com
Cc:     Kangjie Lu <kjlu@umn.edu>, swise@chelsio.com, dledford@redhat.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Wenwen Wang <wang6495@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2018 at 6:41 PM Steve Wise <swise@opengridcomputing.com> wrote:
>
> Hey Wenwen,
>
> > Subject: [PATCH] iw_cxgb4: fix a missing-check bug
> >
> > In c4iw_flush_hw_cq, the next CQE is acquired through t4_next_hw_cqe(). In
> > t4_next_hw_cqe(), the CQE, i.e., 'cq->queue[cq->cidx]', is checked to see
> > whether it is valid through t4_valid_cqe(). If it is valid, the address of
> > the CQE is then saved to 'hw_cqe'. Later on, the CQE is copied to the
> local
> > memory in create_read_req_cqe(). The problem here is that the CQE is
> > actually in a DMA region allocated by dma_alloc_coherent() in create_cq().
> > Given that the device also has the permission to access the DMA region, a
> > malicious device controlled by an attacker can modify the CQE in the DMA
> > region after the check in t4_next_hw_cqe() but before the copy in
> > create_read_req_cqe(). By doing so, the attacker can supply invalid CQE,
> > which can cause undefined behavior of the kernel and introduce potential
> > security risks.
> >
>
> If the dma device is malicious, couldn't it just dma some incorrect CQE but
> still valid in the first place?  I don't think this patch actually solves
> the issue, and it forces a copy of a 64B CQE in a critical data io path.

Thanks for your response! If the malicious dma device just dma some
incorrect CQE, it will not be able to pass the verification in
t4_valid_cqe().

Wenwen
