Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84106C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC6420854
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:46:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DC6420854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbeIKOo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 10:44:58 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:36943 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeIKOo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 10:44:58 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 428g685NcMz1qx9R;
        Tue, 11 Sep 2018 11:46:24 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 428g684psZz1qr2j;
        Tue, 11 Sep 2018 11:46:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id VHDoBf_0hp0J; Tue, 11 Sep 2018 11:46:24 +0200 (CEST)
X-Auth-Info: Vvg1GofJbf0dOClN1N/qOig/xkf7Y0VDnERSmm7/tHI=
Received: from [IPv6:::1] (unknown [195.140.253.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 11 Sep 2018 11:46:23 +0200 (CEST)
Subject: Re: [RFC] reset: make reset controller driver initialize early
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
References: <9854fd68-14e3-aed3-ca35-8e259baa0348@kernel.org>
 <1536654660.3453.1.camel@pengutronix.de>
From:   Marek Vasut <marex@denx.de>
Message-ID: <a4943a9d-9f24-a413-47ce-02b488bc6453@denx.de>
Date:   Tue, 11 Sep 2018 11:46:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1536654660.3453.1.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2018 10:31 AM, Philipp Zabel wrote:
> Hi Dinh,

Hi all,

> On Mon, 2018-09-10 at 14:59 -0500, Dinh Nguyen wrote:
>> Hi Philipp,
>>
>> I need to make the reset controller on the SoCFPGA platform initialize
>> early.
> 
> What does early mean in this context?

Means before timer, since timer needs to be un-reset by Linux before it
can be used.

>> I have one solution which is similar to what reset-sunxi is
>> doing, making the "altr,rst-mgr" initialize early in a separate
>> reset-socfpga.c but using the reset-simple operations.
> 
> That's what I would have gone for as well.
> 
>> I'm guessing SoCFPGA may not be the only platform that needs the reset
>> driver early, would it make sense to have a solution in reset-simple
>> that is capable of an early init?
> 
> I suppose you could share sunxi_reset_init if you pass it a struct
> reset_simple_devdata as an argument.
> 
> regards
> Philipp
> 


-- 
Best regards,
Marek Vasut
