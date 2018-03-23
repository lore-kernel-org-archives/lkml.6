Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1673992-1521822242-2-16284166129396231531
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521822241; b=JizxkBzXAAxbwvfMk49MeAYyQ98AtBMp9774iQ5CXzdHaSF
    noxFLFGixpfWSPTaWe27LzI3T2l4ME/U1YunDQPAPN0437XEiYTAyrIwi3FMIpeM
    Z435lUdmLMaVm41TB1NCTX67Bj1S78fACA84YkuLwtBDeMIVuTRUEq71wOamauI0
    jXvrVqFvSgacaP2B8byGMxdyg1zNbk7NjN3gGwIy9Qq0hkPYRpvRVLOSJWRWgJwa
    r9QmY+2zrlPb5EX/GSZ807PDnDNbtevh4TEwFS7/ozcGhbJGESotgAp45smk7haM
    omPehNVQAOxpf4TIYjqlJtLPkGo2Wl4EJgP6LAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521822241; bh=r
    EMwd7EaqXmf1rKHq/9SCsSywxPv2keEH1QKTFHwvHY=; b=Nh15qywJ7m+mpY2RL
    sm0N5QjTtmKjsTz0+A4fUl1ZG3otxakstrxhg5PLilwS9wmmYat24ewoskkDBLQE
    YK30qvBunD6kTTrJxMoJsmBTNF/3CtBiXsg7XTxJoWFHQT5PSQORsdpijjszj6I3
    ZQjcJAL5E4+/29SMirmY/+ZqWJfRiVHx664r9FI3+8y842/genppbDDONMP1A18f
    MCYnCmmhYmeBn+Q2iov8WoSrb1jXTzNpy7rsdfuNpAuZXU6C9s8au6Q9uioRVPEv
    wfBL2tKgzUjKI0nfK7artIuuuV/MgH/Lz5VibsGDDtkLFSNLGP+MObYteK7gRji6
    ltlNA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=oinqVget x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RFdcW4QQ;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=oinqVget x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RFdcW4QQ;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4+TAlkrlGa36AXg2SljJV6+OF6OFDxVBajqAZH7vdA2QLGh7HBwR85tHPn8qo00/GjgcVNcLiNANEno/4xmPnc=
MIME-Version: 1.0
In-Reply-To: <20180322213722.31822-1-k.marinushkin@gmail.com>
References: <f35d0f86-04b5-6edb-139f-4632edc493b3@gmail.com>
 <20180322213722.31822-1-k.marinushkin@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 23 Mar 2018 18:23:54 +0200
Message-ID: <CAHp75VdYiySBzu99MYoBAZ8tORGP1R43z9d+=VRdktg+U=_ZDw@mail.gmail.com>
Subject: Re: [PATCH v4] staging: bcm2835-audio: Release resources on
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

On Thu, Mar 22, 2018 at 11:37 PM, Kirill Marinushkin
<k.marinushkin@gmail.com> wrote:


> +static void snd_devm_release(struct device *dev)
> +{
> +       struct bcm2835_chip *chip = dev_get_drvdata(dev);
> +
> +       kfree(chip);
> +}

> +       device->release = snd_devm_release;

This is not devm function, so, it would be rather called
snd_bcm2835_release().

>  static struct snd_card *snd_devm_card_new(struct device *dev)
>  {
>         struct snd_card *card;
>         int ret;
>
>         ret = snd_card_new(dev, -1, NULL, THIS_MODULE, 0, &card);
> +       if (ret)
>                 return ERR_PTR(ret);
>
>         return card;
>  }

Same here. You removed anything related to devm here, so, please make
function name consistent.

After addressing above, FWIW,

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

-- 
With Best Regards,
Andy Shevchenko
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
