Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598BCC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 04:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2482086C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 04:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D2482086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbeIDIrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 04:47:00 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:50782 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbeIDIrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 04:47:00 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4882D144A2357;
        Mon,  3 Sep 2018 21:23:46 -0700 (PDT)
Date:   Mon, 03 Sep 2018 21:23:43 -0700 (PDT)
Message-Id: <20180903.212343.355534384554181027.davem@davemloft.net>
To:     mst@redhat.com
Cc:     jasowang@redhat.com, glebfm@altlinux.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost: fix VHOST_GET_BACKEND_FEATURES ioctl request
 definition
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180903231102-mutt-send-email-mst@kernel.org>
References: <20180903222127-mutt-send-email-mst@kernel.org>
        <a9ea89ac-4816-96a1-7de4-caf9884da876@redhat.com>
        <20180903231102-mutt-send-email-mst@kernel.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 03 Sep 2018 21:23:46 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Mon, 3 Sep 2018 23:11:11 -0400

> On Tue, Sep 04, 2018 at 11:08:40AM +0800, Jason Wang wrote:
>> 
>> 
>> On 2018年09月04日 10:22, Michael S. Tsirkin wrote:
>> > On Mon, Sep 03, 2018 at 08:59:13PM +0300, Gleb Fotengauer-Malinovskiy wrote:
>> > > The _IOC_READ flag fits this ioctl request more because this request
>> > > actually only writes to, but doesn't read from userspace.
>> > > See NOTEs in include/uapi/asm-generic/ioctl.h for more information.
>> > > 
>> > > Fixes: 429711aec282 ("vhost: switch to use new message format")
>> > > Signed-off-by: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
>> > Hmm it does make sense, and it's not too late to fix this up.
>> > Jason, what's your take on this? Was _IOW intentional?
>> 
>> My bad, not intentional. And I agree that fixing this is not too late.
>> 
>> So
>> 
>> Acked-by: Jason Wang <jasowang@redhat.com>
> 
> 
> OK then
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Applied, thanks everyone.
