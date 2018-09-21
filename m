Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A2EECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 05:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 079892083A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 05:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cBtD9vVv";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="axCn7es9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 079892083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389241AbeIULNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 07:13:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36538 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388909AbeIULM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 07:12:59 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 230DC60FEB; Fri, 21 Sep 2018 05:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537507549;
        bh=KHT2JQwT6d2tSF6hVKJQqc5lNPccgnOmnW79Oz3MvB8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cBtD9vVvKEATQRxUHF1lJyWfd5WLqvmK0W4ErRIBpS6WUpMs17bM9oyPNW37eMjle
         7QS3s6/u7pAajTwFK2OE6JjDDjtGd8qxJGDt2gOVpBA/zYluqJL3aeIaXmEBQdDIQe
         KZzZS2q8GUQfbOpEhL255KC/Ez0BrW8tTGhGgfK8=
Received: from [192.168.0.114] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AB29E60F94;
        Fri, 21 Sep 2018 05:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537507548;
        bh=KHT2JQwT6d2tSF6hVKJQqc5lNPccgnOmnW79Oz3MvB8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=axCn7es9VzFnwVBWDgiaaCbEE/aokZtDdk52Fsx/BIMmMMLdyxd297wkCpWRXkC74
         YKxl7cXP1KjuUf24RRs64ZP0JjzsB229mfz5JAsN3EiJB+tWnj22Zxuf5wwIFb+vzU
         ry7FzT5hczlKzlAX8FALCv+LAllotJk7Gz+XuTJM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AB29E60F94
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH 0/2] Add API to retrieve the Bluetooth Device Address
 (BD_ADDR)
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>
References: <20180920223436.202454-1-mka@chromium.org>
 <0ea65ca1-8d06-72d8-3bbe-693e09605a8a@codeaurora.org>
 <20180920230121.GT22824@google.com>
 <36e5d881-a45e-c879-c275-e6e18bc99ed5@codeaurora.org>
 <20180920231947.GU22824@google.com>
From:   Sinan Kaya <okaya@codeaurora.org>
Message-ID: <124b6f76-a65f-e304-6c60-fbb9104415f4@codeaurora.org>
Date:   Fri, 21 Sep 2018 01:25:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180920231947.GU22824@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/2018 7:19 PM, Matthias Kaehlcke wrote:
> If the existing users populate a custom property with the BD address
> in the bootloader you could roll out a bootloader change. You'd have
> to make sure that bootloader and kernel match. The bootloader could
> still populate the custom property to be compatible with 'old'
> kernels.

If there is no standard about the name of the property, this probably
doesn't belong to property.c but should rather be hosted in bluetooth
directory for consumption among the bluetooth drivers.
