Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1194855-1524489948-2-10687782008873392923
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524489947; b=R5DImWyzf66zZ9omZQMmXeCr2gecHDiNhB3OeZhl9LTW7EGzSv
    k3CwnIauTgrAFfQmC8qkjZDOM6/gFTS260kO32FZCIKrao80KvSneCJD7jXbPrsk
    J8bOlerD7YlEvLCrdRG+TWpQFWxzUOFzwCWz1ZM0AhJA6Hja5XrCefqrj9HIVYRq
    oMONj1VAHYHSV16GceFHsvTVXmnTdlmIKxyVO5XbgY5CTXLGXbjaug2ML51v3gza
    dMfEpe/5eSyfvyDWFUfL1A1o6St6KDcoQ2Ag4BZWYO/YH/xUsVHXzyp0MPKVefIn
    XHRXoOhOB12abzb33Uzul9jiI0Iq5Y760PLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524489947; bh=do779
    NqdilzewoNuKn5BBWWEiJkpstmTRaotUdanr5w=; b=wancSiwBKHZ8Rmyxpc1oc
    HWGo2ki7/8RiSQT2shIdjr0GMPmwD3VYRb7oqd8wHmhxbNL3lRXUEfRZRGwdcrRP
    tZJDrBFNGZPpa9OABB/ox8Y1BvaFN+clgFtAcvYmtoKHyexbuls3FZKQMr2oOb/J
    ZBmT6tQuDog/+fXLSzNsXB368Q93W4U1tzAI8Q2j9/4uKueb0HSqjEB1jkYDb8Ie
    fMpWG1f2LNkxboibiBqrdczJ9WzFkqqg1I43GBEo9KTC/wI0LMF3ePY8OozyBfDS
    s3boLePBugIMFl0pqF1u+YhsoMuFNRtiLUsBw16X7yOmPeOGv3H/SrOq1knvoVZq
    A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLfXSSAcwMJ8Q2UQHtSLjLknSCauhCkcGcwqy4eponqFKXU5E4wWQs+mESCk6SHLva1gNk5b1+KYyllZMWH/Vu5pVVIQmOWl5IFH3q2jT9FKkI6oqafm
    J3E5f0UcPaPZ1S/PYqMbFsTTjetoEFC12lc5hxKbrr6NhoJRE5OE5XH5Z9d83wx7P6l2lk/75SkUS4I9AS289mffD/xSw8MAAt4W4SY4aaJhlxDuqI0P9E4r
    cP/H8dYzeddEQi4tezerEA==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8
    a=CkfRvMMiBf6NawJzIJYA:9 a=klRJendI_qFQ-kya:21 a=pPQcllndnpdoVz6F:21
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 23 Apr 2018 15:25:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jefferson Capovilla <jefcap@gmail.com>
Subject: Re: [PATCH] staging: mt7621-eth: fix line over 80 char issue in
 mtk_set_link_ksettings()
Message-ID: <20180423132532.GA16104@kroah.com>
References: <20180404013050.GA31356@jefcap-VirtualBox>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180404013050.GA31356@jefcap-VirtualBox>
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
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 03, 2018 at 10:30:50PM -0300, Jefferson Capovilla wrote:
> Fix 'line over 80 characters' issue found by checkpatch.pl script in
> mtk_set_link_ksettings().
> 
> Signed-off-by: Jefferson Capovilla <jefcap@gmail.com>
> ---
>  drivers/staging/mt7621-eth/ethtool.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/mt7621-eth/ethtool.c b/drivers/staging/mt7621-eth/ethtool.c
> index 38ba0c0..e9f4092 100644
> --- a/drivers/staging/mt7621-eth/ethtool.c
> +++ b/drivers/staging/mt7621-eth/ethtool.c
> @@ -52,7 +52,8 @@ static int mtk_set_link_ksettings(struct net_device *dev,
>  			mac->phy_dev = mac->hw->phy->phy[cmd->base.phy_address];
>  			mac->phy_flags = MTK_PHY_FLAG_PORT;
>  		} else if (mac->hw->mii_bus) {
> -			mac->phy_dev = mdiobus_get_phy(mac->hw->mii_bus, cmd->base.phy_address);
> +			mac->phy_dev = mdiobus_get_phy(mac->hw->mii_bus,
> +						       cmd->base.phy_address);
>  			if (!mac->phy_dev)
>  				return -ENODEV;
>  			mac->phy_flags = MTK_PHY_FLAG_ATTACH;
> @@ -62,7 +63,6 @@ static int mtk_set_link_ksettings(struct net_device *dev,
>  	}
>  
>  	return phy_ethtool_ksettings_set(mac->phy_dev, cmd);
> -

You did this too :(

Don't lie in a changelog text, please fix up and resend.

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
