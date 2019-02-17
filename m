Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0732FC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 08:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D05B82192D
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 08:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfBQI0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 03:26:33 -0500
Received: from ozlabs.org ([203.11.71.1]:56239 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfBQI0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 03:26:32 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 442KpZ5B0Dz9sDr;
        Sun, 17 Feb 2019 19:26:30 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     linuxppc-dev@ozlabs.org, linux-mm@kvack.org, erhard_f@mailbox.org,
        jack@suse.cz, aneesh.kumar@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/64s: Fix possible corruption on big endian due to pgd/pud_present()
In-Reply-To: <87pnrran89.fsf@igel.home>
References: <20190214062339.7139-1-mpe@ellerman.id.au> <87pnrran89.fsf@igel.home>
Date:   Sun, 17 Feb 2019 19:26:29 +1100
Message-ID: <87h8d2ddmy.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab <schwab@linux-m68k.org> writes:

> On Feb 14 2019, Michael Ellerman <mpe@ellerman.id.au> wrote:
>
>> The fix is simple, we need to convert the result of the bitwise && to
>> an int before returning it.
>
> Alternatively, the return type could be changed to bool, so that the
> compiler does the right thing by itself.

Yes that would be preferable. All other architectures return an int so
I wasn't game to switch to bool for a fix. But I don't see why it should
matter so I'll do a patch using bool for next.

cheers
