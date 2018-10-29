Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3C1C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0445720657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fq1waz3E";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ocLjI+Y9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0445720657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbeJ2Wfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 18:35:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46756 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbeJ2Wfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 18:35:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0658B6074F; Mon, 29 Oct 2018 13:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540820828;
        bh=8dPbVSAxLJHdVLyoN5v/BTj9H5GcUPqgbJNX2FssYao=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=fq1waz3Ew9LqcMR+EASKdaVrqmRHH/qiTsvJxQkJgVdJ1mWKtYJjQPPMcGI6LbWPN
         YPIOGS2rX4G/liqd8Cj3zQ3b5dSaNJOMJiUIHKNIdlSZYfiJNMLm/vQ0SoLF2lQmDL
         hrBaRvhkFRRLK2xskqLFbed7P7c+ksrhd8lP7A+g=
Received: from [10.206.28.53] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: anilc@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 87091601D2;
        Mon, 29 Oct 2018 13:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540820827;
        bh=8dPbVSAxLJHdVLyoN5v/BTj9H5GcUPqgbJNX2FssYao=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=ocLjI+Y9n34VHHO4Sq9DJcRPT6yMmVJ+5H+VhjHuTb0kZAB8wvPvrR8XC/ps75a5i
         yJG+Eag/1kryxdaBGy7o0MCRgNsNUlvpKAjUE9U8cUejFqlAF+g/5ClMvCwQc3JJrp
         UV/FEXcNqwv2s+J4P8lPvDBqRzeKuhvHDicnVbBA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 87091601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=anilc@codeaurora.org
From:   AnilKumar Chimata <anilc@codeaurora.org>
Subject: Re: [PATCH 3/3] crypto: qce: ice: Add support for Inline Crypto
 Engine
To:     Rob Herring <robh@kernel.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        mark.rutland@arm.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1539789476-6098-1-git-send-email-anilc@codeaurora.org>
 <1539789476-6098-4-git-send-email-anilc@codeaurora.org>
 <20181025145548.GA30244@bogus> <20181025152856.GD4970@thunk.org>
Message-ID: <a00932da-72a5-42f9-bf82-eb3e611c35b5@codeaurora.org>
Date:   Mon, 29 Oct 2018 19:17:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181025152856.GD4970@thunk.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rob,

Thanks for the comments,

On 2018-10-25 20:58, Theodore Y. Ts'o wrote:
> On Thu, Oct 25, 2018 at 09:55:48AM -0500, Rob Herring wrote:
>> > +Introduction:
>> > +=============
>> > +Storage encryption has been one of the most required feature from security
>> > +point of view. QTI based storage encryption solution uses general purpose
>> > +crypto engine. While this kind of solution provide a decent amount of
>> > +performance, it falls short as storage speed is improving significantly
>> > +continuously. To overcome performance degradation, newer chips are going to
>> > +have Inline Crypto Engine (ICE) embedded into storage device. ICE is supposed
>> > +to meet the line speed of storage devices.
>> 
>> Is ICE part of the storage device or part of the host as the binding
>> suggests?
> 
> My understanding is that for this particular instantiation, the Inline
> Crypto Engine is located on the SOC.

This is part of the Storage controller, illustration below

--------------------
|            !_ICE_!
|                  |
|    UFS/SDCC      |
|   Controller     |
|                  |
|                  |
--------------------

> 
> However, from the perspective of generic kernel support, the inline
> crypto support could be implemented on the SOC, or in the host bus
> adaptor, or as a "bump in the wire", or on the storage device.  And
> whatever abstract interface in the block layer should be able to
> support all of these cases.

As name suggests ICE hardware is inline with the data lines of storage 
controller that is the reason why throughput is inline with storage 
speed. Having it out side of the controller kills the purpose of 
introducing ICE on storage controller. If this ICE hardware is placed 
outside then its similar to other crypto engines which are used for 
cryptographic operations. The main reason to keep ICE hardware inline 
with storage is to avoid extra latency (buffer copy) during read/writes 
which involves decryption/encryption.

> 
> I do not believe it would be wise to assume that inline crypto will
> forever be a mobile-only thing.  I could easily see use cases in the
> data center; for example, if you believe that Nation State Actors
> might be trying to create "implants" that attack hard drive firmware,
> per some of the Snowden leaks, creating an open design ICE engine with
> auditable firmware and a trusted secure key store, and which sits
> between the host CPU and the storage device might be one way to
> mitigate against this threat.

Above comments valid here as well.

> 
> 					- Ted
