Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE92C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6873B2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hMPEWev5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Fff7IYsB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6873B2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbeHaULy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:11:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46794 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbeHaULy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:11:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0A8C76044E; Fri, 31 Aug 2018 16:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535731424;
        bh=2BOUgD5jCZDSJSq/IGotr8UWEA/DYMfbHVKcoFYHiwU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hMPEWev5wS25AzHeT2EhH5KoShYyUJXKMVYT4G1mZAX3MwcK5ibIAxfWdHlEYg5Eg
         1592yIfdiIRJRmR4Ufskjn0UYAODqqBdwTOP6T6Fbdrk8wEN5VUXp9KPsOzkmmVUUL
         GIpFS9EyZMxbenusBifSVrECPCbcWrAdRyzxACSU=
Received: from [192.168.86.122] (cpe-76-176-58-9.san.res.rr.com [76.176.58.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tsoni@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BF68A60242;
        Fri, 31 Aug 2018 16:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535731423;
        bh=2BOUgD5jCZDSJSq/IGotr8UWEA/DYMfbHVKcoFYHiwU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Fff7IYsBO1G9oNE8nyC+Xuv3B/V6zE6T/A+bTWYI4RI9RZLFTttUdYsEcQg1VV5bF
         SBcJPDB8Ha4Cz4oVE7w/enSY3RDfAjdlUBW5AQ4b2Ry95A5Am4E7zpSFkXYjNPTMiU
         PjMMd9QO7DwoIUqKOxvt9Zv9M9h1qZ3EnzYI4nkw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BF68A60242
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tsoni@codeaurora.org
Subject: Re: [PATCH v1 0/2] Add Embedded USB Debugger (EUD) driver
To:     Prakruthi Deepak Heragu <pheragu@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, ckadabi@codeaurora.org,
        bryanh@codeaurora.org, psodagud@codeaurora.org,
        rnayak@codeaurora.org
References: <1534464348-8227-1-git-send-email-pheragu@codeaurora.org>
From:   Trilok Soni <tsoni@codeaurora.org>
Message-ID: <51874c59-46d0-363d-bb53-af9450207194@codeaurora.org>
Date:   Fri, 31 Aug 2018 09:03:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1534464348-8227-1-git-send-email-pheragu@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/2018 5:05 PM, Prakruthi Deepak Heragu wrote:
> This is a series of patches that implements a driver for the control
> peripheral, EUD (Embedded USB Debugger). The EUD is a mini-USB hub
> implemented on chip to support the USB-based debug and trace capabilities.
> Apart from debug capabilities, EUD has a control peripheral. Control
> Peripheral is on when EUD is on and gets signals like USB attach, pet EUD,
> charge phone etc. EUD driver listens to events like USB attach or detach
> and charger enable or disable and then notifies the USB driver or PMIC
> driver respectively about these events via EXTCON. At regular intervals,
> the EUD driver receives an interrupt to pet the driver indicating that
> the software is functional.

Any other review comments on this patch series?

---Trilok Soni
