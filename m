Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01440C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE7920873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eUc7lTCr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE7920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbeLMKmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:42:51 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39543 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbeLMKmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 05:42:51 -0500
Received: by mail-pf1-f193.google.com with SMTP id c72so923375pfc.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 02:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qa0Qjrm5LRvT7JMQPccKOwXY+mphMRaaLgV5iYnYGOk=;
        b=eUc7lTCrvRz4j6QHumB8SgmYyIPb1ROiRZ0JfMvoFTpRuznXp/ECQCbvn4PypAJG20
         cN1zK9gEvj55sH8QICH6QAm5pgufXxVQvc+KkDDhou5CBRMSGB8hCYYwjkIJLo2xyXmX
         vmGonnFCxip5mbZs+sRUYoy1XWVNscsNldA1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qa0Qjrm5LRvT7JMQPccKOwXY+mphMRaaLgV5iYnYGOk=;
        b=n1zpdvdMduQt7uE5qwKhmGv8UAPxHSGujdb8ufj9Rzfx0/8/gml0VJs53QZ26H42+E
         USdHHMEoSKtFxVPdNHAX0FVl9wFvxqFEif06jUfBvQoc1zXmg7Ldciw/L+SyU6VdhPsg
         69fGV5NNZ8Z5sKrMG06Cm+TpDUoH30NdqJccvGLsS8Rd0Jh9inxsIMJnV7+T/AlkRjlF
         AqGey15pmnlKQ+WJFWv2M2fV4d1x9acuW9lQgPR25XJgGnv3oMRQwH2ElYbrTP4w8D/1
         K7r+BtAd2WCCxAKowJpctzgvfjgPx3iDka+rfghNdl2I69BaVNn4Un2nD33wj2U12SYy
         IjTA==
X-Gm-Message-State: AA+aEWZsvVfitkNCAfTQsRfgrW7HYllaxWS0p0lhX98STMqdkhYFsn9e
        kcbsRUNFUegv4VvnYEYO9ColRg==
X-Google-Smtp-Source: AFSGD/XfmN1+4I2XvAOUmv5fUZh3KEujjguaALXU25J5juJy9rYPFfvjTX5VbDQNBJ6D6dHnTqQRrQ==
X-Received: by 2002:a63:d208:: with SMTP id a8mr21069119pgg.77.1544697770477;
        Thu, 13 Dec 2018 02:42:50 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id n66sm2581150pfk.19.2018.12.13.02.42.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 02:42:49 -0800 (PST)
Date:   Thu, 13 Dec 2018 16:12:47 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nick Fan <nick.fan@mediatek.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        tfiga@chromium.org, Chiawen.Lee@mediatek.com, erin.lo@mediatek.com
Subject: Re: [PATCH] opp: Add API for getting voltage from supplies
Message-ID: <20181213104247.kosguuoukoi645pf@vireshk-i7>
References: <1543906760-15631-1-git-send-email-Nick.Fan@mediatek.com>
 <20181204082158.rb7uzdiwmcotwoxh@vireshk-i7>
 <1544445372.3502.42.camel@mtksdaap41>
 <20181213063850.c5nu3bbe7gm647ca@vireshk-i7>
 <1544697412.6417.13.camel@mtksdaap41>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544697412.6417.13.camel@mtksdaap41>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-12-18, 18:36, Nick Fan wrote:
> This new API is suitable for the users that required to access for
> multiple regulators. And I am one of users who uses this API, but I am
> not able to upstream the GPU kernel driver which uses the new API.

Look at it from mainline's perspective..

- We don't (can't) care about non-mainline stuff. Actually we do care,
  but we can't add code to mainline which is not going to be used by
  any mainline user.

- I am fine with introducing the new API, but that will happen only if
  there is going to be a mainline user as well.

- As you are going to maintain your GPU driver offline, you can
  maintain this patch too.

Sorry Nick.

-- 
viresh
