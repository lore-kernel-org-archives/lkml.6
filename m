Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E6AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 01:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97349218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 01:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuPmh2DF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388457AbeLUBIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 20:08:54 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:36512 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbeLUBIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 20:08:54 -0500
Received: by mail-io1-f65.google.com with SMTP id m19so2392029ioh.3;
        Thu, 20 Dec 2018 17:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8KATF8kssH2IrIsieP4Kx3E/kGAOy94n70DXfribFJk=;
        b=BuPmh2DFaurlvdoznmiOQS8/LsjXjj1Sx/thazf8HHpol/614Kv7g+aFKCjbWLbue/
         UO5oJ470ZXdknzRrTvAkCKjEe8KzOGehWkZ9PLm5iqRSBLtqC23KQ6OS1TRao04/UeQH
         6YCmRyOjUAf19WNKuifp4ZmgtDc04xYcPgp4MWueDhppLL3V8H7hl1K2CFjbb8fsWjOW
         /BlOx1Hw4m7VE3wCsBpvhw2AxhQqmW1DBeNIrZoYZNhGusXWwm48k4HVHBunL0yAPsy3
         oYU8fmGYvDw8jbUjps4xM3VPamxD6sWnPNqjD5t83RX8Mo7I1PGoXU8Tuec4Lo9z+cB5
         6AWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8KATF8kssH2IrIsieP4Kx3E/kGAOy94n70DXfribFJk=;
        b=Ysz5f3VJmkirqgiXLh8eWerm5QTOs6iJmC2/uzOdml6qkcJdCUAB/fVi3WdQSoosxl
         Vqb/jE447iDlIopRExCSFl9lC/LgRpSIsdTkQoUKzDhpxSubiSrZ2pWfWGtW6AWbjHo/
         HpRIQ0ddIH1ZV6+KLcCMijxQ4Hu335GOqfkau8vdbKkADRYsLeUKEwDvWYmr++nxuLoI
         CkufDXOKihLf+ihmY5ryExqj3t4NRf63ApBK2VeMcDHiueN8ZNUQFs0CxHxYzDAr1GCR
         pWKFkLD90eBpof5COqR1vmxALmer/zLc4qyM7ssX9ORZn+yxoV7AnykFreqGqx+09Z4V
         HQng==
X-Gm-Message-State: AJcUukeRpsTQ7sDkQ8JXsD0DHSt2936NGcPTQqnLcQvXxNJutl0tUOXf
        H18Aur0eMkZbypvR563rT1CuiT4VHQMJbaP7lnE=
X-Google-Smtp-Source: ALg8bN73hZk43ui03OHNU6hHQmBUI7ZvYmAVx2rrdF/9IKSUNBqSDRKaSNi9avI+YN4dL64aYiYvdis0oAHyFp52bjE=
X-Received: by 2002:a6b:9355:: with SMTP id v82mr403894iod.40.1545354533622;
 Thu, 20 Dec 2018 17:08:53 -0800 (PST)
MIME-Version: 1.0
References: <CGME20181121130510epcas3p4498edc67a02f61a6aa8e55efa9349681@epcas3p4.samsung.com>
 <20181121130439.22255-1-tiny.windzz@gmail.com> <b3331d3f-3bfd-f3ce-cea1-30c4b13e6374@samsung.com>
 <a925d66a-09ea-b6db-8043-df58548da192@kernel.dk>
In-Reply-To: <a925d66a-09ea-b6db-8043-df58548da192@kernel.dk>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Fri, 21 Dec 2018 09:09:48 +0800
Message-ID: <CAEExFWuNc+3RyEHvpfAxtFFeFKk9nyVE_ZKHcpy2T6VWOEY1QA@mail.gmail.com>
Subject: Re: [PATCH] ata: pata_macio: add of_node_put()
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 2:01 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 12/20/18 10:03 AM, Bartlomiej Zolnierkiewicz wrote:
> >
> > On 11/21/2018 02:04 PM, Yangtao Li wrote:
> >> of_find_node_by_path() acquires a reference to the node
> >> returned by it and that reference needs to be dropped by its caller.
> >> bl_idle_init() doesn't do that, so fix it.
> >>
> >> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> >
> > Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>
> Yangtao, were you going to resend this one?
Actually,I've rensent the v2 at  Nov 22.And  I just changed the changelog.
Can you pick it up?

Thanks,
Yangtao
