Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1230003-1520367714-2-15692099529060130431
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520367714; b=pF4nWHPWw9nIwXjrYkSbt4aSl8EM3VCRm5rFMrlJkZ6fxkX
    hTjvZPjGbGeMu1nEwe4aWNzALXjgLr90K48dB/zkepdx+H46PGlDyxJcIT8X7nJs
    8VQCyFRPI/g664mhHEzEwqwLxwCHb1HWRZ+YijInKX1PDxqeUOdZ0NzzpDQ+k4Pb
    8MTtTQ5dtFWYvkfEs5x/Q9UCx+wiefW5FdjT+cBFkM2XXZ9COnuYml/duBt7V7uI
    5eYASp3+KudpbVRJC4n41cZ4wkS/eJztPCySVdVxlmCCnq+l1feVmfXF4f37Bgn6
    Q5tlWITNYt0yKYEo5/tubU4tto8xQ7XSehAWc5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520367714; bh=f
    UvTvjYtyAiJAh4SreNPE3yryBHSgHu78sYbiEEaNdI=; b=wJ2U2GL8Qp0tV0N4Z
    nJ562c32NAZsEod5cj3qYlZ7Xc09wvQLQqlqLgvn/z9CPw/tGNlqkgRkIx1xGVC5
    6M8r58OBRLPpoF4tnv5QX9yp8J3VjeMhI6gZx8wjveGBFv2hhku132v6dwcrAX2k
    NUoVAGxZovxTsrzgUBuub8YT1CTOlbwgd522wDTT0LPH40QJlimKpbTI97GYniwn
    2EQuqxb1Xyhrb6OE05cz4w5XEZrwpvaVe6MJ5zptyK8OLU+F2T9zeTLFzjSw9lsI
    uV+JgZpDCsxXGmhQdRtMhF9s2ctJwZiLf5snn1SWmqu0DQkNKx6oPgW+um6rCRzR
    M7dTw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=V60290vn x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=C61+VPLM;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=V60290vn x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=C61+VPLM;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELvNHbS9INhFCEFl7epjK3qsXwg9ftoIioARaDK1/G39pi0HjOECpMcMgDuQSuijogLYeP5ajw==
Date: Tue, 6 Mar 2018 17:21:38 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 3/3] staging:iio:meter: Aligns open parenthesis
Message-ID: <20180306202138.dquhxpfiwq6matbe@smtp.gmail.com>
References: <cover.1520338980.git.rodrigosiqueiramelo@gmail.com>
 <284b70f83bac86ec5f0048b957ec2f679ca8ab99.1520338980.git.rodrigosiqueiramelo@gmail.com>
 <20180306135314.vxngtgj6yxomasm2@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180306135314.vxngtgj6yxomasm2@mwanda>
User-Agent: NeoMutt/20171215
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
 linux-kernel@vger.kernel.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Hartmut Knaack <knaack.h@gmx.de>, daniel.baluta@nxp.com,
 Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi

On 03/06, Dan Carpenter wrote:
> On Tue, Mar 06, 2018 at 09:26:07AM -0300, Rodrigo Siqueira wrote:
> > @@ -63,7 +63,7 @@ int ade7758_probe_trigger(struct iio_dev *indio_dev)
> >  	int ret;
> >  
> >  	st->trig = iio_trigger_alloc("%s-dev%d",
> > -					spi_get_device_id(st->us)->name,
> > +				     spi_get_device_id(st->us)->name,
> >  					indio_dev->id);
>                                         ^^^^^^^^^^^^^
> The "indio_dev->id" needs to be aligned as well.

I will fix it and send a v2.

Thanks for the review!
 
> >  	if (!st->trig) {
> >  		ret = -ENOMEM;
> 
> regards,
> dan carpenter
> 
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
