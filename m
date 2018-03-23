Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1990790-1521832903-2-12383381878930389308
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521832902; b=DBABVqHyY4kjJP+BaQaWXI2WZF6Vm20vWm7SafZ3X6r1o2G
    hJYqfHm23kl3hpYD2XiHcRBdmnihjobpvw7PrY0sy0gI/yzrZVovP7BXnKwfoJ38
    ORAmp0LHSqEbymVPZ7w2IfCrEOPFZbrurjggKZlPmVDVbzTWBYTHBlMrF6kt2iah
    /Cd2z+4X3NRbG5LUAbPXb1eqG/85nbO/eJipNJEvXbNF8MypPkl1tS9TyNnl5t6G
    rs9uiDwTvWUEZBR9sGe+Oyf6+5MSDBpJt8Pq4+UUJyEIqY/ejQMMNE0X6OqDJGiJ
    eBqxMOkkqPtX53w+T2NjzVm/ggQ/PUc9f1sPT3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521832902; bh=l
    e0AHXRnB9ev5Jp5UiDkQ3V4iXsPzU5HqAzEqRaZ8Is=; b=Mtt/DIFl6IKZqw53O
    DI198yLY4kKzxPGLBZmiynb7R9t2V6rf8hLesHQwkLim/1xHoe9YNUMsEuQQnlJB
    KnD/PDKfyWZ1reYwzuI9GNvZBdgJTP7vGFq9oLtTDddRDlLFLCmOijlA5RjjJoTQ
    KHGi4T79uatm4BunxF1hgGL6WnH3crLhchxPZe51DpP1DJR9abAZuMSnK0orqJ3M
    Kbc/fXA73kUJZPi3xz8y9zYeBOk7Nkw0jq6eHZ7vWrcJBSn26weBgaRUbM/Pu1Cw
    IahqvgnQP/Yv0H6SX9xaV0OeSixxB4OqXqLa7bZHpLR1vztaNt03SBLgByVXvk7C
    SkFJQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Wu5IAVBz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jtVV8waF;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Wu5IAVBz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jtVV8waF;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELtd6NxPR+J3wdL1JFaaU9NOY7x1f2jcz29xIyK8tKwlZEEUDRxWkZKOLvD5a45Hea+QPt0quQ==
Subject: Re: [PATCH v4] staging: bcm2835-audio: Release resources on
 module_exit()
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <f35d0f86-04b5-6edb-139f-4632edc493b3@gmail.com>
 <20180322213722.31822-1-k.marinushkin@gmail.com>
 <CAHp75VdYiySBzu99MYoBAZ8tORGP1R43z9d+=VRdktg+U=_ZDw@mail.gmail.com>
From: Kirill Marinushkin <k.marinushkin@gmail.com>
Message-ID: <0524fb43-ed08-6c54-39ed-32bd96ccaca4@gmail.com>
Date: Fri, 23 Mar 2018 20:22:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdYiySBzu99MYoBAZ8tORGP1R43z9d+=VRdktg+U=_ZDw@mail.gmail.com>
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, devel@driverdev.osuosl.org,
 Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Eric Anholt <eric@anholt.net>, Michael Zoran <mzoran@crowfest.net>,
 bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
 linux-rpi-kernel@lists.infradead.org, Ray Jui <rjui@broadcom.com>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/23/18 17:23, Andy Shevchenko wrote:
> On Thu, Mar 22, 2018 at 11:37 PM, Kirill Marinushkin
> <k.marinushkin@gmail.com> wrote:
>
>
>> +static void snd_devm_release(struct device *dev)
>> +{
>> +       struct bcm2835_chip *chip = dev_get_drvdata(dev);
>> +
>> +       kfree(chip);
>> +}
>> +       device->release = snd_devm_release;
> This is not devm function, so, it would be rather called
> snd_bcm2835_release().

Ah, you mean "devm" in the names. Now I got it.
Agree, I will rename it to "snd_bcm2835_release()"

>
>>  static struct snd_card *snd_devm_card_new(struct device *dev)
>>  {
>>         struct snd_card *card;
>>         int ret;
>>
>>         ret = snd_card_new(dev, -1, NULL, THIS_MODULE, 0, &card);
>> +       if (ret)
>>                 return ERR_PTR(ret);
>>
>>         return card;
>>  }
> Same here. You removed anything related to devm here, so, please make
> function name consistent.

Good, I will rename it to "snd_bcm2835_card_new()"

> After addressing above, FWIW,
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
