Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B431C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7DD208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD7DD208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buttersideup.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeH0Xy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:54:27 -0400
Received: from relay0.allsecuredomains.com ([78.129.187.18]:40444 "EHLO
        relay0.allsecuredomains.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727005AbeH0Xy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:54:27 -0400
X-Greylist: delayed 2134 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Aug 2018 19:54:26 EDT
Received: from [81.174.144.187] (helo=zebedee.buttersideup.com)
        by relay0.allsecuredomains.com with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tim@buttersideup.com>)
        id 1fuNDu-0001MV-Jt; Mon, 27 Aug 2018 19:30:50 +0000
Received: from [IPv6:2001:470:1b4a:0:405:5dff:fe10:5138] (unknown [IPv6:2001:470:1b4a:0:405:5dff:fe10:5138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by zebedee.buttersideup.com (Postfix) with ESMTPSA id D9D69A0D03;
        Mon, 27 Aug 2018 19:30:23 +0000 (UTC)
Subject: Re: [PATCH] EDAC: Remove the i82443bxgx_edac driver
To:     Borislav Petkov <bp@alien8.de>, Takashi Iwai <tiwai@suse.de>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180810141520.8993-1-tiwai@suse.de>
 <20180815155752.GC28669@nazgul.tnic> <s5hh8jv62lk.wl-tiwai@suse.de>
 <20180815161205.GD28669@nazgul.tnic> <20180827164535.GB22318@nazgul.tnic>
From:   Tim Small <tim@buttersideup.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tim@buttersideup.com; prefer-encrypt=mutual; keydata=
 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 bkUp
Message-ID: <56b161bc-9b5e-63c9-b815-8b3ff8214887@buttersideup.com>
Date:   Mon, 27 Aug 2018 20:30:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180827164535.GB22318@nazgul.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/08/18 17:45, Borislav Petkov wrote:
> Actually, looking at this driver more - it has been depending on
> BROKEN since 2007!


Hi,

I'd forgotten that it was in BROKEN state.

The issue was that the driver was fully functioning, but it clashed with
the graphics aperture driver - both use different registers within the
same PCI device - it was marked broken on the basis that the with the
kernel PCI device allocation code as it stood at the time, if the
i82443bxgx_edac driver was loaded first, the graphics aperture
configuration driver could not also be loaded, and this could break
existing setups.

As far as I remember, it was left was that Greg KH had said that he was
working on a change to the PCI device allocation code which would allow
both to coexist.  I don't know if that happened.

The last CPU which used these chipsets (130nm Pentium III) were released
in 2001.  I don't know when they were produced up until.

On that basis, I don't see a problem with removing it, but if there's a
preference for me to fix it, (and if I still have some old hardware
somewhere that I can test it on), I'll be happy to do that instead.

Tim.
