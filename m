Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2070142-1519886036-2-2763743605425137925
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='cc', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519886035; b=RjjyAahtWyeYh56g+jfSyIB0IFbdmToADw+133eqsibBgut
    UuCWTpoQGxtk/oIgixqbYay0s9EhN9dsapJTrLmutNfbm6J5zjpYe+2G+KeyiZUZ
    QGvVtEhnMrF+vgzlUttXLL6U9ThwROSHGDbs8zDGrW8twBgJ3ZiMUad37hDHe+R5
    aK5qnlNX281V/Sa4giN3RZnsrx0Snhy/YKanGNcUoklXBFI48r3NCYUqQqxjcm+I
    1BRSuMaNHkhNcJzX+v6UMbvfydMuqSavzWe7RcuFyrMUTQb67pD56DBh+pagE7+Z
    ncS0arEBln1kh181Usl7/Oop5NPURkcugHes0/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519886035; bh=k
    51Ufs/ItwmQ3fFmIeFdtGMco0tcse4unASbUSE+nTU=; b=MvgERXpJ/I+8zrBNm
    sLFbYSS7OWIpXLAuBkfSo73JHWgGKjbpnswV/yQ0Sbp1lUgUbhTOCnJVZmvJp1jT
    u0DRz12gMygwS8Ktlvbobmv2AHDr3u9McadnjEy4zxSVmjcaG1vnToNKJ8lKNY3N
    J/vbe4B0+57ie8vJ2cxj/sKhxppidELa00YP4GrzXXW8p84BY2GbSdESaglHjV0/
    cy0uJ1VvW5cm5PVDxRs0wh8n6n5U8cIGWBS4kIucnW7u8MSWX5/8xgpBSpHfE1XP
    YOzfoq8nzgxmOgxoLBf8ey5O77mhHucn2OJ86c4hY0DYkaBjOOUDCrcWglN/hdfc
    kWIbA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=bCVaW0a3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=tobin.cc header.i=@tobin.cc header.b=bWVEOMfP x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tobin.cc;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tobin.cc header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=bCVaW0a3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=tobin.cc header.i=@tobin.cc header.b=bWVEOMfP x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tobin.cc;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tobin.cc header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-ME-Sender: <xms:yJ6XWhYc4O27ro16Oagy_B2LSEjPVPLfpmc7ipBLmkXQtjJMn_fNNA>
Date: Thu, 1 Mar 2018 17:33:40 +1100
From: "Tobin C. Harding" <me@tobin.cc>
To: Quytelda Kahja <quytelda@tamalin.org>
Subject: Re: [PATCH 1/5] staging: ks7010: Use constants from ieee80211_eid
 instead of literal ints.
Message-ID: <20180301063340.GB4059@eros>
References: <20180301051911.1314-1-quytelda@tamalin.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180301051911.1314-1-quytelda@tamalin.org>
X-Mailer: Mutt 1.5.24 (2015-08-30)
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
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
 driverdev-devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
 wsa@the-dreams.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 09:19:07PM -0800, Quytelda Kahja wrote:
> The case statement in get_ap_information() should not use literal integers
> to parse information element IDs when these values are provided by name
> in 'enum ieee80211_eid' in the header 'linux/ieee80211.h'.

Nice.  Magic number removal, I like it.

> Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
> ---
>  drivers/staging/ks7010/ks_hostif.c | 31 +++++++++++++++----------------
>  drivers/staging/ks7010/ks_hostif.h |  1 +
>  2 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
> index 74a08417bd0b..67cf32433023 100644
> --- a/drivers/staging/ks7010/ks_hostif.c
> +++ b/drivers/staging/ks7010/ks_hostif.c
> @@ -251,9 +251,8 @@ int get_ap_information(struct ks_wlan_private *priv, struct ap_info_t *ap_info,
>  	offset = 0;
>  
>  	while (bsize > offset) {
> -		/* DPRINTK(4, "Element ID=%d\n",*bp); */

nit: Probably shouldn't remove debugging output in the same patch as
doing magic number removal.  (super nit-picky though.)

> -		switch (*bp) {
> -		case 0:	/* ssid */
> +		switch (*bp) { /* Information Element ID */
> +		case WLAN_EID_SSID:
>  			if (*(bp + 1) <= SSID_MAX_SIZE) {
>  				ap->ssid.size = *(bp + 1);
>  			} else {
> @@ -263,8 +262,8 @@ int get_ap_information(struct ks_wlan_private *priv, struct ap_info_t *ap_info,
>  			}
>  			memcpy(ap->ssid.body, bp + 2, ap->ssid.size);
>  			break;
> -		case 1:	/* rate */
> -		case 50:	/* ext rate */
> +		case WLAN_EID_SUPP_RATES:
> +		case WLAN_EID_EXT_SUPP_RATES:
>  			if ((*(bp + 1) + ap->rate_set.size) <=
>  			    RATE_SET_MAX_SIZE) {
>  				memcpy(&ap->rate_set.body[ap->rate_set.size],
> @@ -280,9 +279,9 @@ int get_ap_information(struct ks_wlan_private *priv, struct ap_info_t *ap_info,
>  				    (RATE_SET_MAX_SIZE - ap->rate_set.size);
>  			}
>  			break;
> -		case 3:	/* DS parameter */
> +		case WLAN_EID_DS_PARAMS:
>  			break;
> -		case 48:	/* RSN(WPA2) */
> +		case WLAN_EID_RSN:
>  			ap->rsn_ie.id = *bp;
>  			if (*(bp + 1) <= RSN_IE_BODY_MAX) {
>  				ap->rsn_ie.size = *(bp + 1);
> @@ -293,8 +292,8 @@ int get_ap_information(struct ks_wlan_private *priv, struct ap_info_t *ap_info,
>  			}
>  			memcpy(ap->rsn_ie.body, bp + 2, ap->rsn_ie.size);
>  			break;
> -		case 221:	/* WPA */
> -			if (memcmp(bp + 2, "\x00\x50\xf2\x01", 4) == 0) {	/* WPA OUI check */
> +		case WLAN_EID_VENDOR_SPECIFIC: /* WPA */
> +			if (memcmp(bp + 2, "\x00\x50\xf2\x01", 4) == 0) { /* WPA OUI check */

Shouldn't have this line (unnecessary white space change)

>  				ap->wpa_ie.id = *bp;
>  				if (*(bp + 1) <= RSN_IE_BODY_MAX) {
>  					ap->wpa_ie.size = *(bp + 1);
> @@ -309,18 +308,18 @@ int get_ap_information(struct ks_wlan_private *priv, struct ap_info_t *ap_info,
>  			}
>  			break;
>  
> -		case 2:	/* FH parameter */
> -		case 4:	/* CF parameter */
> -		case 5:	/* TIM */
> -		case 6:	/* IBSS parameter */
> -		case 7:	/* Country */
> -		case 42:	/* ERP information */
> -		case 47:	/* Reserve ID 47 Broadcom AP */
> +		case WLAN_EID_FH_PARAMS:
> +		case WLAN_EID_CF_PARAMS:
> +		case WLAN_EID_TIM:
> +		case WLAN_EID_IBSS_PARAMS:
> +		case WLAN_EID_COUNTRY:
> +		case WLAN_EID_ERP_INFO:
>  			break;
>  		default:
>  			DPRINTK(4, "unknown Element ID=%d\n", *bp);
>  			break;
>  		}
> +

FTR try not to include unrelated whitespace changes.  I see you changed
the case statement but the whitespace is after it and not really
related.  Again quite nit-picky but I'm guessing you are in staging to
learn so might as well learn it now than when you are patching the core
kernel :)


Good work,
Tobin.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
