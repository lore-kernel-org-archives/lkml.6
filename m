Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB04BC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5EC20846
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J80ftiHt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A5EC20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933280AbeGJIPK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 04:15:10 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55995 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751232AbeGJIPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 04:15:04 -0400
Received: by mail-wm0-f66.google.com with SMTP id v128-v6so6082071wme.5;
        Tue, 10 Jul 2018 01:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=C5hnSiVquI4dMhsZ+/i0zP8ki+Zdst7lNYygFO5AMBk=;
        b=J80ftiHtEp0QqVp5kwI/etolo+7MwjfoIY/zoHK8i11L6w25ZgmWSJylTgX/xLUQqs
         cX/7c7RsB7I1EHn1ujYBZVVVMoD/qoKJnpjWAKjnCm5QaiBnDxSeZMgb4LIAUC3liZZs
         cU+p5qgxwitWoN8nHSjiRmJftAJv2joNl1CdSTz3ysPxGUQU5GtJ+xnYqeosJh3qR6Yo
         iYqutCpI343SCfTg7+Z/JTwZ73K37sNSNtUTBlOsMmChekgo4k+Pienr7rrIBG2sv6+K
         umN1yDG9XDR/gBeLb4JlbI5bql/rYjVdEYw5/TSL3rSJM5UQvik8B4DF7lDw8vHUjKXc
         wbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=C5hnSiVquI4dMhsZ+/i0zP8ki+Zdst7lNYygFO5AMBk=;
        b=eREOV8I/Oxr6FxYP2z+RoH1hZvoUWSNxxkZWCckSpSGrBX1R5W8v/Oed5ly2+g3UmG
         IzNFRDh5oEnI2gI8K42dysaACyFv482i7b/xKyVTupwpOBFLA2KdaWv0jLojWLKo9ucl
         /zZcg5rYsXbfmd4ECfVhcAh0DRkSfjwyN04rlO9D+9hy9qo8+WYZ8/laOuvo51pa+inK
         LMjzNjYvWcKXBmzNDl7AMSTpf10fg2GyHFKzNoefrW15zT42Fr6wkcA1ksUIM6bSWmtx
         1DiPiJtgmEMeDynzdtD2VVXqoIv9rGXexIMRpNy6f9iLTSBzX5a8I7zd0iql0cDsHNHO
         3tdA==
X-Gm-Message-State: APt69E2BycxyZHkpXoJ5Wsbj+YqzJojw/gVQUQvrrTIX4CNxSsYVqBcv
        tABoOLpkmqiyzjq5oaMo2LU=
X-Google-Smtp-Source: AAOMgpcBGFj6bQNzXYSLaYkG9TM3ZuYjNU2HkfYtMEXLbPpz7SE+XmSrWMD22SRtIYvMjcgK2d65Kw==
X-Received: by 2002:a1c:6709:: with SMTP id b9-v6mr14761581wmc.68.1531210502538;
        Tue, 10 Jul 2018 01:15:02 -0700 (PDT)
Received: from [192.168.8.10] ([185.175.214.210])
        by smtp.gmail.com with ESMTPSA id r17-v6sm12798306wrt.44.2018.07.10.01.15.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 01:15:01 -0700 (PDT)
Subject: Re: [V9fs-developer] [PATCH] p9_check_errors() validate PDU length
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com, v9fs-developer@lists.sourceforge.net,
        davem@davemloft.net, Al Viro <viro@ZenIV.linux.org.uk>
References: <20180709224323.20597-1-tomasbortoli@gmail.com>
 <20180709235403.GB19917@nautica> <20180710022819.GA19285@nautica>
From:   Tomas Bortoli <tomasbortoli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tomasbortoli@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <ba4e159c-a78e-1d42-ca11-d4c8897a9a83@gmail.com>
Date:   Tue, 10 Jul 2018 10:15:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180710022819.GA19285@nautica>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2018 04:28 AM, Dominique Martinet wrote:
> Tomas Bortoli wrote on Tue, Jul 10, 2018:
>> As suggested by Dominique:
>> https://lkml.org/lkml/2018/7/9/688
>> Such check is not enough as it will prevent to read more than how it h=
as
>> been allocated but it won't prevent to read more than how it has been =
read
>> So this patch will require some more changes to prevent bad sizes.
> Sorry, I'm the one who suggested to put a note after the commit message=

> and I didn't see it.
>
> Let's get the proper fix right away, it's not much further.
I agree.
>
>> Also, they really need to check against the actual read size, not just=

>> capacity.
>> For virtio/rdma, something like this ought to fix pdu->size, then
>> p9_parse_header can just never overwrite it (untested but it's useless=

>> on its own, I'll test the full patch with the parse header change)
> I actually took the time to test a bit; I had only suggested something
> for virtio/rdma because I had assumed trans_fd (the socket transport
> actually used by syzbot) was setting the length in the fcall, but I rea=
d
> that code too fast this morning and it is not (it only sets the size in=

> its private struct)
>
> Something like that ought to work for trans_fd:
> diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
> index 588bf88c3305..9f3ce370c685 100644
> --- a/net/9p/trans_fd.c
> +++ b/net/9p/trans_fd.c
> @@ -369,6 +370,7 @@ static void p9_read_work(struct work_struct *work)
>  	 */
>  	if ((m->req) && (m->rc.offset =3D=3D m->rc.capacity)) {
>  		p9_debug(P9_DEBUG_TRANS, "got new packet\n");
> +		m->req->rc->size =3D m->rc.offset;
>  		spin_lock(&m->client->lock);
>  		if (m->req->status !=3D REQ_STATUS_ERROR)
>  			status =3D REQ_STATUS_RCVD;
> ---
>
> This however gets more complicated once you start factoring in that
> change I suggested about p9_parse_header not setting size (and checking=

> size) because trans_fd relies on it; so I'm not sure how we should
> proceed.
Mmh, me neither. I don't see where the *actual* PDU length is stored.
>
> Do you have a working 9p tcp server to test changes are valid, or are
> you only working off the syzbot reproducer?
No, I was just using the reproducer to test.
> In the first place, are you willing to take the time to do that bigger
> fix?
Yes.
>
> At this point I can either help you get a working setup and let you do
> the rest, or just finish the bigger patch myself and add you as whateve=
r
> tag you feel comfortable with (persumably Signed-off-by)
>
> Thanks again for starting this,
For me both ways are good. Signed-off-by will be good.
You know for sure more than me about 9p as I started delving it for the
first time yesterday. I can also make and test a patch but I'll need to
understand more about it. Let me know if you find out more.


