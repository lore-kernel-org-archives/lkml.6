Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DE2C43612
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 21:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F6E4206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 21:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731021AbeLPVp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 16:45:29 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:51428 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbeLPVp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 16:45:28 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 43HyWT4pwWz1qwdZ;
        Sun, 16 Dec 2018 22:45:25 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 43HyWT1g6Wz1qqkw;
        Sun, 16 Dec 2018 22:45:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 46zP_XmvU_8O; Sun, 16 Dec 2018 22:45:24 +0100 (CET)
X-Auth-Info: NdrY/Xw+cWHy68Zn4OnD0//5nYXKnZ1ISBEirVyv22o=
Received: from [IPv6:::1] (unknown [195.140.253.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 16 Dec 2018 22:45:24 +0100 (CET)
Subject: Re: [PATCH] Revert "serial: 8250: Fix clearing FIFOs in RS485 mode
 again"
To:     Paul Burton <paul.burton@mips.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        Daniel Jedrychowski <avistel@gmail.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.com>
References: <20181213174834.kxdy6fphaeoivqgh@pburton-laptop>
 <20181216200833.27928-1-paul.burton@mips.com>
 <f5a76d73-862f-3ebc-cd07-effc5c432103@denx.de>
 <20181216213133.kwe24pif3v4wcgwp@pburton-laptop>
From:   Marek Vasut <marex@denx.de>
Message-ID: <949fdd3d-535e-d235-f406-d5bde4658c5e@denx.de>
Date:   Sun, 16 Dec 2018 22:45:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181216213133.kwe24pif3v4wcgwp@pburton-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/2018 10:31 PM, Paul Burton wrote:
> Hi Marek,

Hi,

> On Sun, Dec 16, 2018 at 09:32:19PM +0100, Marek Vasut wrote:
>> I am unable to test it on such a short notice as I'm currently ill, so I
>> cannot tell if your change breaks the OMAP3/AM335x boards or not. Given
>> that there are very few CI20 boards in use, I'd like to ask you for some
>> extra time to investigate this on the OMAP3 too.
> 
> I'm sorry to hear that you're ill, but your patch is getting awfully
> close to becoming part of a stable kernel release & it causes
> regressions. Even if it didn't break a board I use, I think the patch
> would be broken & risky for the reasons I outlined in my revert's commit
> message.

That's what the incremental releases are for, so that minor problems can
get fixed there. Sure, it's great to have things perfect in the first
release, but if that breaks other systems, too bad.

> Ultimately it's Greg's decision but it sounds like you're asking me to
> say it's OK to break the JZ4780 in a stable kernel with a patch that I
> think would be risky anyway, and I won't do that.

I am saying this revert breaks AM335x, so this is a stalemate. I had a
discussion with Ezequiel (on CC) and he seems to have a different
smaller patch coming for this problem.

[...]

-- 
Best regards,
Marek Vasut
