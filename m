Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509F2C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED5E20BEC
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsXL5kWE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DED5E20BEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbeGLLOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 07:14:39 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35866 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbeGLLOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 07:14:39 -0400
Received: by mail-lf0-f68.google.com with SMTP id b22-v6so11468586lfa.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 04:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xaLCL8bQO7Lo+syLR/WCQIT5yv6W2GMvfIYddw13b+k=;
        b=SsXL5kWEU4iURf8VxFLwAxiPNa8QTLQ6N607ZywQ0HpgbvW5jyMGaIZZQ+cTbkjWlH
         EoD4FA1T5f17zN1fQOCYzd/2u+DiaxpnUo4xmXzZ+1b5whWWpKEKPcZADlMOu3h3WUcA
         +Qtlw36EkU6p//D3ei7ycY/MUjAc3SyGu6sieYOcZKouKR9oHr+A/tzogG/Q3+ipwdpp
         SoWHDlOu5kpfO2L32hjda2qnVdNyt8Aia6RYhW6KxcrVd7VO0AmgcnnzQbeVsayeZD3a
         ujsfiePLYeMIBlNWLcD02lu6kcl7UR158fxgKsCUExv9JAxu4Fik70QXCmrsDs4LWHM7
         /j+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=xaLCL8bQO7Lo+syLR/WCQIT5yv6W2GMvfIYddw13b+k=;
        b=Nj8BCT+3m94ZBGpA4ixhOxafTpb5cuKLEZxH3C9H98l5IKT0vKDjU6vjPpOPCuXdqS
         HRJKrS89hJF/iJRj36nD9t+Kng/h76k45rh+TyA7Mp50S/NBZLAqcmObPBnW679Uzz8Q
         WFPaMJobsvGcpVmqXqLx4v0mCKk8J2ONOvrkWbUS7bq7//rxYHWu6ebIcHRY6LfWHA7p
         cK1AIugiJw/lMOTW/gUZotP+BoFb0DieclYqalgQokTEAJpMIA3r1bH+1rOhg/qkEMCI
         ZicbI4UyQXSphnnMusoBaQ4Hp3bbELdgeLHjEo5P++yuDS5jBogXfP0QfeChkjBP+if0
         apaA==
X-Gm-Message-State: AOUpUlGBhgQe5UvJociM+hxgSA53GUU8AqcLH5fPHwshyGmqe0+PCIpV
        Dk024vzZzgB1EkEEDvNYTFk=
X-Google-Smtp-Source: AAOMgpeKMSz6bxZ4DdcrAl9Qtx/pxOUhSAMEDcrXKCCpAr9chQsKpkF1laqGE2ZZRgQlLiHzYKcH3Q==
X-Received: by 2002:a19:d754:: with SMTP id o81-v6mr1442334lfg.124.1531393533564;
        Thu, 12 Jul 2018 04:05:33 -0700 (PDT)
Received: from ?IPv6:2001:2012:22e:1b00:f2e2:9015:9262:3fde? ([2001:2012:22e:1b00:f2e2:9015:9262:3fde])
        by smtp.gmail.com with ESMTPSA id g3-v6sm6201247lfk.72.2018.07.12.04.05.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 04:05:32 -0700 (PDT)
Subject: Re: [V9fs-developer] [PATCH] Integer underflow in pdu_read()
To:     jiangyiwen <jiangyiwen@huawei.com>, ericvh@gmail.com,
        rminnich@sandia.gov, lucho@ionkov.net,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
        v9fs-developer@lists.sourceforge.net, davem@davemloft.net
References: <20180709192651.28095-1-tomasbortoli@gmail.com>
 <5B4565AA.6050309@huawei.com>
From:   Tomas Bortoli <tomasbortoli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tomasbortoli@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <512b9cc7-3b7a-3ee4-5759-0a27144825a8@gmail.com>
Date:   Thu, 12 Jul 2018 13:05:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <5B4565AA.6050309@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2018 04:04 AM, jiangyiwen wrote:
> On 2018/7/10 3:26, Tomas Bortoli wrote:
>> The pdu_read() function suffers from an integer underflow.
>> When pdu->offset is greater than pdu->size, the length calculation will have
>> a wrong result, resulting in an out-of-bound read.
>> This patch modifies also pdu_write() in the same way to prevent the same
>> issue from happening there and for consistency.
> I guess this case may happened only when server send wrong size to
> the client and then cause size < offset, or else I think this case
> will not happen. Is it right? Or other cases?
>
> In addition, the email should also send to andrew morton, because
> 9p maintainer already don't maintain the project, andrew can help
> merge the patch.
>
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
>>  
>>  size_t pdu_read(struct p9_fcall *pdu, void *data, size_t size)
>>  {
>> -	size_t len = min(pdu->size - pdu->offset, size);
>> -	memcpy(data, &pdu->sdata[pdu->offset], len);
>> +	size_t len = pdu->offset > pdu->size ? 0 :
>> +	 min(pdu->size - pdu->offset, size);
> I suggest this add two *Tab* lens.
>
>> +	if (len != 0)
>> +		memcpy(data, &pdu->sdata[pdu->offset], len);
>>  	pdu->offset += len;
>>  	return size - len;
>>  }
>>  
>>  static size_t pdu_write(struct p9_fcall *pdu, const void *data, size_t size)
>>  {
>> -	size_t len = min(pdu->capacity - pdu->size, size);
>> -	memcpy(&pdu->sdata[pdu->size], data, len);
>> +	size_t len = pdu->size > pdu->capacity ? 0 :
>> +	 min(pdu->capacity - pdu->size, size);
> The same as above.
>
>> +	if (len != 0)
>> +		memcpy(&pdu->sdata[pdu->size], data, len);
>>  	pdu->size += len;
>>  	return size - len;
>>  }
>>
>

This patch is not necessary anymore, the one I just sent fixes the
length validation issue.

