Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D88C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A7F2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFT4q7ks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A7F2133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbeKPFr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:47:58 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42203 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725742AbeKPFr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:47:58 -0500
Received: by mail-wr1-f68.google.com with SMTP id u5-v6so17184896wrn.9;
        Thu, 15 Nov 2018 11:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jejHqvs7v+KilXZwrcX/iftr9I/o1SE/6GWohFls/nk=;
        b=fFT4q7ksvbSRXardjWtF91PgWjagff0p+OEIHRXAbdz2QAqCk0i6feeE6laQ9YjHyd
         gNdQVpyNYq06+TFdIexZiwsQi2oQ3pjorZDwcFUWNVyLreJnC0IX3DOEgUCcCI6pfMRQ
         iJnYn7lm7VUEgQdauCiI1bwkZwvTuEL5Qs10NIKAbkxGLmWHqYmvBlg+u8aSJxJfgxHE
         GG92xqKBR7Hi3jQkunUDkp++UFd4UCHjXUExsNnQL8dvzHYu0JrQGlYBK2kA7onfCQCb
         OhZiqs/y+TPQIKnyuSp+5yCnSDu/NLyGJtnmLg2+X7dKWuW/4FptZ77ZnUn6zUk+aF8m
         1CFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jejHqvs7v+KilXZwrcX/iftr9I/o1SE/6GWohFls/nk=;
        b=Vv47mj1bSGWzqquyZjJBayLNaSnVZh2L/IIrvMgShL+ICnMrvTjpd7oS8UymLTnEX3
         UUXndSXraaEcLgNWh6GPFBOXECgAFHw/1m1WfzDzP9TtuoTExYwY7ilxD1MUlNyAwXVh
         zlPS6Tq7KiE1eQ/yrbDUUtlLo31UC4FKK1Ahp1ZO9NgvNHP6KPi+Xh3df+gCVGsfbvxj
         WaNDYB3LvRlo3pFt+yjSk7ki2H5bdSfa8tUQKQV8v1a/ZBlgCLh05NbdRsUWu60+g2gx
         cd++tSryp/oPdGZGvs7KTBgFkvE3A7DNHeOXSazoBYxlcz1+FWGaMejQbRi4jY5SHdj8
         9g2w==
X-Gm-Message-State: AGRZ1gJcJjQRHvJdqnpsnkXASbe1fckRdhmPL1kWcSvBIvi38qar+1xz
        ksnirfIGXdd3t/zSc/0vb/ixZvOfL8s=
X-Google-Smtp-Source: AJdET5ch4Sm0Vpo2y37bYGKiPmWYpQk5tuo2adwqHAFZww46q7VNBgxianPdXQ+V/bsDE0DFCJpB8g==
X-Received: by 2002:adf:c6c3:: with SMTP id c3-v6mr6810581wrh.243.1542310727919;
        Thu, 15 Nov 2018 11:38:47 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id 6-v6sm18916745wra.35.2018.11.15.11.38.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 11:38:47 -0800 (PST)
Date:   Thu, 15 Nov 2018 12:38:45 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     David Miller <davem@davemloft.net>
Cc:     sbrivio@redhat.com, sd@queasysnail.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] geneve: Add missing braces in addr6 initializer
Message-ID: <20181115193845.GA22070@flashbox>
References: <20181112221248.11477-1-natechancellor@gmail.com>
 <20181115.113501.2215768757973757171.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181115.113501.2215768757973757171.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 11:35:01AM -0800, David Miller wrote:
> From: Nathan Chancellor <natechancellor@gmail.com>
> Date: Mon, 12 Nov 2018 15:12:48 -0700
> 
> > Clang warns:
> > 
> > drivers/net/geneve.c:428:29: error: suggest braces around initialization
> > of subobject [-Werror,-Wmissing-braces]
> >                 struct in6_addr addr6 = { 0 };
> >                                           ^
> >                                           {}
> > 
> > Fixes: a07966447f39 ("geneve: ICMP error lookup handler")
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> 
> And this makes GCC warn.
> 
> drivers/net/geneve.c: In function ‘geneve_udp_encap_err_lookup’:
> drivers/net/geneve.c:428:27: warning: missing braces around initializer [-Wmissing-braces]
>    struct in6_addr addr6 = { { 0 } };
>                            ^
>                                { }
> 
> （╯°□°）╯︵ ┻━┻

Yes, sorry, I thought I test built before sending it but apparently not
:( v2 should be sitting in your inbox as a reply to this one unless I
screwed that up too...

Nathan
