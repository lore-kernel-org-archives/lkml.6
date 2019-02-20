Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0511EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C69632147C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbfBTNBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 08:01:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:54204 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727828AbfBTNBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 08:01:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A926EB130;
        Wed, 20 Feb 2019 13:01:35 +0000 (UTC)
Date:   Wed, 20 Feb 2019 14:01:35 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Joao Moreira <jmoreira@suse.de>
cc:     live-patching@vger.kernel.org, pmladek@suse.cz, jikos@suse.cz,
        nstange@suse.de, jpoimboe@redhat.com, jeyu@kernel.org,
        matz@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/8] livepatch: Create and include UAPI headers
In-Reply-To: <20190130165446.19479-2-jmoreira@suse.de>
Message-ID: <alpine.LSU.2.21.1902201401240.26855@pobox.suse.cz>
References: <20190130165446.19479-1-jmoreira@suse.de> <20190130165446.19479-2-jmoreira@suse.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> diff --git a/include/uapi/linux/livepatch.h b/include/uapi/linux/livepatch.h
> new file mode 100644
> index 000000000000..bc35f85fd859
> --- /dev/null
> +++ b/include/uapi/linux/livepatch.h
> @@ -0,0 +1,28 @@
> +/*
> + * livepatch.h - Kernel Live Patching Core
> + *
> + * Copyright (C) 2016 Josh Poimboeuf <jpoimboe@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */

People will ask to replace GPL boilerplate with SPDX tag.

> +#ifndef _UAPI_LIVEPATCH_H
> +#define _UAPI_LIVEPATCH_H
> +
> +#include <linux/types.h>

#include is not necessary here, I think.

> +#define KLP_RELA_PREFIX		".klp.rela."
> +#define KLP_SYM_PREFIX		".klp.sym."
> +
> +#endif /* _UAPI_LIVEPATCH_H */

Miroslav
