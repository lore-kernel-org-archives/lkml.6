Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-126354-1522304151-3-14498239301561795578
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522304150; b=ohz7XGui0+3PFUT3DI2x9osX/H3JPDa7uFbSJIsacHsiTNv
    deJpWQNOeK76eUELzN1jltAki6qAX7A3iAlJ5mC8nh9YeiUAt1aT82fxULmrCIcF
    dxarycWmkpkxRnaDRX6NwCrIFzLlk7Hmf2Ew2s0umfVxqU5AbpiOpHZA1zoqUyqY
    V+YiYbMtYYacWUmQ/r8lFtrsZ+0dDYrLgtnOlXbcCADUOHPD+hS8OnTW5z1u2Ngf
    PjWLVRS7Ho4SKRT6Vtxzh3BXm0YtPOD4D+MjoGmcCHP0833tN8FSrVe8b1/a0Tt3
    sirRpLiPCvov0IfUn2ZgNq59g6VgYZt0I2l+LvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:date
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1522304150; bh=f
    e8npd5h0EBpzQDEUzaAZxWnIKGmAza8XdhTh5CNBb8=; b=g6cz7GizwYE1XyKYL
    0CiAhbUevr25RfcV/bOIH//QKTPA8s8CbDl6L6fp1HbDBzJYNE/0gAbaApZFA0AU
    dFMvsb4zeyf354GO/b01H1LWp9PCYq4icCOtFOyCWaTggtRF1IOyarWdeM3cuCxp
    F874NUJp3Td1zhxFIECF3ObADfZSo0NCAM7sEQIYoxnoGAT7QDEvrAwsi+3tdFbD
    5L8i08qmV56OogQSG/mZ8lRG12RK7Qexoi4PKHTSiJrT+RRx3dDLQnjEJcYEgoWA
    0CjLXPaXXczkX+R2yppJUj1Lo0wYJCN+7u/7+u3/JD6M+ecK7bFst76zFZ7Loa0c
    r2qBw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=perches.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=perches.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=perches.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=perches.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLJKtDUZZH1ojEB2LLjPtaGf5K/5TEqrqPGxi4RGXAKMh2aB9j4HPe+fIaC1zp3wlqD5iXVcovAID/WSDfTL7JgU7QzPvaXY8eDvofgBNaGFFKSc4rhz
    I6xsGp+F1AuAfCVWlTqX0rpLFvG+ynAsTf4Isywjwi4/T8Xxxk5Aw62OfCMAAsYJX8mBxxHQwxD2TLAyzn/KmLp3OIk8SjavYuVNRFAdImOgqzS+UATL4qfc
    BqNzPF9GECyUaGbL5Y5WSQ==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=lSkAmSfmPWUWBljS_vgA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Remote-Spam-Summary: 2, 0, 0, , d41d8cd98f00b204, joe@perches.com, :::::::::::,
 RULES_HIT:41:355:379:541:599:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1539:1567:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:4321:5007:7903:8603:10004:10400:10848:11026:11232:11473:11658:11914:12043:12740:12760:12895:13069:13161:13229:13311:13357:13439:14659:14721:21080:21627:30054:30091,
 0,
 RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,
 CacheIP:none, Bayesian:0.5, 0.5, 0.5, Netcheck:none, DomainCache:0,
 MSF:not bulk, SPF:fn, MSBL:0, DNSBL:neutral, Custom_rules:0:0:0, LFtime:20,
 LUA_SUMMARY:none
X-HE-Tag: food95_1412961adf52b
X-Filterd-Recvd-Size: 1530
Message-ID: <1522304136.2210.23.camel@perches.com>
Subject: Re: [PATCH 9/9] staging: ks7010: Remove extra blank line between
 functions.
From: Joe Perches <joe@perches.com>
To: Quytelda Kahja <quytelda@tamalin.org>, gregkh@linuxfoundation.org,
 wsa@the-dreams.de
Date: Wed, 28 Mar 2018 23:15:36 -0700
In-Reply-To: <20180329055152.13059-9-quytelda@tamalin.org>
References: <20180329055152.13059-1-quytelda@tamalin.org>
 <20180329055152.13059-9-quytelda@tamalin.org>
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
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
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-03-28 at 22:51 -0700, Quytelda Kahja wrote:
> Remove an extra blank line indicated by checkpatch.

The changelog doesn't match the actual changes made.

> diff --git a/drivers/staging/ks7010/ks7010_sdio.c b/drivers/staging/ks7010/ks7010_sdio.c
[]
> @@ -305,7 +305,8 @@ static void tx_device_task(struct ks_wlan_private *priv)
>  	if (priv->dev_state >= DEVICE_STATE_BOOT) {
>  		ret = write_to_device(priv, sp->sendp, sp->size);
>  		if (ret) {
> -			netdev_err(priv->net_dev, "write_to_device error !!(%d)\n", ret);
> +			netdev_err(priv->net_dev,
> +				   "write_to_device() error (%d)!\n", ret);


_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
