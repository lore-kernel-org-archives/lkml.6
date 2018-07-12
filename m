Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB1CC476E8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1044620849
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9L1V6Tl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1044620849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbeGLQ34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 12:29:56 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:40760 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbeGLQ3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 12:29:55 -0400
Received: by mail-lf0-f67.google.com with SMTP id y200-v6so24739801lfd.7;
        Thu, 12 Jul 2018 09:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Vyz4XxstOcV8pbG74Qmupu88IRUf9qTh3TTCwU1140Y=;
        b=U9L1V6TlGNyyQWynDhjK21uxg3cdBuwc5nkY8atWnrVc3asoAUXwLu+/+Z8aC/vuhx
         /gHJRK+2RwS0p4LOBtfLbdQo36M6pEiM7UwyTTVGlxIBrKjv1jFMstgFh1vKMZkJeFde
         2/NeMxoAh8pR4PfTW7gauUlWdYX6qS7LjIh8tjdTnRPoeJpmBKzOd55HPax2Cu97FAx4
         xb0Z73Iblr81CNwYr4hbA5I5n9nijT1zRig2q1q69uSsPG6um5wzIrmjDdi9lbubmUS4
         yNfM9sBjOMQGDIyDkRnCEx2+sJw2eHxQD/bRaBjPJaJSK8rW7nRrOWRnIsNvYOukhJnt
         Udjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=Vyz4XxstOcV8pbG74Qmupu88IRUf9qTh3TTCwU1140Y=;
        b=PPe3lSOHK2zr9fKdCDIzr/pjyPwskyjt15BhWU6nl6X4uxFApVCXRKC66ndExVa3iY
         rWeQkj1o/RPtDLiUyljVc8TUBemVoykJ0vtRAprPciSHKIXwrQ0p9fNAu+reN7m43nig
         /R2I+fBzAYvlpQ6loc3DvgbB7dbalkat/c8dG8uq+ploWMyBqRwM/zWMnFYO1R8qu8Y/
         4pGYQZ+ceTk8U+haIFmvhDCoimLB9rcBzpR0KL/dP4Ni7wU/QXdpCe0ND97Pm6PEYk7m
         pru/nVo5gPJjJ1FKARZFRnA9yNkYNYYBuo6+HkSrXiPOuWrcCLF+qJxnGZT++5xRim1m
         0l5g==
X-Gm-Message-State: AOUpUlGCd3mNF99VsAbrkjuVoOCIm2euSER66W/FuCUcHhWqIxsIz0TF
        uv8tlVa0zw2gn9T+89lscv8=
X-Google-Smtp-Source: AAOMgpcu411h3wi1yPK4obZHBXHQKZ6xqwoCrYWfOfq0aiOAjnc/wtHazRLuBdzMYxQyjcivcpk3Tg==
X-Received: by 2002:a19:d44a:: with SMTP id l71-v6mr2213897lfg.28.1531412379056;
        Thu, 12 Jul 2018 09:19:39 -0700 (PDT)
Received: from ?IPv6:2001:2012:22e:1b00:f2e2:9015:9262:3fde? ([2001:2012:22e:1b00:f2e2:9015:9262:3fde])
        by smtp.gmail.com with ESMTPSA id y74-v6sm6179292lfi.61.2018.07.12.09.19.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 09:19:38 -0700 (PDT)
Subject: Re: [V9fs-developer] [PATCH] p9_parse_header() validate PDU length
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net,
        viro@ZenIV.linux.org.uk, davem@davemloft.net,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>
References: <20180712110211.25535-1-tomasbortoli@gmail.com>
 <20180712114304.GB17774@nautica>
From:   Tomas Bortoli <tomasbortoli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tomasbortoli@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <fed36388-4e18-49f4-ec26-2b6b3d08ef54@gmail.com>
Date:   Thu, 12 Jul 2018 18:19:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180712114304.GB17774@nautica>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Cc: Andrew Morton <akpm@linux-foundation.org>

On 07/12/2018 01:43 PM, Dominique Martinet wrote:
> Tomas Bortoli wrote on Thu, Jul 12, 2018:
>> This patch adds checks to the p9_parse_header() function to
>> verify that the length found within the header coincides with the actu=
al
>> length of the PDU. Furthermore, it checks that the length stays within=
 the
>> acceptable range. To do this the patch brings the actual length of the=
 PDU
>> from the different transport layers (rdma and virtio). For TCP (trans_=
fd.c)
>> the length is not know before, so we get it from the header but we che=
ck it
>> anyway that it's within the valid range.

Still for TCP it you could read "garbage" pre-allocated memory but I
don't know how much it is a risk, it might be a good idea to zero it
post allocation (I mean pdu->sdata). Allocated at:

https://github.com/torvalds/linux/blob/master/net/9p/client.c#L236

> Just a note on transports here, I totally had forgotten about trans_xen=

> when we discussed this earlier as it is fairly new, but it looks like i=
t
> sets the length in the fcall properly so it should work without any
> change.
>
> I however cannot test trans=3Dxen, so if someone could either point me =
to
> how to set that up (I couldn't find any decent documentation) or do som=
e
> very basic tests that would be great.

>> Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
>> Reported-by: syzbot+65c6b72f284a39d416b4@syzkaller.appspotmail.com
> Looks good to me, as the rdma/virtio part come from my suggestion:
> Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>

True
>
>> diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
>> index 3d414acb7015..002badbcc9c0 100644
>> --- a/net/9p/trans_rdma.c
>> +++ b/net/9p/trans_rdma.c
>> @@ -319,7 +319,7 @@ recv_done(struct ib_cq *cq, struct ib_wc *wc)
>> =20
>>  	if (wc->status !=3D IB_WC_SUCCESS)
>>  		goto err_out;
>> -
>> +	c->rc->size =3D wc->byte_len;
> (nitpick, I'd keep the empty line here. If you don't mind I'll add it
> back in my tree; this doesn't warrant a v2)
>

Sure,

Tomas

