Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA4AC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C392216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="h8+E/euo";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="o/4Ywzuv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C392216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbeI0XGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:06:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50058 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727622AbeI0XGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:06:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4EEA260BEE; Thu, 27 Sep 2018 16:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538066830;
        bh=cOMd1iDuqkuzHjfwqOtwWUesrbKTYoTboLawwYv4x8k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=h8+E/euo4VyKQrcK1aGIQWD0wR9sDi1mPrTRNu0/f7MQUENUK695POCXaEI6jLQDM
         YLC+LTwqj0CyG52KGlzkwz7Rca9IFLt+ne7RtFC5rfSu+efmx5XtTwK3hVwxIljoYc
         HTnW3NrAUm8uG16T7nqDb04dDiOrHMtkUoTgZ2Y4=
Received: from [192.168.0.106] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 02C6A609A8;
        Thu, 27 Sep 2018 16:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538066829;
        bh=cOMd1iDuqkuzHjfwqOtwWUesrbKTYoTboLawwYv4x8k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=o/4YwzuvRXziZu5IeOZY+W0uq3vcgYQggXr/6lI3it0Avjrk/LGdDqOen3Ti7yjDv
         QFsaeatYfO/m9EulqkPHhtdr94OOziuwtaXXT6qUXbQiXaNlQaI4zEAvieUZshimMx
         Bj9bOaTXKCuGtJ+XAqpa8BSMm/iVUzU/RomDoMjw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 02C6A609A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH v4 1/2] Bluetooth: Add device_get_bd_address()
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Andy Shevchenko Andy Shevchenko <andy.shevchenko@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>
References: <20180927004810.124185-1-mka@chromium.org>
 <20180927004810.124185-2-mka@chromium.org>
 <b28c34475e447cc29a139f9121b3c1d9@codeaurora.org>
From:   Sinan Kaya <okaya@codeaurora.org>
Message-ID: <e6752d4b-b22a-d951-e9db-1ae7445dc403@codeaurora.org>
Date:   Thu, 27 Sep 2018 12:47:06 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b28c34475e447cc29a139f9121b3c1d9@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/2018 12:41 PM, Balakrishna Godavarthi wrote:
>   void bt_sock_reclassify_lock(struct sock *sk, int proto);
> 
> +int device_get_bd_address(struct device *dev, bdaddr_t *bd_addr);

Maybe change the API name to start with bt_ and get rid of device_?
