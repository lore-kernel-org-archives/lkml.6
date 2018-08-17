Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DA4C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 20:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6EEC206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 20:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6EEC206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbeHQXta convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 19:49:30 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:45000 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbeHQXta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 19:49:30 -0400
Received: from relay7-d.mail.gandi.net (unknown [217.70.183.200])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id C29523A293D;
        Fri, 17 Aug 2018 22:43:27 +0200 (CEST)
X-Originating-IP: 67.23.203.6
Received: from [10.136.4.142] (unknown [67.23.203.6])
        (Authenticated sender: josh@joshtriplett.org)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id EDC7120008;
        Fri, 17 Aug 2018 20:43:24 +0000 (UTC)
Date:   Fri, 17 Aug 2018 13:43:20 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20180817133935.b93ce7534656e587d4c8d3e6@linux-foundation.org>
References: <20180817101036.20969-1-linux@rasmusvillemoes.dk> <20180817133935.b93ce7534656e587d4c8d3e6@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] linux/compiler.h: don't use bool
To:     Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
CC:     Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Josh Triplett <josh@joshtriplett.org>
Message-ID: <688799DE-85EE-4755-A9C6-78312DE2F7A4@joshtriplett.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On August 17, 2018 1:39:35 PM PDT, Andrew Morton <akpm@linux-foundation.org> wrote:
>On Fri, 17 Aug 2018 12:10:35 +0200 Rasmus Villemoes
><linux@rasmusvillemoes.dk> wrote:
>
>> Appararently, it's possible to have a non-trivial TU include a few
>headers,
>> including linux/build_bug.h, without ending up with linux/types.h. So
>> the 0day bot sent me
>
>What's a "TU"?

Probably "translation unit".

