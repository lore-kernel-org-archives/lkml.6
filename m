Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3601762-1520702518-2-5693792773131321971
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520702517; b=WiVhZ6ja7OtBikdI4xIF6DJSRZ3/SrzBrRH1Q1m6oqDItcz
    uB8j4Zd+UhS4254BtBCGe03nBLfUwJuDR57OlmXLmX+hNvcHOb48Xy04IYvCo4Rj
    Ft1ls26cMfD/Mb9YdX9JwQHhw6G/OOmCyf0enSWuQGe3OkAcjYETVk76amraHD6S
    FKFDlts4rjwHPyyZTzIT1V5X2LO34bpHbWlWex085rxXbPoU0G8iQqNWKbfZz3X3
    bap3kANFFmoVJcWDLeXIwHz7ZfIbT/c0mH4Kkxej+j0LYVQBntNC4ISP1YJBBnss
    GWwK5rGGyjJ0H5BkezKmTBXprrdwIv2hWTQ+DAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520702517; bh=O
    9TtCm7nmGEFUT+BRaaPjhkqxDY0P4aewY2NjIScDe8=; b=QiP++wDYdb1zeYMZA
    fhdfAmxRL8OgvEG4pC7i5SXUnYcJ95NnJtF/1RrXwUgLp66S8DP+L9TIbGtk8AnK
    Yk3A5OBfM9mO1sS8mSXWSket9rvo5utT1qOc7BTQGmc0N3elnIbcXIklo6y75Sfv
    rgQQZmAYuiOFanziCqN8qUh5kKTSbOGmqjJYtoV/deXa6m+wSkhAvQulikfcLx2X
    xtTvA6Cwa4IkEAhm/TT1+gCj80h6dzSvmmbUHpF+AHKAPGNdAf2T4fEWlltHaW9e
    GSilfNtVCUtD8PS0li+QclriZue7xMFFdfqFf27NuHTA5vqjWh1KjPCP3qKEtloR
    XYgkA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48CB621771
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 10 Mar 2018 17:21:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Subject: Re: [PATCH 3/4] staging:iio:ad2s1210: Remove old_data from
 ad2s1210_state
Message-ID: <20180310172145.19f2dc00@archlinux>
In-Reply-To: <c622bde87a9e1ed5ddf89b999231c69579b7d2e6.1520638889.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1520638889.git.rodrigosiqueiramelo@gmail.com>
 <c622bde87a9e1ed5ddf89b999231c69579b7d2e6.1520638889.git.rodrigosiqueiramelo@gmail.com>
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
Cc: devel@driverdev.osuosl.org, Graff Yang <graff.yang@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>,
 daniel.baluta@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 9 Mar 2018 20:46:25 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> The variable old_data is a bool type, which only receives the value
> 'true' in the function ad2s1210_config_write and ad2s1210_config_read.
> There is no other use for this variable. This patch removes old_data
> from the ad2s1210_state and from all the function that use it.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/resolver/ad2s1210.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index 79cb56670fc2..ac13b99bd9cb 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -76,7 +76,6 @@ struct ad2s1210_state {
>  	unsigned int fclkin;
>  	unsigned int fexcit;
>  	bool hysteresis;
> -	bool old_data;
>  	u8 resolution;
>  	enum ad2s1210_mode mode;
>  	u8 rx[2] ____cacheline_aligned;
> @@ -107,7 +106,6 @@ static int ad2s1210_config_write(struct ad2s1210_state *st, u8 data)
>  	ret = spi_write(st->sdev, st->tx, 1);
>  	if (ret < 0)
>  		return ret;
> -	st->old_data = true;
>  
>  	return 0;
>  }
> @@ -129,7 +127,6 @@ static int ad2s1210_config_read(struct ad2s1210_state *st,
>  	ret = spi_sync_transfer(st->sdev, &xfer, 1);
>  	if (ret < 0)
>  		return ret;
> -	st->old_data = true;
>  
>  	return st->rx[1];
>  }

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
