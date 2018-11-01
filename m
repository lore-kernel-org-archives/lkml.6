Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFEFC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 19:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C2C20820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 19:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70C2C20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbeKBEK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 00:10:27 -0400
Received: from mail02.iobjects.de ([188.40.134.68]:49960 "EHLO
        mail02.iobjects.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725722AbeKBEK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 00:10:26 -0400
Received: from tux.wizards.de (p3EE2F45F.dip0.t-ipconnect.de [62.226.244.95])
        by mail02.iobjects.de (Postfix) with ESMTPSA id E69ED4160539;
        Thu,  1 Nov 2018 20:06:10 +0100 (CET)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.wizards.de (Postfix) with ESMTP id 01BFCF01599;
        Thu,  1 Nov 2018 20:06:09 +0100 (CET)
Subject: Re: [PATCH RFC] block, bfq: set default slice_idle to zero for
 non-rotational devices
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-kernel@vger.kernel.org
References: <154109421062.925711.4117729151502021084.stgit@buzz>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <317076f7-f84f-c08f-5fb5-b227094cabfd@applied-asynchrony.com>
Date:   Thu, 1 Nov 2018 20:06:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <154109421062.925711.4117729151502021084.stgit@buzz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/18 18:43, Konstantin Khlebnikov wrote:
> With default 8ms idle slice BFQ is up to 10 times slower than CFQ
> for massive random read workloads for common SATA SSD.
> 
> For now zero idle slice gives better out of box experience.
> CFQ employs this since commit 41c0126b3f22 ("block: Make CFQ default
> to IOPS mode on SSDs")

Well, that's interesting because 3 years ago I made the same suggestion
and was told that BFQ's heuristics automagically make it not idle when
rotational=0. Did you actually benchmark this? I just tried and don't
get a noticeable performance difference with slice_idle=0 compared to
deadline.

Discussion link:
https://groups.google.com/forum/#!msg/bfq-iosched/iRMw2n3kYLY/6l9cIm3TBgAJ

curious..

Holger
