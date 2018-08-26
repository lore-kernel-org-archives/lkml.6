Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0046C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 17:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DCB72086B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 17:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="lLbUUUSR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DCB72086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=aol.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbeHZV2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 17:28:19 -0400
Received: from sonic309-21.consmr.mail.gq1.yahoo.com ([98.137.65.147]:35310
        "EHLO sonic309-21.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726714AbeHZV2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 17:28:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1535305505; bh=N9yQMr6aX5kvPsvUvoPPV6/zixgZZtur7yBsf0Q8SI4=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=lLbUUUSRr8bmHwDPhWOsOVgs76QybZSIHWxhI0EzK1A+cdn83Z2Yx7FR0Np6yyJ8z9ZTyaENovfzyLMJEFJxf1F0PZcB5nezUdFIQ7a8dwXhFh3OQZlgiQTDdsOH2P1FYwETT8Ib3JzCRvgrfvDwEgMVVbcy+Vbqn/RycMmOTzJbKqC8eu3wVzFHLup33uaXPZ1DWDv8w1USupUbVML6pG3ziueLCqFtz3Gulh0eFzHzWrG4Y6wdqzV37thdsxOPLidQKtbwCGW+GTpRuOtBwA9MC6cUfXVUBv9pqjUdXiZdq/bSsHmzaZk6dOqhwNzVCeVFzts0FVtbsnWIl7OB/Q==
X-YMail-OSG: wswD4LQVM1nI0w5BgyuFUdCwg7EhtDHP6R2CXLzQ5fGfLQSbnF5hwNdFglFigqL
 XWFCaxbUUOf5TH0OY4ZuAHMcQWAZzOb8wMmiz7.cMxz_Cwk78SPq4E6tBgkAVn2Mk1fta7ee6MY1
 uD59HriEDdy.Q.NWMjVOG0AE93Wf_z1hpwUcRSHySdubrOQt0RHEv.EONRMm6r.RmeVDb.2c7OIF
 eBWNjYUS0o6UCc2kiIMXyjfSgQULQAriqiPrQ3bQS15uHUukvxpkRvwWKVgFzxBKsID4HlC4Khl8
 KFLkKmbALdS2fw81L49K2yOPZYKt7StLyLgPUI_6o7.cJKqQgYg.Fj1pNdjbddnjLovTlvDyDB4z
 PJj56wwhpz3aemEYH88lVYecrF8KhvGZ55jS6Kj4.6QWX0zxLeHDNMfbfz91EuHDSw4YFLS2G2ec
 WCkUnEwQSvZ5Log2OlliM_BfmXiYl.3vKr.9WfkOl_XbrQmruYvr6ZFD7PMJ9miLN5A_Z9TPYnaP
 eDVL4ffN0tXusGNfayUmxBHjvW.Mkw_av_1DRgnxzzDc1Zw.ZSfBc1yXp23Gr1Lmb2XLrhgSofhi
 WsiOL2k3Bi2IHeQWGqkRC_U_FQABPihc4EJBISHUH6bDgZ8o24DavotHiPpMMUTFw1nd0gJhSvGc
 REYeabsk9dvaNKip7hasNM9AyLwqWcLvULzIyQKY5_GaIfJLtFsXUDyD0bR9bRaGA28ZooO3pK8H
 kMT5W7806938jspTBdscKrJaLnh04n1Yw42VK_u1DJERnLQCAGPHgTHBaCJJjZwONlOAPxCubkrl
 kWhJs.pIbfKW4lrMrJKKxqYIaAl.xrYw3U35m18JkkArEp2yibaoYm91161QmKQxwta2m8QFXGZw
 sheqYhWtGEZieyGf1R9mcjVa96bmBtmK2rjYWQL7eMyC7ZmzlhcCmAbM1asW_EcAdkSe1hQqd23i
 j.ODucuaMH3imEcjc_bfaSFjDcn.6gup0J573lUXhwXPwApani.M6_sGpQLA9UYr4jqdZQjNrRPo
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Sun, 26 Aug 2018 17:45:05 +0000
Received: from 116.226.251.211 (EHLO [192.168.1.7]) ([116.226.251.211])
          by smtp427.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID a05c9b9d96e0b8894eb4b08e15e6ef81;
          Sun, 26 Aug 2018 17:45:01 +0000 (UTC)
Subject: Re: Re: [RFC PATCH 02/10] fs-verity: add data verification hooks for
 ->readpages()
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Chuck Lever <chucklever@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Michael Halcrow <mhalcrow@google.com>,
        Victor Hsieh <victorhsieh@google.com>
References: <20180824161642.1144-1-ebiggers@kernel.org>
 <20180824161642.1144-3-ebiggers@kernel.org>
 <C86750D6-CA95-4A7F-9204-51345C497EC2@gmail.com>
 <20180826170433.GA728@sol.localdomain>
From:   Gao Xiang <hsiangkao@aol.com>
Message-ID: <a83219f8-44a2-7a40-319a-dc2f9d567cbe@aol.com>
Date:   Mon, 27 Aug 2018 01:44:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180826170433.GA728@sol.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 2018/8/27 1:04, Eric Biggers wrote:
> Hi Chuck,
> 
> On Sun, Aug 26, 2018 at 11:55:57AM -0400, Chuck Lever wrote:
>>> +
>>> +/**
>>> + * fsverity_verify_page - verify a data page
>>> + *
>>> + * Verify a page that has just been read from a file against that file's Merkle
>>> + * tree.  The page is assumed to be a pagecache page.
>>> + *
>>> + * Return: true if the page is valid, else false.
>>> + */
>>> +bool fsverity_verify_page(struct page *data_page)
>>> +{
>>> +	struct inode *inode = data_page->mapping->host;
>>> +	const struct fsverity_info *vi = get_fsverity_info(inode);
>>> +	struct ahash_request *req;
>>> +	bool valid;
>>> +
>>> +	req = ahash_request_alloc(vi->hash_alg->tfm, GFP_KERNEL);

Some minor suggestions occurred to me after I saw this part of code
again before sleeping...

1) How about introducing an iterator callback to avoid too many
ahash_request_alloc and ahash_request_free... (It seems too many pages
and could be some slower than fsverity_verify_bio...)

2) How about adding a gfp_t input argument since I don't know whether
GFP_KERNEL is suitable for all use cases...

