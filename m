Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D292FC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80BD42174B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jkWt8ls2";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oddceUD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80BD42174B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732280AbeHCLF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 07:05:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42082 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbeHCLF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 07:05:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 09CC8607BD; Fri,  3 Aug 2018 09:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533287404;
        bh=f3b+i8SCQxLUBbRfSfIw8KTtBfV+fLyU6cXMjWja9VA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=jkWt8ls2fUUfT2jeplF0P7Dxv3sOBu+4Sl1u5Z8L9g6wuCBPd7YfxqO7W1EiCHx6Y
         1eGuEUp4D0yyOHrHQk06ySjC6kDvwTJa+ZcgvdmOyXO6lnJgCC3wnP+7e3Kkyr/5ev
         vB29pZ5KSGiXy3eVXCyBGX/+1nF/wmrNJDve0kcw=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 35FEC601A1;
        Fri,  3 Aug 2018 09:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533287403;
        bh=f3b+i8SCQxLUBbRfSfIw8KTtBfV+fLyU6cXMjWja9VA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=oddceUD6TlUC/23ZuAv16PhX7qGrzWU/K6gjslS5EakUTlE3xzV9ZSkz5aRArRSpk
         bJnwhIiZE6ijaBHWl7nAqi721Y1TS/lsnnYun2Gw2MUveKTBKFy17MbgJqLPtcac4x
         kXJ30dReHMYqFxEChqB6fLaSHgMy6zqYsAHx6M5k=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 35FEC601A1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Wireless <linux-wireless@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>
Subject: Re: linux-next: build failure after merge of the wireless-drivers-next tree
References: <20180803182942.4de98df2@canb.auug.org.au>
Date:   Fri, 03 Aug 2018 12:09:59 +0300
In-Reply-To: <20180803182942.4de98df2@canb.auug.org.au> (Stephen Rothwell's
        message of "Fri, 3 Aug 2018 18:29:42 +1000")
Message-ID: <874lgb7r4o.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> After merging the wireless-drivers-next tree, today's linux-next build
> (powerpc allyesconfig) failed like this:
>
> ld: drivers/net/wireless/mediatek/mt76/mt76x0/trace.o:(__tracepoints+0x0): multiple definition of `__tracepoint_set_shared_key'; drivers/net/wireless/mediatek/mt7601u/trace.o:(__tracepoints+0x0): first defined here

[...]

> Caused by commit
>
>   7b4859026ccd ("mt76x0: core files")
>
> and following ones.
>
> I have just marked that driver broken for now:

Thanks Stephen for the report. Odd that kbuild bot didn't catch this, I
did have these patches in my pending branch for several days.

Stanislaw, could you please send a fix for this ASAP? I can't submit a
pull request to Dave until this is fixed.

-- 
Kalle Valo
