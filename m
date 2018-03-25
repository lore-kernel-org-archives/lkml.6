Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2055598-1521974663-2-142058237825226021
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521974663; b=nvv7/OcM57t//amtehDEkQUCXWozdi0XJ/s2rIqmbWPDcAC
    1MfFAj20xbXDTWVYKGZpOkio2ta33PFfrwosNQOixrmreNi6+fQ1B3wX/Z89zwV9
    R4r4QB9t80ymL9p4178vEYCl2XkKf8aZdnmT1yrKh4/l3m+3KAYd8oQEgLIT5VAN
    ZXnvlEtVi7+Mh39jSG4RcKZ0eDmAyC2nooxUwF3Hw6qz6wNVHHIOf+h2/Bs0qVEk
    lopcFtoabEeEaMHuBFMi1kutweeZ1amPz+nANdWKblX9Uml8slmirK/YtrS7rQYW
    0eGlWkZDKRmJ5zdw/UTLjNr2Dymekt85P5zWWEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521974663; bh=Z
    3lV+eRRMo2thwRve1uvgkIR+HEaAag3JQP0LGPvRNc=; b=FFDyN+/moKZlhpn66
    084SLvmeURK/m03RnmAczbXF9dyXcjnxSSUIkkcZ+HkB67VygEhIqewIHQPPhXrB
    gv96ra6GuyBGyqR7EyI93TEtQu6MHxw/+125VXfT7ke2+0IPqabPxhIK+PiZJ6WW
    b3F5HsPzzPQeNWjPsFFklFYBoQNMHiQkfx6fDkOA0lcpTuikr22r29KPMQv0e9PI
    Yi+6jv81sRgCOFl+vEIU1vnFn86IpktqStW6aqpWCg8dlEfMN2psKWNCDguuYpkg
    qobHNLUtqNJeakjSzLuEQRiPM5GIML0Q3+/2JI+6X10V0rt5StvXL9I1lpK95CQp
    jfr8A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=qB4u/6PC x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=noygbHRg;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=qB4u/6PC x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=noygbHRg;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELtlprs8c/9RTQxH66yxD3lpP/JXh6aNt5jIZI8+kD01ltiiZV5Qy4CUM2bol+F25UN6g0nDcg==
Subject: Re: [PATCH v4] staging: bcm2835-audio: Release resources on
 module_exit()
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <f35d0f86-04b5-6edb-139f-4632edc493b3@gmail.com>
 <20180322213722.31822-1-k.marinushkin@gmail.com>
 <CAHp75VdYiySBzu99MYoBAZ8tORGP1R43z9d+=VRdktg+U=_ZDw@mail.gmail.com>
 <0524fb43-ed08-6c54-39ed-32bd96ccaca4@gmail.com>
 <CAHp75VfJjCHd5U1D22NANLCA1kAoTKLnDGSQPj3ay6OhKSoZxg@mail.gmail.com>
From: Kirill Marinushkin <k.marinushkin@gmail.com>
Message-ID: <4e473a93-317a-5777-7444-6deb105c8f66@gmail.com>
Date: Sun, 25 Mar 2018 12:44:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfJjCHd5U1D22NANLCA1kAoTKLnDGSQPj3ay6OhKSoZxg@mail.gmail.com>
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

On 03/25/18 12:33, Andy Shevchenko wrote:
> On Fri, Mar 23, 2018 at 9:22 PM, Kirill Marinushkin
> <k.marinushkin@gmail.com> wrote:
>> On 03/23/18 17:23, Andy Shevchenko wrote:
>>> After addressing above, FWIW,
>>>
>>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Seems you missed my tag in new version.
> When someone gives you a tag and you are going to send a new version
> (w/o drastic changes), it's your responsibility to append it
>
> I will send a new mail with it, so, this time no need to resend. Just
> keep it for the future contributions.
>

What is a "tag"?
I added in-reply-to this email, I added you as CC.
Isn't it enough to keep track of the versioning within a mailing list?

Could you please clarify: what "tag" should I usually attach in addition?

Best Regards,
Kirill
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
