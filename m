Return-Path: <abbotti@mev.co.uk>
X-Cyrus-Session-Id: sloti22d1t05-2645812-1521195451-2-4796006075119651540
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_NONE -0.0001,
  LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='108.166.43.65', Host='smtp65.ord1c.emailsrvr.com', Country='US',
  FromHeader='uk', MailFrom='uk'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: abbotti@mev.co.uk
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521195450; b=Ud5cAnY6Eew7H6ctVNGVNiG+fWnn+PJHKTB2+yQFdrUbzbL
    lJAcj9j96yy5Ot+3KeLTHlybIwxmzEIfuuVNhiL7CSkgl7dpYREdVOse8A+9JI17
    +I8sw5S9ODFrZgD3CwweCBP6oFbBEw+RA6t3vHu6xyKheT1MjWBRAT7gbqFT8HI/
    Pstlo5k4NYqojUVaeHL6JusbkH1vH34Uj0fLoBv6Vtc1/MZ6IFn5Hvzw4ROoUvz8
    yXTbJ9ZXX4iDf9p5/5tW81uskehk6dGkm1JRAjm9G8X8XZDCy7lauJma6Zjmu0lS
    VTCnH+mRrAqhXJmBuPCMhJNxREsKN5ipLQoQZUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding; s=arctest; t=1521195450; bh=RPl/i04h
    yHfpv66EiD9Am7lJy4uq1rZ5YtIyHt/FDj8=; b=p5snzQoTtSj6vKpyO99MH8tu
    uTnTaz2gRvnRA6RsBxLTx/2kvzAjOiyqr9hTYBgjzEvYCLQ9nDEyLCa+BaFCrgln
    7LbJmJ8Q23AlDI583Ub9KIhQ9XmVXUvIq1q4tJ2TQ2te/N5fEHu+LFVZFP7cnxGr
    ruaAauiojtruvjbb+TTbd6nnjkftBUfAQj3MCP+UZdjJkFQDuPXt/EjS+c3pbM7e
    vKsEjLSRURpDEcXsIjXJ81B3gkKiMSi2UE2DZWkWTgNcy+s/4uM7Kkoha811akZG
    uWGpF6uMcI8CmjPDM4sXn4qBUXE9K0ED+Wbdjs3cccX3jdlLGTSD8rT8labKBw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=mev.co.uk;
    iprev=pass policy.iprev=108.166.43.65 (smtp65.ord1c.emailsrvr.com);
    spf=none smtp.mailfrom=abbotti@mev.co.uk smtp.helo=smtp65.ord1c.emailsrvr.com;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=smtp65.ord1c.emailsrvr.com x-ptr-lookup=smtp65.ord1c.emailsrvr.com;
    x-return-mx=pass smtp.domain=mev.co.uk smtp.result=pass smtp_is_org_domain=yes header.domain=mev.co.uk header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=mev.co.uk;
    iprev=pass policy.iprev=108.166.43.65 (smtp65.ord1c.emailsrvr.com);
    spf=none smtp.mailfrom=abbotti@mev.co.uk smtp.helo=smtp65.ord1c.emailsrvr.com;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=smtp65.ord1c.emailsrvr.com x-ptr-lookup=smtp65.ord1c.emailsrvr.com;
    x-return-mx=pass smtp.domain=mev.co.uk smtp.result=pass smtp_is_org_domain=yes header.domain=mev.co.uk header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Auth-ID: abbotti@mev.co.uk
X-Sender-Id: abbotti@mev.co.uk
Subject: Re: [PATCH] Staging: comedi: drivers: ni_atmio.c: fixed multi-line
 derefernce issue
To: Pratik Jain <pratik.jain0509@gmail.com>, greg@kroah.com
Cc: linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
References: <CABbwmYcnDNcA70_-BhLkBcuK-77tk3BWKcvzQts6eWqu5_mMKA@mail.gmail.com>
 <20180315185943.18902-1-pratik.jain0509@gmail.com>
From: Ian Abbott <abbotti@mev.co.uk>
Message-ID: <2dd4e733-b74a-c296-a554-3520a85e8ce2@mev.co.uk>
Date: Fri, 16 Mar 2018 10:17:28 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180315185943.18902-1-pratik.jain0509@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 15/03/2018 18:59, Pratik Jain wrote:
> Fixed coding style issue.
> 
> Signed-off-by: Pratik Jain <pratik.jain0509@gmail.com>
> ---
>   drivers/staging/comedi/drivers/ni_atmio.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/comedi/drivers/ni_atmio.c b/drivers/staging/comedi/drivers/ni_atmio.c
> index b9e9ab548c4b..4e27a2959b64 100644
> --- a/drivers/staging/comedi/drivers/ni_atmio.c
> +++ b/drivers/staging/comedi/drivers/ni_atmio.c
> @@ -226,8 +226,8 @@ static int ni_isapnp_find_board(struct pnp_dev **dev)
>   	for (i = 0; i < ARRAY_SIZE(ni_boards); i++) {
>   		isapnp_dev = pnp_find_dev(NULL,
>   					  ISAPNP_VENDOR('N', 'I', 'C'),
> -					  ISAPNP_FUNCTION(ni_boards[i].
> -							  isapnp_id), NULL);
> +					  ISAPNP_FUNCTION(ni_boards[i].isapnp_id),
> +					  NULL);
>   
>   		if (!isapnp_dev || !isapnp_dev->card)
>   			continue;
> 

I suggest splitting the expression just after the '=' to avoid going 
over 80 columns.

-- 
-=( Ian Abbott @ MEV Ltd.    E-mail: <abbotti@mev.co.uk> )=-
-=(                          Web: http://www.mev.co.uk/  )=-
