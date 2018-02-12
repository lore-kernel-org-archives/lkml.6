Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1572815-1518446286-2-1629209288075826181
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.8
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  RCVD_IN_SBL_CSS 3.335, RCVD_IN_SORBS_WEB 1.5, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518446286; b=Vt9fL4HbQQCaus03I4MfBcnW5bQI6kxH2DXokbPbUBuUcwa
    I4UyWoWZKg67+BWUvggybJ7AYxCvQjN8BbOvhguoDkaAYmP3JdLrKQi5D7vEXwFD
    TFMpfN39zkPwQ/FYV6pyVduWwC/IYBk3xQ3zB3OXSduGj7qtWTsMl2e3ccflwYjo
    96FW/A061WzVwZfklJ/tiutkOw8sYwyDNL4dWfISU7CqyowRdwxvRdk+BqqKjcE5
    sSotj6FH5EhQ3IHkxZAN5Oo7XAO/hYDG7Km8cPZIrx9YMrTyX5bODamETX0FI13z
    Z7+2wfAprzgoJDpJRK/aPT5yBptCAixknoVNatg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518446286; bh=i
    W9I0cvIu31gRzzs+F8NT7nAL6uwwg+v9S+hWMggxnE=; b=czrLTbyJFd9WAkkte
    vJj86uAUw8k4OP6iKcQ5CwQaKPHLBCLFE7Ba7rVvKNG573s2ZyrOk/Qu2v9VNZMa
    DMBGKkvMzW0zOpao3/q7a4k4ZHzRaeDQ/W/da95WxOqfit8nCASQO/iva03uQbJq
    auMj/eHlhhKEerp2JUgXUOwI7IGw8TsCYNqIsIC6Nw/63Dy4rOAueCzlxtcEHFvk
    jjXMAbdoY5NfVrcqbXlAIku4gA0WH2fCuh3+yIRLRlLVp/jC85e+EDoMHQqxfCZL
    bzcWZKUJCK3Li9H3ql8+a6eBrJS79N2Up86vI4yzQDa8lCQilu5YAHbP3HsU6ydy
    ETPxg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=PV7wdj11 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=h74hhAty;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=PV7wdj11 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=h74hhAty;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x226JMKflpmLwdV/1lAlBaEATcowrXFn/johFcZ9YP/qiVQ32qZzqKu2QDCjy6KQEJLPaKyIA+A==
Date: Mon, 12 Feb 2018 20:07:50 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH 4/4] staging: iio: accel: Move adis16201 driver out of
 staging
Message-ID: <20180212143750.GB12142@himanshu-Vostro-3559>
References: <1518436499-8584-1-git-send-email-himanshujha199640@gmail.com>
 <1518436499-8584-5-git-send-email-himanshujha199640@gmail.com>
 <CAOFm3uFOy+Rea8yz798sEoCGRfavsR9gwY9-d_RQ75K5yoq1=g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOFm3uFOy+Rea8yz798sEoCGRfavsR9gwY9-d_RQ75K5yoq1=g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: devel@driverdev.osuosl.org, Lars-Peter Clausen <lars@metafoo.de>,
 Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 21cnbao@gmail.com,
 LKML <linux-kernel@vger.kernel.org>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>,
 Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 03:10:56PM +0100, Philippe Ombredanne wrote:
> On Mon, Feb 12, 2018 at 12:54 PM, Himanshu Jha
> <himanshujha199640@gmail.com> wrote:
> > Move the adis16201 driver out of staging directory and merge to the
> > mainline IIO directory.
> >
> > Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> 
> <snip>
> > --- /dev/null
> > +++ b/drivers/iio/accel/adis16201.c
> > @@ -0,0 +1,315 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> 
> <snip>
> 
> > +MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> > +MODULE_DESCRIPTION("Analog Devices ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer");
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_ALIAS("spi:adis16201");
> 
> Your MODULE_LICENSE does not match your SPDX license id.
> MODULE_LICENSE("GPL v2"); means SPDX GPL-2.0
> MODULE_LICENSE("GPL"); means SPDX GPL-2.0+
> 

I didn't knew about that! Thanks for pointing.

-- 
Thanks
Himanshu Jha
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
