Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6678AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 310C920870
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:23:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 310C920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbeJJUp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 16:45:26 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45443 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbeJJUpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 16:45:25 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gAESF-0008RI-9O; Wed, 10 Oct 2018 15:23:11 +0200
Date:   Wed, 10 Oct 2018 15:23:07 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Hans de Goede <hdegoede@redhat.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>
Subject: Re: [PATCH 1/2] LICENSES: Add note to CDDL-1.0 license that it should
 not be used
In-Reply-To: <20181010110540.22468-1-hdegoede@redhat.com>
Message-ID: <alpine.DEB.2.21.1810101518050.15060@nanos.tec.linutronix.de>
References: <20181010110540.22468-1-hdegoede@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2018, Hans de Goede wrote:

> The only reason we have the CDDL-1.0 license text around is for some
> dual-licensed files from virtualbox. New code should not use this license.
> 
> Add a note about this and change the example tag to be dual-licensed.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  LICENSES/other/CDDL-1.0 | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/LICENSES/other/CDDL-1.0 b/LICENSES/other/CDDL-1.0
> index 195a1687930a..164401ea9e62 100644
> --- a/LICENSES/other/CDDL-1.0
> +++ b/LICENSES/other/CDDL-1.0
> @@ -1,10 +1,12 @@
>  Valid-License-Identifier: CDDL-1.0
>  SPDX-URL: https://spdx.org/licenses/CDDL-1.0.html
>  Usage-Guide:
> +  Do NOT use. The CDDL-1.0 is not GPL compatible. It may only be used for
> +  dual-licensed files where the other license is GPL compatible.
>    To use the Common Development and Distribution License 1.0 put the
>    following SPDX tag/value pair into a comment according to the placement
>    guidelines in the licensing rules documentation:
> -    SPDX-License-Identifier: CDDL-1.0
> +    SPDX-License-Identifier: (GPL-2.0 OR CDDL-1.0)

I'd rather replace the 'GPL-2.0' with something like '$GPL-COMPATIBLE-ID'
and say explicitely in the prosa text that CCDL can only be used with OR
and not with AND.

Thanks,

	tglx
