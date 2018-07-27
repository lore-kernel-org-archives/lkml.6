Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB63C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBFF6208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="OxQJFQuP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBFF6208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732452AbeG0PF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 11:05:28 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35238 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730698AbeG0PF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 11:05:28 -0400
Received: by mail-ed1-f67.google.com with SMTP id e6-v6so3968847edr.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 06:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sEDLB8eFVpHa+l9VCSECu/Pfniq11tvH7Va7zgjVWA8=;
        b=OxQJFQuPaCuQ2LvOMdrXOZtZiF39OcMCHoImHg76dHPB9Rz4JfnktQstXHz9yfYz25
         cNVqV4eLuJS5gCkBTU4X4+tjKQIkJ4axju0DbYRH3yj8oqtO6b42+haLpS/QwcFUMD+E
         CtVW8YFnwKwhZxotxAYMrhO55hCL8kjNMDlVFdlA5MzI+FuMkUkE+t6d36F0oPjKQp3l
         rk1eUUhg5lVB2AbzEECo8s7hKWozI7UrcOkH4f4BD+TM+UiCznJq3FD1L0//cRfz0yXS
         vKTvr1VHcqHNjS+ygtXYF8MluyQhuRvEkytdMCX6rquG2r+WoR0jeqcc+Ih/xOtcW+YO
         Q8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sEDLB8eFVpHa+l9VCSECu/Pfniq11tvH7Va7zgjVWA8=;
        b=TpjCks+GbfctDTjvnae2N7gKRewSTxgvToUknUKgZsxMwyrERg3+Pca6L0EVR6nYJr
         cupb90l2mnEwxrLNB1WoFIaJ6UqMjGRSoG/lMuPQEqap8LDKRGo8Nu5/CN2Wz+Dta3Na
         7Xnclc8pMipLwZ30zZ5ROHyVOarlOyfMhFCAtXYNil+2n2L1MpSielWjHJndIg1HFRCw
         z+MtyO4WWFkIIkgj6sh5gULUPSgqtvSqM7/P4D2JbGo2rUt2lFyAzGpQX1W6wzx9hwlx
         uB/qZ3OcrGNC0juVzesJ4rNb0sbGgXulB5C1CioFfBvc8jmRmOUDZneR+DwSj5bcrhjR
         kWIg==
X-Gm-Message-State: AOUpUlFW48METpUiuigoiENY1VCQi+dYi740uqnnKaTwRs0GD5OeZGcn
        d0FS+RvlLjXiIgoqCvJbBpB8pg==
X-Google-Smtp-Source: AAOMgpfmJv77JaiB6E2q/T1nuwBFfo6oC/teiMSuvFloEkMiDOj1b9ywTaPGAN2tqu5ZBcIXDg6eJA==
X-Received: by 2002:aa7:c68b:: with SMTP id n11-v6mr7674779edq.122.1532699007003;
        Fri, 27 Jul 2018 06:43:27 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id a9-v6sm2124702edi.26.2018.07.27.06.43.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 06:43:25 -0700 (PDT)
Message-ID: <1532699004.2679.9.camel@arista.com>
Subject: Re: [PATCH 06/18] netlink: Do not subscribe to non-existent groups
From:   Dmitry Safonov <dima@arista.com>
To:     David Miller <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, herbert@gondor.apana.org.au,
        steffen.klassert@secunet.com, 0x7f454c46@gmail.com,
        netdev@vger.kernel.org
Date:   Fri, 27 Jul 2018 14:43:24 +0100
In-Reply-To: <20180725.212258.182134114222639499.davem@davemloft.net>
References: <20180726023144.31066-1-dima@arista.com>
         <20180726023144.31066-7-dima@arista.com>
         <20180725.212258.182134114222639499.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-25 at 21:22 -0700, David Miller wrote:
> From: Dmitry Safonov <dima@arista.com>
> Date: Thu, 26 Jul 2018 03:31:32 +0100
> 
> > Make ABI more strict about subscribing to group > ngroups.
> > Code doesn't check for that and it looks bogus.
> > (one can subscribe to non-existing group)
> > Still, it's possible to bind() to all possible groups with (-1)
> > 
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: Steffen Klassert <steffen.klassert@secunet.com>
> > Cc: netdev@vger.kernel.org
> > Signed-off-by: Dmitry Safonov <dima@arista.com>
> 
> This really has nothing to do with adding a compat layer for xfrm,
> and is a bug fix that should be submitted separately in it's own
> right.

Sure, will do.

-- 
Thanks,
             Dmitry
