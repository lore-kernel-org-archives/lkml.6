Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 28298C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8981208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GK7Skdw9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8981208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755121AbeFNMAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 08:00:33 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:37438 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754885AbeFNMAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 08:00:31 -0400
Received: by mail-ua0-f195.google.com with SMTP id l14-v6so505571uao.4;
        Thu, 14 Jun 2018 05:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fLhSW3KG0kQmZti18DpUdNS6AbKNzGJOXSzJmL0TeO8=;
        b=GK7Skdw963p84Og2aIGelNHuAKfVJYFy9eyhRwG0trgomImTPELVFMHFZapdzezaSM
         9eQvde4T1FQt3EK/5laatCW5MnVFE4AFryk7a2lQI2qgkwXgCdUpI72DC4TUwyEZTn7U
         pIavWEUBtgdSDrqFGl4OjVO4Eb30fA1PYTaKEOGUgMOYfRm83Af470E+kx8oqyzWAi3j
         aJvXgAbDr+1SlqCpIyqluSjE5HCVs4fPsafWGyBPPdNkyDPHopeUbMF08ISzZq4fG8pX
         DQO8gtI3HzaQX2jssWeYVbxFhejQhGEb4cVMOOuoP1vZDLVTTA9/raQGAty94Z2k4STE
         kYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fLhSW3KG0kQmZti18DpUdNS6AbKNzGJOXSzJmL0TeO8=;
        b=KfvZlfJgr4CuHzs4I5f46k59ExAcrpuxkMIOPnj85lbNt7bJVhA89yp9kSqhkFtSr0
         //x4h8h1KHUbeVmYj0SUESVE/sq2LOT9LT5uGjNGENQm2Txmc1mE9EOznryW0vy0lqMF
         K2RxAZdqGrLYtn9tcUV1Kk3ZC1Hz94cnA2TvWdVv7OYptN1AONpHIt5yFIxYvPOvZ9fW
         nOp2jHjyO2t4WNf/0Xby3VTEdfAXRiJAt49xAPpMTvh/KVp5NkqOfFyVik+PfYGRbob6
         HfkMjAaxd0pkHyDF+NL6b1KghbPRGRN+90izZSMtD/2Pod6NCfL4BP6dXVTTUUt9Xl1Q
         yRqA==
X-Gm-Message-State: APt69E2UtU76gv7MtF75Se7EnLw7IhX0EbiMUjGP4msP6wGByQBDBAUl
        7JqINC2R9H2ldbkML5GoxJsnzxNHmP/Uu+LhYHQ=
X-Google-Smtp-Source: ADUXVKJD0T+83b/KlKOKaSx5g50vzwS/rMtpf5UqinlxStmjEFiB5FsdP3F4xnqAQDlb2yX0BxEahIimqIbtopKpq7M=
X-Received: by 2002:ab0:1446:: with SMTP id c6-v6mr1485315uae.12.1528977630761;
 Thu, 14 Jun 2018 05:00:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 05:00:30
 -0700 (PDT)
In-Reply-To: <1528977459-52285-1-git-send-email-jiazhouyang09@gmail.com>
References: <1528705581-34646-1-git-send-email-jiazhouyang09@gmail.com> <1528977459-52285-1-git-send-email-jiazhouyang09@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 14 Jun 2018 15:00:30 +0300
Message-ID: <CAHp75VfuHASHEigiy+3-J3+7N2q=1nTyHr1KShkjRO+7COjMrw@mail.gmail.com>
Subject: Re: [PATCH v2] scsi: bfa: add error handling for pci_iomap
To:     Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 2:57 PM, Zhouyang Jia <jiazhouyang09@gmail.com> wrote:
> When pci_iomap fails, the lack of error-handling code may
> cause unexpected results.

What results?
How had you tested it?

> This patch adds error-handling code after calling pci_iomap.

> +       if (bfad->pci_bar2_kva == NULL) {

> +               printk(KERN_ERR "Fail to map bar2\n");

pr_err() ?

> +               goto out_unmap_bar0;
> +       }

-- 
With Best Regards,
Andy Shevchenko
