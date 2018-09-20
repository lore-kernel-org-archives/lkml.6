Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF79ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE9721522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Pu2OvzjK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Fru2pBzi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DE9721522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbeIUEbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 00:31:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56832 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbeIUEbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 00:31:49 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4504260C61; Thu, 20 Sep 2018 22:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537483562;
        bh=tj71YHs95BcB0PwgaNxXFmaEFnuER7g6AjjmrUabc5w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Pu2OvzjKQknE1zWBlk6WcjZ4WDGRLZ6WKG20NrBHYFGztv0QnCRuGEtV1WVSzPQX3
         Y0yPFsOvZTx2Fmn1gUMkzH/9ot8IvnY/YIHpP3w4774HytdXGzHwuzVOVsn/fNkKl/
         J4ifqqeNeNtDRDNxfTLmMhzW0t0tNo0j7iCRUHa0=
Received: from [10.80.45.152] (unknown [71.69.156.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EB6B960BE3;
        Thu, 20 Sep 2018 22:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537483561;
        bh=tj71YHs95BcB0PwgaNxXFmaEFnuER7g6AjjmrUabc5w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Fru2pBziV09rV6zQhr5RzpGVUQVutxrRegx8cPhe4jClLU91OoFCMwMAU1kF4vjqL
         fB8Uist6KK99KdvLu5ApCDg4BoMMsP4X935OBwgOI5hMmegDX3OyGTp8g6YrTHBYwV
         LnRLNVjKk2MPmCtKQzUzEB2mitbvg/fY6jK8WosI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EB6B960BE3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH 0/2] Add API to retrieve the Bluetooth Device Address
 (BD_ADDR)
To:     Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>
References: <20180920223436.202454-1-mka@chromium.org>
From:   Sinan Kaya <okaya@codeaurora.org>
Message-ID: <0ea65ca1-8d06-72d8-3bbe-693e09605a8a@codeaurora.org>
Date:   Thu, 20 Sep 2018 18:45:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180920223436.202454-1-mka@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/2018 6:34 PM, Matthias Kaehlcke wrote:
> On some systems the Bluetooth Device Address (BD_ADDR) isn't stored
> on the Bluetooth chip itself. One way to configure the BD address is
> through the device tree. The btqcomsmd driver is an example, it can
> read the BD address from the DT property 'local-bd-address'. It is
> also planned to extend the hci_qca driver to support setting the BD
> address through the DT.
> 
> To avoid redundant open-coded reading of 'local-bd-address' and error
> handling this series adds an API to retrieve the BD address of a device
> and adapts the btqcomsmd driver to use this API.

I don't think you have got enough number of line savings to make this
code to be folded into property.c

Not my call but seems redundant IMO.
