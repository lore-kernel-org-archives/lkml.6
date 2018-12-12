Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3E2C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 01:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EE5E20851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 01:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ITYIE18J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EE5E20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=purestorage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbeLLBbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 20:31:36 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40786 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeLLBbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 20:31:35 -0500
Received: by mail-qt1-f193.google.com with SMTP id k12so18780596qtf.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 17:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J6fFGJHnjceq1r5h/KuGidS1/t2IUyPSho208krEb6M=;
        b=ITYIE18JbXHVspKL/CUngrw7avgWXI6uoR+Fi3iNyYSW4olj33rA64fBJuBTt5BkLE
         wcfblW5f44jUEM9FgP3xLmTZK0KLNBZyhThCff6uH+djYbpneZz8l0ktXPTVH+XYKL4F
         4FCkIMoqTqVemDgrZkfGfpjRQul1GSEdNwdzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J6fFGJHnjceq1r5h/KuGidS1/t2IUyPSho208krEb6M=;
        b=mgYh6kawv/cTtm4WWCOJaoitmO4zxSIBR/1vTp+o4wxdHY5MYGbb6/RUmg9fa2Wgb3
         5mDKJ4R8IQsycrl0nzcOTsCTHT/gRTb6iXoO5+mE21XLK9FkqtJMLlocOWNhbUzczuxJ
         dSIBNt6xCcn0XxHJbPwO5Oi09y+kF59eLCb2OgGlMtbnqSyRKtge8ZH9HgOwQIFXj1qy
         SpnlZc7filY9VvsUIsnXqoeq+xsKRtZBO087idiDs+0qW2SzLtMumPteHs1wXgj3+OFj
         vqu9Yi7GqrDOlhGMoxMRIXfrkLveclLIY4t4+g4Q17kI8tn65iQhxsY3gH2FY8P97TXl
         1oXQ==
X-Gm-Message-State: AA+aEWYDvmb6nxst5oGVlztfjve6aBSVDxmuvHF3W5jxqIftMgV3o26J
        cpOX9g44dLLOFznM8wBh5bXFpWszpHPqlG5Iu5mNQZ/wOhs40w==
X-Google-Smtp-Source: AFSGD/UGSGSnAuw21onh38FGLD7LI2wxZ8+QP2yIYQ8xluKcFlfo/KGW6S9oR6vLvS76Gj37Dl/KBJ5If2Ax5hAem7w=
X-Received: by 2002:ac8:18fa:: with SMTP id o55mr18605544qtk.256.1544578294605;
 Tue, 11 Dec 2018 17:31:34 -0800 (PST)
MIME-Version: 1.0
References: <1543535954-28073-1-git-send-email-jalee@purestorage.com>
 <cc7cbad6-0e7d-8328-c602-61d659c3a7de@grimberg.me> <b7b26a7a-70be-d805-ee64-67fba0b4efa8@mellanox.com>
 <CAJX3Cti_ZJF5E+NRuRzSeEUgaXsbA2U9C+Rh5OdYd4EMwXC1gw@mail.gmail.com>
 <773bb91f-40a4-a525-f7b8-db821b402821@mellanox.com> <CAJX3Ctjtt2zebuLfzKM30PV1x3fm8HaJJFJw3zZSOShWnQnu=Q@mail.gmail.com>
 <c645f196-3fbb-c9b9-5686-730ceed102fa@grimberg.me>
In-Reply-To: <c645f196-3fbb-c9b9-5686-730ceed102fa@grimberg.me>
From:   Jaesoo Lee <jalee@purestorage.com>
Date:   Tue, 11 Dec 2018 17:31:23 -0800
Message-ID: <CAJX3Ctg9rn2JyTL1xfb2htWjPaB3qj9t4gV=QZ+3yjGbCNz8UA@mail.gmail.com>
Subject: Re: [PATCH] nvme-rdma: complete requests from ->timeout
To:     sagi@grimberg.me
Cc:     nitzanc@mellanox.com, keith.busch@intel.com, axboe@fb.com,
        hch@lst.de, Roland Dreier <roland@purestorage.com>,
        Prabhath Sajeepa <psajeepa@purestorage.com>,
        Ashish Karkare <ashishk@purestorage.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please drop this patch. However, it would be happy if this bug can be
fixed as soon as possible.

Nitzan, do you mind if you send your patch for review?
On Tue, Dec 11, 2018 at 3:39 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>
> > I cannot reproduce the bug with the patch; in my failure scenarios, it
> > seems that completing the request on errors in nvme_rdma_send_done
> > makes __nvme_submit_sync_cmd to be unblocked. Also, I think this is
> > safe from the double completions.
> >
> > However, it seems that nvme_rdma_timeout code is still not free from
> > the double completion problem. So, it looks promising to me if you
> > could separate out the nvme_rdma_wr_error handling code as a new
> > patch.
>
> Guys, can you please send proper patches so we can review properly?
