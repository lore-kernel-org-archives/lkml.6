Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB83AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E94120841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="pNUTqcGm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GM9qpOcp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E94120841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732315AbeGaVLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:11:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38086 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730113AbeGaVLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:11:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2703960585; Tue, 31 Jul 2018 19:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533065371;
        bh=c/GM2cjHDfXOclKo3+J/QnCvB60x8LGTbxAsCdgDgow=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pNUTqcGmumilDa1cfQB8avR5/4VoK2MTnH6Z7KRaA4dQftD4JQuwMMxlstUznskRk
         05sV/xaV3UXVEfax/WcVGIyoxRlB17CcVgn8/gsVU/1NSOUvX7sOpbSosZrYAkzM97
         7ApZsJimBSd3SPFqYZWuEDnGlSJ0YRt513rWoINk=
Received: from [10.63.172.127] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tsoni@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9B16C60397;
        Tue, 31 Jul 2018 19:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533065370;
        bh=c/GM2cjHDfXOclKo3+J/QnCvB60x8LGTbxAsCdgDgow=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GM9qpOcpy5D31ROvTx0e9955q15nllSlF6F4UpzISpmD3Qo7MOuwlKxn47uEIwlGz
         NQYKw+/NfZpgHI1p78LgoD6jlgNO/dFXAZ0TJH8r0Z7SoxPh5tuRvBVjh6Oy+gjS1Q
         gshS9vcHvHhIxJuxqXmFX7isf7F99bQyTsgTOc98=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9B16C60397
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tsoni@codeaurora.org
Subject: Re: [PATCH 2/2] Embedded USB Debugger (EUD) driver
To:     Prakruthi Deepak Heragu <pheragu@codeaurora.org>,
        linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, ckadabi@codeaurora.org,
        bryanh@codeaurora.org, psodagud@codeaurora.org,
        Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>
References: <1533061333-7680-1-git-send-email-pheragu@codeaurora.org>
 <1533061333-7680-3-git-send-email-pheragu@codeaurora.org>
From:   Trilok Soni <tsoni@codeaurora.org>
Message-ID: <1a34e079-929c-5ac1-c4e9-85ce707c42e0@codeaurora.org>
Date:   Tue, 31 Jul 2018 12:29:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1533061333-7680-3-git-send-email-pheragu@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prakruthi,

On 7/31/2018 11:22 AM, Prakruthi Deepak Heragu wrote:
> Add support for control peripheral of EUD (Embedded USB Debugger) to
> listen to events such as USB attach/detach, charger enable/disable, pet
> EUD to indicate software is functional.

We should CC linux-usb mailing list too?

> +
> +config QCOM_EUD
> +	tristate "QTI Embedded USB Debugger (EUD)"
> +	depends on ARCH_QCOM
> +	select SERIAL_CORE

We don't need to select SERIAL_CORE since there is nothing related to 
serial console in this driver.
-- 
---Trilok Soni
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
