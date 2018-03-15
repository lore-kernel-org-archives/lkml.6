Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3494850-1521093425-2-2554031632875309037
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521093425; b=K6RY5aCg0JQ0fuGxV3g1e2W31DU4vv7OTc3YcnBffDV6DPT
    V19RYtqvCNyfdbVbznfGLas95VK42exufjV7HJjh3K3mVVi3+39AZynlGcg/IbRO
    FS1sjovG6WjKTjanWmTg0v22vn0b3aMeZ4Vf/1CF8SkTBuHQHGd7xOQuqkEpru9k
    NiSbg8Rb3yH9gqojZa0w473ItJkGtlV8ATsx7Vo1EAouDghTEXqVsyo+yR/XAUxC
    zTgMqujFokLnwzhIk9X1T8EV5wNfDlYs79IITPQZ2JU3PJfaFVj3q2851I5U4zUA
    zdY1RObUCGYWungZmyWF1rN9tVAJmubrVaqu/Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521093425; bh=k
    Z43ukufH5JfC+FmCZ23kIQ1mxGkXXVXFa55P0tMOgE=; b=o9rzzpEhIjRFynz8V
    LMLTtm+SqJ2kMAWq/P5DrhAZbB0IGb/xFRoHUv0P7P3oTO0FTHHLdD6Okj3UWpXD
    Q1yb2JVWNjlFhWUGBolaAX3fi9xeT2AfBSYXnw0Ya/iXyVbzmCBgMrDlar6aB6aZ
    fQR1/W7Gk3MsqPy4MHnsBRXVNrG5vzcYitWMU2DcmNadj78heegxENZ8NvCPhkfT
    T9c3rXJb8d2U1OPaOSuj9GrKZOX8QWRfn9pBJUgYihYew+3FcRBQOCcXRIZrDAjN
    azAuPOPI45QXCGO/zzwQOfoexN8+rO/296OgQVOxTVZ0R4awWSSJN4AnrHNyaZHG
    MKqTw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=nAjt1ylp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=aGTjA1VR;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=nAjt1ylp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=aGTjA1VR;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELtbtlhBegSjJeXjI//ZjPv0uSScaPaftltxr40RoCuwYcuTcYRYklK4OiivHM1TeaTX/WNL+A==
Subject: Re: [PATCH v2] staging: bcm2835-audio: Release resources on
 module_exit()
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <63ee611d-9fd7-a67a-45aa-229cc4a83ed2@gmail.com>
 <20180313193414.11535-1-k.marinushkin@gmail.com>
 <CAHp75Ve9MRAgSu74Mzr2defd84umyeKpfvX51-Qhk4SvLx3Qng@mail.gmail.com>
From: Kirill Marinushkin <k.marinushkin@gmail.com>
Message-ID: <1a59a938-0381-49f4-dfd9-c7a52bdb0eae@gmail.com>
Date: Thu, 15 Mar 2018 06:57:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Ve9MRAgSu74Mzr2defd84umyeKpfvX51-Qhk4SvLx3Qng@mail.gmail.com>
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

On 03/13/18 22:23, Andy Shevchenko wrote:
> On Tue, Mar 13, 2018 at 9:34 PM, Kirill Marinushkin
> <k.marinushkin@gmail.com> wrote:
>> In the current implementation, `rmmod snd_bcm2835` does not release
>> resources properly. It causes an oops when trying to list sound devices.
>>
>> This commit fixes it.
> Nice catch!
>
> See my comments below.
>
>>  static void snd_devm_unregister_child(struct device *dev, void *res)
>>  {
>>         struct device *childdev = *(struct device **)res;
>> +       struct bcm2835_chip *chip = dev_get_drvdata(childdev);
>> +       struct snd_card *card = chip->card;
>> +
>> +       snd_card_free(card);
>> +       dev_set_drvdata(childdev, NULL);
> AFAIU this is done by device core.

Maybe you are right. But I don't know, which function in the device core does it.
It is safe to have this line. So, I suggest to keep it.

>
>>         device_unregister(childdev);
>>  }
>> +static void snd_devm_release(struct device *dev)
>> +{
>> +       struct bcm2835_chip *chip = dev_get_drvdata(dev);
>> +
>> +       kfree(chip);
>> +}
>
>>  /* chip-specific constructor
>> @@ -122,7 +136,7 @@ static int snd_bcm2835_create(struct snd_card *card,
>>
>>         err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
>>         if (err) {
>> -               snd_bcm2835_free(chip);
>> +               kfree(chip);
> Do you call device_register() inside snd_device_new()?
> In this case you might need put_device() here instead of simple kfree().

No, from what I see, device_register() does not happen inside snd_device_new().

>>                 return err;
>>         }

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
