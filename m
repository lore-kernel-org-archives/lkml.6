Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89F5C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A51E23DA3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oSwSH//C";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oSwSH//C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A51E23DA3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751227AbeFVGJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 02:09:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50010 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750868AbeFVGJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 02:09:51 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8DCA460791; Fri, 22 Jun 2018 06:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529647790;
        bh=3owINM8pw4+1tqLd897TaqWFB79DF/+ltn8C6jOSmZg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oSwSH//CxM6hXZeJr/jTzGCEMKw4oaFs5brA0Ekr7Zevr5W+TG+DvpZ2dXKWkmhrm
         /QXzhzTU/Z69WAYY2C3ZrlxDb5JiyqFVr93z6WXuCWjvntmOArzhdcErzmCMb8SUyW
         Ar6T6uhIEO1yh6JIEU8eVonrLkjTyzXoSTzsgpSI=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 157AB60274;
        Fri, 22 Jun 2018 06:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529647790;
        bh=3owINM8pw4+1tqLd897TaqWFB79DF/+ltn8C6jOSmZg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oSwSH//CxM6hXZeJr/jTzGCEMKw4oaFs5brA0Ekr7Zevr5W+TG+DvpZ2dXKWkmhrm
         /QXzhzTU/Z69WAYY2C3ZrlxDb5JiyqFVr93z6WXuCWjvntmOArzhdcErzmCMb8SUyW
         Ar6T6uhIEO1yh6JIEU8eVonrLkjTyzXoSTzsgpSI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 22 Jun 2018 11:39:50 +0530
From:   Abhishek Sahu <absahu@codeaurora.org>
To:     Sricharan R <sricharan@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH] arm: dts: qcom: Fix 'interrupts = <>' property to use
 proper  macros
In-Reply-To: <1529486619-443-1-git-send-email-sricharan@codeaurora.org>
References: <1529486619-443-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <e15ea4689014ff69eed0c0b93552c4da@codeaurora.org>
X-Sender: absahu@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-20 14:53, Sricharan R wrote:
> Fix all nodes to use proper GIC_* macros for the interrupt type and the
> interrupt trigger settings to avoid the boot warnings.

  Thanks Sricharan for fixing these warnings.

  Applied over 4.18 rc1 and tested in IPQ8064 AP148 board.
  No backtraces are coming during boottime and IRQ seems OK.

  root@OpenWrt:/# cat /proc/interrupts
            CPU0       CPU1
  16:       2602       4750     GIC-0  18 Edge      gp_timer
  17:          0          0     GIC-0  26 Level     arm-pmu
  23:         19          0     GIC-0 241 Level     ahci[29000000.sata]
  24:        912          0     GIC-0 184 Level     msm_serial0
  25:        113          0     GIC-0 185 Level     i2c_qup
  26:          6          0     GIC-0 187 Level     1a280000.spi
IPI0:          0          0  CPU wakeup interrupts
IPI1:          0          0  Timer broadcast interrupts
IPI2:       2045       1713  Rescheduling interrupts
IPI3:          1          4  Function call interrupts
IPI4:          0          0  CPU stop interrupts
IPI5:          0          0  IRQ work interrupts
IPI6:          0          0  completion interrupts
Err:          0

> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>

Tested-by: Abhishek Sahu <absahu@codeaurora.org>

