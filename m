Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFD0ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B92EE2152C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eC4U5AB+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IyR09dfc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B92EE2152C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387599AbeITSOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:14:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42970 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730984AbeITSOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:14:04 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5CF2B600ED; Thu, 20 Sep 2018 12:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537446648;
        bh=i5YYbXA8haf7G9GkqOIHzi8w/mP6tD0X8dj3GRqL9+o=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=eC4U5AB+b1KgyNr8Pth1TpTwISdg4BCbslVZyWQFcc/LQz6aFtX+qirj8jgH86QnD
         Ew+KTVYmlv3j+n5UXkv7xtV3o6ctXJrm6om+mdGRYe3w5POQV3LbqWQFxItCAaHrpT
         vabsX2+OshOVIMpyeubVrtxZg3vRzpPWd6gnFoIE=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B7FA360B73;
        Thu, 20 Sep 2018 12:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537446647;
        bh=i5YYbXA8haf7G9GkqOIHzi8w/mP6tD0X8dj3GRqL9+o=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=IyR09dfc4T9Mnps/3ARGOmdtdw5ukFV3ak0K8/woEv5xTPh72MK4yElU/NZSPSNGc
         muvdKUmM0giIbDrd1FKlyFKhWGOknTZOh8LeWPgEYgCgk0GKrW1cFVvwQv+wrI3U76
         Of7NpERltgw1cMYCQN58LofL5koJDwjOR4t0vtwk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B7FA360B73
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     <davem@davemloft.net>, <hante.meuleman@broadcom.com>,
        <franky.lin@broadcom.com>, <arend.vanspriel@broadcom.com>,
        <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list.pdl@broadcom.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] brcm80211: remove redundant condition check before debugfs_remove_recursive
References: <1536761412-24932-1-git-send-email-zhongjiang@huawei.com>
        <20180920120709.5FE6960BF7@smtp.codeaurora.org>
        <5BA391D4.20205@huawei.com>
Date:   Thu, 20 Sep 2018 15:30:42 +0300
In-Reply-To: <5BA391D4.20205@huawei.com> (zhong jiang's message of "Thu, 20
        Sep 2018 20:25:56 +0800")
Message-ID: <877ejg1hcd.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zhong jiang <zhongjiang@huawei.com> writes:

> On 2018/9/20 20:07, Kalle Valo wrote:
>> zhong jiang <zhongjiang@huawei.com> wrote:
>>
>>> debugfs_remove_recursive has taken IS_ERR_OR_NULL into account. So just
>>> remove the condition check before debugfs_remove_recursive.
>>>
>>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> It seems you already submitted an identical patch four days earlier:
>>
>> https://patchwork.kernel.org/patch/10593061/
>>
>> Why the duplicate? Please ALWAYS add a changelog and increase the version number:
>
> I am sorry for that. Maybe I send the patch earlier, but I remeber I
> should forget to cc to
> netdev@vger.kernel.org and LMLK. So I repost it.  Plese ingore the current patch.

Even then please increase the version number and mention in the change
log why you sent a new version. Otherwise you will make maintainers
confused and wasting time with asking what has changed.

-- 
Kalle Valo
