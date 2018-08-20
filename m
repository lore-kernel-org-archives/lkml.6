Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02E1C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8963C21473
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EPGOWIyN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EPGOWIyN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8963C21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeHTUPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 16:15:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44798 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbeHTUPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 16:15:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E58B46143B; Mon, 20 Aug 2018 16:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534784350;
        bh=3KP7yolDnZ54h2hcvzHp676CTvEP9jSqzVqiUmqBJyU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EPGOWIyNakLp/4NS8yLOVM45SGnVRXxi5wHHfhA8UeOkuLBGilvcCj0QsrgmkKCeZ
         sR4eA1ccnKK73xUJefMFoRJpMCE2FJ7AUxSfZTf91ofoir7PBW7/7/+20Gw6aP1Tch
         C2y47TlijQYFY9vyjYvQTHcJvUht7oTdPjjkqb7Q=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 9577A61423;
        Mon, 20 Aug 2018 16:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534784350;
        bh=3KP7yolDnZ54h2hcvzHp676CTvEP9jSqzVqiUmqBJyU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EPGOWIyNakLp/4NS8yLOVM45SGnVRXxi5wHHfhA8UeOkuLBGilvcCj0QsrgmkKCeZ
         sR4eA1ccnKK73xUJefMFoRJpMCE2FJ7AUxSfZTf91ofoir7PBW7/7/+20Gw6aP1Tch
         C2y47TlijQYFY9vyjYvQTHcJvUht7oTdPjjkqb7Q=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 20 Aug 2018 09:59:10 -0700
From:   pheragu@codeaurora.org
To:     Trilok Soni <tsoni@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        ckadabi@codeaurora.org, bryanh@codeaurora.org,
        psodagud@codeaurora.org, rnayak@codeaurora.org,
        Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>
Subject: Re: [PATCH v1 2/2] Embedded USB Debugger (EUD) driver
In-Reply-To: <589f8341-580b-d1d0-5efd-261d8d4821b0@codeaurora.org>
References: <1534464348-8227-1-git-send-email-pheragu@codeaurora.org>
 <1534464348-8227-3-git-send-email-pheragu@codeaurora.org>
 <589f8341-580b-d1d0-5efd-261d8d4821b0@codeaurora.org>
Message-ID: <cffb39ab91d2922d5eb06fb9cf388d1f@codeaurora.org>
X-Sender: pheragu@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-17 12:47, Trilok Soni wrote:
> Hi Prakruthi,
> 
> On 8/16/2018 5:05 PM, Prakruthi Deepak Heragu wrote:
>> +
>> +#define EUD_INT_VBUS		BIT(2)
>> +#define EUD_INT_CHGR		BIT(3)
>> +#define EUD_INT_SAFE_MODE	BIT(4)
>> +
>> +#define EUD_NR			1
> 
> I don't see any use of EUD_NR in the driver below. Do we need it?
Sorry about that. Will get rid of it.
