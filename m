Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1133588-1524486030-2-13988081933673208436
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524486030; b=m1Lz+eoz93TuQb/agksaxXoN6klOcD0bypUPGhqhH4xrD7+1yn
    NaHHD/QDbV+zAElFHrejvu/33CXHy5eOrZe7ArEukRotd62dHh56rhDbPX+tgxb2
    UC6dDs4ubqYAfiDzakULKN967TzeaeUNRoQYJEwh3gRDeyYCaF1n2k9l7nJRH+i6
    mqHuRgWoctg/hnrswT9N5qMznYMzA0mTIO7WVx3zMYMN3XHE/tWjbEq+l9mVtaMZ
    ugDKOqQiMHMqwIaK3jKXw2++8mswmdiZEqwxEMzcf4/bZXcjDsKzzo5tC1P35X1/
    kxIedOTU1Dk+b9uO5GmmFJ+mcqRThsKVDcpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524486030; bh=ceCDP
    dshF3p9vaO1xbdmKSB5CWXucolUZtT+020xKFM=; b=XXF14xCLQfydwpnHEyqEz
    cbURYuJWTcQwv1zhWm9kVt7KyN4/GMo4vgvqkCvdWl7Td1X7I+ndsHPiF+/ELMZJ
    KCkUZhm0PGWSPHAYPM9MRPeI71gnrrs7tY0Ujf9ZpfuQ/z5ItrMSiGGyE6e13h/w
    ALaMjZ0YFpzQs/orrI7gzoP/lXHfrahnzzU7/tvJ59FRNS0y5ASbPCAetNORDpg3
    dW4167NLaCPPTis3QaArWoqPoJAkU5S4M6rOPWoODOFYXaPLzIrXUUp9SGTGT+tx
    84NKJiZopt5uKK/BvVTH07KPXh0dCvniripKU3opjaUq/WaPwvLsW6tlTPU4Sg/v
    w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOfhbx1homQ9rDO7WN3aoFpwt19bYE+JRoPHQ9HLhhqnkDvVxZwDlmgXARwZq4ak1qWwgAsHzKAlrp7punNasNI9Toe7ve16e9yE8GtrjtSa0YX0FGgw
    kuXigGE4HBxEreUIPAWRBp6Xj506vAgsf7H3LgZvwIKcoISWNdcie4BUQiWSUOFax8zxyXleIjpXN/NBeB05Y00Fas7joRrUwkAWIEvI5jZgqpSEk14iuP3C
    WbOMvfXQFShJQclw9hHiYQ==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=7qWs73fSjE7IAAGP654A:9 a=arwKyck18Mnk8ZL_:21 a=h34G491bg4AfSIqg:21
    a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 23 Apr 2018 14:20:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Quytelda Kahja <quytelda@tamalin.org>
Subject: Re: [PATCH v2 75/75] staging: ks7010: Replace memcpy() with
 ether_addr_copy().
Message-ID: <20180423122017.GA30910@kroah.com>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
 <20180331060855.9452-75-quytelda@tamalin.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180331060855.9452-75-quytelda@tamalin.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
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
Cc: devel@driverdev.osuosl.org, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org, wsa@the-dreams.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 30, 2018 at 11:08:55PM -0700, Quytelda Kahja wrote:
> ether_addr_copy() is the function for copying a hardware address,
> so replace the manual memcpy() operation with ether_addr_copy().
> 
> Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
> ---
>  drivers/staging/ks7010/ks_hostif.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
> index b5a2ba702dec..a461dd568d28 100644
> --- a/drivers/staging/ks7010/ks_hostif.c
> +++ b/drivers/staging/ks7010/ks_hostif.c
> @@ -522,7 +522,7 @@ void hostif_mib_get_confirm(struct ks_wlan_private *priv)
>  	case DOT11_MAC_ADDRESS:
>  		/* MAC address */
>  		hostif_sme_enqueue(priv, SME_GET_MAC_ADDRESS);
> -		memcpy(dev->dev_addr, priv->rxp, ETH_ALEN);
> +		ether_addr_copy(dev->dev_addr, priv->rxp);
>  		priv->mac_address_valid = true;
>  		netdev_info(dev, "MAC ADDRESS = %pM\n", dev->dev_addr);
>  		break;
> -- 
> 2.16.3

Not all of these patches applied.  Can you please rebase and resend the
remaining ones?

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
