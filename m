Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B39C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF282174D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QoX6kgZd";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QoX6kgZd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF282174D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732653AbeHCM0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 08:26:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44610 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732233AbeHCM0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 08:26:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DF9BC606DD; Fri,  3 Aug 2018 10:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533292265;
        bh=jvguKH8OUifI9BKBsIr6mIxLJd2zkw/vkLLjQQwpcvQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=QoX6kgZdD8MZ/rjVFuFxXhTaNR1vTROOTayI6JIZ69FUrSFeF5UAddUeRmuBwqKJ3
         YcuTy/OkSVHgWwJpOgdfUfWkcE31cbOdyjMRyczJQ3JYVFLKcLbuhq9tacR2jeMDlx
         4x0+gztVrul0IVrhBmPxKTegBNjd+YY1J9z6ooT4=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 30D09602B7;
        Fri,  3 Aug 2018 10:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533292265;
        bh=jvguKH8OUifI9BKBsIr6mIxLJd2zkw/vkLLjQQwpcvQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=QoX6kgZdD8MZ/rjVFuFxXhTaNR1vTROOTayI6JIZ69FUrSFeF5UAddUeRmuBwqKJ3
         YcuTy/OkSVHgWwJpOgdfUfWkcE31cbOdyjMRyczJQ3JYVFLKcLbuhq9tacR2jeMDlx
         4x0+gztVrul0IVrhBmPxKTegBNjd+YY1J9z6ooT4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 30D09602B7
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
        <87zhy36c4n.fsf@kamboji.qca.qualcomm.com>
        <20180803092822.GD10284@redhat.com>
        <20180803100939.GE10284@redhat.com>
Date:   Fri, 03 Aug 2018 13:31:01 +0300
In-Reply-To: <20180803100939.GE10284@redhat.com> (Stanislaw Gruszka's message
        of "Fri, 3 Aug 2018 12:09:40 +0200")
Message-ID: <87va8r68t6.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stanislaw Gruszka <sgruszka@redhat.com> writes:

> On Fri, Aug 03, 2018 at 11:28:22AM +0200, Stanislaw Gruszka wrote:
>> > But this feels like an ugly hack to me. Isn't there a better way to fix
>> > this? (I don't have time to investigate the error in detail right now.)
>> 
>> Yes, rename symbols names. And I will do this, just wanted to provide
>> quick fix for the problem. 
>> 
>> Moreover seems the same thing should be done for mt7601u to avoid build
>> errors and perhaps with mt76 :-( 
>> 
>> So I'm going to rename functions.
>
> I have the patches, I'm building kernel with allyesconfig now,
> it will take a while ...

I'm now hoping to send the pull request tomorrow, so if you can submit a
proper patch some time today that would be good.

-- 
Kalle Valo
