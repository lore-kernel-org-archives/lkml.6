Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3624994-1525631179-2-8521300405086635675
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525631179; b=Kf05XkAg/pv89HlaCbP1RCakoWotfe7pDt2JKzY01nbTs9351f
    7x9Xnug2UJ+fHYgCHeAeQYdM56+2Oxqgpr/0lrfKzEaM2AmMZHvD62AFk8elWKsi
    5VAYJ8T2AOnPtrIG1xr/5OO5Ov+X0pLScSetorAXTrTNskeD4NFrjl9GKrT3faxr
    I5+Fsl4jFTVIch4lLkFZklky/q9W7qRTjk4Qv9l6LTj7zm8a++E1EJbU+Czqp9fI
    BI6ogFfkbIz+TE70TNZS6yWvkAwscV18mklMWtsUUWAQ4jPx3GRvejzlpbd5pi6v
    W/F3rO6NenkYOtm3JYAIaY2hRp6rpLhWn3UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525631179; bh=ks20d
    1VBd9OJrM0zbxay+bGYbinPZMNexsancfPSSN0=; b=J7IqNffwolLwY+YTEMg6r
    6IkTikgHP0rBFG9ipGf3gyHdNfTd2eDdbP+WxJjVowTJzMCMQsUePRy7RhHibRPu
    OWMXongBMufyleSFZcLgLMZ2aFL0a+XcrSW0H+vYxuG/Dq48VUVRocf66PLNrISP
    YB0pun51oUGfHu6dGef1wTcVdDlbUX1Xmkqq9tKUJid8qrRJCWHTlckultVRRN5E
    B3+9rNXq6+ePFSNTutck+/Ro3Y7D4I6JyDcG1EbH9gFnHn2KMdJGvFue3R0iT2hr
    nQbc/8IkW3z8fnIFaAG/I8xTcP20G2Y72Rd61sKmo9tmlbC4tspQ+7zo6s3Lauvb
    Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=c31k669y x-bits=1024
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=c31k669y x-bits=1024
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
X-CM-Envelope: MS4wfG4UdWJZei4jNrDXo8WZUMZ5lY5npP/l03MjNcAyXWvXqdIXcscONI+ZQhnfmFJoLFIHKDLPnELvJO9I+uMOgf3++UnGFL2xEPpGDcxF/9CkC2qcjXlP
    QZh3iwqb1Z+VBfTlSoY4q/O+f6xofK86AE8AE9JEWPpFsKxs53Vyhd4oHzMh0VTLDBYc25qOWwPzos8K4K2EW0SALbcc4ZzzzaZrdlgPGLCaM2rngGnH9Z14
    va8E9iwpSHDFRh3CR2LyPw==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=jXuWQn543RUbTG4LIugA:9 a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Sun, 6 May 2018 19:26:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH v2 08/11] staging: iio: tsl2x7x: add device ids for code
 readability
Message-ID: <20180506192605.46438f81@archlinux>
In-Reply-To: <20180504025319.28953-9-masneyb@onstation.org>
References: <20180504025319.28953-1-masneyb@onstation.org>
 <20180504025319.28953-9-masneyb@onstation.org>
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

On Thu,  3 May 2018 22:53:16 -0400
Brian Masney <masneyb@onstation.org> wrote:

> This patch adds the device IDs to the device_channel_config array to
> improve code readability.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index e3e37501829f..39de5e60fd33 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -273,16 +273,16 @@ enum {
>  };
>  
>  static const u8 device_channel_config[] = {
> -	ALS,
> -	PRX,
> -	PRX,
> -	ALSPRX,
> -	ALSPRX,
> -	ALS,
> -	PRX2,
> -	PRX2,
> -	ALSPRX2,
> -	ALSPRX2
> +	[tsl2571] = ALS,
> +	[tsl2671] = PRX,
> +	[tmd2671] = PRX,
> +	[tsl2771] = ALSPRX,
> +	[tmd2771] = ALSPRX,
> +	[tsl2572] = ALS,
> +	[tsl2672] = PRX2,
> +	[tmd2672] = PRX2,
> +	[tsl2772] = ALSPRX2,
> +	[tmd2772] = ALSPRX2
>  };
>  
>  static int tsl2x7x_read_status(struct tsl2X7X_chip *chip)

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
