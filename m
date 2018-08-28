Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5022C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 23:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F0D2087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 23:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="I3Ab/6I7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74F0D2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=aol.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbeH2DZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 23:25:07 -0400
Received: from sonic302-49.consmr.mail.gq1.yahoo.com ([98.137.68.175]:42008
        "EHLO sonic302-49.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727104AbeH2DZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 23:25:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1535499069; bh=C5y5Dw5LjULoWZSGgYUGZo8p0zWgNIBw2Lg2kTfNvng=; h=From:Subject:To:Cc:References:Date:In-Reply-To:From:Subject; b=I3Ab/6I7/v47KTZA3sgN/u1Y8Z27dowvXQOLeNzsLdc7xyU9QtDhm/Hu/WH0UGV4wyLZWA1TxBxmigP04oC++ktouID2xRxL9nlhceviJd19n3wnNqbbSwkYoX6EXZxaPT8n4EzCe/jImZpN4EgjGZV26Xi/aPxDwfYdD5Sqg88C9chjyl/xL79T0NfLa5dccowlQgY2KuJ9NS1ki7WqrKntOYxp1Qy1mr/b1LcNb5gMAo+vHcyq7/VyYuCIS29T3J8xbpz+RVr6sEMjIwbc3IG640w3k+1fNXVNfAf25usoGPI1Qm7qtSLQ15GHtF00zlf4qcViYb4KRyfWo0Ma4Q==
X-YMail-OSG: 9WyBONAVM1mURjOcgWcsk5nODfa51rX.NAhIgtZsWhPfqbgQAralJlp7a.xheQd
 YDOjW6uE4wrg1hiOm1p03cr7tlzqFRbH0vOPO2soV2emK.Izi2iCU56Di6l8fsLH8GHK2mQPZ8uR
 NvtiM9eU5Ys.XoMsRRx4pWl2t6piIVwSPcBC6BTYqdmqoxPIBFoL09Qc3QBimdJG6Bc5TkDM5lLM
 jq6q2CTdb0k5f9A37TnURFedpf18XX9ExBI9ltTcz.mYnkSgAv4Ex9ueFl99M53XtndihhKygJ40
 pDWKXQkvCzD0CMcEDjewtKRnLly1ZnXy259WjvwXwkh49R9azLcmgERZtMFK1Tv6Ch0IS1Y3TS4Z
 8kT0fPKcqkcZ0Hl10rXblx5SvqNm7ZXIzEmRknYz2BEz4SiOSHBtHE7EVDsBI0B9ENVAoaf8L_Fa
 A4BB45lp7fhouAeiT.pOmHmd84_vRdq2lrkmUBIkXHAENfJXKUs1U0ZQBGhFxkeU3CkG3_AicdmN
 mBdk9dslkcqJVKaYo6.62hMDErFnb3AAwqV7Cex5lS1VdNtWntE_MUlSGdOVHHcCpfXZ_fXTUqnE
 t5mFL6tADWFfZuM4edJzuaixJkWDcvNWXv.g9.3scKVPlsoZkTvuKrdwvGlAHHFlrifesREoVK.t
 N.NB5es.pEzJBuvE6__ktCc9ec_1Q_2Jk.f69n43gSD0OH1z14Xh_FTYjlEcgG9bxCkYJN1ggPGS
 LF3elW9FCjPZGj7PRmVkMUQDHiLqDEFt2lxYDnMkFNyiu2GMUm8X638UwyWsqqUZZeUeun1VNKAo
 9JRasmzNCQqLO5d1n7S1ti61JEDJAEBbW2GxvTBs97yVG_IgiS1s7AREpQpWX0tE87s8Nt2Gf9MD
 TTU1Heem_qEf_BiEmPQzOdpVXZ.9ONCd9Lh.dURzy9JQV0CWv3Icxvv9LHm3IpM9zP1Iz2XPWde5
 TTP7J9OhtLlSgZSoeQkUPH.gcCBb2RldZjWS4kebMl96DlSK3xZB5V_ESQUhwaPJR6udofDhB6u0
 1Sn96Ud68EdUuuJ2.JeqZOXYjWyJfGrg-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Tue, 28 Aug 2018 23:31:09 +0000
Received: from 112.96.253.137 (EHLO [192.168.24.100]) ([112.96.253.137])
          by smtp422.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 1fd94944c5d6bb4665f1de0362da0504;
          Tue, 28 Aug 2018 23:27:08 +0000 (UTC)
From:   Gao Xiang <hsiangkao@aol.com>
Subject: Re: Tagged pointers in the XArray
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Gao Xiang <gaoxiang25@huawei.com>,
        zhong jiang <zhongjiang@huawei.com>,
        Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20180828222727.GD11400@bombadil.infradead.org>
Message-ID: <8f565135-ffe4-e8a6-8a6f-4b74cedd4209@aol.com>
Date:   Wed, 29 Aug 2018 07:26:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828222727.GD11400@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018/8/29 6:27, Matthew Wilcox wrote:
> I find myself caught between two traditions.
>
> On the one hand, the radix tree has been calling the page cache dirty &
> writeback bits "tags" for over a decade.
>
> On the other hand, using some of the bits _in a pointer_ as a tag has been
> common practice since at least the 1960s.
> https://en.wikipedia.org/wiki/Tagged_pointer and
> https://en.wikipedia.org/wiki/31-bit

Personally I think this topic makes sense. These two `tags' are totally
different actually.

> EROFS wants to use tagged pointers in the radix tree / xarray.  Right now,
> they're building them by hand, which is predictably grotty-looking.
> I think it's reasonable to provide this functionality as part of the
> XArray API, _but_ it's confusing to have two different things called tags.
>
> I've done my best to document my way around this, but if we want to rename
> the things that the radix tree called tags to avoid the problem entirely,
> now is the time to do it.  Anybody got a Good Idea?

As Matthew pointed out, it is a good chance to rename one of them.


In addition to that, I am also looking forward to a better general
tagged pointer
implementation to wrap up operations for all these tags and restrict the
number of tag bits
at compile time. It is also useful to mark its usage and clean up these
magic masks
though the implementation could look a bit simple.

If you folks think the general tagged pointer is meaningless, please
ignore my words....
However according to my EROFS coding experience, code with different
kind of tagged
pointers by hand (directly use magic masks) will be in a mess, but it
also seems
unnecessary to introduce independent operations for each kind of tagged
pointers.


In the end, I also hope someone interested in this topic and thanks in
advance... :)


Thanks,
Gao Xiang
