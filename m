Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3952077-1521897824-2-6934500743913515299
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521897823; b=APzrng6lmMnnMWpKK1xTMySOx2fIlWemPknX4wp09p5Xito
    B34EluXYy/x+MBNj8XIFO4aGK+gGAN4bV8/aW7DC79Mza+v86glMIVToDeA/WPX+
    FmwOubMPQp0KwuwoWPswsnrIzZ5lGYgqnW6iAoJqvF4o3eweXwxL99i8foR0Yn5Q
    k1Ftz9TVAnEsVZ381Z5ddu+o7LN0BUzIGna9x14um9DjD3RCHHKWZjDsMDhBQS32
    YAzpIyi3glJzOGkrMQFK+qytijh7b/6Q05AyqHDVqUBVRgVTmZugPNcO7Fnn0z6v
    EOCzeIah+C5WCiI07WE+2qxvxtT32eH7U6IK+FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521897823; bh=T
    1TJo2/s/ngXuc/nA8SSnGUYN8NM3YOSqD/hE8aqyng=; b=GAFOnd+vDISsyci+3
    dOZBSE/AtYgishoqtjSQbNV51LwMImojYIM8YcPb1tfWGzWOLloC0hbr2wb/CHmg
    6d9Kdi+ea65g6yrDRwj/wYn3JYDdniOfd4LdehL42hZim+5RniAWqbi+3b6i1RMs
    G//jVvpVdnyphC5sMSAvC0ohxxndNNpMAI/8h1fVt3JGkALexju1SrMGhGmKHVja
    OKwM7wj/cN6cQKEd7AfanDM+gefrjw8ZUnBcS0ec78uCKYVwY/9I6rm6e8xcXHCu
    5qUYiHBZBbNp39w6gw1CkzZwBGW76vtt4Yyd7APQJcdos+TfRFdU08eVERWQphTy
    23/tg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21D0F21716
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 24 Mar 2018 13:23:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: John Syne <rodrigosiqueiramelo@gmail.com>
Subject: Re: [PATCH v3 2/8] staging:iio:ade7854: Fix the wrong number of
 bits to read
Message-ID: <20180324132331.03af7f4e@archlinux>
In-Reply-To: <5a7be7d02989db19d35f6d919fc9bce995666a55.1521813782.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1521813782.git.rodrigosiqueiramelo@gmail.com>
 <5a7be7d02989db19d35f6d919fc9bce995666a55.1521813782.git.rodrigosiqueiramelo@gmail.com>
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
Cc: devel@driverdev.osuosl.org, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>,
 daniel.baluta@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 23 Mar 2018 11:25:48 -0300
John Syne <rodrigosiqueiramelo@gmail.com> wrote:

> Fixes: correctly handle the data size in the read operation for I2C
> 
> The function ade7854_i2c_read_reg_32() have to invoke the
> i2c_master_recv() for read 32 bits values, however, the counter is set
> to 3 which means 24 bits. This patch fixes the wrong size of 24 bits, to
> 32 bits.
> 
> Signed-off-by: John Syne <john3909@gmail.com>
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Applied with fixed 'fixes' tag.

Jonathan

> ---
> Changes in v3:
>  - Clarify authorship
>  - Add Fixes tag in the commit message
> 
>  drivers/staging/iio/meter/ade7854-i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
> index 4437f1e33261..37c957482493 100644
> --- a/drivers/staging/iio/meter/ade7854-i2c.c
> +++ b/drivers/staging/iio/meter/ade7854-i2c.c
> @@ -191,7 +191,7 @@ static int ade7854_i2c_read_reg_32(struct device *dev,
>  	if (ret < 0)
>  		goto out;
>  
> -	ret = i2c_master_recv(st->i2c, st->rx, 3);
> +	ret = i2c_master_recv(st->i2c, st->rx, 4);
>  	if (ret < 0)
>  		goto out;
>  

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
