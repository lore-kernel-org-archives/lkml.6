Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_ADSP_ALL,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAD2C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5636B208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="rEFSlUGn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5636B208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=natalenko.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389580AbeHAQCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 12:02:43 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:53346 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389344AbeHAQCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 12:02:42 -0400
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id DD6B73BD493;
        Wed,  1 Aug 2018 16:16:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1533133003;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZxBoa0v1qT37CRtjEc5PskihmZMdBAYz3QNxU+zUUac=;
        b=rEFSlUGnI/bv+qbyIopfKw20bWMUsxUofEjBJ94qQNJ/yG3EwUHUpr6HjGwJIxOrXrn9HW
        hTpaNRfii0MCJkvwCIsyQHNeL7cvbUcy5ti8DYOHAr1XXjpMy63Ee/ILQ2OIfZY7mc06rP
        59acHBOBElqtYw5ME6xlrUBHbeylHUA=
DMARC-Filter: OpenDMARC Filter v1.3.2 vulcan.natalenko.name DD6B73BD493
Authentication-Results: vulcan.natalenko.name; dmarc=fail (p=none dis=none) header.from=natalenko.name
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 01 Aug 2018 16:16:42 +0200
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     bp@alien8.de, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, sironi@amazon.de,
        stable@vger.kernel.org, tony.luck@intel.com
Subject: Re: [PATCH v2] arch/x86: Fix boot_cpu_data.microcode version output
In-Reply-To: <b84518d4-fc78-ca2a-7bde-ad6b5f6a7d83@redhat.com>
References: <d8ac835211e5649b5494141a0decc3bc@natalenko.name>
 <b84518d4-fc78-ca2a-7bde-ad6b5f6a7d83@redhat.com>
Message-ID: <0a4c663887ecc1672d9927ed7256485b@natalenko.name>
X-Sender: oleksandr@natalenko.name
User-Agent: Roundcube Webmail/1.3.6
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1533133003;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZxBoa0v1qT37CRtjEc5PskihmZMdBAYz3QNxU+zUUac=;
        b=NafF3XKP1RywXS+WcHvFtlY0cxhfZwEle7QLWNXTjfiC3hedFFvEdRhGYN/91MLxupdcuU
        BK8JDatiO/HnrYgWCSgMciQHWcFEJD6TTIgLrHZvm/Oc4QIzoIstXZo4Qu+9NK8yKo8x6v
        ZKLkpqoUTSOa57FofSifxyH/HC92TBU=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1533133003; a=rsa-sha256;
        cv=none;
        b=XAtfVI3kdoYN5Ebhxu36rUl0lGZC+Cp/OLFhnslPAr0lU8trOBD2IzmPWzhvGoQg3cEAmF6/FKNNhBuTDQZ7LlZXBOjyeoSB7OUI0uL1eUwnupDqkBFy87IbI6Wsy6HI5gY0dFqnkeo+8vDOGzXe7Ji5Flm0r5wdmSXgRSrlQ5I=
ARC-Authentication-Results: i=1; vulcan.natalenko.name;
        auth=pass smtp.auth=oleksandr@natalenko.name smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On 01.08.2018 13:38, Prarit Bhargava wrote:
>> After this patch, do we preserve an original microcode version 
>> somewhere? If no,
>> why? Sometimes it is useful while debugging another crash because of 
>> faulty
>> microcode.
>> 
> Interesting, and thanks for bringing this up.  Oleksandr, under what
> circumstances would you want to know what the old version was.  AFAICS 
> it is no
> longer running and should not have an impact on the system?

Once the kernel log does not contain a printout regarding updated 
microcode anymore (because the log buffer is limited in size and can be 
overwritten) and once you have a vmcore, it is handy to use 
boot_cpu_data to compare the microcode version with the per-CPU value to 
find out that is was updated at all. Or, maybe, that can be inspected in 
another way now?

-- 
   Oleksandr Natalenko (post-factum)
