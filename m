Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61A3C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5F821717
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dmMUo3SO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Hyk4b65N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D5F821717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732350AbeHCLOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 07:14:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51974 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729357AbeHCLOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 07:14:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 448F86024C; Fri,  3 Aug 2018 09:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533287968;
        bh=QoQJBCtKxQgkeyCYVft34c9KVICuflt/Y/m4gyY3rVk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=dmMUo3SOoKiWRzAhpCoEzkBun6uND4hrL1jB4trEeBSC0a5JvooNXmqq+FnAVKOxH
         vdC+QFF/FOPeSLighxuKfztkYRexjnXziDQMMcH5K6YBag6oi9ZQna8cCFdZWLYpbU
         BoitRGVpL93KzOHSljzMmAK8tQ4y0eHVthXnp43E=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5C5FA6071C;
        Fri,  3 Aug 2018 09:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533287963;
        bh=QoQJBCtKxQgkeyCYVft34c9KVICuflt/Y/m4gyY3rVk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Hyk4b65NP10ADysv8N74nd1iSbixzygixwD02i5wwSnI3fumZH5+NAwMZgjN0QSPW
         DOUzJLlxOmJdrDDnu9d/bZ2Rsw4Ykk9qlTmDO8F/sQYcot1Yd6n4ggXQdB3Cb2L+FS
         jbb8hcoY8VmKjknePyrB97Wg0BKOWqqOyUtd9kVo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5C5FA6071C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     Wireless <linux-wireless@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mt76x0: build driver only as module
References: <20180803091401.GB10284@redhat.com>
Date:   Fri, 03 Aug 2018 12:19:20 +0300
In-Reply-To: <20180803091401.GB10284@redhat.com> (Stanislaw Gruszka's message
        of "Fri, 3 Aug 2018 11:14:01 +0200")
Message-ID: <87zhy36c4n.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stanislaw Gruszka <sgruszka@redhat.com> writes:

> There are various symbols that conflicts with mt7601u.
> Due to that kernel will not build with allyesconfig.
> For now limit the driver to be build only as module.
>
> Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>

Thanks for the quick patch!

> --- a/drivers/net/wireless/mediatek/mt76/Kconfig
> +++ b/drivers/net/wireless/mediatek/mt76/Kconfig
> @@ -11,7 +11,7 @@ config MT76x2_COMMON
>  
>  config MT76x0U
>  	tristate "MediaTek MT76x0U (USB) support"
> -	depends on MAC80211
> +	depends on MAC80211 && m

But this feels like an ugly hack to me. Isn't there a better way to fix
this? (I don't have time to investigate the error in detail right now.)

-- 
Kalle Valo
