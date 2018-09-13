Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF21C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 03:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2D52146E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 03:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bd29LdJO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D2D52146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbeIMIZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 04:25:57 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:41352 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeIMIZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 04:25:57 -0400
Received: by mail-pl1-f170.google.com with SMTP id b12-v6so1932268plr.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 20:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=6VH3VX7As53cWimUbvfA2Yqc+XKpLTqCykE0/VNLwmI=;
        b=bd29LdJOAoLiv/Cf56hJLYGhcbjiTfNQifVv7K1Fl07S8/bFe+Pc/cnlzpzvIYtWQd
         mhJsisStR8kpH9knWjY25LWxXRxSsrJC12K0NUDgujDWZW04upAkKQc0bTHcg0vz+U1o
         vnbfEnhbeYrXaQJcm9D2hkmEODtJM7j5eLaUP87GMUss2/A0+uMD4ztgmOMCC3uxCKIA
         +7Y5T7QaOsoA969Z1hu9GYgP3aUDaKn1fKS9siYSGhXmNIHBiI0Czajlx8dcNR3510rz
         ffyS/xZThH2Gd2syHNW3VhmpCez26nb9HO4r6tME463WwYrRqeFSN0S8dVRxEq4Al6eQ
         aQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6VH3VX7As53cWimUbvfA2Yqc+XKpLTqCykE0/VNLwmI=;
        b=GVOrMhyeSWEMBwPejIPQ9kk+jLffP+DIOQqvC8sW0/iEtuVr+7qyRdE137YF1XvlpP
         byQLuCmReiCAJp7MEfRlomVZ31ZT1uHe3uVsU5wU/0/T6yw+NmrGQIS2u4oZb/I58HTC
         hCP0DwtpVR794hQz/vVVLfQNFPGnC7I0BOKe+3ADktXUzXDM/Dhxnbp+xI1Bs9eFCo2x
         XRdUK2B1Ut63nIiz9x2UHmadKuqLSshrn7WEJETgYB4/u1AYfwLvzJa1O/lTTbRjtMRW
         V4cfFvquoJCSIzkVonVwLRdchRsWHliiNEfR4bi7OmvZVgcGM5Cpt/u7zAQ+XDHXGimc
         QV3A==
X-Gm-Message-State: APzg51CblBkyud2bCuS3+hN3nsg4CHAO8mtQaFrUjeMMGMwvtJVgwm+J
        EIs4DjbqRC1lL14zToXHA5rZ8m7a
X-Google-Smtp-Source: ANB0VdZQ9eWysMvCWWSloocqUPUyI9D5NZ7gxsm2wG2kNadRl1rgK5Ys4LqXoRHf1ZyzjGCd80abgw==
X-Received: by 2002:a17:902:bd95:: with SMTP id q21-v6mr5170417pls.284.1536808706811;
        Wed, 12 Sep 2018 20:18:26 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.58? ([2402:f000:1:1501:200:5efe:a66f:473a])
        by smtp.gmail.com with ESMTPSA id 74-v6sm5438642pfv.33.2018.09.12.20.18.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 20:18:26 -0700 (PDT)
Subject: Re: [BUG] [Resend] Possible sleep-in-atomic-context bugs involving
 regmap_lock_mutex()
To:     Mark Brown <broonie@kernel.org>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        David Howells <dhowells@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linus.walleij@linaro.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <9bcef57b-1a5c-cd16-8e44-932ef3be08cb@gmail.com>
 <20180910174104.GD10889@sirena.org.uk>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <6a754893-535a-c53e-fb65-2221408e06e3@gmail.com>
Date:   Thu, 13 Sep 2018 11:18:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180910174104.GD10889@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the reply :)

On 2018/9/11 1:41, Mark Brown wrote:
> On Thu, Aug 30, 2018 at 10:34:20AM +0800, Jia-Ju Bai wrote:
>
>> My static tool DSAC reports many sleep-in-atomic-context bugs involving
>> regmap_lock_mutex(), so I wonder whether this function is possible to be
>> executed in atomic context.
> Have you actually analyzed the code paths that are really taken here?
> Static tools really don't cope very well with the pluggable locking in
> regmap.  If there are problems I'd suggest reporting them to the authors
> of the drivers using them, it's not really anything to do with regmap if
> they've messed up their locking.

Okay, I will send the reports to the developers for these drivers.


Best wishes,
Jia-Ju Bai
