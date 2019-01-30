Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB07C282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03311218A4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732818AbfA3SFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:05:50 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:48031 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732805AbfA3SFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:05:48 -0500
Received: from [2a01:598:b890:92b7:20d0:59ff:fe6e:bab9] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gouF3-0007Jh-SB; Wed, 30 Jan 2019 19:05:42 +0100
Date:   Wed, 30 Jan 2019 19:05:35 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Liu Xiang <liu.xiang6@zte.com.cn>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        liuxiang_1999@126.com
Subject: Re: [PATCH] x86/mm: Add SPDX identifier in arch/x86/mm files
In-Reply-To: <1548858044-4695-1-git-send-email-liu.xiang6@zte.com.cn>
Message-ID: <alpine.DEB.2.21.1901301900400.1622@nanos.tec.linutronix.de>
References: <1548858044-4695-1-git-send-email-liu.xiang6@zte.com.cn>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1461891994-1548871541=:1622"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1461891994-1548871541=:1622
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 30 Jan 2019, Liu Xiang wrote:
> --- a/arch/x86/mm/iomap_32.c
> +++ b/arch/x86/mm/iomap_32.c
> @@ -1,19 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0

This is wrong.

>  /*
>   * Copyright © 2008 Ingo Molnar
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.

      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

And there are more of those wrongs.

Aside of that, you really need to differentiate between files, which do not
have any license notice or reference at all and those which have. For the
ones without adding the identifier is fine. For thos which have, you really
need to create separate patches and cc the copyright holder(s) and the
initial author if possible.

Just slapping random identifiers into source files is not helping anything,
actually it's making the problem worse because you are relicensing the
source files.

Thanks,

	tglx
--8323329-1461891994-1548871541=:1622--
