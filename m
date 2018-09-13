Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C35C63685
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C08AE204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C08AE204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbeINANe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 20:13:34 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52558 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbeINANd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 20:13:33 -0400
Received: from localhost (c-24-18-209-70.hsd1.wa.comcast.net [24.18.209.70])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5AB41140219E1;
        Thu, 13 Sep 2018 12:02:45 -0700 (PDT)
Date:   Thu, 13 Sep 2018 12:02:41 -0700 (PDT)
Message-Id: <20180913.120241.924379440079172532.davem@davemloft.net>
To:     sergei.shtylyov@cogentembedded.com
Cc:     vasilykh@arista.com, roopa@cumulusnetworks.com,
        adobriyan@gmail.com, edumazet@google.com,
        stephen@networkplumber.org, jwestfall@surrealistic.net,
        w.bumiller@proxmox.com, anarsoul@gmail.com, keescook@chromium.org,
        ihrachys@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] neighbour: confirm neigh entries when ARP packet is
 received
From:   David Miller <davem@davemloft.net>
In-Reply-To: <16ad730b-ef79-62b0-4b11-9473c0b033e1@cogentembedded.com>
References: <20180913181203.4207-1-vasilykh@arista.com>
        <16ad730b-ef79-62b0-4b11-9473c0b033e1@cogentembedded.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 13 Sep 2018 12:02:45 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 13 Sep 2018 21:26:42 +0300

> Hello!
> 
> On 09/13/2018 09:12 PM, Vasily Khoruzhick wrote:
> 
>> Update 'confirmed' timestamp when ARP packet is received. It shouldn't
>> affect locktime logic and anyway entry can be confirmed by any higher-layer
>> protocol. Thus it makes sense to confirm it when ARP packet is received.
>> 
>> Fixes: 77d7123342 ("neighbour: update neigh timestamps iff update is effective")
> 
>    Need at least 12 hex digits... Perhaps could be fixed when applying?

Yeah I took care of that.

> 
>> Signed-off-by: Vasily Khoruzhick <vasilykh@arista.com>
> [...]

Applied and queued up for -stable.
