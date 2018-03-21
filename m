Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-14983-1521644610-2-11100700185556869730
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521644610; b=SoFXyJBhhsbmfLVQfjTlaQgwIbUawS6/gW0rVP9eaN8KDd+
    U3BggPhtq7OwHMfJm/WhJ1K5zRFv+mV90z9SNTgXmVLfRkNVCUo/ShtNFpmvcEdg
    R8TdQHhPBa+x+ZxSSDnVWcXapjLgY62xl0UWcwOIkHsEDzqUedDZKZaNAuB+tCj8
    lC35PpF6hkKGllhMjD89CHTAeD38DqudW7hcRqC6z7oqekcHfpV/818fz7Ytclv0
    O+tWkfJLkmmo7yUcLctOzC7XrhWufriORJmU1p5lGb045H6/66+iFZvkR3JxikQT
    1UD8r6h/7QwRBHweLPlLt/KSaxVyEN/pQraCVAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521644610; bh=4
    pWKMwk/tEXvgpLpExmzxkToNj3tAyjj5TLlobtPbhs=; b=HKc6tPG93NEl/wuMn
    bdIzcFqruEjbxfGll8UJBwEuXRwiZpjpjs5pvBcMOkSA/ESdxAES7sjK0jNWFT+g
    77pi1yCjXMb8M7eb3q7Zw/zV39+ANvVAZcvf58oM3n+GZLINumRX5UiAgd3sKNe/
    R1YmO697ekVwowcG9lV0F2RUDPJLKs+bYE4sC3spDKTh4r9UJNPZkGRa7VSoukxj
    2m4J78OEUfuUYAxvY4iWAA+sG8KKkabHs8CbyvuIBVVwyunrAVz9suaCJDZOyt9g
    2BJKIJJ2OWQM573NaEGjjjRDiXscj9IrsxHyz2X0zFjxx/CfbolpdX52xTyHcL8+
    0b9WA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=opk35qIK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=XH/EGqaF;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=opk35qIK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=XH/EGqaF;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4/kAItRJK2Qp40hMInIKtjkRLpc8bi5ioTNzSXKd1y2kAjDs4tnNDidcbV9K4lL0nCd/HHNtPQKkwilRBjEbKg=
MIME-Version: 1.0
In-Reply-To: <1a59a938-0381-49f4-dfd9-c7a52bdb0eae@gmail.com>
References: <63ee611d-9fd7-a67a-45aa-229cc4a83ed2@gmail.com>
 <20180313193414.11535-1-k.marinushkin@gmail.com>
 <CAHp75Ve9MRAgSu74Mzr2defd84umyeKpfvX51-Qhk4SvLx3Qng@mail.gmail.com>
 <1a59a938-0381-49f4-dfd9-c7a52bdb0eae@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 21 Mar 2018 17:03:21 +0200
Message-ID: <CAHp75Vfwpwcc6_somOcSMYwmBhnkSwR7vn2piAZwA1GFkGAJRw@mail.gmail.com>
Subject: Re: [PATCH v2] staging: bcm2835-audio: Release resources on
 module_exit()
To: Kirill Marinushkin <k.marinushkin@gmail.com>
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

On Thu, Mar 15, 2018 at 7:57 AM, Kirill Marinushkin
<k.marinushkin@gmail.com> wrote:
> On 03/13/18 22:23, Andy Shevchenko wrote:
>> On Tue, Mar 13, 2018 at 9:34 PM, Kirill Marinushkin
>> <k.marinushkin@gmail.com> wrote:
>>> In the current implementation, `rmmod snd_bcm2835` does not release
>>> resources properly. It causes an oops when trying to list sound devices.
>>>
>>> This commit fixes it.
>> Nice catch!
>>
>> See my comments below.
>>
>>>  static void snd_devm_unregister_child(struct device *dev, void *res)
>>>  {
>>>         struct device *childdev = *(struct device **)res;
>>> +       struct bcm2835_chip *chip = dev_get_drvdata(childdev);
>>> +       struct snd_card *card = chip->card;
>>> +
>>> +       snd_card_free(card);
>>> +       dev_set_drvdata(childdev, NULL);
>> AFAIU this is done by device core.
>
> Maybe you are right. But I don't know, which function in the device core does it.
> It is safe to have this line. So, I suggest to keep it.

Please, remove.
If you don't know, perhaps you need to spend more time on doing homework?

% git grep -n -w dev_set_drvdata -- drivers/base/dd.c
drivers/base/dd.c:469:          dev_set_drvdata(dev, NULL);
drivers/base/dd.c:499:  dev_set_drvdata(dev, NULL);
drivers/base/dd.c:902:          dev_set_drvdata(dev, NULL);

Last one is the point of your interest.

-- 
With Best Regards,
Andy Shevchenko
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
