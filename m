Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2529736-1521059091-5-14438329573713090247
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521059091; b=mt22YM5CJC9KuYQ2GVOUzZ98Uv+ujrdlfWfLFjG24WWnQL3
    ZHxW1GYG/DHD7neryal13GGgp9/8dck0KIy8QsxbwSDMuA8hp3jLuCcyNsoai3If
    LvO4ytp0M0JI+5OfcxOUQ/NAP1tlBslpQkUWLypN3oheePpYEM6L9hEA4v5oFwhU
    o8Cak5G8jtdHqRLlXf0YRzuKYt0JBZnlYbfbmGHWpGGM+zAQreUbhB+iqoazkBxm
    JmYm/zgjIdv3yVBkivZtLkoM31atjCnt0Q3x/HFq/5YFSS4yVc0tAetEbHTAhn9c
    AKm5pY+jVQJ2WhLIiDauW08qwYQRtwVPwS9zd4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521059091; bh=s
    X7lmWRSQN0DVGbvZc5bkZX1czNVC0KO/z8vTABfQXI=; b=lRhfQQRuabBU0PDub
    xH5hDpyB1SRKqIpe2ocfNAVcmvMDViFhDRj1isFVA/YWvigxXB5uuTiovOLDza1W
    wEx0xDjKk41nS7KAz2LYrraxunbQXU23BXsytym2Qugy1PqT2bbiO3Ogz1cyRSnw
    1fRSkSqUbmqy4+JqqT2hcHUMLXxP/UM7eQ1NjB5S/tGzru2PLMPQXzLZqGrAMCn/
    WqOtjrbFnkrKq/a55KMuwUI+vfqZZ2akYBJWBKMdQt1sV2vSj04sgjuIrySHUWS9
    HbLB5f0qWPqTeIvRdAihzaeDgPp0shqa3XuUWB7IlC0v71e7XXU+ddchoBabOVOi
    Ku6Zw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=dB0cF64D x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=U5/lq57j;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=dB0cF64D x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=U5/lq57j;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELs4EO5Kf+eI/BGYTMm96av3KpJm3PUvc/+aa6k9ooC1aYePvkgKQ5iQOeoO5lHfdh3FCp/toRFc7tVrxcsOLpA=
MIME-Version: 1.0
In-Reply-To: <20180314180633.000067dd@huawei.com>
References: <20180314153603.3127932-1-arnd@arndb.de>
 <20180314153603.3127932-48-arnd@arndb.de>
 <20180314163207.GA4279@kroah.com> <20180314180633.000067dd@huawei.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 14 Mar 2018 21:24:41 +0100
X-Google-Sender-Auth: ahZUtYR9Cm5eebdxfdXjYxcm6Cw
Message-ID: <CAK8P3a3Pg0sbzQeSJfjdCmepRGz9PP7Uusd5UopZT0gTBbL1QQ@mail.gmail.com>
Subject: Re: [PATCH 47/47] staging: iio: remove iio-trig-bfin-timer driver
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
 linux-iio@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>,
 Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 6:06 PM, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> On Wed, 14 Mar 2018 17:32:07 +0100
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>> On Wed, Mar 14, 2018 at 04:36:00PM +0100, Arnd Bergmann wrote:
>> > I'm not sure about the other staging iio drivers though: almost
>> > all of them are for Analog Devices devices like this one. They
>> > are likely used along with blackfin SoCs, but could easily be
>> > used on any others as well.
>> >
>> > It might be time to consider whether they should be removed, but
>> > it doesn't feel like a decision that I should be making.
>>
>> The IIO driver maintainer/developers are talking about that currently, I
>> think they have a plan for those other drivers.
>
> Some of the drivers are under consideration for removal (particularly most
> of the meter drivers) but it is unconnected to the blackfin removal.
> They are simply other obsolete parts that we don't have test hardware
> for and need sufficient 'surgery' that we wouldn't feel comfortable
> cleaning them up without.  One has been reprieved as a user, who was
> happy to test, came forward when I announced the intent to remove them.

Ok, thanks for the clarification. I'll just drop my comment then, as you
clearly have this under control

>> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>
>> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Thanks,

      Arnd
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
