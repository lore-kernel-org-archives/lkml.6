Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA6FC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6607F2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544547151;
	bh=OTc48uJyVryuD7wlqugSBtK8r3+i/ApjD50hL/vLW6M=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=qQ2V4lMbUHn4urLC1yHH2tkqZlcxuGUGncEa8hzq5LnwXLbzu259AVvIse0cxFDRv
	 BHzs/sUTx/0/A3z3dj+aSODL781cXPd4FG+h4cdEhcampAmfLyam1umxBB8LX6ibGq
	 QOpiHHR4BeC0wV37HP0vSHHDwCvRQAERTweg22NY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6607F2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbeLKQwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:52:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:44570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbeLKQwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 11:52:30 -0500
Received: from [10.80.45.159] (unknown [71.69.156.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9EED20851;
        Tue, 11 Dec 2018 16:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544547149;
        bh=OTc48uJyVryuD7wlqugSBtK8r3+i/ApjD50hL/vLW6M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Oik9ZyiwiuaPenxPBmUj859eRwDm08NE8iHR/7EnbYse8phaMDNVJpsULmDdGm3C0
         oEE5GGDLTQp6uSl4b2Ba37nhX44wqjgha1uxAEPUI+Mes8frK5UezlLJ5SA/LwKXlL
         D7Akql5deUIh4Dn7tpTJ7o/OpFdzEfIGueU+dYK4=
Subject: Re: [PATCH v3 2/3] ACPI / OSL: Allow PCI to be disabled
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181210181315.5023-1-okaya@kernel.org>
 <20181210181315.5023-2-okaya@kernel.org>
 <CAJZ5v0htmHTgRa9TZ7f0XcGEt_XMmfEYhcQ=N2Lcn1V+TxPzxg@mail.gmail.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <50b7ee57-d066-fdd8-e497-259b695aab52@kernel.org>
Date:   Tue, 11 Dec 2018 11:52:25 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0htmHTgRa9TZ7f0XcGEt_XMmfEYhcQ=N2Lcn1V+TxPzxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/2018 5:07 AM, Rafael J. Wysocki wrote:
> On Mon, Dec 10, 2018 at 7:13 PM Sinan Kaya <okaya@kernel.org> wrote:
>>
>> Getting ready to allow PCI to be disabled with ACPI enabled. Stub
>> out calls that depend on PCI.
> 
> I would prefer the subject to say something like "Allow CONFIG_PCI to
> be unset" or "Allow PCI to be disabled in Kconfig".
> 
> It is somewhat ambiguous otherwise and one has to look at the patch to
> see what it really is about.
> 

Makes sense. I'll update.
