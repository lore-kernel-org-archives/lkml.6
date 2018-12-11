Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF107C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845B320851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544569224;
	bh=zOR8PPYgvXC9s3RZP0gGiPN6TsglqnewrJlUIqJNrBU=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=cgRogosmlNv1ugsLkkzbvKCtIgk9v/N0FPE0Ub08UoF9m3AA8XWXCHX/5eCIfSKlN
	 S6Icyt+J3m0pu742TzrPa5FaBMqaMGWb2/PJK9ldhsRmc+pjj8pwlf/JU0M+2Xjzh6
	 xbu+BoSYxNTwreMCRm7n74jn1fQVpSxK8pipky7o=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 845B320851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbeLKXAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:00:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:46324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbeLKXAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 18:00:22 -0500
Received: from [10.80.45.159] (unknown [71.69.156.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 712622084E;
        Tue, 11 Dec 2018 23:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544569222;
        bh=zOR8PPYgvXC9s3RZP0gGiPN6TsglqnewrJlUIqJNrBU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cch+zKO3ECSzyThMi0AK5f5k0qKxIAd0nDj3TwTy5fUL3ugYLjOXzDHf0VSGpU9l3
         BHKxjM8bmTY6aCEstuHSz6Au6lYHkEkemJLNZWi9tXzyTgpHoIJBNONt7MXIlc5Ds5
         6RUzAcIWa8AMZgA7lKKI34xP7DjjwKw9AtVkrxWE=
Subject: Re: [PATCH v3 2/3] ACPI / OSL: Allow PCI to be disabled
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181210181315.5023-1-okaya@kernel.org>
 <20181210181315.5023-2-okaya@kernel.org> <20181211170957.GA335@infradead.org>
 <342c5dd9-cb3d-d714-c87f-814a942cf395@kernel.org>
 <CAJZ5v0ia+eotSZgjbitt7TAT0ECSmTAz1XJhS3Auz5w5Z61SZA@mail.gmail.com>
 <a9c7cbe1-eef3-40ad-de62-8194df12ca20@kernel.org>
 <CAJZ5v0g5t4sx6mY=mCPWOdZLbhEAXo5Ah1TZw9jZNJQ-+cgWsw@mail.gmail.com>
 <6644defb-9199-6467-6e3e-8ce552b56f87@kernel.org>
 <CAJZ5v0i+rgLL+KrRs69URbGhUxDK9eUEuLifDWuL2mgpkAv_1g@mail.gmail.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <edc8afd7-64a0-a143-e8d6-df3b14b21753@kernel.org>
Date:   Tue, 11 Dec 2018 18:00:19 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0i+rgLL+KrRs69URbGhUxDK9eUEuLifDWuL2mgpkAv_1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/2018 5:51 PM, Rafael J. Wysocki wrote:
> Well, users running kernels with CONFIG_PCI unset on platforms
> expecting PCI support to be present in the OS may want to know that I
> suppose, so that would be a good reason to return an error, but
> perhaps just once rather than on every access (maybe unless debugging
> is enabled?).

Warning once would be a good trade-off.
