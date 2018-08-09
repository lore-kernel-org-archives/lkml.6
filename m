Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E32C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A2021CC3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YI6RhAgK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ioxQwPBM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A2021CC3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbeHINPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 09:15:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59754 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbeHINPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 09:15:32 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0594A60710; Thu,  9 Aug 2018 10:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533811874;
        bh=Qk4lNLV7Wkfnq1Rk8ErrbBSS/sYz0aPrDMFErmK0PgE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=YI6RhAgKDYP2tsaMtBgUCns8o4FcLzZFKHi2Azb+1HLBEM6E02sO/HxGpYB49FaTF
         nKeYX+9dYltjLzJQ4Q/BJ5YybnD+ZaIER32Jqs2KMTbV8J6nXElR1w1vPsW2f3Qq17
         bEuzyWDZeq4KPSTn11Z5aR473AmHX8TQMJbgGAZU=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C9C7F60710;
        Thu,  9 Aug 2018 10:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533811873;
        bh=Qk4lNLV7Wkfnq1Rk8ErrbBSS/sYz0aPrDMFErmK0PgE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ioxQwPBMbFnrxzKKVUEUgAWS2ay1pvu+HENOnsN0nJo63/FnVLmTcnj9d7H8egkE/
         mA12e/yEsW5pPNAfKWLtoLhfkPVl00HY55HMZG6dV56qLUzNNGlZ08OdUqrjiGqUBk
         ywYUAL7PEhqrq6aprYchdhtB9j0mptNu4UZbDpRk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C9C7F60710
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH wireless-drivers] mt76x0: Remove VLA usage
References: <20180807225040.GA2164@beast> <20180808092450.GA25772@redhat.com>
        <871sb942cx.fsf@kamboji.qca.qualcomm.com>
        <CAGXu5jKqeAHDWdNg++QJko5AM4g160kEQ54jLAojpRq6FszqgA@mail.gmail.com>
        <20180809104137.GA1955@redhat.com>
Date:   Thu, 09 Aug 2018 13:51:09 +0300
In-Reply-To: <20180809104137.GA1955@redhat.com> (Stanislaw Gruszka's message
        of "Thu, 9 Aug 2018 12:41:38 +0200")
Message-ID: <87bmab3jaa.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stanislaw Gruszka <sgruszka@redhat.com> writes:

> On Wed, Aug 08, 2018 at 08:41:28AM -0700, Kees Cook wrote:
>> >> I thought SPDX line is needed only if file has no license and eeprom.c
>> >> file and other mt76x0 files have specified the license. Is SPDX still
>> >> needed in that case ?
>> 
>> I thought all source files needed SPDX: https://lwn.net/Articles/739183/
>
> Ok, goal is to have all kernel source files with SPDX header.

Yeah, it's a goal but I don't think it's a hard requirement yet. At
least I don't see it as a reason to reject patches.

And besides, mt76 uses ISC license and that's not in LICENSES directory.
So someone should add that first, and I think that patch should go via
Jonathan Corbet's tree (CCed).

-- 
Kalle Valo
