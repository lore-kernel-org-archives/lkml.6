Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1362021-1526123721-2-13266605287048278673
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES endaro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526123720; b=hFr5jKvHm/Pee8XAVNE9B4XQrkhKVjdxvbWRx65i/LJ9GXU1je
    g31YHxgKK5VZW02RutzV7KhvikLUQeePX4LNVdRp8RwYiNShIpx9n/3cfys14HEh
    AmNCq8uHcCboJu5/wJmfWVtl8FVPhrDxBN+PbmeggBsYL+fJg/iNRFSNvvZ/39Xy
    cU+g5JjrFGApaaKeJOZ7iCiD+1OC/JzKLNlSKjUV6N8cNiuO24VhLThC0o4B6WHE
    RDry6+M4Lm/jHT/RkB6eu1SrhLtKPJQ7QkJA8YB+/CNFVPKXmf0SQWAthfA0XzBh
    vnGH6XYaGFj8gk5Q1LMpIZ5M3Ls9old8+Acw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526123720; bh=H5nfZ
    cfdv+p/6bb72JqfM9NnfN0f9ZjshTe1bZ4Shgs=; b=j9bw2WZLfs8prhNN+3mGU
    pelanWLx22/0e96//IG67QwRYtAooAkFzDD1qg5o5giURNYGO61N42t3DVs4Fn4z
    b/e90JJy/lObOdAsxg319RnXWcRgf2Z+lO+d8C6bt9iO+hVTMMHX8860N8nhgViX
    StGkwoE96HsdashJHV95jdzlyX7uvAcdQ0Xz5YO0dQzYMVmEkFWj+UtTXhUXFoXf
    nVfQ2U3S126CWOFnWf2SrFNnU+TTyQkk75J5fqlb7dYsJHEFnNcoeF6e0N4Z0v0S
    tr7FQJemGWFDA27Wa3WyAQXOx/dVnjm1yMYrvsWYfWDErV0RciOGm74SxB0vcY1+
    Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=FELJLjbb x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=kernel.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=FELJLjbb x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=kernel.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN/FACramG5XUHq1WLuDCSJydCXD+ZEm8vu1xcJJxd2vlclL7ni9llZ2pu8ayj8Gr9A9FSRThV2nYJa1HgCJAw4H9GrynF6P83FllHxxfiLj+aHBy2eG
    nNfNleChLzzR0QGGfU4CS9JVcDzVwnFulmg53wcsquJS+Mog1MLYLf188hpalzmo9rsdy/hSB8KUS0c1CbHULGoifOTb/ImeZbqQra56sdD1rR13Assv2kBv
    pvscqdJuHwSrpoXn23VasA==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=hUgFpdHPpd7-Y6ermcwA:9 a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Sat, 12 May 2018 12:15:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH v3 1/9] staging: iio: tsl2x7x: remove unnecessary
 whitespace
Message-ID: <20180512121506.3cb3ca08@archlinux>
In-Reply-To: <20180511001223.12378-2-masneyb@onstation.org>
References: <20180511001223.12378-1-masneyb@onstation.org>
 <20180511001223.12378-2-masneyb@onstation.org>
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
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, pmeerw@pmeerw.net,
 knaack.h@gmx.de, drew.paterson@ams.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 10 May 2018 20:12:15 -0400
Brian Masney <masneyb@onstation.org> wrote:

> This patch removes unnecessary whitespace in preparation for moving this
> driver out of staging.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 22 +++++++++++-----------
>  drivers/staging/iio/light/tsl2x7x.h |  1 -
>  2 files changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index cc863e8927f5..3ae2fd19ae9c 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -196,16 +196,16 @@ static const struct tsl2x7x_lux tmd2x72_lux_table[TSL2X7X_DEF_LUX_TABLE_SZ] = {
>  };
>  
>  static const struct tsl2x7x_lux *tsl2x7x_default_lux_table_group[] = {
> -	[tsl2571] =	tsl2x71_lux_table,
> -	[tsl2671] =	tsl2x71_lux_table,
> -	[tmd2671] =	tmd2x71_lux_table,
> -	[tsl2771] =	tsl2x71_lux_table,
> -	[tmd2771] =	tmd2x71_lux_table,
> -	[tsl2572] =	tsl2x72_lux_table,
> -	[tsl2672] =	tsl2x72_lux_table,
> -	[tmd2672] =	tmd2x72_lux_table,
> -	[tsl2772] =	tsl2x72_lux_table,
> -	[tmd2772] =	tmd2x72_lux_table,
> +	[tsl2571] = tsl2x71_lux_table,
> +	[tsl2671] = tsl2x71_lux_table,
> +	[tmd2671] = tmd2x71_lux_table,
> +	[tsl2771] = tsl2x71_lux_table,
> +	[tmd2771] = tmd2x71_lux_table,
> +	[tsl2572] = tsl2x72_lux_table,
> +	[tsl2672] = tsl2x72_lux_table,
> +	[tmd2672] = tmd2x72_lux_table,
> +	[tsl2772] = tsl2x72_lux_table,
> +	[tmd2772] = tmd2x72_lux_table,
>  };
>  
>  static const struct tsl2x7x_settings tsl2x7x_default_settings = {
> @@ -1241,7 +1241,7 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
>  						    0,
>  						    IIO_EV_TYPE_THRESH,
>  						    IIO_EV_DIR_EITHER),
> -						    timestamp);
> +			       timestamp);
>  	}
>  
>  	if (ret & TSL2X7X_STA_ALS_INTR) {
> diff --git a/drivers/staging/iio/light/tsl2x7x.h b/drivers/staging/iio/light/tsl2x7x.h
> index 1097ee890ce2..db344796fc1b 100644
> --- a/drivers/staging/iio/light/tsl2x7x.h
> +++ b/drivers/staging/iio/light/tsl2x7x.h
> @@ -92,7 +92,6 @@ struct tsl2x7x_settings {
>   * struct tsl2X7X_platform_data - Platform callback, glass and defaults
>   * @platform_lux_table:        Device specific glass coefficents
>   * @platform_default_settings: Device specific power on defaults
> - *
>   */
>  struct tsl2X7X_platform_data {
>  	struct tsl2x7x_lux platform_lux_table[TSL2X7X_MAX_LUX_TABLE_SIZE];

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
