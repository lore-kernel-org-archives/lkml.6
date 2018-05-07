Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1362602-1525715986-2-1017761663079448604
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525715985; b=MjQWyvCAp/uebdYJV7KvG62HhhwJpP2ksk7VE/QJ8TSNV/vbCe
    DVA9ryjiVylwEWkZF0imMZsIb9cfLjXQWczyzvXHUQGSLCLUH5bqTgIW2K1kipWC
    q4JLR4bpT+vQw9H26AZxipJ5AchTROHRkNNm/CjKHerlPDOpdVUgjnGF+loZmfou
    IOHyvd/2cwp/Lwb8eXhRsLNjbR47w4REFeS936X+JR/t8dwT0e/su77smXag82s/
    M/vm9TOqXzlBdCNAF8KVeVD2i/m3IxOFsZRwKFTXVJo7+Fob5gEYTyGUt+ISAh+T
    ooufOqVRfws0sF/X/lcYXSK2MclEdB27QVhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525715985; bh=bqKEx
    uPCDt/HiSnBv98c9+hL6wQycYLU6np4Ld+5jXI=; b=klLMdYJ7UrzlWvxFYLpyB
    NC30UeKnmTnZ4R8ZasyCnh+t54uIsRLRb0/Uyi2JNhkcQFbqkPppATBhPTEZWw+4
    KgKqwMcvkXusE0UxbqbClLvhCnq9PSyGAYDqjsKx1KNeFZ5kYzhltGo+8dD6ALLz
    YniIV65/JRpT9xAcItLbBkb83/sxxYPOKwh0EuqyfR663aBdEw+8oCVX2DUXm9J3
    ZjxPe4I06tg77tECVzKisoyWGe6IxWo7A1VrkClviaOlJlnPD/y1NRED4SqNipsI
    0LiBgtfaDiyEFf1f3zifk9DthItkthBSBfiD+xXgTPLFbbMMGcV19oY84BUgfYyN
    Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=OBlxQ+ZU x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=pU1vpTLV;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=OBlxQ+ZU x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=pU1vpTLV;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFe8A5J6B6KJTc6ZjM6AGLL0ZR49VQ07zQRW6eqiIw+DiiLuFjK48zfHa/yTIZjE/3CYNDrnCCKzwsURDMEwAL1QGbm9WAt73MAbj32cuoUjri9aYgA4
    E6W/bZOybckXFEvyF+IwaBiPG2FIuZYBQNmApELpzkb89V70hXDDNfAmsuONy+DBthtZSfT4QXddr8UnVylixZtHsBMAPb9dTeoTIBYI7fmdwtMgAIOg4lt0
    iDIobx9wL9EVaKbOd087Cw==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=vY_346TuTMEA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=pr1uMUhtlroiFnFafKwA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZra8Ud1h08eaH5PiSsQkSKm6A4B8BHT2kIEPPHq6qRSHxhwEhUjYByrRhz07+XaZE/xI9RBhA==
Date: Mon, 7 May 2018 10:59:34 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: devel@driverdev.osuosl.org
Subject: Re: [PATCH 2/7] staging: ks7010: Remove unused variables
Message-ID: <20180507175934.GA14302@localhost>
References: <20180506220304.13040-1-natechancellor@gmail.com>
 <20180506220304.13040-2-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180506220304.13040-2-natechancellor@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, May 06, 2018 at 03:02:59PM -0700, Nathan Chancellor wrote:
> GCC warns these variables are all set but never used so remove them.
> 
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/staging/ks7010/ks_hostif.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
> index c0a9a67dc0b4..4c2f8f710c6e 100644
> --- a/drivers/staging/ks7010/ks_hostif.c
> +++ b/drivers/staging/ks7010/ks_hostif.c
> @@ -354,7 +354,6 @@ void hostif_data_indication(struct ks_wlan_private *priv)
>  	unsigned short auth_type;
>  	unsigned char temp[256];
>  	struct ether_hdr *eth_hdr;
> -	unsigned short eth_proto;
>  	struct ieee802_1x_hdr *aa1x_hdr;
>  	size_t size;
>  	int ret;
> @@ -369,7 +368,6 @@ void hostif_data_indication(struct ks_wlan_private *priv)
>  	get_word(priv);	/* Reserve Area */
>  
>  	eth_hdr = (struct ether_hdr *)(priv->rxp);
> -	eth_proto = ntohs(eth_hdr->h_proto);
>  
>  	/* source address check */
>  	if (ether_addr_equal(&priv->eth_addr[0], eth_hdr->h_source)) {
> @@ -464,13 +462,9 @@ void hostif_mib_get_confirm(struct ks_wlan_private *priv)
>  	struct net_device *dev = priv->net_dev;
>  	u32 mib_status;
>  	u32 mib_attribute;
> -	u16 mib_val_size;
> -	u16 mib_val_type;
>  
>  	mib_status = get_dword(priv);	/* MIB status */
>  	mib_attribute = get_dword(priv);	/* MIB atttibute */
> -	mib_val_size = get_word(priv);	/* MIB value size */
> -	mib_val_type = get_word(priv);	/* MIB value type */
>  
>  	if (mib_status) {
>  		netdev_err(priv->net_dev, "attribute=%08X, status=%08X\n",
> @@ -792,9 +786,6 @@ void hostif_ps_adhoc_set_confirm(struct ks_wlan_private *priv)
>  static
>  void hostif_infrastructure_set_confirm(struct ks_wlan_private *priv)
>  {
> -	u16 result_code;
> -
> -	result_code = get_word(priv);
>  	priv->infra_status = 1;	/* infrastructure mode set */
>  	hostif_sme_enqueue(priv, SME_MODE_SET_CONFIRM);
>  }
> @@ -872,14 +863,13 @@ static
>  void hostif_phy_information_confirm(struct ks_wlan_private *priv)
>  {
>  	struct iw_statistics *wstats = &priv->wstats;
> -	unsigned char rssi, signal, noise;
> +	unsigned char rssi, signal;
>  	unsigned char link_speed;
>  	unsigned int transmitted_frame_count, received_fragment_count;
>  	unsigned int failed_count, fcs_error_count;
>  
>  	rssi = get_byte(priv);
>  	signal = get_byte(priv);
> -	noise = get_byte(priv);
>  	link_speed = get_byte(priv);
>  	transmitted_frame_count = get_dword(priv);
>  	received_fragment_count = get_dword(priv);
> -- 
> 2.17.0
> 

On second glance, I did not realize most of these functions involve
pointer semantics. Please do not apply this. I can send a v2 series if
necessary although every other patch is fine.

Thanks,
Nathan
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
