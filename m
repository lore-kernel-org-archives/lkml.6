Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02CBC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 04:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 903732175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 04:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfBGEeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 23:34:00 -0500
Received: from ozlabs.org ([203.11.71.1]:34215 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbfBGEd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 23:33:59 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43w56s4PGvz9sN9;
        Thu,  7 Feb 2019 15:33:57 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org,
        David Gibson <david@gibson.dropbear.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v2] powerpc/mm: move a KERN_WARNING message to pr_debug()
In-Reply-To: <20190205202133.5048-1-lvivier@redhat.com>
References: <20190205202133.5048-1-lvivier@redhat.com>
Date:   Thu, 07 Feb 2019 15:33:57 +1100
Message-ID: <8736p0kyiy.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

I'm not sure I'm convinced about this one. It seems like we're just
throwing away the warning because it's annoying.

Laurent Vivier <lvivier@redhat.com> writes:
> resize_hpt_for_hotplug() reports a warning when it cannot
> increase the hash page table ("Unable to resize hash page
> table to target order") but this is not blocking and
> can make user thinks something has not worked properly.

Something did not work properly, the resize didn't work properly. Right?

> As we move the message to the debug area, report again the
> ENODEV error.
>
> If the operation cannot be done the real error message
> will be reported by arch_add_memory() if create_section_mapping()
> fails.

Can you explain that more. Isn't the fact that the resize failed "the
real error message"?


> Fixes: 7339390d772dd
>        powerpc/pseries: Don't give a warning when HPT resizing isn't available

This should all be on one line, and formatted as:

Fixes: 7339390d772d ("powerpc/pseries: Don't give a warning when HPT resizing isn't available")

See Documentation/process/submitting-patches.rst for more info and how
to configure git to do it automatically for you.

cheers
