Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44866C5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 20:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D09205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 20:15:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05D09205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbeJQEHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 00:07:46 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56966 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbeJQEHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 00:07:46 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 615C812DE5810;
        Tue, 16 Oct 2018 13:15:41 -0700 (PDT)
Date:   Tue, 16 Oct 2018 13:15:38 -0700 (PDT)
Message-Id: <20181016.131538.1460013299973717680.davem@davemloft.net>
To:     grygorii.strashko@ti.com
Cc:     ivan.khoronzhuk@linaro.org, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexander.h.duyck@intel.com
Subject: Re: [RFC PATCH net-next 2/4] net: 8021q: vlan_core: allow use list
 of vlans for real device
From:   David Miller <davem@davemloft.net>
In-Reply-To: <2242102f-bfc8-e334-e9ae-93edd26587eb@ti.com>
References: <20181016182035.18234-1-ivan.khoronzhuk@linaro.org>
        <20181016182035.18234-3-ivan.khoronzhuk@linaro.org>
        <2242102f-bfc8-e334-e9ae-93edd26587eb@ti.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 16 Oct 2018 13:15:41 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Tue, 16 Oct 2018 14:39:43 -0500

> 
> 
> On 10/16/2018 01:20 PM, Ivan Khoronzhuk wrote:
>> It's redundancy for the drivers to hold the list of vlans when
>> absolutely the same list exists in vlan core. In most cases it's
>> needed only to traverse the vlan devices, their vids and sync some
>> settings with h/w, so add API to simplify this.
>> 
> 
> below has to be under ---.

I think it is good to docuement this in the commit message.

More information in the repository can never hurt.
