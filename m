Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1839758-1523431057-2-17545563695145551315
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523431057; b=PQ8YceL/mLAg1+K+vQHxbphwjnyXltSdNRxL+0tXXOaHTRSKU0
    D9brn9I6aAQ7QMC7H9bfRPZXswwR94qL3j2XWRcfqhuKyA2NQpCF/rjJhFl/DXuH
    G96is+pnZTVDhSWOSrLkDEwH5BnTJxV0JHJqDtqOgZ6R5Wtsr7QgFqvV+S2J0z9Z
    Y92hywvZxdrjZh4VGOYWpSZQxlYzIiXvbABnYjJnLbcq6TCrmydcW9Isos7IzFgb
    cFoXirJw1jb131CdIJ+W7kdGdlgzUrLYaWjs+nIyHZg/o9BzAG7GUCqHyT+O9B1R
    cRPU+GZZ73Dsvj2GQfeBXKiMpgny4xVfFDJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=fm2; t=
    1523431057; bh=82Mw3nOWkH/EgEyt2ThOVu+PxGFfjmk9gRObQkU78pU=; b=f
    qZ2N1IlmgOMytibsFi4mm+lppLAAExhIZzzgWQvIIW/WCbn4E4X16vSo2/ZTdzxt
    NBJ/a6zzrE1kGIaCSMYR3xJ/WBBgVKCV72sAyLE00b9f3i4lew46nM9RirkY1QTA
    RGnAgk7HnLSIa21uhSog2KCmk14lfW7QL40+dXtcv1eVNrSSF5+w76TTJhv/scFS
    5Rke4ffzSpM+lfY/9Ur4g3iJR5foBxkFfmcYM+e01UafttLU6c4Hsl5RFbCd1/gk
    Weh+eUyMGicq6Xd6AA1IYQ2IDY/ZpoBjJvCgE/+staGzaankxzRQngaufMLvHmF6
    GSglXQ937fzvdn+/DlYoA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=rY229fc9 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tzatrEQU;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=rY229fc9 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tzatrEQU;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNnmvFOdHZv+alMLad103mZDEolsMX1vb0mQeuHd3K6K1Kq5aIVREAU0TEKrfOoiVHpADEuesZL5r375sNP8wVq0Rz/UrMLah+o0FECG3nt2+b8H04M6
    iXhhHosd0m8yh3zgaQjDAjOGHriAdA2DUj1boUMd7qb8Z681mBjEejozN9JUMy6FP99VvPWs/cK9tEoE6AvqXsQkHcUAcqaC8GroZKxALZ8Eaor+DhljZuJ3
    h1gX75HkkrH4R3+glGxCpA==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=tmjX-nCzVX8A:10 a=xqWC_Br6kY4A:10 a=4_-BN3WEXhEA:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8
    a=_25IKoWP_ZaVYd19-QQA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4+dviikwU2kiFl3KJWlrwKss+31iwXxDXQutdljrq/ZGOZITGwTq+TeFcpeIUnF8xpUDU+8Lg==
Subject: Re: [PATCH 1/2] staging: irda: Replace mdelay with usleep_range in
 stir421x_fw_upload
To: Greg KH <gregkh@linuxfoundation.org>
References: <1523410174-1553-1-git-send-email-baijiaju1990@gmail.com>
 <20180411064135.GA28354@kroah.com>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <d65d1116-7ffd-e289-5379-cc052782700d@gmail.com>
Date: Wed, 11 Apr 2018 15:17:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180411064135.GA28354@kroah.com>
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
Cc: devel@driverdev.osuosl.org, samuel@sortiz.org, netdev@vger.kernel.org,
 johan@kernel.org, linux-kernel@vger.kernel.org, arvind.yadav.cs@gmail.com,
 davem@davemloft.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 2018/4/11 14:41, Greg KH wrote:
> On Wed, Apr 11, 2018 at 09:29:34AM +0800, Jia-Ju Bai wrote:
>> stir421x_fw_upload() is never called in atomic context.
>>
>> The call chain ending up at stir421x_fw_upload() is:
>> [1] stir421x_fw_upload() <- stir421x_patch_device() <- irda_usb_probe()
>>
>> irda_usb_probe() is set as ".probe" in struct usb_driver.
>> This function is not called in atomic context.
>>
>> Despite never getting called from atomic context, stir421x_fw_upload()
>> calls mdelay() to busily wait.
>> This is not necessary and can be replaced with usleep_range() to
>> avoid busy waiting.
>>
>> This is found by a static analysis tool named DCNS written by myself.
>> And I also manually check it.
>>
>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>> ---
>>   drivers/staging/irda/drivers/irda-usb.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> Please, at the very least, work off of Linus's tree.  There is no
> drivers/staging/irda/ anymore :)
>

Okay, sorry.
Could you please recommend me a right tree or its git address?


Best wishes,
Jia-Ju Bai
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
