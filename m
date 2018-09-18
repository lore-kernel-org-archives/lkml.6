Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3781ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 02:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D10B2088F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 02:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D10B2088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbeIRIWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 04:22:15 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54630 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbeIRIWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 04:22:15 -0400
Received: from localhost (unknown [104.240.4.228])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 20022146330DA;
        Mon, 17 Sep 2018 19:51:51 -0700 (PDT)
Date:   Mon, 17 Sep 2018 19:51:50 -0700 (PDT)
Message-Id: <20180917.195150.315319338322641005.davem@davemloft.net>
To:     asmadeus@codewreck.org
Cc:     doronrk@fb.com, tom@quantonium.net, davejwatson@fb.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kcm: remove any offset before parsing messages
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180918024536.GA2061@nautica>
References: <20180918015723.GA26300@nautica>
        <20180917.194059.1970452340378032090.davem@davemloft.net>
        <20180918024536.GA2061@nautica>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 17 Sep 2018 19:51:51 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dominique Martinet <asmadeus@codewreck.org>
Date: Tue, 18 Sep 2018 04:45:36 +0200

> David Miller wrote on Mon, Sep 17, 2018:
>> Remind me, is there actually any way for the bpf programs run in this
>> situation to even _see_ strp_msg(skb)->offset at all?
> 
> No, they can see it, so it's possible to make a KCM program that works
> right now if you are careful (I'm not sure why the offset within bpf is
> different from the offset in the kernel though, it looks like the bpf
> program skips the qos part of the control buffer)

What helper is used in the BPF program to get this offset value?

(also good info to add to the commit message)
