Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57875C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 15:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051D821581
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 15:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYAIx2+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 051D821581
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbeHTSdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 14:33:37 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38458 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeHTSdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 14:33:36 -0400
Received: by mail-lf1-f66.google.com with SMTP id i7-v6so1606000lfh.5;
        Mon, 20 Aug 2018 08:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Anh+wFBOWVHH6iB+ZaJYW4xBDPvhY8pwv8o2LOamJ2g=;
        b=CYAIx2+2iWiQNU0E9oqxYRLpJ0DLM4s1FN7RAp3RxhTxgxWQjv/hTDLv2Vz8GyoLxj
         SDfBkf/UFJVNsAomAsthnUrBR/gC/lCkvV0ubnIs3OG6DH+Al86Yevplfb9CUWpEqmRw
         4sNHy+MAhtLgMivPfChG45uulif5HtbLZQTSEkf1HfywlTM0NXXa7h3heSKtplwXQV62
         R7WR4y/YqhWWQJBg61gStufBJ742wdixl80a30Z1PtUrSJ3HTmbgeo3mijeXx7Q52Lkh
         iIT31FszAvHDTdlzgQiFaBkLjCBRRj59fQ1DCydpWyaIgDYn0J1Mq8++Hyc8QIvhUvw8
         U5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Anh+wFBOWVHH6iB+ZaJYW4xBDPvhY8pwv8o2LOamJ2g=;
        b=Y7jlOeiR/LRrm7eWBJVsuy8r6EvL3z1GZAKStg8KE7yP6zbJeOGBqrCvZfVxrirQhP
         EKnmaqfpBfmSTkHG0jw2OWafSaFThj0rMcX5dWQ+YJIGXtxfk4aZf6u8J5qstHqGUqM5
         7O35dVmEQicAgRw2v8u4YL2kobguWxwmW5yuc6y+WeAs9PrNs/sfay3bTdXM/Kd2wRrB
         yE1lDoUFztRb82WxfF4qUd/FP/Y6pbtIfxplCeE43B7jssRktu2D9fUD+GqKkvuwBYOk
         a35CFFyWrLW0KOonN+/Ku+xtc7by3qAB72p1MRNH9keZzKW+6ri8+Dxrbc26iru/ATeF
         DLVQ==
X-Gm-Message-State: AOUpUlGH2UHsAzM4v6WL+gda3Pf+gE+lIA0x06Bpw7z+TtQIMHY9hU9l
        GVqNPbQIKm/oE3EQIKaPaDg6f9Q5
X-Google-Smtp-Source: AA+uWPxNje1qVmGuP5VXyeK1methNhN0IQqDhXvBaMjLs3P8c6uCNLYcOWDBpLcgLTLBbtFj8m57HQ==
X-Received: by 2002:a19:e991:: with SMTP id j17-v6mr12773818lfk.112.1534778252387;
        Mon, 20 Aug 2018 08:17:32 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id r73-v6sm1655970ljb.16.2018.08.20.08.17.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 08:17:31 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1frlvv-0000OV-LI; Mon, 20 Aug 2018 17:17:31 +0200
Date:   Mon, 20 Aug 2018 17:17:31 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Keerthy <j-keerthy@ti.com>
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, johan@kernel.org
Subject: Re: [PATCH v6 2/2] rtc: omap: Cut down the shutdown time from 2
 seconds to 1 sec
Message-ID: <20180820151731.GD14967@localhost>
References: <1534396140-1161-1-git-send-email-j-keerthy@ti.com>
 <1534396140-1161-2-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534396140-1161-2-git-send-email-j-keerthy@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 10:39:00AM +0530, Keerthy wrote:
> Cut down the shutdown time from 2 seconds to 1 sec. In case of roll
> over try again.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---

You forgot to include a changelog, but it looks like you've addressed
the issues with v5, and this now looks good to me:

Reviewed-by: Johan Hovold <johan@kernel.org>

Johan