It seems there could be more fsverity_verify_page users as well as
fsverity_verify_bio ;)

Sorry for interruption...

Thanks,
Gao Xiang

>>> +	if (unlikely(!req))
>>> +		return false;
>>> +
>>> +	valid = verify_page(inode, vi, req, data_page);
>>> +
>>> +	ahash_request_free(req);
>>> +
>>> +	return valid;
>>> +}
>>> +EXPORT_SYMBOL_GPL(fsverity_verify_page);
>>> +
>>> +/**
>>> + * fsverity_verify_bio - verify a 'read' bio that has just completed
>>> + *
>>> + * Verify a set of pages that have just been read from a file against that
>>> + * file's Merkle tree.  The pages are assumed to be pagecache pages.  Pages that
>>> + * fail verification are set to the Error state.  Verification is skipped for
>>> + * pages already in the Error state, e.g. due to fscrypt decryption failure.
>>> + */
>>> +void fsverity_verify_bio(struct bio *bio)
>>
>> Hi Eric-
>>
>> This kind of API won't work for remote filesystems, which do not use
>> "struct bio" to do their I/O. Could a remote filesystem solely use
>> fsverity_verify_page instead?
>>
> 
> Yes, filesystems don't have to use fsverity_verify_bio().  They can call
> fsverity_verify_page() on each page instead.  I will clarify this in the next
> revision of the patchset.
> 
> - Eric
> 
