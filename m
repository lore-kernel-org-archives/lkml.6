Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4106523-1520976229-2-1342111067964188399
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES roen, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520976227; b=CE/f+6nEG1ifcBiyvC/N2MrNZtshh/RH2cgD643ZK7aiD4d
    vwSiyYgDUNxNQDEHI+x8Nrl9Y5qt4dEh1V4ARmzdMMUxWb5jR0UGp5yTf4k+2m0P
    apqEoAnXSqcVuXVHRt3N7sOIP8BDxayojUMyIJamcH0TFT5N3EY+UTFs4cU0ta3/
    zQF4zSrpnMHSAby+xZcZu8tDqY/hc/xetrmTkPs4asxStu7MiFmbyr+ostAaF/mv
    P3sxiZoT88k9S9HemN0P4H3VSUwojedt+Hy7rTNVahyUw+h1QSYOc/BaKjHwfHed
    1r/En7DGhFrRZ3JIuWLI58aEwmUgQvuvoQ3XJoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520976227; bh=/
    xhC6MRxwDvumWXHfiQlNblpYkBTxaLtIcDM7l/eWwE=; b=tWUBHAEepIbt3WKcM
    bS9XMwr13qNPW4PqPXH5y6nXmHVKPdxr9uq2weJ7MVL/9iLiL9p8l0x5mCvCTBYf
    HrRciSpVUiWLzaDjI9l6n9RfZJfyX+RJp46KNPWwsc37sqHRqeYG3znjOXPt7T8/
    zWu4fyIaMWQgNFQr2vezehWq940crPtX1qcnFLkBPJGanumiaJdLpktpKzzOI5FD
    ZmCaFOoRZX1QamNiNdAot/noc8j9EhyiTXFCVDQR3cIOyOdaTnt41IHVjkBg4n+F
    9lT/+SuhyayJAWByy3/+yYgPq9nl1iPH0LnUKqnaEJ00LCd1qWeHJ4PK/8h91L/v
    7RBEA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=IVtvChsC x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=VDqlqpaM;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=IVtvChsC x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=VDqlqpaM;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELt5pPkZwQcToj4+NN19gqpjsQ15AHBFptwXw6YV4vELVNcUIj38HlNzzwxS9Hu6m/xmvpM8M1n0KSnS1rXZ76M=
MIME-Version: 1.0
In-Reply-To: <20180313193414.11535-1-k.marinushkin@gmail.com>
References: <63ee611d-9fd7-a67a-45aa-229cc4a83ed2@gmail.com>
 <20180313193414.11535-1-k.marinushkin@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Mar 2018 23:23:38 +0200
Message-ID: <CAHp75Ve9MRAgSu74Mzr2defd84umyeKpfvX51-Qhk4SvLx3Qng@mail.gmail.com>
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

On Tue, Mar 13, 2018 at 9:34 PM, Kirill Marinushkin
<k.marinushkin@gmail.com> wrote:
> In the current implementation, `rmmod snd_bcm2835` does not release
> resources properly. It causes an oops when trying to list sound devices.
>
> This commit fixes it.

Nice catch!

See my comments below.

>  static void snd_devm_unregister_child(struct device *dev, void *res)
>  {
>         struct device *childdev = *(struct device **)res;
> +       struct bcm2835_chip *chip = dev_get_drvdata(childdev);
> +       struct snd_card *card = chip->card;
> +
> +       snd_card_free(card);

> +       dev_set_drvdata(childdev, NULL);

AFAIU this is done by device core.

>         device_unregister(childdev);
>  }

> +static void snd_devm_release(struct device *dev)
> +{
> +       struct bcm2835_chip *chip = dev_get_drvdata(dev);
> +
> +       kfree(chip);
> +}


>  /* chip-specific constructor
> @@ -122,7 +136,7 @@ static int snd_bcm2835_create(struct snd_card *card,
>
>         err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
>         if (err) {
> -               snd_bcm2835_free(chip);
> +               kfree(chip);

Do you call device_register() inside snd_device_new()?
In this case you might need put_device() here instead of simple kfree().

>                 return err;
>         }

-- 
With Best Regards,
Andy Shevchenko
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
