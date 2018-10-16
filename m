Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B064DC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1244E20881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="w1KEz+jt";
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="zTd8RzEy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1244E20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbeJPWuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:50:03 -0400
Received: from forwardcorp1g.cmail.yandex.net ([87.250.241.190]:60281 "EHLO
        forwardcorp1g.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727026AbeJPWuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:50:02 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1g.cmail.yandex.net (Yandex) with ESMTP id 0B27F21AFA;
        Tue, 16 Oct 2018 17:59:10 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id SUd5SlX1iD-x9lGAeRb;
        Tue, 16 Oct 2018 17:59:10 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1539701950; bh=hlnFOxPwoDqJsWeipAEabaxemXSxlGGeraQyhuJY9c8=;
        h=Subject:To:References:From:Message-ID:Date:In-Reply-To;
        b=w1KEz+jtwCjzYADGQVSANPA5Wbn4zpyQ9us4H9cAml5MnKD35mWPhzxOP3DfYjqtk
         7AB/rnCHpjmp/D5xRj1hZ8bjLkMYuHEsuw9zAtWzhQ5MaHdIk9QLw+lIUcg1rL9bZ7
         C2qZleg+Kwdtr77eFzdrkwT5MZpVXi27aOOyO2hk=
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b010:d007::1:95])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id SQvn0sggDJ-x9WauGYH;
        Tue, 16 Oct 2018 17:59:09 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1539701949; bh=hlnFOxPwoDqJsWeipAEabaxemXSxlGGeraQyhuJY9c8=;
        h=Subject:To:References:From:Message-ID:Date:In-Reply-To;
        b=zTd8RzEyjPYZNXPyDoh6MKcr3yJYRQhvl5iVTMVOrJn0aF93dVqdjqY2YC/K7Oj/h
         Su42yjUZDZ146hSPBOdbyxwUtcOIqJ5f6y61bRAafZsSLSaemmw6vCpqK3fLli+oNG
         53xBN/9JGwHk9c9cPNzRt8SmE4mqnE8cZGla4rnI=
Authentication-Results: smtpcorp1p.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Subject: Re: [PATCH] block: fix comments about choosing request list
To:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
References: <153968002141.396220.12979757828960821275.stgit@buzz>
 <5f5b7f16-b4cd-7c8f-519f-7ddbbea1ba41@kernel.dk>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <e6a73872-7239-df1b-6089-4de51a43d4a6@yandex-team.ru>
Date:   Tue, 16 Oct 2018 17:59:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5f5b7f16-b4cd-7c8f-519f-7ddbbea1ba41@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.10.2018 17:45, Jens Axboe wrote:
> On 10/16/18 2:53 AM, Konstantin Khlebnikov wrote:
>> Request list is determined by blk_get_rl() and without queue_lock.
> 
> This code is going away shortly, so let's just leave the comment
> alone.
> 

Ok, I see some patches in flight for 420

Probably they also fixes linking non-bio based request with cgroups?
I've found that old stack calls blk_rq_set_rl() for all request
while MQ do this only in blk_mq_bio_to_request,
in blk_mq_get_request() request gets only io-context.
