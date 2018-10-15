Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598F2C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 09:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7ED42054F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 09:25:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7ED42054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbeJORKL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 13:10:11 -0400
Received: from ozlabs.org ([203.11.71.1]:53857 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbeJORKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 13:10:11 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42YY2Y6K4xz9sBq;
        Mon, 15 Oct 2018 20:25:41 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     LEROY Christophe <christophe.leroy@c-s.fr>
Cc:     dri-devel@lists.freedesktop.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-block@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        aneesh.kumar@linux.vnet.ibm.com, Scott Wood <oss@buserror.net>,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Li Yang <leoyang.li@nxp.com>,
        Kumar Gala <galak@kernel.crashing.org>,
        Jens Axboe <axboe@kernel.dk>,
        Geoff Levand <geoff@infradead.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v3 06/24] powerpc/mm: properly set PAGE_KERNEL flags in ioremap()
In-Reply-To: <20181014115810.Horde.99_1JiRv0nxT_Jq3cbpMhw1@messagerie.si.c-s.fr>
References: <cover.1539092111.git.christophe.leroy@c-s.fr> <52bd80b06bae0d854d04501e1e136575b77fa9fa.1539092111.git.christophe.leroy@c-s.fr> <87d0sd19vm.fsf@concordia.ellerman.id.au> <87a7nh104q.fsf@concordia.ellerman.id.au> <20181014115810.Horde.99_1JiRv0nxT_Jq3cbpMhw1@messagerie.si.c-s.fr>
Date:   Mon, 15 Oct 2018 20:25:41 +1100
Message-ID: <87zhvfzhm2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LEROY Christophe <christophe.leroy@c-s.fr> writes:
> Michael Ellerman <mpe@ellerman.id.au> a écrit :
>> Michael Ellerman <mpe@ellerman.id.au> writes:
>>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>>
>>>> Set PAGE_KERNEL directly in the caller and do not rely on a
>>>> hack adding PAGE_KERNEL flags when _PAGE_PRESENT is not set.
>>>>
>>>> As already done for PPC64, use pgprot_cache() helpers instead of
>>>> _PAGE_XXX flags in PPC32 ioremap() derived functions.
>>>>
>>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>>
>>> Something in here is breaking my p5020ds (both 32-bit and 64-bit):
>>
>> Oh duh.
>>
>> That's because I didn't take patch 4.
>>
>> It didn't have any acks, but I guess I'll just merge it rather than
>> breaking things.
>
> Yes indeed. Maybe should I have followed it more carrefully to ensure  
> it gets an ack.

That's OK, I should have paid more attention to what it was actually
doing, I thought it was just a cleanup.

cheers
