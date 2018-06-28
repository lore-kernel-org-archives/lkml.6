Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB05C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E22CF270BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RVp4gaOc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RVp4gaOc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E22CF270BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753080AbeF1Ivx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 04:51:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53424 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752281AbeF1Ivv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 04:51:51 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8B42560B19; Thu, 28 Jun 2018 08:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530175910;
        bh=hDhFtz9iIUvGcHXJGsK9dnAyUDXWfEM2IaqZhwhhLQg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=RVp4gaOcE2uRpTpKpkQ7BdIfDdO0OpUJNhIijoHIxSY7V7lQOyJtyHMvzu3dDiFIZ
         yC4G7tw/POUfGw839s+DVsBg0f+rgRwUiNK0vKHa8HMFFgsj2pSVkMOrZFtNkfbkRy
         1VCECG4GpREni15+o/sUmwp6ccsnwRDZLWtX515o=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 776236028C;
        Thu, 28 Jun 2018 08:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530175910;
        bh=hDhFtz9iIUvGcHXJGsK9dnAyUDXWfEM2IaqZhwhhLQg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=RVp4gaOcE2uRpTpKpkQ7BdIfDdO0OpUJNhIijoHIxSY7V7lQOyJtyHMvzu3dDiFIZ
         yC4G7tw/POUfGw839s+DVsBg0f+rgRwUiNK0vKHa8HMFFgsj2pSVkMOrZFtNkfbkRy
         1VCECG4GpREni15+o/sUmwp6ccsnwRDZLWtX515o=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 776236028C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Matthew Wilcox <willy@infradead.org>,
        Wireless <linux-wireless@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the xarray tree with the wireless-drivers-next tree
References: <20180628145900.4ca1e648@canb.auug.org.au>
        <1530172269.4988.1.camel@sipsolutions.net>
Date:   Thu, 28 Jun 2018 11:51:40 +0300
In-Reply-To: <1530172269.4988.1.camel@sipsolutions.net> (Johannes Berg's
        message of "Thu, 28 Jun 2018 09:51:09 +0200")
Message-ID: <87in63s38j.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Thu, 2018-06-28 at 14:59 +1000, Stephen Rothwell wrote:
>> Hi all,
>> 
>> Today's linux-next merge of the xarray tree got a conflict in:
>> 
>>   lib/Kconfig.debug
>> 
>> between commit:
>> 
>>   0e2dc70e3d0d ("bitfield: add tests")
>> 
>> from the wireless-drivers-next tree and commit:
>> 
>>   d968f529e39f ("xarray: Add XArray load operation")
>> 
>> from the xarray tree.
>
> Thanks for the heads-up! Not really sure where/how we'll be able to get
> that resolved before it hits Linus, but as the conflict seems rather
> easy (overlapping additions), I guess it's not such a big deal.

Yeah, I would assume this is business as usual for Linus and we don't
need to do anything. But please do let me know if that's not the case.

-- 
Kalle Valo
