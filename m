Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A84FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D982A20866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOUEeR8z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D982A20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbeINVOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 17:14:46 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40451 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbeINVOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 17:14:46 -0400
Received: by mail-lf1-f67.google.com with SMTP id x26-v6so8296418lfi.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 08:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eRbZc/y0P7bbQ7FbptUHdaIHHqc2nA8r25gdpXT6jDI=;
        b=IOUEeR8zVZGLj28tbvvakwZxA+cav2FMuTH690bHPnqYtxVgHcXwXrU+kKwNHb2OLw
         hYzVo2XShs6PDrqk+7295IvdVOnYMETU+o8I9kyF3lf09l64jofD3Z7ERXs1vv8BYb4t
         DiE/CtPUUob8qvgg+6s83b29ZK0KWeQepLdTDBhrEeyYJTUu8UAHqtYT8wYvhhPQFG/y
         lXfklojSkv0I/lkjP48oqighw6yeVu5oAhxbFeE1qcIz0UeIoc313gP/g8m5m5brUp4H
         6S6fKxqZbw3OTRJjtOBGCM7ga07U10ivW2ApzXw2VWVIPr0hmZ4kKYysCJsygmtVqYRo
         j4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eRbZc/y0P7bbQ7FbptUHdaIHHqc2nA8r25gdpXT6jDI=;
        b=mMgmrKOXVCXwIVe/dRJME8lIRhyvzx/jWbdfuXelobwUIM2zF9SU58CnWd3sYTvuiY
         c3YJwqa5+7SXB/3HShuAGkOMnHpxTu2qK61LWsZf/o/NYpLqHPxy97GHsLGT+ZiYA3Kg
         EMB9siDse9gPFaZ2GZ0BTp9XfgwC4641zD31yzUdZkwi2yXWLa0Z4sm1/uN6qMRA33b3
         wl/JBrD3pUOxAZM+VidD286Hk7IaZ2778sirem2omoPIEDru2CBIzyoYFiC2nEzgkeQF
         FjiAAtAw/lf9qiMer8KY/1U8OToI5Ykh4K7fIBTPHQpTBMYaxlX1ju5hMqbkHrwxnfaC
         Bp2w==
X-Gm-Message-State: APzg51CSAo5pAcRzQQI6961en/fHbM9mJFtqoTYFxZTDrHE6H83NMpSA
        evpFtXnugJpAsFg92Q3wR5c=
X-Google-Smtp-Source: ANB0VdYhghhl2tAEHOcU6ZxTs5t5uh8JgLTr4Hy12CzoAzUVwGJ5sla/shCzAW1m4LMzksaftIf5Xg==
X-Received: by 2002:a19:73c5:: with SMTP id h66-v6mr8955798lfk.22.1536940777639;
        Fri, 14 Sep 2018 08:59:37 -0700 (PDT)
Received: from localhost.localdomain (staticline22297.toya.net.pl. [217.113.232.143])
        by smtp.googlemail.com with ESMTPSA id 14-v6sm1278434ljc.74.2018.09.14.08.59.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 08:59:36 -0700 (PDT)
From:   =?UTF-8?q?Robert=20W=C4=99c=C5=82awski?= <r.weclawski@gmail.com>
To:     dan.carpenter@oracle.com
Cc:     =?UTF-8?q?Robert=20W=C4=99c=C5=82awski?= <r.weclawski@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Bhaskar Singh <bhaskar.kernel@gmail.com>,
        =?UTF-8?q?Kacper=20Ko=C5=82odziej?= <kacper@kolodziej.it>,
        Janani Sankara Babu <jananis37@gmail.com>,
        Santha Meena Ramamoorthy <santhameena13@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Manish Shrestha <manishshrestha2006@gmail.com>,
        Valentine Sinitsyn <valentine.sinitsyn@gmail.com>,
        Aishwarya Pant <aishpant@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8188eu: remove code that is valid only for 5 GHz
Date:   Fri, 14 Sep 2018 17:58:58 +0200
Message-Id: <20180914155905.4891-1-r.weclawski@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180914061232.323jxklcp75ugtvr@mwanda>
References: <20180914061232.323jxklcp75ugtvr@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Sep 13, 2018 at 10:32:39PM +0200, Robert Węcławski wrote:
> > diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
> > index eca06f05c0c4..b610443f2ac6 100644
> > --- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
> > +++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
> > @@ -1819,16 +1819,6 @@ void rtw_update_registrypriv_dev_network(struct adapter *adapter)
> >  	case WIRELESS_11BG_24N:
> >  		pdev_network->NetworkTypeInUse = Ndis802_11OFDM24;
> >  		break;
> > -	case WIRELESS_11A:
> > -	case WIRELESS_11A_5N:
> > -		pdev_network->NetworkTypeInUse = Ndis802_11OFDM5;
> > -		break;
> > -	case WIRELESS_11ABGN:
> > -		if (pregistrypriv->channel > 14)
> > -			pdev_network->NetworkTypeInUse = Ndis802_11OFDM5;
> > -		else
> > -			pdev_network->NetworkTypeInUse = Ndis802_11OFDM24;
> > -		break;
> >  	default:
> > 		/*  TODO */
> > 		break;
>
> Are you sure about this chunk?  I would have thought that <= 14 was not
> 5G.  (I try to avoid rhetorical questions and I don't know the answer
> here).
> 
> regards,
> dan carpenter

I'm 99% sure this part is not needed because this chipset only supports B, G and N WiFi networks.

I think we should add pdev_network->NetworkTypeInUse = Ndis802_110FDM5 to default case to be 100% sure it won't break anything.
If we do this we can be sure pdev_network->NetworkTypeInUse will be set.
Should I make a new version of this patch?
