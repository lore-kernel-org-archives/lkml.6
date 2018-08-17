Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99049C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 19:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 328342177F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 19:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MJCdAVxe";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MJCdAVxe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 328342177F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbeHQWwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 18:52:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52170 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbeHQWwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 18:52:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8DF8862439; Fri, 17 Aug 2018 19:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534535241;
        bh=SKrvxg4aeSoDcQlGWd/+NVapSJY6pEO72FC5QFRmp8E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MJCdAVxe98fxQpdKP6nnqsPrZ+QVbkOXwwGUlj2rYy1hzFez1it/HgtiRALgZ2yY+
         1MVvK46JIq2Fbx9gLUoZQsPXrkohPP6LH3wNViMjDXZ6bVB/uNq+WeXJ+ZSd042lGY
         pqOn+Yy5Fy8dmiNhHJe6/1g3CbIIJw4I5vVDHhqM=
Received: from [192.168.86.119] (cpe-76-176-58-9.san.res.rr.com [76.176.58.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tsoni@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 359B362433;
        Fri, 17 Aug 2018 19:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534535241;
        bh=SKrvxg4aeSoDcQlGWd/+NVapSJY6pEO72FC5QFRmp8E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MJCdAVxe98fxQpdKP6nnqsPrZ+QVbkOXwwGUlj2rYy1hzFez1it/HgtiRALgZ2yY+
         1MVvK46JIq2Fbx9gLUoZQsPXrkohPP6LH3wNViMjDXZ6bVB/uNq+WeXJ+ZSd042lGY
         pqOn+Yy5Fy8dmiNhHJe6/1g3CbIIJw4I5vVDHhqM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 359B362433
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tsoni@codeaurora.org
Subject: Re: [PATCH v1 2/2] Embedded USB Debugger (EUD) driver
To:     Prakruthi Deepak Heragu <pheragu@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, ckadabi@codeaurora.org,
        bryanh@codeaurora.org, psodagud@codeaurora.org,
        rnayak@codeaurora.org,
        Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>
References: <1534464348-8227-1-git-send-email-pheragu@codeaurora.org>
 <1534464348-8227-3-git-send-email-pheragu@codeaurora.org>
From:   Trilok Soni <tsoni@codeaurora.org>
Message-ID: <589f8341-580b-d1d0-5efd-261d8d4821b0@codeaurora.org>
Date:   Fri, 17 Aug 2018 12:47:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1534464348-8227-3-git-send-email-pheragu@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prakruthi,

On 8/16/2018 5:05 PM, Prakruthi Deepak Heragu wrote:
> +
> +#define EUD_INT_VBUS		BIT(2)
> +#define EUD_INT_CHGR		BIT(3)
> +#define EUD_INT_SAFE_MODE	BIT(4)
> +
> +#define EUD_NR			1

I don't see any use of EUD_NR in the driver below. Do we need it?
