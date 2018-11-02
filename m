Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AD8C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3590720833
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="1bwCY/Ck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3590720833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbeKCEKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:10:25 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36932 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730637AbeKCD50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:57:26 -0400
Received: by mail-lf1-f65.google.com with SMTP id p17so2015436lfh.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 11:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E/vRdTumm7utnNDrfFjktioKALxKHfCrSVSsL9V3rfE=;
        b=1bwCY/CkLJXMInamZ1jLkRIbjxCt7QoVNSJGAOa43nHh3Yj24xbIwfpSp1O3Wbmell
         bb6Fyn9mThxpGeLhgwsrKDZTJ3IU72THc3C+0r5E+Xkvii2QzzltpBLMNwhcJJDatx0N
         usSv4R/lvkuFjGHlyAGJkZphmHFFQjLI21DLDrpbYU4F6zdzs0ahZ19q82u/lgltqNOY
         1+RzAmdMAdfdvnBMB8cYeu2v28QHst6rXH3DpBxRrKkGuX60LtmX4HUDNWqORS1NYvXt
         LbfPHlj3qDQs9Tg5SEzhceKxxbARqTbkDxSegVlffwEiNN/CSv+RbvUeFIS3JIW8PBTW
         Rzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E/vRdTumm7utnNDrfFjktioKALxKHfCrSVSsL9V3rfE=;
        b=XOU3bqXAPcDXuBrmpk42+amYwZLX7lH/YtDTRRbfH6zMd6bc6O2qRX12QIGyvwupPZ
         MEO7V82JaNLAI6A8w0VqW4ceZJ8uereG/e6FYWBhahngu14kfXUldxia6vOjPJ02vATY
         bbPxRV4yaqRD5OdZwHKxTx6DuI/Sm+N6kcrMYE69AcOZ2lf/gREQULjc0qe7k8/cLgAJ
         mMZGCOSlHJ2SZjUt5EWljJXC31MXASPqcZ0ZzhMwwUnXY4jwlAKP5FeJdm6ZfVf9SdHV
         +g0eP1mQILH32QnMFST2gt0mDNO91qmiA22u+Jn50g5MGfJ6fYBdQx0vbwesI+BvpdJE
         83Tg==
X-Gm-Message-State: AGRZ1gJIttTalTaN8MBW2BiFRizUA2X4GV3Q4PdKxfAvbWYFvHT6TOWp
        eDuLQiROOd0Agyvtuif9DpHlGA==
X-Google-Smtp-Source: AJdET5eG6tZGe6Up4LGL/UdelkiS2GlTZcjCK41zrPy+3faJhz1CAgZuGPTNgWGxWkz0KZBJNYUzxA==
X-Received: by 2002:a19:702:: with SMTP id 2mr4637054lfh.144.1541184550896;
        Fri, 02 Nov 2018 11:49:10 -0700 (PDT)
Received: from localhost ([85.30.9.151])
        by smtp.gmail.com with ESMTPSA id e14-v6sm1630980ljl.43.2018.11.02.11.49.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 11:49:07 -0700 (PDT)
Date:   Fri, 2 Nov 2018 11:33:25 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     arm@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 0/2] dt-bindings: uniphier: two trivial DT bindings
 patches
Message-ID: <20181102183325.awq7auc7qwn4amlz@localhost>
References: <1539945019-24950-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539945019-24950-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 07:30:16PM +0900, Masahiro Yamada wrote:
> 
> Arnd, Olof,
> 
> I know it is very late in this development cycle.
> 
> If possible, could you directly apply these two patches
> to your ARM-SoC, aiming for the upcoming v4.20-rc1 MW?
> 
> If not, I can wait for v4.21-rc1.

Hi,

As you've noticed by now, this didn't make it in but we'll be happy to take it
if you resend after -rc1.

Thanks!


-Olof
