Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A19DC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3B520693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s5BzJ4TI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD3B520693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731627AbeGSJcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:32:22 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33859 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbeGSJcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:32:21 -0400
Received: by mail-lf0-f68.google.com with SMTP id n96-v6so5458024lfi.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 01:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=kk9zcbuA4v1yYPsDKhqCoSLVwSLnJadQcRc2LhHyIYE=;
        b=s5BzJ4TIJ0wsSLh3g04HKiLFVDjTvMIIa6nfya3TqtLdxen2UfSa76u4tHl8BO8f3Y
         DuwacOsd+IllRq5HGqfGBMbWIMTZVmzVtdgGRd0Bpms+sPp+lNA0Gdpxr9JcUqdY0Y1C
         Py3EshV8HM6Fl8/Nj+wVrFuolUjcOM3LfiXcr1z6NIOirJ1wFzaeGfm7y/vKWy7ivXYw
         RBtYWRb5uHj4WH6z8xOE3myY6bST76eXhTFqCzrDksLlhUl6E4gGKYYBK3xTdNsl6wo4
         W1KE1mQ4pSqYeNiqsEUb0f13ekGzSIP2VmFfaxJYmEo1VtHDXEgN+SpTmKc/5neU9xPn
         MEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=kk9zcbuA4v1yYPsDKhqCoSLVwSLnJadQcRc2LhHyIYE=;
        b=Ozz4ZfPZkI5ODUmh3+1fX3PI6N4lH40F//T1e1XD0IJvjxYZhAP0TEVpEKvPNPZjfY
         3NhIZL3GhKze9UaNV2KW37yVL/zKvlaZfQHAmJRmmvd9ARPggekPj8h0YFfCdZPsnyXy
         N3mSUmnzoNHF92DxNY5LCGK6t+HelwQNPc1AfLH5+52t84fVBWMNl/lKFFakEx5BqIGY
         KddHkFgB/+8m0txg1sWd8S5/DzqbcBZ9XPywEOmWx+nHFePUACBO3m9D/eJXabnZd/je
         tWZolGvy46Q3FwWkEUMSzg5Y+nViPjhshk4Vf0Vg6Tps1WI/nF9STI0LMWg/syBn604S
         ZIJw==
X-Gm-Message-State: AOUpUlGL2Eczzaadge1OvYnvBdk5jhULYOkorKdvVkGRwI8WklKqhw+y
        sdJGZ/gvpITvWDk9c4YwoDlfaEaoc9OFWU6IavU=
X-Google-Smtp-Source: AAOMgpeeOS8aHOfJHqNiqFSHvHImY6jPacESBQbrl/GLnptl37+4mVL9qE/7Hg8/ATtokyWA3Adi3+xiJkAS9+gn8TI=
X-Received: by 2002:a19:5c06:: with SMTP id q6-v6mr6292447lfb.6.1531990213211;
 Thu, 19 Jul 2018 01:50:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 01:50:12
 -0700 (PDT)
In-Reply-To: <cda1d3de-3f21-2dfc-0423-c1cf456838b4@huawei.com>
References: <1531899055-29362-1-git-send-email-wangxiongfeng2@huawei.com>
 <1531899055-29362-5-git-send-email-wangxiongfeng2@huawei.com>
 <b6eaf471-7279-ca4f-bb7c-d25df8db2419@gmail.com> <20180718164625.GA20360@sirena.org.uk>
 <82248c13-42fe-b598-0cd7-68e5db0b51be@gmail.com> <cda1d3de-3f21-2dfc-0423-c1cf456838b4@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 19 Jul 2018 10:50:12 +0200
X-Google-Sender-Auth: 9wbA-mGSGXGaj8Ejv8PLkvNRhlg
Message-ID: <CAK8P3a2oubqRKg1tnoG6CsmUs-U5Ab6q5rwpfg08PRNJLhEjEw@mail.gmail.com>
Subject: Re: [PATCH 4/5] crypto: Add IV generation templates
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     Milan Broz <gmazyland@gmail.com>, Mark Brown <broonie@kernel.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>, dm-devel@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 3:46 AM, Xiongfeng Wang
<wangxiongfeng2@huawei.com> wrote:
> Hi,
>
> On 2018/7/19 1:17, Milan Broz wrote:
>> On 18/07/18 18:46, Mark Brown wrote:
>>> On Wed, Jul 18, 2018 at 10:16:05AM +0200, Milan Broz wrote:
>>>
>>>> So we are here again and moving INTERNAL dm-crypt functionality into
>>>> cryptoapi.
>>
>> 2) If the reason is performance, please provide numbers with the patch.
>> What I see now is that the performance is almost the same. So why you are doing it?
>> Any real hw that benefits from it?
>
> Because the internal implementation of the IV template 'benbi()' is still
> dividing the whole bio into sectors, so the performance is almost the same.
> The purpose of this patch is to let dm-crypt rely on the new algorithm 'aes-cbc-benbi'
> and pass the whole bio to the new algorithm.
> And then if the hardware driver implements this new algorithm, it can get the data of
> the bio at one time, and return the processed data at one time.
> I think it will decrease the overhead of passing each sector alternatively.
> But the hardware need to implement the new algorithm if it want to benefit from this.

There seems to be some support for at least essiv(aes) in
drivers/crypto/ccree/cc_cipher.c, is that compatible with your essiv(*)
template, or is that something else?

       Arnd
