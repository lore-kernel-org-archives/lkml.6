Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1093326-1523010776-2-10424416714219133443
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  RCVD_IN_SORBS_WEB 1.5, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523010775; b=At0BltfSn5g/zxYiABjzsyyjDa8aerUoO+SWczbHQmzU5WZ9R0
    7EiLdVyOoD6BM8SX3Z1lTcnY8pYodxxME4mxa05OxepRmH67MLEF9rJnAuNymqqn
    4JDtbC8u8Bn0ujiBVkjoy87L8SR9YJLQOFCOb+Td5THMi3Hd4QTBW4itrr0XyylD
    gcWCJz22rAbXwZJbNFXR8SjKZ7ilM+6D/3uhau0i7jXZpAbU7HWN22Mrxuw1bWis
    yzsLoWZ7fei+HLnwrW50/ut4cl3bjg/+W129JGZDGrowWCRa9I90UaLqwdWiJrRl
    XTjAusMYQ1tEm/BrXuimaUek9gJ97Tl0v60Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=fm2; t=
    1523010775; bh=QMXVI6tT75ogSKjEG99LkOwdI7FS8pgPzKt3tO3yYcI=; b=H
    MgOxFDWMk28pfTSKpNGvwQP+pZpLu03iXpfDiqQVFJcirr0Q/+AtSmDpa1DX5ZbN
    txsCs2m91IkjxFF9wI7ZaZNMN5uW/dAEFkzDimxy7koo7MK1ObPRk4DZrZh+/yPC
    bJR11h4LaRfB19mnVC6Kt3gb0+oZWndrDQkg0GCaGkj4LTdw/FK101AOcPzpswgU
    LuNFwynGdUscZm10fpcZw7QPsObs0oRichkAxOsqVUjOCpPJfGk4QTiN8a1VmgD7
    TCQiqIzgCSsEMQIYLhGv5vm14mfB0kJdS8rMC+jdFwTRk5CW7FhHPZdGeWmhQsrT
    3ZzTC6x6YHGQijqvgEtyg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ZDhpJkIB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SSiZ8Q1v;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ZDhpJkIB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SSiZ8Q1v;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIbSt99uAdx6qoGk/kAKBUXOjP4mi/Yf+nzkRdtRebrG2QDcwOlTVeYrtQHsy6+32wgidLrpH7GHdXk2hRUhFYDynCV7A0BUOduIp9+gVD5L+3RzKX2Z
    iep/UAFeeWew/j8uaDeCA4J9cTaRzFbwwsy19fhmHpfEf0iG78U//LyxP4/WINbvbe4qlVdKQeU70JsKRk3hasqnF8DqJK4JZDqt92chWQKaBGFrbh5jnuE8
    tBHRcfkHMiBdeKYS6DeONA==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=HEJfwf0tOL4A:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=Sv9GXSi2Xp36V-D6HJsA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4+by86reoUfSPS2YYvJ75msusiMcmBnQUwF+UP2Fa4W644jhZeQA3diNwSxj/WjirtHc/S0aA==
Subject: Re: [PATCH v2] staging: greybus: Fix warning to limit chars per line
To: Viresh Kumar <viresh.kumar@linaro.org>
References: <20180406100953.GA12400@stallman>
 <CAOh2x==TphhhoPVSFdFmFCQr4Ag_+tMzOOW3yp-e++SQcrWggA@mail.gmail.com>
From: Gaurav Dhingra <gauravdhingra.gxyd@gmail.com>
Message-ID: <1bb8c642-a2ba-0c8c-cab9-b4ea408eeedb@gmail.com>
Date: Fri, 6 Apr 2018 16:02:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAOh2x==TphhhoPVSFdFmFCQr4Ag_+tMzOOW3yp-e++SQcrWggA@mail.gmail.com>
Content-Language: en-US
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: driver-dev <devel@driverdev.osuosl.org>,
 Vaibhav Agarwal <vaibhav.sr@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Johan Hovold <johan@kernel.org>, Mark Greer <mgreer@animalcreek.com>,
 greybus-dev@lists.linaro.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,


On Friday 06 April 2018 03:52 PM, Viresh Kumar wrote:
> On Fri, Apr 6, 2018 at 3:39 PM, Gaurav Dhingra
> <gauravdhingra.gxyd@gmail.com> wrote:
>
> Why did you remove the commit log? You had the right one in v1.
>
I didn't realize that it would be necessary to add it to this patch set. 
I thought you guys will do squashing of the commits (v2 and v1) and 
using just one commit message (and will take it from last commit), seems 
like I was wrong. Now I've understood it.
>> Signed-off-by: Gaurav Dhingra <gauravdhingra.gxyd@gmail.com>
>> ---
>> Changes in v2:
>>      - use correct format for multiline comment
>> ---
>>   drivers/staging/greybus/audio_codec.h | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/greybus/audio_codec.h b/drivers/staging/greybus/audio_codec.h
>> index a1d5440..4efd8b3 100644
>> --- a/drivers/staging/greybus/audio_codec.h
>> +++ b/drivers/staging/greybus/audio_codec.h
>> @@ -23,7 +23,10 @@ enum {
>>          NUM_CODEC_DAIS,
>>   };
>>
>> -/* device_type should be same as defined in audio.h (Android media layer) */
>> +/*
>> + * device_type should be same as defined in audio.h
>> + * (Android media layer)
>> + */
>>   enum {
>>          GBAUDIO_DEVICE_NONE                     = 0x0,
>>          /* reserved bits */
> This looks ok.

Do I now need to send v3 with these exact changes, since I missed the 
'commit log' in this one?

-- 
Gaurav Dhingra
(sent from Thunderbird email client)

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
