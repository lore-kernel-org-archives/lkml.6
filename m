Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E7CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC242081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=temperror (0-bit key) header.d=twistedcode.net header.i=@twistedcode.net header.b="HjfAtQDf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P83m14jH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC242081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twistedcode.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbeK2DUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 22:20:20 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:33453 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728747AbeK2DUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 22:20:19 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 4F92C220DA;
        Wed, 28 Nov 2018 11:18:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 28 Nov 2018 11:18:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=twistedcode.net;
         h=reply-to:subject:to:references:from:message-id:date
        :mime-version:in-reply-to:content-type
        :content-transfer-encoding; s=mesmtp; bh=eTaAEuK2AazQ+CGFd+xXx6p
        a6XGX/+fCbfFWLAln/AQ=; b=HjfAtQDfGMJsRPMdGvSI9cYtvV7XGcOKJLWlOdG
        XLIIOxn+mVTdzRQIOg4qnnOni7JYW6Z/WiDdow4U0iwTWaxbNTTEd75OOF2OOlDB
        L71ItflqURUi4NKjcPpJo6BCNVoq5N2n7+fY6aeM6Tw3+zqFwqvJsPTkZBvXmbf0
        9bJs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=eTaAEuK2AazQ+CGFd+xXx6pa6XGX/
        +fCbfFWLAln/AQ=; b=P83m14jHRRUayBmVozs3uVwJUY066cgYKRm1vRM7XgnzP
        ZlN/XHd4WOoyXHRGENn07/x+xlYYxeRcmnuv+x6jm6baQdmgv0KARP8yypVd4iKd
        hXrpE3aqyPx02Ua+FNetuC2QSfwbMO1831JRp59Ni/zlcKSvbZGVMI5CkYzuNqLt
        acdE7M2oTbIm4FyE9z6n0dbx3HjzG2hpxKA5x0YBUVwwIkOsp4RnJiKumwjQ52nM
        +FXNwxNpU7cPdK9m1qWAHSaNshy+CNnscxt23GesKe0/rBs0bRZ2vBNFdWzqEil1
        jCaTMFfZ2ZgFIu27sm7GooOKZXu9phOC7gFmx9vKw==
X-ME-Sender: <xms:vL_-W_wZ8tazhH6p4TscS9ZiLtEkP6b43-Wrx3c4iExqUU3LpDuk7g>
X-ME-Proxy: <xmx:vL_-W4qHTee-VeT_fAqzeUXrPjV3PAgHihfyu4xFb0h4kL2YemjtpA>
    <xmx:vL_-W3pLETBSQVjCaRttcZ0tbHlSsIRiACX3TETLNLNTHNeGTD1fUw>
    <xmx:vL_-W6H3FGo3hScIrvTsOuYgvE4dLhdS6GnsYTNUMO8FJyW_2jB7pw>
    <xmx:vL_-WyzvJ0S9rqV6ntoRExK4OgO76gM0VZy7Ll-Nvo5NIPR-qZGLPg>
    <xmx:vL_-W5odO0VjjXEYiBVg7U824PnrJBuDpLxVjxNC1XXj0MOZqrmLPg>
    <xmx:vb_-W0FwWbWQNRmmwt4kTHxwHie5SNb2iTVh1DMZm0yyy-zo8WvdOA>
Received: from [192.168.1.2] (d220-122.icpnet.pl [109.173.220.122])
        by mail.messagingengine.com (Postfix) with ESMTPA id D5DC8E405E;
        Wed, 28 Nov 2018 11:18:02 -0500 (EST)
Reply-To: grendel@twistedcode.net
Subject: Re: ext4 file system corruption with v4.19.3 / v4.19.4
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Rainer Fiebig <jrf@mailbox.org>, linux-kernel@vger.kernel.org,
        "Andrey Jr. Melnikov" <temnota.am@gmail.com>,
        linux-ext4@vger.kernel.org
References: <065643a0-f9aa-a361-715a-03ca978d9228@roeck-us.net>
 <20181128041555.GE31885@thunk.org> <en52df-5dh.ln1@banana.localnet>
 <2547416.7Vy7A2kRpU@siriux> <20181128161033.GH31885@thunk.org>
From:   Marek Habersack <grendel@twistedcode.net>
Openpgp: preference=signencrypt
Autocrypt: addr=grendel@twistedcode.net; prefer-encrypt=mutual;
 keydata= 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
Organization: I just...
Message-ID: <80caa2dd-c630-d69b-9095-f68846e60515@twistedcode.net>
Date:   Wed, 28 Nov 2018 17:18:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181128161033.GH31885@thunk.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2018 17:10, Theodore Y. Ts'o wrote:
> On Wed, Nov 28, 2018 at 04:56:51PM +0100, Rainer Fiebig wrote:
>>
>> If you still see the errors, at least the Ubuntu-kernel could be ruled out.
> 
> My impression is that some of the people reporting problems have been
> using stock upstream kernels, so I wasn't really worried about the
Also, the Ubuntu mainline kernel doesn't patch the kernel code, it merely uses Ubuntu configs to build the stock kerenel
(you can find the patches in e.g. http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.19.5/ at the top of the directory)

> Ubuntu kernel (although it could be something about the default
> configs that Ubuntu sets up).  What I was more wondering was whether
> there was something about userspace or default configs of Ubuntu.
> This isn't necessarily a *problem* per se; for examople, not that long
> ago some users were getting surprised when a problem showed up with an
> older version of the LVM2 userspace with newer upstream kernels.
> After a while, you learn to get super paranoid about making sure to
> rule out all possibilities when trying to debug problems that are only
> hitting a set of users.
> 
> 						- Ted
> 

marek
