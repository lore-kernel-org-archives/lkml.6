Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1F8ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 23:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE7D21525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 23:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Qu+XhM/U";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="M7QK+0NG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BE7D21525
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388743AbeIUEtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 00:49:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40014 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbeIUEtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 00:49:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 72CE860CEC; Thu, 20 Sep 2018 23:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537484601;
        bh=DbZMkpzuhJjJ3p0ABBXPcRUjto0sse3KnxUhSBndCYQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Qu+XhM/Uouce/RTEbZ2HKzDVmXJV7630orDu+pivp3p0APDJMn9U1uk7e9RZCPNA2
         vzL7EhTEETcz0fmnGzXlZxDtVzBuDlOU/3AXe9KyAt5Yg3eUFOsWtJENW0ULR1QfG+
         To26GgTCW+Sj8kvFRT74jTp8QBRg+7TTBJuxqhCs=
Received: from [10.80.45.152] (unknown [71.69.156.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B32FE60C61;
        Thu, 20 Sep 2018 23:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537484598;
        bh=DbZMkpzuhJjJ3p0ABBXPcRUjto0sse3KnxUhSBndCYQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=M7QK+0NG/xOxCCAk+2Do/aKkt2cyKNwzi9e8wlSIn76TcrtRT/u41nQvzM+42nlPc
         +/YmjqKVXRKQhczFSE73MncY7aHWDYee/yXoeFc5s5Ixnqd87OVAnr6uQCqVQ7lZRz
         5pIo9DYc2SEheKCDrv12rXxY7Um9f1sKsqDqdZvo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B32FE60C61
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
From:   Sinan Kaya <okaya@codeaurora.org>
Message-ID: <36e5d881-a45e-c879-c275-e6e18bc99ed5@codeaurora.org>
Date:   Thu, 20 Sep 2018 19:03:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180920230121.GT22824@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/2018 7:01 PM, Matthias Kaehlcke wrote:
> Certainly true if this was the only driver. However another one will
> follow soon and 'local-bd-address' is the official binding, so it's
> not unlikely there will be more.

I was missing this information.
Is there a way to convert existing users to this if any as well?
