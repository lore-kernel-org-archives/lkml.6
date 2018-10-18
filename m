Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2087C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E6D2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZeOPrlBF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E6D2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbeJSEgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 00:36:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:40396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725738AbeJSEgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 00:36:54 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AB1021480;
        Thu, 18 Oct 2018 20:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539894851;
        bh=xibyru/6E+pbWcbcO1mQcay7znSyaxQ3AvZX6Uo7gF8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZeOPrlBFocuLQWMoYmnhJeDyTbb6BbyuxBa/tCizpxwKo49IYr1qwzQ0t1/vYJDpe
         uJCcJ402zOeRNNz1LaWRQyOus7OwtZKDYwptroV9ZuLaYx+pNpEHIHVYRgAKDv525Q
         nAG4xXtt3+qA+mGnW/gxlZQCiLQ3UM2SVlhdnA/0=
Received: by mail-ed1-f42.google.com with SMTP id y19-v6so29479177edd.2;
        Thu, 18 Oct 2018 13:34:11 -0700 (PDT)
X-Gm-Message-State: ABuFfoh1R0U+L2pkVwwSsGGqT1Yp+3DHneU7x9A5fUtXb0/VHUYm2kIe
        qxS/pMen9j9T1gVVUdhfZXR6FidbCzq4fD4gT0Y=
X-Google-Smtp-Source: ACcGV62fx7uprVHx4BIko1GPkcmpIgc+eNKc1q933vS9zTruPnOYKtb68bVQWIZCs3ymht1XL1olpE+QJfwuXiksE2A=
X-Received: by 2002:a50:8bd5:: with SMTP id n21-v6mr4442093edn.41.1539894849583;
 Thu, 18 Oct 2018 13:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <1467735814-23518-1-git-send-email-ricardo.ribalda@gmail.com>
 <1467735814-23518-11-git-send-email-ricardo.ribalda@gmail.com>
 <CANk1AXRvJQtcmAysrkfAGurGUGVHSq55=8PZARGYsEZNv2zt0g@mail.gmail.com> <153989424794.53599.4926915592056818669@swboyd.mtv.corp.google.com>
In-Reply-To: <153989424794.53599.4926915592056818669@swboyd.mtv.corp.google.com>
From:   Alan Tull <atull@kernel.org>
Date:   Thu, 18 Oct 2018 15:33:33 -0500
X-Gmail-Original-Message-ID: <CANk1AXRkO1uCPQ0ef1rBvkWtx6=qcc-F-8qk6YkY+CLiJES4wQ@mail.gmail.com>
Message-ID: <CANk1AXRkO1uCPQ0ef1rBvkWtx6=qcc-F-8qk6YkY+CLiJES4wQ@mail.gmail.com>
Subject: Re: [PATCH v5 8/8] clk: fixed-rate: Convert into a module platform driver
To:     sboyd@kernel.org
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        mturquette@baylibre.com, sboyd@codeaurora.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-clk@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 3:24 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Alan Tull (2018-10-18 12:20:58)
> > On Tue, Jul 5, 2016 at 11:45 AM Ricardo Ribalda Delgado
> > <ricardo.ribalda@gmail.com> wrote:
> >
> > I've stumbled across a of_node_get/put imbalance that happens when the
> > fixed rate clock is added and deleted using device tree.  The cause is
> > that this driver calls of_clk_add_provider() when probed, but doesn't
> > call of_clk_del_provider() when removed.
> >
> > It looks like a lot of clock drivers share that issue:
> >
> > $ cd drivers/clk/
> > $ git grep -l of_clk_add_provider * | xargs grep -L of_clk_del_provider | wc -l
> > 131
> >
> > It should be a one line fix, but for many files.
> >
> > I'm not a clock subsystem expert, so please let me know whether I'm
> > missing something here.
> >
>
> Patches welcome. Please include Fixes: tags for backports. Probably
> drivers don't care because clk devices are almost never removed. That
> isn't to say it shouldn't be fixed, but just giving some background on
> why nobody has fixed it.

Thanks for the context.  I ran into this while testing some devicetree
overlay code changes.  My use is FPGAs where a clock may be added or
removed if the FPGA is reprogrammed.

Alan
