Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAFDECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7AA121565
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BEs+utip";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="c2hyBA5H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7AA121565
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390800AbeIUWjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:39:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38384 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389683AbeIUWjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:39:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A156E612DE; Fri, 21 Sep 2018 16:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537548567;
        bh=wfl7CY2HNioLA7leeZKAIAgYMyV9JiBzsT95ShCPR4Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=BEs+utipIL6Agf8ekpGzjbbhIoKPE+CpP/wX39NRlzw47O9noWzjzvgpDNZ1z1Y9q
         w5FZkFLRPveEWOH5AJG5krfngqmyOPjhXgP1eRiA/TfDRydwsgeVk7OrEkGs8Htp7p
         +dh+uqWMsq1q7lUUZ7C207UwDveXRNi+n7Z7mcSY=
Received: from [192.168.0.114] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7FDE160D30;
        Fri, 21 Sep 2018 16:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537548566;
        bh=wfl7CY2HNioLA7leeZKAIAgYMyV9JiBzsT95ShCPR4Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=c2hyBA5H5l37/G2qu7XQSWlpHc3SrMRBMHFf1zV8oW606muPN0NAPhqOM+rJ4QIXu
         BQCR2oLZzaxGB0yDSV36zFGEPrMuaLTtxz3NwMXqA/HC48lSBci8WIjmAUKaK3gCkf
         BWBlq7ErcAI7fP1X3VFLLI5itqMm87O7DAatFfXQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7FDE160D30
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
 <124b6f76-a65f-e304-6c60-fbb9104415f4@codeaurora.org>
 <20180921164541.GX22824@google.com>
From:   Sinan Kaya <okaya@codeaurora.org>
Message-ID: <a1f8d4de-04e5-c150-531b-7d2ceee6325c@codeaurora.org>
Date:   Fri, 21 Sep 2018 12:49:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180921164541.GX22824@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/2018 12:45 PM, Matthias Kaehlcke wrote:
> Well, there is a generic binding
> (https://elixir.bootlin.com/linux/v4.18/source/Documentation/devicetree/bindings/net/bluetooth.txt),
> the fact that there are drivers that aren't adhering to it doesn't
> change that.

OK. If there is some soft of a "standard" naming convention, we should be good.
Otherwise, as Sakari also raised the concern; common code becomes a dumping
ground for drivers.
