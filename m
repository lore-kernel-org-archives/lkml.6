Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDE0C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6E72086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:54:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC6E72086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbeJPSoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:44:02 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:50619 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbeJPSoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:44:02 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M8Qme-1gGmol014K-004QOk; Tue, 16 Oct 2018 12:53:15 +0200
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M8Qme-1gGmol014K-004QOk; Tue, 16 Oct 2018 12:53:15 +0200
Subject: Re: [PATCH v6 1/1] ns: add binfmt_misc to the user namespace
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        containers@lists.linux-foundation.org,
        Dmitry Safonov <dima@arista.com>
References: <20181010161430.11633-1-laurent@vivier.eu>
 <20181010161430.11633-2-laurent@vivier.eu>
 <97280bb2-933e-9281-bd91-99748e1dd653@rasmusvillemoes.dk>
From:   Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1eca343b-19c7-a82c-d7ac-b3aea288b56b@vivier.eu>
Date:   Tue, 16 Oct 2018 12:53:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <97280bb2-933e-9281-bd91-99748e1dd653@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3keoEeeL+2NKb2FraSq4o0jqfkqccO3MxPpEsK5dpRapOoobKav
 rUS1FY2VOt7dHfJz2t7taM6lToTINYAQGJ57WOUBA3LIiN3DAeLLLmlrqvlcVIg5ZzSaHcw
 4l78dCXkke4JCMEK/OAiYnYoiHzlZps/pmtMvDP+SuMJb8ykfamyhqnXFSuay+uskRuIelt
 WAqrjo35rW0yFeu0PrILw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GPW1UDPAXbE=:0KyPEZQW03mK8Ruf+SASxD
 9+rSWnuysZFuP3OymhyLLzp8E0eQhQa5nLG/2tIz7aW7OWCa+qgQMAYxYZmjtgFmSUOoaKgfk
 WyKwtmgOb5bg156z/qQczkGBva+Fkrn8FknHw4fa/rwndqHyUyl2ibVM3oGpofSomCJukigrM
 npfIPTjeVV7keCgBalUIdJfhf48qPshho9+sBJvoZLYK97COUYvm7W0mvaAqlmv2qQC9Q3e5M
 LAhDuyNj2jNILY/ewt6Tj+ljH3jgCNGtCwIj9j1oNDw5hFssoRYI8ETzgV98LdC7eHH1yC2L9
 8mCvIsDjAqTj88f3mInq0AFY9UHF5NrskEQhTyiSMNBFduwuWmDdw93LIVLJE9myHvT4QM1rg
 gGzWOVgouv1qffVURDIUd3HWho8dWMwzO6a2nT4I/fVpqVSB9Upysn8ylS9AcxEgfSrXdGKQw
 D01estsGOTWnV2EwL0An5tXE22fwD5YrZRmoNOlBJW7OqR0AUD3l09IbATjlK71NmNywxcKXO
 I70ITUDu15QgVONUoqPvlYxjMJaf6RxKfGx0IAgQSHuinK3v4XLEZV6kwagQKvYkhJTfmEFA9
 5H6zLFOwWvezGV5v8vsMNwY6z0cWzv/+I9AqeM5oUGGtOMr4x+Fht6mIFW9T2Fser6rVzNBf+
 zrWn4ezN7DqzrVbahTkzHEtOvq7YNJtHnvplmTC1qqg77HlupyIar8f8iuF+VwZdWNFPg7w5o
 K87vsbuIFscuKxFJ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 16/10/2018 à 12:13, Rasmus Villemoes a écrit :
> On 2018-10-10 18:14, Laurent Vivier wrote:
> 
>> +	/* create a new binfmt namespace
>> +	 * if we are not in the first user namespace
>> +	 * but the binfmt namespace is the first one
>> +	 */
>> +	if (READ_ONCE(ns->binfmt_ns) == NULL) {
>> +		struct binfmt_namespace *new_ns;
>> +
>> +		new_ns = kmalloc(sizeof(struct binfmt_namespace),
>> +				 GFP_KERNEL);
>> +		if (new_ns == NULL)
>> +			return -ENOMEM;
>> +		INIT_LIST_HEAD(&new_ns->entries);
>> +		new_ns->enabled = 1;
>> +		rwlock_init(&new_ns->entries_lock);
>> +		new_ns->bm_mnt = NULL;
>> +		new_ns->entry_count = 0;
>> +		/* ensure new_ns is completely initialized before sharing it */
>> +		smp_wmb();
>> +		WRITE_ONCE(ns->binfmt_ns, new_ns);
>> +	}
> 
> If ns->binfmt_ns can really change under us (given you use READ_ONCE),
> what prevents two instances of this code running at the same time, in
> which case one of them would leak its new_ns instance? Also, there

See
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1782780.html

> doesn't seem to be any smp_rmb() buddy to that wmb(), I don't think
> that's implied by READ_ONCE() in binfmt_ns().

See
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1783049.html

Thanks,
Laurent
