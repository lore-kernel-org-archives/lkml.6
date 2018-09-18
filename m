Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C8FECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D392E2150E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SK5UmWca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D392E2150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbeIRVxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 17:53:39 -0400
Received: from mproxyhzb2.163.com ([123.58.178.202]:35304 "EHLO
        mproxyhzb2.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729680AbeIRVxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 17:53:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=bbRL9
        w9EeoVL3vWLbwhzHITae1Gt+hdPMZanQQCy7us=; b=SK5UmWcaYhqzPuAsl0jdl
        6f6h6hGhTXn8gOn2Hb3YQWUaGZjj0ZPgeXHleQjYn15fc6iuXIUyUbGSvw+mlCbP
        fkhQUR9iYmGy+T/VQuZpiTawqs+DVB02EBXwVyMhYGjjOcAmkskb6RLEFGmswZC8
        W9jYqyoRPfkVdVPI1nCcR4=
Received: from [192.168.43.190] (unknown [112.86.218.164])
        by smtp3 (Coremail) with SMTP id DdGowAAXHmarIaFb_EopAA--.14S2;
        Wed, 19 Sep 2018 00:03:08 +0800 (CST)
Subject: Re: [PATCH v3 2/2] irq/matrix: Spread managed interrupts on
 allocation
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, mingo@redhat.com,
        hpa@zytor.com, douly.fnst@cn.fujitsu.com
References: <20180908175838.14450-1-dou_liyang@163.com>
 <20180908175838.14450-2-dou_liyang@163.com>
 <alpine.DEB.2.21.1809171713270.16580@nanos.tec.linutronix.de>
From:   Dou Liyang <dou_liyang@163.com>
Message-ID: <d8f6c9d3-9947-a5ba-3b2b-b8625d2afeb5@163.com>
Date:   Wed, 19 Sep 2018 00:02:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1809171713270.16580@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: DdGowAAXHmarIaFb_EopAA--.14S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF47Kr1xJFWxJr15Zr4ruFg_yoW3AFb_ur
        s2yFy7Gw1UJa90grW7uF1qyFn8XayUJryUJa4UXr10g3s5AFZxGan0yryxXF4rWa42grnI
        yryrJ34Yyr9rWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUeGXdUUUUUU==
X-Originating-IP: [112.86.218.164]
X-CM-SenderInfo: pgrxszxl1d0wi6rwjhhfrp/1tbitxzFolaD3866fgAAsM
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Thomas,

On 2018/9/17 23:32, Thomas Gleixner wrote:
[...]
> I think it's still worthwhile to do that, but the changelog needs a major
> overhaul as right now it's outright misleading. I'll just amend it with
> something along the above lines, unless someone disagrees.
> 

Yeah, Yes, right, I was wrong, can't prevent vector exhaustion, just
make it looks balance as you said. Thank you so much.

> That said, it might also be interesting to allow user space affinity
> settings on managed interrupts. Not meant for the pre/post vector case,
> which just needs to be made non managed. It's meant for the case where a

Yes, I am cooking according to the direction you are proposing.
Recently, I changed my PC and just completed the configuration of the
environment. ;-)

Thanks,
	dou

