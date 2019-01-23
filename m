Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AB9C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D530A218A1
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=postn.eu header.i=@postn.eu header.b="ia1UBVOj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbfAWU3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 15:29:45 -0500
Received: from postn.eu ([84.200.50.9]:43896 "EHLO postn.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbfAWU3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 15:29:45 -0500
Received: from [127.0.0.123] (cloakedhost.private [127.0.0.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by postn.eu (Postfix) with ESMTPSA id AE4025FE86;
        Wed, 23 Jan 2019 21:29:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postn.eu; s=mail;
        t=1548275383; bh=33Sw34tW6yxtrRkXs1DtORnQR9jUyo8S+uyZCIT+ZE8=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=ia1UBVOj06BkB7xLuTbfak6D3CKeWhdwbmhRPXFcZlh052y7m05rc7MW3SNSWeda5
         o82ByhOffgQhB01uiXDkqBk8Yb8QKKV1gz5LBD71KtYq25cWXn0a8+K0K7wnk/bB5t
         WZ7LO3pe5WfnLrEIBYluAKiq/OYYTgOngZkvexuU=
From:   Kevin Weidemann <kwe-lnx@postn.eu>
Subject: Re: udf: Prevent write-unsupported filesystem to be remounted
 read-write
To:     Jan Kara <jack@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
References: <124cc6ea-ca79-20f2-651e-c2f909729ac0@gmx.de>
 <8cf39b7c-505b-91e6-849d-e66ba980042f@postn.eu>
 <20190114103011.GD13316@quack2.suse.cz>
 <20190122132228.GF13149@quack2.suse.cz>
Message-ID: <3aaf70fd-39de-be64-c9b3-e821167f9e99@postn.eu>
Date:   Wed, 23 Jan 2019 21:29:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190122132228.GF13149@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wednesday 22 January 2019 14:22 Jan Kara wrote
> The kernel is 5.0-rc3. What kernel were you testing with?

I don't remember exactly, but it was probably in the 4.20 line, as far
as I can tell.
The test case was a Veracrypt-compatible container file mounted with
cryptsetup using |the --readonly flag.|||
||

|--||
Kevin Weidemann|
||

