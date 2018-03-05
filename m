Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-999826-1520234223-2-12508144106643951211
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='fr', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520234222; b=pvscWmt4W/U64JMjnew7UDR5i0rNruHIHT9bFGYTnxHP5qt
    m6+pl9e/8A3KsDqXoBTn+t/dUd6c3XsjGj84P9VRTcbIPxhl7jEgh7c3HCsg6v2U
    WTulcCwazw0rc6Z1//aCqlp9+Irv6aAD1RgEAIXQCfzSHf8r4YVSjszM2jv37l39
    B7bFKhUEvJOOnVLDK3EeP4KRvGifaaXQb2YEHTJHi5Riwx4btGkD84HCfTNjtn7y
    HgMmxVqPgewf4TaOk1pqR2HUP/dnLrU0pJv3352xUKrW1hNdqkMlpal1iS1j/2wS
    P8Gh/w/gG81ZQ5GlSDBUOGIMIXGHiaWWRp71GEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:in-reply-to
    :message-id:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520234222; bh=K
    cdPoPO8iX8xrJ2GCx8cx3ZS2i8h1tsnVVNENSTZpXU=; b=tM5EozdcENPnYRtZ4
    POVpkGuBdl2WdccZfrPqGoLhrhOSiw82+c7FCws70/DdBCaLsLKZ9f1D7YgHbcZm
    Dv4LKwwCH17tIqoXZzJ/VkOyHinlZL/xGuNRRTD3jX8chOOadbX43B1oVbWYjKOr
    MPeuCRZLKYf2iGEDOC2Y47ouz+WINcjNMhpfCjq0llEpteJCzCuk8pNwQDjIyJUv
    erFL+FV48k3ieSyVchh426LGl8xy77AwZ6iirC4uy5l50M/tZ5f5VKJItRBLk2GU
    GHwsE+UqcPErKD+7HGqIsLHbTEkMMp/7XzWortLEaNh1jxruerEKMxmm5W26ITEb
    SD0cQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lip6.fr;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-51 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lip6.fr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lip6.fr;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-51 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lip6.fr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-IronPort-AV: E=Sophos;i="5.47,426,1515452400"; d="scan'208";a="256957767"
Date: Mon, 5 Mar 2018 08:16:50 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Subject: Re: [Outreachy kernel] [PATCH v3] staging: ipx: Replace printk()
 with appropriate net_*macro_ratelimited()
In-Reply-To: <20180305041740.GA23378@seema-Inspiron-15-3567>
Message-ID: <alpine.DEB.2.20.1803050816230.2306@hadrien>
References: <20180305041740.GA23378@seema-Inspiron-15-3567>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
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
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
 outreachy-kernel@googlegroups.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Mon, 5 Mar 2018, Arushi Singhal wrote:

> Replace printk having a log level with the appropriate
> net_*macro_ratelimited.
> It's better to use actual device name as a prefix in error messages.
>
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> ---
> changes in v2
> *In v1 printk was changed to pr_*macro(), which is used
> in kernel instead of calling printk() directly. And for drivers,
> dev_*macro() or net_*macro_ratelimited() should be used for calling
> printk() directly.
>
> changes in v3
> *Indentation is not changed, as line is exceeding 80 characters limit.

Put the v3 changes on top of the v2 changes, so that one can see
immediately what has changed most recently.

julia

>
>  drivers/staging/ipx/af_ipx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/ipx/af_ipx.c b/drivers/staging/ipx/af_ipx.c
> index d21a9d1..5ec6591 100644
> --- a/drivers/staging/ipx/af_ipx.c
> +++ b/drivers/staging/ipx/af_ipx.c
> @@ -744,7 +744,7 @@ static void ipxitf_discover_netnum(struct ipx_interface *intrfc,
>  			intrfc->if_netnum = cb->ipx_source_net;
>  			ipxitf_add_local_route(intrfc);
>  		} else {
> -			printk(KERN_WARNING "IPX: Network number collision "
> +			net_warn_ratelimited("IPX: Network number collision "
>  				"%lx\n        %s %s and %s %s\n",
>  				(unsigned long) ntohl(cb->ipx_source_net),
>  				ipx_device_name(i),
> --
> 2.7.4
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20180305041740.GA23378%40seema-Inspiron-15-3567.
> For more options, visit https://groups.google.com/d/optout.
>
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
