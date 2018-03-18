Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3678177-1521366493-2-4768270958168662230
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521366493; b=XhzB77l4/Q3Sj05c83ir7jIe/PoWLIFWVpwD6qLSDuPPQPj
    6o+TfUlYH1zkoB+Ks7po2H9ZwGmV0T6ktpW5AOMgHksXIIc5/UALX9iPzpDwHkY8
    PR88enKBOjoANJUZGm3BMEyFD7YhfmlaZdNAVWOWOvE0zvvYlCzQJs3PlmN8nK1b
    HA6qwt4gLlOZCMEWkkxrfzEUyPK43D7Cyjk9jabBC2cWOTxHEOrcgeEjphuW3wZl
    2l4Z+D+8fyQkb7nMhUXw100KwbqlNgs3D5JwBVD8aTg3kifgP2LJNs5BvIea7L9J
    q4D9nH0Uf/PcboSQShaSfFDehjWnx5ftIg+QvsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521366493; bh=D
    O93LXGjDh3qLFUA3tvc+QofNwI5A7T0L6Xg8/+EQds=; b=tkXq69P57Va3lh7Pi
    vU+IQSFDkZsXyQOAb6uHhBNa9i9s+AyKOrp+apl8FXfETiWgzz7AvRxos3ZBLCRD
    E78dFGx902iBZqdE7EAT4FS8PT2ifGCSbz9a7qQkQ/7Trp5Up3NZMbA/HuCdG9ip
    uafIv/iwjnxnwpXup6CPMyyN/eXxBLsUkmYx5BuQEazdBFU9AoTrXJlCDJ7qiRah
    HMPBgLk0eqjPVh1bOImd4oUskJler11rz8nAIgVYdbreaLeGGqyDGWWNEog/da2O
    daBLCDRjMOCeg04H5KKq3Yr3MC2dOyk9RTZDU8r6k/RFB41hUU9CM/3+uiZkc8tG
    QwR8g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16AE520838
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 18 Mar 2018 09:48:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Subject: Re: [PATCH v2 2/8] staging:iio:ade7854: Fix the wrong number of
 bits to read
Message-ID: <20180318094801.47e61123@archlinux>
In-Reply-To: <b5f76bfcf37667a473ec962bfafadc7f9455bec6.1521239766.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1521239766.git.rodrigosiqueiramelo@gmail.com>
 <b5f76bfcf37667a473ec962bfafadc7f9455bec6.1521239766.git.rodrigosiqueiramelo@gmail.com>
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

On Fri, 16 Mar 2018 19:48:51 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> The function ade7854_i2c_read_reg_32() have to invoke the
> i2c_master_recv() for read 32 bits values, however, the counter is set
> to 3 which means 24 bits. This patch fixes the wrong size of 24 bits, to
> 32 bits. Finally, this patch is based on John Syne patches.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> Signed-off-by: John Syne <john3909@gmail.com>
Same issue with clarifying the authorship.  Also for these fixes
ideally include a 'fixes' tag to the original commit. It makes
life easy for the scripts the stable maintainers use to work
out when things should apply.

Here I would imagine it is the original commit that added the driver,
though we may have had enough changes over the years to make these
hard to apply.

Jonathan

> ---
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
