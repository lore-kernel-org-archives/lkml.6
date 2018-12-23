Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D109C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 23:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2383D2184D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 23:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbeLWX6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 18:58:42 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:53720 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbeLWX6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 18:58:41 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 441BB14BFEB77;
        Sun, 23 Dec 2018 15:58:41 -0800 (PST)
Date:   Sun, 23 Dec 2018 15:58:38 -0800 (PST)
Message-Id: <20181223.155838.90910738750758535.davem@davemloft.net>
To:     alexei.starovoitov@gmail.com
Cc:     gustavo@embeddedor.com, ast@kernel.org, daniel@iogearbox.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: core: Fix Spectre v1 vulnerability
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181223055959.jlzbyd5ec55thiz7@ast-mbp.dhcp.thefacebook.com>
References: <20181223041253.bxqru567rs32mecg@ast-mbp.dhcp.thefacebook.com>
        <e8343bfd-7846-a23b-b6c0-4b82218efdc0@embeddedor.com>
        <20181223055959.jlzbyd5ec55thiz7@ast-mbp.dhcp.thefacebook.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 23 Dec 2018 15:58:41 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 22 Dec 2018 22:00:00 -0800

> On Sat, Dec 22, 2018 at 11:03:31PM -0600, Gustavo A. R. Silva wrote:
>> > I took another look at the following patches:
>> > "net: core: Fix Spectre v1 vulnerability"
>> > "nfc: af_nfc: Fix Spectre v1 vulnerability"
>> > "can: af_can: Fix Spectre v1 vulnerability"
>> > and I have to say that none of them are necessary.
>> > I'm not sure whether there were other patches that pretend to fix spectre1.
 ...
> in other words there is no bug and there is no vulnerability,
> but there is a 'policy' set by ... ?
> So hence Nack to the policy and Nack to the patches.

I have to agree with Alexei after looking at all of this stuff one more
time.

I'm reverting all of these changes.
