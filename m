Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4199AECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 05:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC0FC2154B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 05:48:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC0FC2154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=macq.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389262AbeIULgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 07:36:11 -0400
Received: from smtp2.macqel.be ([109.135.2.61]:56342 "EHLO smtp2.macqel.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbeIULgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 07:36:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp2.macqel.be (Postfix) with ESMTP id BB60D130D43;
        Fri, 21 Sep 2018 07:48:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at macqel.be
Received: from smtp2.macqel.be ([127.0.0.1])
        by localhost (mail.macqel.be [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YodWpRD4htQB; Fri, 21 Sep 2018 07:48:51 +0200 (CEST)
Received: from frolo.macqel.be (frolo.macqel [10.1.40.73])
        by smtp2.macqel.be (Postfix) with ESMTP id 5B0D7130D3A;
        Fri, 21 Sep 2018 07:48:51 +0200 (CEST)
Received: by frolo.macqel.be (Postfix, from userid 1000)
        id 2F98FDF007D; Fri, 21 Sep 2018 07:48:50 +0200 (CEST)
Date:   Fri, 21 Sep 2018 07:48:51 +0200
From:   Philippe De Muyter <phdm@macq.eu>
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org
Subject: Re: [PATCH v2 1/5] m68k: Rename system call table file name
Message-ID: <20180921054850.GA13343@frolo.macqel>
References: <1537455973-12468-1-git-send-email-firoz.khan@linaro.org> <1537455973-12468-2-git-send-email-firoz.khan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537455973-12468-2-git-send-email-firoz.khan@linaro.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 08:36:09PM +0530, Firoz Khan wrote:
> The system call table entries are present in syscalltable.S. One of
> the patch in this patch series will auto-generate the system call
> table entries using the system call table generation script and
> which'll replace the existig table file.
> 
> In order to come up with a common naming convention across all
> architecture, we need to change the file name to syscall_table.S.

That file was probably called that way to be able to distinguish it
from syscalltable.s and syscalltable.o in a file system with a 14
characters limit in file names (in sysV unix systems).

> This change will unify the implementation across all architecture.
> 
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> ---
>  arch/m68k/kernel/Makefile        |   2 +-
>  arch/m68k/kernel/syscall_table.S | 403 +++++++++++++++++++++++++++++++++++++++
>  arch/m68k/kernel/syscalltable.S  | 403 ---------------------------------------

You should generate your patch with the '-M' or '--find-renames' option.

Philippe

-- 
Philippe De Muyter +32 2 6101532 Macq SA rue de l'Aeronef 2 B-1140 Bruxelles
