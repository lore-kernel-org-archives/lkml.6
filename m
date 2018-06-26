Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D9DC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39938252DC
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39938252DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752687AbeFZQXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 12:23:44 -0400
Received: from mail02.iobjects.de ([188.40.134.68]:52002 "EHLO
        mail02.iobjects.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750933AbeFZQXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 12:23:42 -0400
Received: from tux.wizards.de (p3EE2F038.dip0.t-ipconnect.de [62.226.240.56])
        by mail02.iobjects.de (Postfix) with ESMTPSA id 0CCE141603FA;
        Tue, 26 Jun 2018 18:23:41 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.wizards.de (Postfix) with ESMTP id B49C5F01613;
        Tue, 26 Jun 2018 18:23:40 +0200 (CEST)
Subject: Re: [PATCH BUGFIX RESEND 0/4] bfq: fix bugs breaking bandwidth
 guarantees occasionally
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, broonie@kernel.org,
        linus.walleij@linaro.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name
References: <20180625195537.7769-1-paolo.valente@linaro.org>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <371643da-7465-91d8-6765-65905776be64@applied-asynchrony.com>
Date:   Tue, 26 Jun 2018 18:23:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180625195537.7769-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/25/18 21:55, Paolo Valente wrote:
> Hi,
> during some bandwidth tests, I found some occasional but severe
> malfunctions (losses of bandwidth control). The first three patches in
> this series fix the bugs that caused these malfunctions. The last
> patch is a fix/improvement of the name of one of the functions
> involved with these bugs.
> 
> I guess these patches are appropriate for next kernel release.

Ran these overnight on 2 machines on top of recent BFQ and nothing
caught on fire. One funny benchmark result stood out since it gave
me (repeatedly!) 560 MB/s read bandwidth on an SSD which is rated to
do "up to 550MB/s", so I guess BFQ's bandwidth guarantees are now
really quite strong. :-)

Therefore:
Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>

cheers,
Holger
