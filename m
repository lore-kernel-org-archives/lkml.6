Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68306C71138
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34874208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:06:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34874208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbeJPBwX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 21:52:23 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:42489 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbeJPBwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 21:52:22 -0400
Received: from marcel-macbook.fritz.box (p4FF9F655.dip0.t-ipconnect.de [79.249.246.85])
        by mail.holtmann.org (Postfix) with ESMTPSA id 55638CF361;
        Mon, 15 Oct 2018 20:13:24 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH v4 1/2] Bluetooth: Add device_get_bd_address()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20181004173338.GL22824@google.com>
Date:   Mon, 15 Oct 2018 20:06:02 +0200
Cc:     Sinan Kaya <okaya@codeaurora.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Andy Shevchenko Andy Shevchenko <andy.shevchenko@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <9B742DB5-F584-4A47-A04B-4F72EB17519C@holtmann.org>
References: <20180927004810.124185-1-mka@chromium.org>
 <20180927004810.124185-2-mka@chromium.org>
 <b28c34475e447cc29a139f9121b3c1d9@codeaurora.org>
 <e6752d4b-b22a-d951-e9db-1ae7445dc403@codeaurora.org>
 <20180927171305.GG22824@google.com> <20181004173338.GL22824@google.com>
To:     Matthias Kaehlcke <mka@chromium.org>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

>>>>  void bt_sock_reclassify_lock(struct sock *sk, int proto);
>>>> 
>>>> +int device_get_bd_address(struct device *dev, bdaddr_t *bd_addr);
>>> 
>>> Maybe change the API name to start with bt_ and get rid of device_?
>> 
>> device_ indicates that we get the BD_ADDR for a 'struct device' and
>> not for e.g. a 'struct fwnode_handle'.
>> 
>> Anyway with this version of the patch fwnode_get_bd_address() has been
>> scrapped and it might never be introduced again, so I'm open to change
>> the name to bt_ if there is a general preference for it.
> 
> Marcel, can you live with this being added to the Bluetooth code base
> instead of property? Also if you'd prefer the function to be named
> bt_get_bd_address() let me know.

explain to me again why this is useful? I am failing to see the benefit if this is not part of the property.h API.

Regards

Marcel

