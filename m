Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3477952-1524594948-2-13969908501119285496
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524594948; b=G9nu5asIdkUXXNIw2p7d/fcU28Yt0Vu0QgO1DDYFsIy1q914Xf
    kK47IYQhYv931DfId3+qjN2mgrVgKABQM77JRbAyZNJ3oOoeYLzJ6b8Ncbbn6A/L
    dbOOY6esxofRwh4PYgV56ZQwmJ/ut+zGNipbGyhrsxAq7fcssnNa2cNctiVO6lrC
    021FLvzrFrmYAWRw8tBZ6IEPtpe1b0DRHlSgArYshk9iVq5+Ok1aCqVTDWoGTgc3
    CsXFs1RfD/OVHjs9Ew/ZK4Xb2nteP3Q5yAcyniwYKa5Wv0Qk2HXR1EQxmqmZnDzm
    9S/s6dox1qVlDXJWIU46ccIUEnvGk2vjg2Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524594948; bh=NxTYd
    lwt3PR1E4wATeWoKnvWWnTNGbaoLOt6rt5dciQ=; b=SI/WGzRec+xg0HRWTJvJs
    oV/Y3BBTWTshnVvybst593rG5nkNBbIVrRtEYuF0JXBmuba2uhQctRARnXPQqiQP
    T/TnAGlTx8PENSEXapynebi7K+4ssLw/BANQYy4eYEEjVKGhJT5R6DpZ+vHT8E6Q
    MpctDQ8XASo57wlO6PRV1WtJ0FRZN8ZPsGSUw0Uz35FHrDJtyDcs/HgoQ4QPKvGf
    FR12am/+Praq55x2av4Mfgb95pZYoyv3Yyc/1/K/N24t2qZJd6ARnoNAz4AsELtV
    rCVfyKEKS1SBbXDXKa6/5hxoT0lKafi2kfkNBmJlmQvA0bCxn6Q+WIuu1PKcI4SE
    g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=GYTbgO7Q x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CM0OShrG;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=GYTbgO7Q x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CM0OShrG;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGpCWLUsJB5x4ve0n74pM7RcUynWB1ZRhlbWdCkxjTCKQOZHXApHb2w/gKXgsu137O2wSRJz+BMcxTg2OGO6joQW1Tisfd3+0R5GBx0W5CQZSaTcqjUW
    lQt5hnKGklfwhIl2CS/XbctZf6kvQPa95/LxYyVh92wvKs19Ssc3iItg/kDgcHcru9DANeK8EDY+8/juAhelgrROUwPkR/Z8mj0DNKQ/FcJda6uCR5i8Ob6i
    ZuLJqJwmLc5JTRu6ZOf1Ug==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=fbV3Th2LUxsA:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=Pupt36HRvj6XKI2kbAsA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZpEER6nqeJCiz0+jo7oh2WeQInv4fPe2qctMcUUSWOqU6jvqfmpD2uAI2dg5JDPkO/LhPdCXhlOjVceDnahXPA=
MIME-Version: 1.0
In-Reply-To: <9e4fc4a0-370b-9101-2809-4040de58553c@gmail.com>
References: <20180424071618.GB17825@kroah.com>
 <20180424074459.7215-1-k.marinushkin@gmail.com>
 <9e4fc4a0-370b-9101-2809-4040de58553c@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 24 Apr 2018 21:35:40 +0300
Message-ID: <CAHp75Vd=_7g4N6b2Mkw1dLOao6gFsQuhzO7-9d=1kjyX0kgMAQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] staging: bcm2835-audio: Disconnect and free
 vchi_instance on module_exit()
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
 Eric Anholt <eric@anholt.net>,
 bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
 linux-rpi-kernel@lists.infradead.org, Ray Jui <rjui@broadcom.com>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 9:27 PM, Kirill Marinushkin
<k.marinushkin@gmail.com> wrote:

> @Andy
>
>> AFAIR I gave you a tag and you again missed it.
>> Before sending anything just check twice if all prerequisites are fulfilled.
>
> I think you mix it up. This is a new patch, you didn't review it before.

Ah, okay, send new version as a separate thread and if I have time I
would review it.

-- 
With Best Regards,
Andy Shevchenko
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
