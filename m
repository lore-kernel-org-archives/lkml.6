Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79679ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 11:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B26120665
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 11:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="neqo9wFS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B26120665
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=aol.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbeJ1TuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 15:50:06 -0400
Received: from sonic301-21.consmr.mail.gq1.yahoo.com ([98.137.64.147]:33460
        "EHLO sonic301-21.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727065AbeJ1TuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 15:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1540724746; bh=sUVEpUzLHerQbzVzMAyN3TNpJJBFHrv2o+nirERAh88=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=neqo9wFSSpXgdzI5KVnYeIm3wfMF1/bfOBKYSd65z7r4gOZklaQ7vaoY/k8JlZyusgYjHIRcUCwHp9YXxqacg8JQY5L5PTaAyx3OUS1uElB3toKpj7gnwVp7uCDO5iJTyi8FIchPxHdI93Tr05eKMRQ7J+x7dMXd9CZ6MLx2/ZZ273IT7kaSKGLXkLY7UvdUBdsOWSC++jJSQkmvPYjBBsy9bl5khSjsy3Qq+zd+IxEGUcRhFmqrQ8ZFcfY4y5SkxZdfF2hrOzAQiNGcEmi4/j3n+tVjN0rOx4idnYaHtoNO/IDxiEQLX2v8sCnCnYcawqEwUwarzTxrzTW4Tq6K/A==
X-YMail-OSG: .XSLIU0VM1l8ySmwxDfWhivFDa6tnu_Fn_6HnrZu_P.1Dst5imJv1pn9OI0y3ah
 SAcn2pTGlZH7itFvom4dZmfJY4giTCAEdKw39m8tHXxikzSHpSqpMQD3ujkYO7hGGeMv8L1jzYKT
 HwkObUGz6SLHTGsGcioGVzKavFJEUfnhZdLGTBRJaxaFaoLn08yIaVesdMUKHcnEOlEt3nZNlQFk
 x10Mu2._lJe3LE3uTkVTgtP9bW3W8s6EGPMPdktArO8K82D1WkAQs7qwB4Nombo2Vgg27N1_p82L
 2sVTs114xYJo0TCE2510mGUzRK0SGpxLc9vW7Kko0057vlp4lNgdbOD3tzT_bJATum26wtzLywhb
 9OtBT25B2zaXiAeRAMgT5peagrf0qwQ_kfK3XHJDQob99K94StTDqAsNdyCYsXkh3v.pRbAOwQR2
 djezRi46k9HUBcgjM_0AuqT4VesCIj4Mebl0suQnCK790pdrbwukqlAPBnuUHPtZPjRs.mwvuCd_
 vK2TDxDPhjTSeH.iicbduyaSJSlLY8V3CBT6cgKxSLUBLOVYMrdR4XuvgJuXGbbgInxckkbx2pv.
 pYYFqtAtzLYmRnAt7.3z5SaujiJ1SB_qUcOl7x5dKCR4PZF4WsxWUblvMEoDbQ1mQfiRMHIgpOBc
 aUYBuDGB66KuEbsN3DCtQ4nJf_elaNnnpP0F6MPSdDONsZrJjtlIR3wM5l5KYecbTmi76Shk64IR
 o5H03D7jE0MZs_0HSLJF8kaRuFSRl7ZNA1tQ6_sJpHJDQwnmqFLPiUqAyQPHJperxyvho.zFxlBA
 J_wBzKRIkhzK3C3Fj7OmQyJo8pF2wVPvQcbHJqjCYCPPgEeJLS.rYboef7Mk6GBrymq_RBfw8uF0
 uQpxJz8YgnpBCoOCqgJdmrcbGnygu2GL4yyJ2EOmFKrOt_aOyAAxoZw7WifFyiQyZNPcqvmtwLp_
 vp51VOKgpmVgMKXgpC8j5xMbfkEl8YSAfzA2xUpaQNFvzdqILZs4iZR4PkB_Hj3rbxiySheGItZX
 n4nm7Pd3Kl5F0KbAnFyx26RZpG73FNgajMK0QFTdD
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.gq1.yahoo.com with HTTP; Sun, 28 Oct 2018 11:05:46 +0000
Received: from 115.192.33.5 (EHLO [192.168.199.211]) ([115.192.33.5])
          by smtp418.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6a3374165f371d3e4b27453eae07b9dc;
          Sun, 28 Oct 2018 11:05:44 +0000 (UTC)
Subject: Re: [PATCH] mm: simplify get_next_ra_size
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Fengguang Wu <fengguang.wu@intel.com>
References: <1540707206-19649-1-git-send-email-hsiangkao@aol.com>
 <20181028102346.GC25444@bombadil.infradead.org>
From:   Gao Xiang <hsiangkao@aol.com>
Message-ID: <ceee59a6-b691-8d80-c62b-1b51377d6153@aol.com>
Date:   Sun, 28 Oct 2018 19:05:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181028102346.GC25444@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

On 2018/10/28 18:23, Matthew Wilcox wrote:
> On Sun, Oct 28, 2018 at 02:13:26PM +0800, Gao Xiang wrote:
>> It's a trivial simplification for get_next_ra_size and
>> clear enough for humans to understand.
>>
>> It also fixes potential overflow if ra->size(< ra_pages) is too large.
>>
>> Cc: Fengguang Wu <fengguang.wu@intel.com>
>> Signed-off-by: Gao Xiang <hsiangkao@aol.com>
> 
> Reviewed-by: Matthew Wilcox <willy@infradead.org>
> 
> I also considered what would happen with underflow (passing a 'max'
> less than 16, or less than 2) and it would seem to do the right thing
> in that case.

Yeah, thanks for the review ;)

I also made a simple tester to test this in order to ensure its correctness
and the result shows the same behavior except for the overflowed case.

Thanks,
Gao Xiang

> 
