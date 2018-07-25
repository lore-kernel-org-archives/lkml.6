Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325DFC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D239320844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="M7FmI/47";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="G4bIcWMA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D239320844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbeGYJvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 05:51:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51906 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbeGYJvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 05:51:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 565BC60B19; Wed, 25 Jul 2018 08:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532508036;
        bh=FgDO9eDG1WFgsyg0wQjVPNran9cP4fZeTCvZdofhBRk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=M7FmI/47VYGnddiovRyqUrqWHvYL6DtDsKtEw2Iq0vxNsg3BdHVpY7JMMZQstxjb6
         XuK3DkoR8izYEhisvSulaVdz0J6dg5uS4TxLvhLsjsrDk9J/ohx1FK2zJDwX+6wDGX
         lcJQHmMh6Chu3Zwh3wSsz/BiSjFvjzuNfTXmI+a4=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8029C6074D;
        Wed, 25 Jul 2018 08:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532508035;
        bh=FgDO9eDG1WFgsyg0wQjVPNran9cP4fZeTCvZdofhBRk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=G4bIcWMAa/BCQs++UX+VzF64OGqg1Ef1BRJQIZGFZGM/03SWKhmpAlqJDSW+MeNMX
         wiS/dbppUV94i+noiReYTctFA1A/9OWbCoKAaPRPqFpC9EV6ofhUsJZgQ5kS/dNP4M
         0ZkWei0jaizuVOyfTf5mcg6rmtWVW9ljzmW/EMs0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8029C6074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, "Reizer\, Eyal" <eyalr@ti.com>,
        Kees Cook <keescook@chromium.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com
Subject: Re: [PATCH] drivers: net: wlcore: remove duplicate \n for some warnings
References: <af660348ade58fd33396d2dca432536d2ac85cf7.1532498079.git.hns@goldelico.com>
        <87lg9zyg1p.fsf@codeaurora.org>
        <F5C1808B-516D-4D74-BC43-6E997D9F012A@goldelico.com>
Date:   Wed, 25 Jul 2018 11:40:30 +0300
In-Reply-To: <F5C1808B-516D-4D74-BC43-6E997D9F012A@goldelico.com> (H. Nikolaus
        Schaller's message of "Wed, 25 Jul 2018 10:30:45 +0200")
Message-ID: <87lg9zvhc1.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Nikolaus Schaller" <hns@goldelico.com> writes:

>> Am 25.07.2018 um 08:40 schrieb Kalle Valo <kvalo@codeaurora.org>:
>> 
>> "H. Nikolaus Schaller" <hns@goldelico.com> writes:
>> 
>>> wl1271_warning() already appends a \n to the format,
>>> so adding one to the warning string gives empty lines in the log.
>>> 
>>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> 
>> "drivers: net:" in the title is unnecessary, but I can remove that.
>
> Ok, thanks! I wasn't aware of the precise subsystem tagging style here.

Yeah, subsystems can do it a bit differently. But you can easily check
with git log the preferred style:

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#subject

-- 
Kalle Valo
