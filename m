Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B592C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22638214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:29:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22638214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbeIZVmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:42:54 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38978 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbeIZVmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:42:54 -0400
Received: by mail-ot1-f66.google.com with SMTP id c12-v6so28587405otl.6;
        Wed, 26 Sep 2018 08:29:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GQv0rIvfJ7wZrqYG9ldxCaOBz1O3n/V+ddxZgAsKJ8U=;
        b=AGoeHTw2Gnnp+K9UVbZxUGxO+IiVqhm7JGMH3txOcEvgWjzjOMhZhFbAWOq5b7xrwS
         as62hqmwEKqg+SA0h7O+yhiXxxU9D0IJXIHUHsTgSPLrWol8w61KvD/tahYKlmj2IFsT
         DKFzoFJWbcn+DKdyx3MqqEiAsE+hISUwjw9FZgl6noUWlAvHSBwrqEZ0VujDjv9NsN58
         vW7p9GAWdXyrhg14DcYH9qeowo7ykJ147SjUWZxxuN/lZ0prdn2dVO+PUUBmACY2Hyr6
         0o3BSJRaWT7zA5Vatu+cwGXUd4YasnrJp6RgNKEwbZfNg7P4XVpaSXw7470Ga9GGaSIK
         M4mQ==
X-Gm-Message-State: ABuFfohvIqxfgKtoItUsT35NAj74xcL3Er+lz23+IT/zQiVPbFWHkHJ5
        YJMTT6Afwfh9h/mz2aRyMhMFY5O2jw==
X-Google-Smtp-Source: ACcGV61dfwgqd54Oqy+ue7b/pNMDgACflLAGQFoGLQ4etrbIagSu9rNZb3KxGXF1CzNIipfUv2NL5w==
X-Received: by 2002:a9d:b91:: with SMTP id 17-v6mr4178782oth.263.1537975765180;
        Wed, 26 Sep 2018 08:29:25 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n30-v6sm2313264otb.73.2018.09.26.08.29.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 08:29:24 -0700 (PDT)
Date:   Wed, 26 Sep 2018 10:29:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pascal PAILLET-LME <p.paillet@st.com>
Cc:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "eballetbo@gmail.com" <eballetbo@gmail.com>,
        Pascal PAILLET-LME <p.paillet@st.com>
Subject: Re: [PATCH V2 7/8] dt-bindings: watchdog: document stpmic1 pmic
 watchdog
Message-ID: <20180926152923.GA1821@bogus>
References: <1536325173-16617-1-git-send-email-p.paillet@st.com>
 <1536325173-16617-8-git-send-email-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536325173-16617-8-git-send-email-p.paillet@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Sep 2018 12:59:45 +0000, Pascal PAILLET-LME wrote:
> From: pascal paillet <p.paillet@st.com>
> 
> The stpmic1 PMIC embeds a watchdog which is disabled by default.
> In case of watchdog, the PMIC goes off.
> 
> Signed-off-by: pascal paillet <p.paillet@st.com>
> ---
>  Documentation/devicetree/bindings/watchdog/st,stpmic1-wdt.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/st,stpmic1-wdt.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
