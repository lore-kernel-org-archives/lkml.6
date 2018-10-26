Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882C6ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2884920848
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rxQMdtig"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2884920848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbeJ0Bvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 21:51:51 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41883 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeJ0Bvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 21:51:50 -0400
Received: by mail-qt1-f195.google.com with SMTP id l41-v6so2048020qtl.8;
        Fri, 26 Oct 2018 10:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H6AZH1NRbQyMyiFRtRH5I+kXPEbqUL1zpx7d/eGGfCU=;
        b=rxQMdtig/3zZK79GsWSnOH26k2hYaqFWjCfKfteBsIFvvvb/mkF9mM+lajfLpQRqDq
         P5iX8V5xOZCHGqkJoRVPRUvbvpPWoX8n80Nw3ETh43F8u6JcoFdFxwgYFEQZAp/LSY2k
         I1J/C0kwbhQSHPFothqVoESmqMofFhTC4iUb/UIwdFbOo20SW3VRonit1knrFfU263aE
         VQKAHCL6z/blaa95Vwpjz8YeA+4q0XV7ZScklqXRHY+S2LxFdGbdHlXKTskRCducZGbq
         BrpheKrrtDt/bIpcjHYcZgnqk+qjNcpT1OunmnIawYNOv5WvgqJ/5Xy1hRGkLl3ykTgL
         xo/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H6AZH1NRbQyMyiFRtRH5I+kXPEbqUL1zpx7d/eGGfCU=;
        b=S3ox8+vUMYOj8lG+Jx4PknexktWC9N+ui5Qi/k5038dEyFixjbsU7qrd0fYuntZAcE
         9AntSsTNMza4lwgGcFIJzT7DT8V09585LGcZj0zhdQ6WbnHJnkmSCSoN4BFc8AH7id+L
         JfwbAJgTeGYyP1WNeoorKM+EZVqmXeoB4LHsk1RZ22KVbj9QkWrkGk6eUZ0Ezt7M2UvA
         OSyNXPD8DngAhYvDzDnwcPdAGnRxHao6+cMNU+NWZfqmdSlCIlQCL5yNpt3sAlKgEhCo
         JVTD0t0oYneVM0+J9S31A+oLWDNedvQGhk/TeyTy52HOae/gj3ztlXLBgpvc7pvQBskO
         DQQQ==
X-Gm-Message-State: AGRZ1gLjiArrZfch6syQLUnAhqColyR4nn9kllLlWUG/kJD+J9TeEBdY
        y6DLoIBnWU4ikWJEajeWifEMAlUC2HYBy2ySs3k=
X-Google-Smtp-Source: AJdET5fUK1e7w6SVr+yKqrxWwOMZFo7C0QPsRlMHweHS8vNY9/D/wKzh/h7y0+ayw1SQfcC2mvkmQp4dJCAQoaQhBkk=
X-Received: by 2002:ac8:3027:: with SMTP id f36-v6mr3940340qte.45.1540574041476;
 Fri, 26 Oct 2018 10:14:01 -0700 (PDT)
MIME-Version: 1.0
References: <1540276279-2903-1-git-send-email-mike.looijmans@topic.nl>
 <20181023090119.GA2205@archbook> <1781ed23-e03c-f70a-ea8c-3e9fa6eec9d4@topic.nl>
 <20181023110445.GA1371@archbook> <468b9b34-aa87-9abb-a913-0512a01e9a51@xilinx.com>
In-Reply-To: <468b9b34-aa87-9abb-a913-0512a01e9a51@xilinx.com>
From:   Moritz Fischer <moritz.fischer.private@gmail.com>
Date:   Fri, 26 Oct 2018 10:04:21 -0700
Message-ID: <CAJYdmePrXcH=kYJFAD=dMWem0r6CpP_+P0NB6qGE-8TLT9rcRQ@mail.gmail.com>
Subject: Re: [PATCH] zynq-fpga: Only route PR via PCAP when required
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     mike.looijmans@topic.nl, linux-fpga@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Tull <atull@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Fri, Oct 26, 2018 at 12:54 AM Michal Simek <michal.simek@xilinx.com> wrote:

> > Ok, I had suspected you tested it and probably didn't run into issues,
> > but just wanted to make sure we think about it. If you don't mind, swap
> > it around as I suggested just to be safe.
> >
> > With that change feel free to add my Reviewed-by: Moritz Fischer
> > <mdf@kernel.org> in your v2.
>
> That clock can be used by something else that's why you didn't observe
> any issue. Anyway I have no problem with reverting that setting back
> that icap can be used.

Ok, thanks for clarification, that was what I assumed :)

> In general there should be synchronization mechanism for this. And also
> driver "feature" not to enable access from icap for security reason. But
> that's something what should be done in other patch.

Yeah I'll have to look at remote notifications for FPGA managers
soon-ish for another
project as discussed at ELCE. Part of that would be synchronization I guess :)

Umhh, based on the secure state read from CTRL_SEC_EN bit, or did you
think along the
lines of "xlnx,no-icap" property that your bootloader / dt would provide?

Cheers,

Moritz
