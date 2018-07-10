Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20D7C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5840B20871
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQUr5ehx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5840B20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbeGJI1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 04:27:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43476 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751082AbeGJI1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 04:27:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id b15-v6so13625590wrv.10;
        Tue, 10 Jul 2018 01:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=P6HfmlM/cBK46V8lQXuLn9AZXlb7U0QMuTLQ12qwUZc=;
        b=MQUr5ehxcpAATCZvoEuCxgFrw5p/aKl5vDTmuHLNCeFANW5f+aF+qNKveAOOmFa3/c
         YfSc3PbwyMn3vm4ScOaGxZh97SVrMzcx0kDkWULCDIK50AKrrnPSzkb6/WLtutWTwpwW
         o7m1yM0+CASUDSXIoQditvKogJPH7kfo9IxU2CKpQ57KlFLLWWsJKESak7j+9Id67+Ot
         wy3J/0fJd7fhsC2D+CSwSSdc0DTCf7ZERmuKqXXdBD0uaizgZX9JZGX0mODUywB/3C9B
         psICLFPoBRBCH+vG56Vy+HjrtXxAkopYBWwVzTaCLMth1ePjtMdA5wXLfkXAYVSQiXwv
         htmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=P6HfmlM/cBK46V8lQXuLn9AZXlb7U0QMuTLQ12qwUZc=;
        b=pzQyBTBYL4w/2DHIMmZA+B6U8lUvtoQQvho8yWmt5tWYsvZHz2J4vr7yjQyvi/UvJi
         JInP7chbpY7u97skYDxwNrDAqIwEPVBpGSz7TtyDHwKWb5ThKT4TAdtji1SN5Um0+mNm
         qPqHonY8vj0eH5ZIprB8K+DP7X3yI+gkMj5aBqfn8XAPpesXwEcdYFDXx7ZUuCLl9dWT
         Gn00FjIcJ/E2eMzotoj2hBYfOTvz6xqhjbAA4xC4woMyauqaQ28LT+uq+YZXrj44A9YJ
         hupzEirMF2b+qpviyA+GrpAr4obS03rtOC8im3hN38gdGKdl8ygc18dNbGDIjuwrsc82
         1jWw==
X-Gm-Message-State: APt69E1cahLEz+whBwQQqPQOqw2iMnp+2JZk9PjIXa+zRRLRoBQAW3DC
        70j/yerOZyBoXQgKkoQo0yo=
X-Google-Smtp-Source: AAOMgpe2dP0aBnZUQCy1gE8a31Z4PpTEwqJg+HTFQnLHrXSd6aY3ISIZ9PExKVWcsSA5Zrmfhhmx9g==
X-Received: by 2002:adf:bc03:: with SMTP id s3-v6mr18338778wrg.211.1531211254464;
        Tue, 10 Jul 2018 01:27:34 -0700 (PDT)
Received: from [192.168.8.10] ([185.175.214.210])
        by smtp.gmail.com with ESMTPSA id w9-v6sm10186881wrr.77.2018.07.10.01.27.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 01:27:33 -0700 (PDT)
Subject: Re: [V9fs-developer] [PATCH] Integer underflow in pdu_read()
To:     piaojun <piaojun@huawei.com>, ericvh@gmail.com,
        rminnich@sandia.gov, lucho@ionkov.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com, v9fs-developer@lists.sourceforge.net,
        davem@davemloft.net
References: <20180709192651.28095-1-tomasbortoli@gmail.com>
 <5B440B6A.9090000@huawei.com>
From:   Tomas Bortoli <tomasbortoli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tomasbortoli@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <36523cc7-adec-9e61-d34c-dc00806c403a@gmail.com>
Date:   Tue, 10 Jul 2018 10:27:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <5B440B6A.9090000@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jun,

Intuitively, if you have a packet of size x and you read at an offset y,
when y>x you are off the packet. That's an out out bound read.

In this specific code when offset > size, the available length
estimation will fail as there will be an underflow resulting from
offset-size (it'll give a big big number) that breaks the out-of-bound
control put in place (if offset-size is a big big number, the asked size
to read will be probably smaller and therefore allowed).

These definitions might help:
https://cwe.mitre.org/data/definitions/787.html
https://cwe.mitre.org/data/definitions/125.html

Tomas
> Hi Tomas,
>
> It looks like pdu->size should always be greater than pdu->offset, righ=
t?
> My question may be very easy for you, please help explaining.
>
> Thanks,
> Jun
>
> On 2018/7/10 3:26, Tomas Bortoli wrote:
>> The pdu_read() function suffers from an integer underflow.
>> When pdu->offset is greater than pdu->size, the length calculation wil=
l have
>> a wrong result, resulting in an out-of-bound read.
>> This patch modifies also pdu_write() in the same way to prevent the sa=
me
>> issue from happening there and for consistency.
>>
>> Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
>> Reported-by: syzbot+65c6b72f284a39d416b4@syzkaller.appspotmail.com
>> ---
>>  net/9p/protocol.c | 12 ++++++++----
>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/9p/protocol.c b/net/9p/protocol.c
>> index 931ea00c4fed..f1e2425f920b 100644
>> --- a/net/9p/protocol.c
>> +++ b/net/9p/protocol.c
>> @@ -55,16 +55,20 @@ EXPORT_SYMBOL(p9stat_free);
>> =20
>>  size_t pdu_read(struct p9_fcall *pdu, void *data, size_t size)
>>  {
>> -	size_t len =3D min(pdu->size - pdu->offset, size);
>> -	memcpy(data, &pdu->sdata[pdu->offset], len);
>> +	size_t len =3D pdu->offset > pdu->size ? 0 :
>> +	 min(pdu->size - pdu->offset, size);
>> +	if (len !=3D 0)
>> +		memcpy(data, &pdu->sdata[pdu->offset], len);
>>  	pdu->offset +=3D len;
>>  	return size - len;
>>  }
>> =20
>>  static size_t pdu_write(struct p9_fcall *pdu, const void *data, size_=
t size)
>>  {
>> -	size_t len =3D min(pdu->capacity - pdu->size, size);
>> -	memcpy(&pdu->sdata[pdu->size], data, len);
>> +	size_t len =3D pdu->size > pdu->capacity ? 0 :
>> +	 min(pdu->capacity - pdu->size, size);
>> +	if (len !=3D 0)
>> +		memcpy(&pdu->sdata[pdu->size], data, len);
>>  	pdu->size +=3D len;
>>  	return size - len;
>>  }
>>


