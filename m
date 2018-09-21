Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13CFECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F90421557
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKvrDRDy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F90421557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391034AbeIUXhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:37:13 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40077 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390619AbeIUXhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 19:37:12 -0400
Received: by mail-ot1-f65.google.com with SMTP id g14-v6so166032otj.7;
        Fri, 21 Sep 2018 10:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uHhEAyyEH/JXSfBP7u9H9CJKC9aPf+TdqcrqXGxpmuQ=;
        b=kKvrDRDy2TckOJdtvIZtwN1SoXP3z7GR3swFjFcrX/N93kF4RiNWFA0JFqGgZRLBtO
         pXQDAnYzQrVdxKTyD7f94B/rkEqIK4rBEOBXqfKwISpIUd9QgpeRlF6sA7iyoqnqoqtq
         cRTVgEID+sgUxJ+7rZFVimr1KbgaQSary05oYKC1Bef2AFEOi+tJHXlDIwyuAnu97Y9X
         TRW69sKsv4HOk0fuBkGFnii1oT0BtXDWUgQAuXppulyW/5sXc4uJDGLjT41Vb0zOIOkU
         M4tqbDAZt0SCoE1w4NAw2I7Bz/OiA3GidE0z8eDMhV0qBbJN42/vMQgQFYt16JptFbMK
         z81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uHhEAyyEH/JXSfBP7u9H9CJKC9aPf+TdqcrqXGxpmuQ=;
        b=mGwVa8myHA747H16VGHHYcWkRzHY3pwpn5Tn6OqxSLxG7l58TqAwBTynOMcZhLxhqf
         GXGLKgQKbeP684AYsmnK7pzwuIAgt1RFvWH9E6uAcDn5hLsbMk+qgQK+zWALaLhwocJb
         q7iKGa78pr+3kAH3YHen7RvbeQrQetWtloB7I8kN2+QNlS8A9eYstUBvv/gql6WQnhvW
         jRP9bTUrYl4koFy1pTO3DBSveASxY3ZrtBFqajm4KyPzmUZswPU2zF+GGVw6cLTgD+Lh
         zUdszIZ06cS5NPMDECAW2ylzzxBUK6TT8hnY+BJnogvHooZNRXUwQ2ZJXRo+Yunaaa3m
         axgw==
X-Gm-Message-State: APzg51CguKMPr5V2bmbyBlXLNFfCffMiV/K8MB1MBkrhULMXIP2v2T0Z
        2koQusmFM7yZ+7ptmtSJKXntfyaKG4qIDUlkdq0=
X-Google-Smtp-Source: ANB0VdaRh8MvHi6RN/q2BSP1NY3MCPopnq69lRu0rcox0ccQBuQDwJOIQoy8rZz+QIUu+PENeN62SFhHIoStHGobqWA=
X-Received: by 2002:a9d:3677:: with SMTP id w110-v6mr26948097otb.394.1537552035445;
 Fri, 21 Sep 2018 10:47:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2d28:0:0:0:0:0 with HTTP; Fri, 21 Sep 2018 10:47:15
 -0700 (PDT)
In-Reply-To: <163d1af7d51bfa330f4cc685c5c493cd38aa584b.1537541211.git.leonard.crestez@nxp.com>
References: <163d1af7d51bfa330f4cc685c5c493cd38aa584b.1537541211.git.leonard.crestez@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 21 Sep 2018 14:47:15 -0300
Message-ID: <CAOMZO5CpXjoh0r+HXY7UWCrusbqL-F+oKU1iKKvJ_sLfHhdq+w@mail.gmail.com>
Subject: Re: [PATCH] crypto: mxs-dcp - Fix wait logic on chan threads
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leonard,

On Fri, Sep 21, 2018 at 12:03 PM, Leonard Crestez
<leonard.crestez@nxp.com> wrote:
> When compiling with CONFIG_DEBUG_ATOMIC_SLEEP=y the mxs-dcp driver
> prints warnings such as:
>
> WARNING: CPU: 0 PID: 120 at kernel/sched/core.c:7736 __might_sleep+0x98/0x9c
> do not call blocking ops when !TASK_RUNNING; state=1 set at [<8081978c>] dcp_chan_thread_sha+0x3c/0x2ec
>
> The problem is that blocking ops will manipulate current->state
> themselves so it is not allowed to call them between
> set_current_state(TASK_INTERRUPTIBLE) and schedule().
>
> Fix this by converting the per-chan mutex to a spinlock (it only
> protects tiny list ops anyway) and rearranging the wait logic so that
> callbacks are called current->state as TASK_RUNNING. Those callbacks
> will indeed call blocking ops themselves so this is required.
>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Do you have extra patches to allow this driver to probe?

I see the following probe error for a long time with mainline:

[   25.611780] mxs-dcp 80028000.dcp: Failed to register sha1 hash!
[   25.620798] mxs-dcp: probe of 80028000.dcp failed with error -22

Do you have a fix for this?

Thanks
