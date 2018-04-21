Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-401687-1524327915-2-15300052633453603712
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524327914; b=RJVrZhsyzi54WDANuLeQ9LpDwfyXyZaWSpaUJdNuOecIDw6p1q
    +Icz78OMW9O9xSuWVUG28P6F89LhPM2CadNSCVKNGCN6XN11yIYcAAoHsIlRMIZC
    LbL7IjsbU7U1UTvG+5h5IqfBu51nh6AiMCuxDeEfTTMLmV9b84l0MMTYp3lBgE3U
    0UtpPNiA6R1/7zJCv6a0zXRsoLckzIpx3ULZU+s70g4IxNQXtGTITR8q7XLiaY7v
    DC7DVHOwyTMxkPg+M1IOeEbKnXxGVqivtQoaI0kWlrHK7MUTykn+eF4TQUpSZU7N
    Wbaj2Phy3MnYANy3svLuDl0q5dfaiYlMHc+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524327914; bh=aIfp1
    jQrmhdQzEt3uS9ZE80oq3Fe5N98AnH24GaNx5M=; b=blHx5ez6fkNk1lY1o1+Ap
    Str/7Q7cc3AaRGDlKFgnsHVWgIPFTUTTihdkcurQYZrbJeQBjZwEZAdBf+Ob9ji2
    NUZRKuWD26AXy3UB6B8iFxs4m8D/6LnypnkC8LC6kxwyYAXjNF2wBULwNeQLsUH4
    TfkKTGl54eEbiP/kYFWK4gzrmJGWVRX2a2dmK9yG6k/DGs2sGvr77lgIUePAOlXr
    hJZw475zPIn2fCzgCIXfSeltZdq+1ExDc3aLKC/H172bJigATGROYvDU6Fh2pRyz
    hpdOXJBNxMNpqJoYGwxbTO8NvplunDa5mtf6ZPlOu+Pw11c8C079wSq7zvVpfSQw
    Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNi7nfmozfQAgXwsAL4cOvkViY+UrNiGtyAlkSZgVT71a6SlAcsPBTrdiS0GF4Yw4YaZw4icPNjWr8P0B0NnGn0tggktWKWqGiMfZzjmSuR1Q2VV+ytN
    7Wbr9tOp2YYgxLp61+K4y3bLI/duuza9YTbHivAHS/kJy99y+RR/x8EETwHILIJgQppHo10dimIyXMtSVfrPlpJ6emsNLfeyJeqk31tLFJG0ZzAwhP7kR3I+
    fAK8eM+O09i1Fk8pHwLVkg==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=pB5_8dm6abTcxx7MpBcA:9 a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB0E020C0F
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 21 Apr 2018 17:25:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH 06/13] staging: iio: tsl2x7x: simplify
 tsl2x7x_write_interrupt_config return
Message-ID: <20180421172502.26428794@archlinux>
In-Reply-To: <20180421004153.19073-7-masneyb@onstation.org>
References: <20180421004153.19073-1-masneyb@onstation.org>
 <20180421004153.19073-7-masneyb@onstation.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
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
Cc: devel@driverdev.osuosl.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, Jon.Brenner@ams.com,
 pmeerw@pmeerw.net, knaack.h@gmx.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 20 Apr 2018 20:41:46 -0400
Brian Masney <masneyb@onstation.org> wrote:

> tsl2x7x_write_interrupt_config() has an unnecessary return value check
> at the end of the function. This patch changes the function to just
> return the value from the call to tsl2x7x_invoke_change().
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Nice little cleanup.

Applied,

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 8d8af0cf9768..d202bc7e1f4f 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -982,18 +982,13 @@ static int tsl2x7x_write_interrupt_config(struct iio_dev *indio_dev,
>  					  int val)
>  {
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> -	int ret;
>  
>  	if (chan->type == IIO_INTENSITY)
>  		chip->settings.als_interrupt_en = val ? true : false;
>  	else
>  		chip->settings.prox_interrupt_en = val ? true : false;
>  
> -	ret = tsl2x7x_invoke_change(indio_dev);
> -	if (ret < 0)
> -		return ret;
> -
> -	return 0;
> +	return tsl2x7x_invoke_change(indio_dev);
>  }
>  
>  static int tsl2x7x_write_event_value(struct iio_dev *indio_dev,

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
