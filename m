Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1C5C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0CC25A92
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QTD/8vSU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jxQ7xwwx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE0CC25A92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934896AbeF0QAL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 12:00:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46228 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934246AbeF0QAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 12:00:10 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7F9BC606FA; Wed, 27 Jun 2018 16:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530115209;
        bh=9buYP9JNXr3/dDrUYfosn6t21hOfEfD4v5QN9FTmo+4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=QTD/8vSUmdjVPVhrUXW+TrdfX0JRoSpHgrJNRrsssgkpbOIH/8bmcxSmP7yzeemrp
         N8wp7vG4f/fcldPhSCDT0poaNv+vlu/6Oq7xEwfGBRQwJEby2DG6T4aFj5Jgw2wVoH
         ucMEf+DMVglfMnHYUViIPhn9t7Ix/PyecIyWLyUc=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A313B601EA;
        Wed, 27 Jun 2018 16:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530115208;
        bh=9buYP9JNXr3/dDrUYfosn6t21hOfEfD4v5QN9FTmo+4=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=jxQ7xwwxRlx3Xyukus0quN8ns5b7LtG5EnXxYbziPCD0+K+ynOpeHoSZjXCZ+rJ2z
         ORh3stOXB+Otc/xs2LGiO+6Eo6DGpzT4DA04V3h4scByHbUHeXWvdn94/0jUs8f7Vk
         Mcf94WAk4oODn+Rx4+qaZ9rBEvriQrDQnZP7Qxz8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A313B601EA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v6,(resend),1/3] bitfield: fix *_encode_bits()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180620065830.6612-2-johannes@sipsolutions.net>
References: <20180620065830.6612-2-johannes@sipsolutions.net>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180627160009.7F9BC606FA@smtp.codeaurora.org>
Date:   Wed, 27 Jun 2018 16:00:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> wrote:

> There's a bug in *_encode_bits() in using ~field_multiplier() for
> the check whether or not the constant value fits into the field,
> this is wrong and clearly ~field_mask() was intended. This was
> triggering for me for both constant and non-constant values.
> 
> Additionally, make this case actually into an compile error.
> Declaring the extern function that will never exist with just a
> warning is pointless as then later we'll just get a link error.
> 
> While at it, also fix the indentation in those lines I'm touching.
> 
> Finally, as suggested by Andy Shevchenko, add some tests and for
> that introduce also u8 helpers. The tests don't compile without
> the fix, showing that it's necessary.
> 
> Fixes: 00b0c9b82663 ("Add primitives for manipulating bitfields both in host- and fixed-endian.")
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

3 patches applied to wireless-drivers-next.git, thanks.

e7d4a95da86e bitfield: fix *_encode_bits()
37a3862e1238 bitfield: add u8 helpers
0e2dc70e3d0d bitfield: add tests

-- 
https://patchwork.kernel.org/patch/10476545/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

