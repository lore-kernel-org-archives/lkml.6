Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8A6C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2477820841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bo5EuPUt";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bo5EuPUt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2477820841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732362AbeGaVNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:13:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39494 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730113AbeGaVNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:13:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AF10C60481; Tue, 31 Jul 2018 19:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533065525;
        bh=1MQl1w2QGP209frLHfPblZIsaA0HNzmM7QD27uF5mBw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bo5EuPUtu7ac6d77ravWc37IQWXAGfCmsF+FSr8auhR+5siIPRH6tddGW3ouMUGAy
         mAMcHNtGeVRQJt6HE0hdoavaLMt/2uTXXv053RI9D1H6CB/CIkzgcwlysmm38gWTF8
         io4fCbyMEzZRz3YcFi3cPjgAx5mtxm34kLz8/48A=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 7017A60264;
        Tue, 31 Jul 2018 19:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533065525;
        bh=1MQl1w2QGP209frLHfPblZIsaA0HNzmM7QD27uF5mBw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bo5EuPUtu7ac6d77ravWc37IQWXAGfCmsF+FSr8auhR+5siIPRH6tddGW3ouMUGAy
         mAMcHNtGeVRQJt6HE0hdoavaLMt/2uTXXv053RI9D1H6CB/CIkzgcwlysmm38gWTF8
         io4fCbyMEzZRz3YcFi3cPjgAx5mtxm34kLz8/48A=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 31 Jul 2018 12:32:05 -0700
From:   pheragu@codeaurora.org
To:     Trilok Soni <tsoni@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ckadabi@codeaurora.org, bryanh@codeaurora.org,
        psodagud@codeaurora.org,
        Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>
Subject: Re: [PATCH 2/2] Embedded USB Debugger (EUD) driver
In-Reply-To: <1a34e079-929c-5ac1-c4e9-85ce707c42e0@codeaurora.org>
References: <1533061333-7680-1-git-send-email-pheragu@codeaurora.org>
 <1533061333-7680-3-git-send-email-pheragu@codeaurora.org>
 <1a34e079-929c-5ac1-c4e9-85ce707c42e0@codeaurora.org>
Message-ID: <631fd296787321ce3fa27f9c9b8b3841@codeaurora.org>
X-Sender: pheragu@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-31 12:29, Trilok Soni wrote:
> Hi Prakruthi,
> 
> On 7/31/2018 11:22 AM, Prakruthi Deepak Heragu wrote:
>> Add support for control peripheral of EUD (Embedded USB Debugger) to
>> listen to events such as USB attach/detach, charger enable/disable, 
>> pet
>> EUD to indicate software is functional.
> 
> We should CC linux-usb mailing list too?
> 
Sure. Will get the id and do it.
>> +
>> +config QCOM_EUD
>> +	tristate "QTI Embedded USB Debugger (EUD)"
>> +	depends on ARCH_QCOM
>> +	select SERIAL_CORE
> 
> We don't need to select SERIAL_CORE since there is nothing related to
> serial console in this driver.
Yes, I will take it off. Shall I send a version 1?
