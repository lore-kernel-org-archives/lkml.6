Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2240270-1520399852-2-4148780510323997513
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES dasven, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520399851; b=MZQNOiVQSEhX9zNxwRHrvEQnJukh3k7gqz4L6sB30pe3s/n
    Udo8zaIq9YxjYVgProMKjXeKZ6lqX0JmGl2WMhr/5Gd1kUglraXkMM0YXyFVaUqN
    2a8cPxuYz2XhOKciec8iGepQspxo8oAS3/BOE5Zj8N7MKBHHU0aqTNGawywL3WSr
    geyZ/HxKF9QLk5g18ZBmaYh/7BXnsRD5g5qI4ddMEQuTpxewfvX4Z5E/06/QlD6E
    4VNIgXBTnQGMEshGngQd9Jt5lYIWKxQ2p2ua1hjHicvaJclaxATCF742Xn6a6JGK
    X+uILZtUZ3DOMrJuX/jI3gq2HjKnNo0HE1Qw+JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:date:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520399851; bh=z
    8vuEYMcNhAGhM5KmnhUj36fQihxqvvfekoFnB6STmc=; b=X7RE//TH4qaQIkkwF
    6jS7+PUubJeQHX0xZGQsOKscR4m2UBXe2VAAHBpK6NJzIm7SltxjKkkGQJQ106WL
    xx4QPPbwwqqpyYmOUOCoOZLtmhSLeycwa6vixMV4AhQisUvXX5fruOOAQbdf98zN
    tZhlr6EyLSriVtQRDH1gydPbLqCQSLL1K8Txn+KZOshrA2Vywzcm2jh6fem9Bbfk
    /0kFRBhofRaJIr234kdruvuKpB6STBSBjOQu1vpPF5cEbPQAfOOX+Qz+l8fNw2/I
    TKans6gZ9yYN22ZTRDuyqzVq47B3jEryfhzgiqPLtaRkUpOnFP3148AchxRYcfQf
    Z6oQA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=rVnFAu49 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-85 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=MhDiIi2y;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=rVnFAu49 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-85 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=MhDiIi2y;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELs3SHEBcITzWXzntgwwOnFuy72+lChGWUpqXhN8jhzAA5m6ik7dgeZNJn5Lpun+WvOKHVO3FA==
From: "<Hariprasath Elango>" <hariprasath.elango@gmail.com>
X-Google-Original-From: "<Hariprasath Elango>" <hariprasath.elango>
Date: Wed, 7 Mar 2018 10:47:10 +0530
To: hariprasath.elango@gmail.com
Subject: Re: [PATCH] staging: iio: adc: Remove reduntant __func__ from debug
 print
Message-ID: <20180307051710.GA13147@hariprasath>
References: <20180307051005.13038-1-hariprasath.elango@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180307051005.13038-1-hariprasath.elango@gmail.com>
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
Cc: devel@driverdev.osuosl.org, lars@metafoo.de,
 Michael Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>,
 Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 07, 2018 at 10:40:05AM +0530, hariprasath.elango@gmail.com wrote:
> From: HariPrasath Elango <hariprasath.elango@gmail.com>
> 
> dev_dbg includes the function name & line number by default when dynamic
> debugging is enabled. Hence__func__ is reduntant here and removed.
> 
> Signed-off-by: HariPrasath Elango <hariprasath.elango@gmail.com>
> ---
>  drivers/staging/iio/meter/ade7758_trigger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7758_trigger.c b/drivers/staging/iio/meter/ade7758_trigger.c
> index 1f0d1a0..da489ae 100644
> --- a/drivers/staging/iio/meter/ade7758_trigger.c
> +++ b/drivers/staging/iio/meter/ade7758_trigger.c
> @@ -34,7 +34,7 @@ static int ade7758_data_rdy_trigger_set_state(struct iio_trigger *trig,
>  {
>  	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
>  
> -	dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
> +	dev_dbg(&indio_dev->dev, "(%d)\n", state);
>  	return ade7758_set_irq(&indio_dev->dev, state);
>  }
>  
> -- 
> 2.10.0.GIT
> 

Please ignore this patch as the subject line is wrong. It should be
'meter' and not 'adc.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
