Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E608C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39762087D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tl+jE4rM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39762087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbeJEVwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:52:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:60908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728139AbeJEVwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 17:52:24 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B34021479;
        Fri,  5 Oct 2018 14:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538751201;
        bh=00zcc7T9LOqqvcw8lccqOwJaFe1MY6VWDH4ECJFlkn0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Tl+jE4rMsSuXm7vxnCkApF5zbU5S1iCkUWnHjuOXM7ME4r5SF+OThrHYbQoomG/3+
         jNL3AGZ9XjeG95ghbh6wob3L/FurmTViXDIP8suDsFLOXIEGASFxk4u77iRB0ENTK6
         Xtgvi/FBv3Gaq9ZBEtx8xBIcP/izrBjKwdvGwYF4=
Received: by mail-qt1-f171.google.com with SMTP id b4-v6so5992327qtc.7;
        Fri, 05 Oct 2018 07:53:21 -0700 (PDT)
X-Gm-Message-State: ABuFfoiQPUl/WsSQ/0nQNTI2KgSSra6t9J4ZQSMnlui83WehGIYEyVLd
        NHvGusPZZUM+UrxKF/1fARQcLvmeiCyudZEvrw==
X-Google-Smtp-Source: ACcGV61UtYTBgqWR4Mbl1nxSdTwcm9wKf7n/oxaa9XcPPvcWE+aikjffBw8WLByXacL/CLAsjyI6fN7yi6RSp/gnCnI=
X-Received: by 2002:ac8:2ac9:: with SMTP id c9-v6mr9642544qta.188.1538751200204;
 Fri, 05 Oct 2018 07:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <1538712767-30394-1-git-send-email-frowand.list@gmail.com> <1538712767-30394-16-git-send-email-frowand.list@gmail.com>
In-Reply-To: <1538712767-30394-16-git-send-email-frowand.list@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 5 Oct 2018 09:53:08 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+dqRr54_WAdBQ88sJytAuLL=U9kF_Xbj5rJv4PVn9gQg@mail.gmail.com>
Message-ID: <CAL_Jsq+dqRr54_WAdBQ88sJytAuLL=U9kF_Xbj5rJv4PVn9gQg@mail.gmail.com>
Subject: Re: [PATCH 15/16] of: unittest: initialize args before calling of_irq_parse_one()
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 11:14 PM <frowand.list@gmail.com> wrote:
>
> From: Frank Rowand <frank.rowand@sony.com>
>
> Callers of of_irq_parse_one() blindly use the pointer args.np
> without checking whether of_irq_parse_one() had an error and
> thus did not set the value of args.np.  Initialize args to
> zero so that using the format "%pOF" to show the value of
> args.np will show "(null)" when of_irq_parse_one() has an
> error and does not set args.np instead of trying to
> dereference a random value.
>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
>  drivers/of/unittest.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Does this need to be part of this series?

Rob
