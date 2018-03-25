Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1997770-1521974005-2-1132720192944008318
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
    t=1521974005; b=JZPfrCLoYBCos63XgahuCs3k8zXyVAfQ0a3FVqDv/G4r+fb
    GWJRnf3nUg9sRzviwMDA4MMcQjW/GGvmvrE/phv8o5HtZ5e8cgM5OzZhi+caK9uM
    HPNJuy2G+3J69Nrf420Jvsa4FBPoXRbQ7hZyGFujYVu9SoEt54ODhgG58gaMmzC2
    cL/uOFyvFQsy283Ae6WDf5bzHdKfFo3AmfDbpU100MDMB0TenIN4m0DX5HLiNy6p
    k4DWkDPmC4OetRhvDLylWNMURYJH1Q1NZ55znp6RSNGApbiivynxyF5hzO0TvaVj
    4jSrydyXeTvEtZfJGSDiaAhFi5QeHg1cYLidgoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521974005; bh=/
    KH4VE1C7liJdbkxCKvXqcaBVWjKEGVR4E5xcfRp0WY=; b=DCKEtAdKKzhS6XB3l
    2WLz7ObNzRrJsmMjcMtotwZYiS/XZNzZ/6cHqO+4WJga21vO4Xxkp1HWRzwwugkA
    m5f2OnygMYmYI/+qGDOQYEVBOnaUL/Us304DESBDnlagdgz+MAjcW5w1yzDMf76v
    6GULB2uta+IEQ2XEQVS9zKwPhs8qbWWA1yiPf06Q7qwP7ikfZK0nEXHqBP550qj9
    V2j94PR9CkVjSjK/88SoqEHaVwRgN8GdwfkfAxKTC05bLP6b0BQ/609bSbxHvtu2
    CsBE1cGcZRPMzHoGccVmUy0dY9x3pzyru2xxcu9BvaIDdvdIaWLdTzFJohu/t0FW
    uI/2g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=iNqdUdyt x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=IiX+obkD;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=iNqdUdyt x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=IiX+obkD;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx49oEMbdocB/XFmCLtRq+rEakYwXItoD6+Alkp9VQ+mZWx57fV03u2InoOYYVy9EOBTuuIx9AbWKKUk9/ZHYR7I=
MIME-Version: 1.0
In-Reply-To: <0524fb43-ed08-6c54-39ed-32bd96ccaca4@gmail.com>
References: <f35d0f86-04b5-6edb-139f-4632edc493b3@gmail.com>
 <20180322213722.31822-1-k.marinushkin@gmail.com>
 <CAHp75VdYiySBzu99MYoBAZ8tORGP1R43z9d+=VRdktg+U=_ZDw@mail.gmail.com>
 <0524fb43-ed08-6c54-39ed-32bd96ccaca4@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 25 Mar 2018 13:33:16 +0300
Message-ID: <CAHp75VfJjCHd5U1D22NANLCA1kAoTKLnDGSQPj3ay6OhKSoZxg@mail.gmail.com>
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

On Fri, Mar 23, 2018 at 9:22 PM, Kirill Marinushkin
<k.marinushkin@gmail.com> wrote:
> On 03/23/18 17:23, Andy Shevchenko wrote:

>> After addressing above, FWIW,
>>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Seems you missed my tag in new version.
When someone gives you a tag and you are going to send a new version
(w/o drastic changes), it's your responsibility to append it

I will send a new mail with it, so, this time no need to resend. Just
keep it for the future contributions.

-- 
With Best Regards,
Andy Shevchenko
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
