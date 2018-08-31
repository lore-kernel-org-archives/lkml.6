Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6C4C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF7B420652
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="j/w5aGzG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Kgp/62qV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF7B420652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbeHaN7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 09:59:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46906 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbeHaN7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 09:59:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 01475606FC; Fri, 31 Aug 2018 09:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535709159;
        bh=yFm+eKN4XMCF/AChukJnyrNHWfw4YnFeA0bZNbnSKbU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=j/w5aGzGsZm4mJMcOqKQDML2lubkFUZKJaCq6gJzW392OH9jcmcuWECZhbXPVSwEV
         Dh8GWqT16vB6vygE+DSaKbwMC7JZBWWWWgVU6TGgkQBNEyaGhH58i4ZDFpvKOg13C1
         dyqzQRsOEsB4j1NqKuoWAmGrk9EnDP0e5Pq1PL/0=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C1032606FC;
        Fri, 31 Aug 2018 09:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535709158;
        bh=yFm+eKN4XMCF/AChukJnyrNHWfw4YnFeA0bZNbnSKbU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Kgp/62qVXRkMihlHdULECxUMmYZiuNhA2H1C5jiRiQiAhkc2vTnP/FKXgElqV8IZy
         zPxnZVAXll4J9kic6bbIyXfdZxaVdllFme9e0BPsGDLqwblFc54TnKdG86MqKCN5Wg
         73X8GdzNNOn0LBQEwea6l0FIFSKD4vzZ7sQj2nlI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C1032606FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Igor Stoppa <igor.stoppa@huawei.com>,
        Christian Lamparter <chunkeey@googlemail.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 10/23] wireless: remove unnecessary unlikely()
References: <20180830223429.30051-1-igor.stoppa@huawei.com>
        <20180830223429.30051-11-igor.stoppa@huawei.com>
Date:   Fri, 31 Aug 2018 12:52:33 +0300
In-Reply-To: <20180830223429.30051-11-igor.stoppa@huawei.com> (Igor Stoppa's
        message of "Fri, 31 Aug 2018 01:34:16 +0300")
Message-ID: <87va7qdfry.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ linux-wireless

Igor Stoppa <igor.stoppa@gmail.com> writes:

> WARN_ON_ONCE() already contains an unlikely(), and the logical or of two of
> them is still unlikely(), so it's not necessary to wrap them into another.
>
> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
> Cc: Christian Lamparter <chunkeey@googlemail.com>
> Cc: Kalle Valo <kvalo@codeaurora.org>

IMHO you could fold patches 10, 11 and 12 into one to avoid having three
patches with duplicate titles. Or alternatively use proper driver
prefixes like "ath10k:", "b43:" and so on.

But how do you want these to be applied? For the wireless patches you
didn't Cc linux-wireless so our patchwork won't see them and hence I
can't take them. So if you want me to take these, please resend and
include linux-wireless.

-- 
Kalle Valo
