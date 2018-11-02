Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A38C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14FF32081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9gmkal1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14FF32081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbeKCAeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:34:09 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44613 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbeKCAeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:34:09 -0400
Received: by mail-pg1-f195.google.com with SMTP id w3-v6so1120815pgs.11;
        Fri, 02 Nov 2018 08:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=+tiYrxvHegvRIReUVdDqpD8LcgeUWFuNGCEcrAENPyQ=;
        b=Y9gmkal1oF9OCzSiOuLWoxGnki/7tClk8D6bDN7oRfHKNRIj7hk9LeYVryuROJnJfk
         PHdjSdakpo6aTCwtE6Y/c9pujyPGCMCa8+I3gAqPD3VC72xP3vnRS65znHsCjxZFuMF6
         ZvbAm+WfVW+P7QmBfOvs+JtUWSmpFV210V0jrc+WU1DaLe/O3mNbrFDMyfagQa6wunkv
         rIHXJnl6U81JlMRi98LwszAoQr3UDs3FMCkPpL/Xff6LF++YLoiX5hrKNlgZDMXnMlCD
         OeyusDgTZi/p/gx9udDCSgGrJTDLHzLTLFpKH4f0Xx0oGiq6CWNMCbR96ZvXvqGk2h4H
         qqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=+tiYrxvHegvRIReUVdDqpD8LcgeUWFuNGCEcrAENPyQ=;
        b=fI251XD2iIS/g3mrD6aXzTEkbEuv5vqofrxdVQjk8Dzyz68XK0afC0lztrrKHcladE
         EjUnD6+WFI7bl+mhIKMOCvuboFlH4Nm151B/2gQLyFLNcY5phNdXepMeHMr1KamGcMSy
         Bt2ha6Vu+1+7dlTbdXOkb9b/jHGUGQNIugWDF7iesezg2HS2RfQKBttm+mLvOJ/KgiQq
         iQZ9h+LykCcGA/9dcdTwrVxgtJ6NJPW4CMnmmPsbyYYcQXNG/s8F1kE4rnpTdDieMyFI
         gHQJC+Qrcit5BOHojx5YV+rbDVJmx3gXiyJHuCocMd+x+ZRogZf8ZTUTYXAXDk4KUeC7
         BNGw==
X-Gm-Message-State: AGRZ1gJzllUneVaRtDmEiYVuaaKfFO+Yan2n6P9Bsw7zQUoC6KpX5ANZ
        BNLZdbuFTwbjYYCPXSp33IfnV2q3rM4=
X-Google-Smtp-Source: AJdET5cNWL7DThrPqgs269y7ihpvjo9a5tnA9lwpl4KepyhU3SEFaSn2OF3O4oQT90vFyal73Ss6uw==
X-Received: by 2002:a63:e70a:: with SMTP id b10-v6mr11017882pgi.363.1541172402657;
        Fri, 02 Nov 2018 08:26:42 -0700 (PDT)
Received: from hp-pavilion-15-notebook-pc-brajeswar ([2405:205:6427:c85d:d9ea:5b7b:3457:bf48])
        by smtp.gmail.com with ESMTPSA id v26-v6sm42532395pfg.43.2018.11.02.08.26.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 08:26:41 -0700 (PDT)
Date:   Fri, 2 Nov 2018 20:56:37 +0530
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
To:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        parri.andrea@gmail.com, mingo@kernel.org,
        paulmck@linux.vnet.ibm.com
Cc:     jrdr.linux@gmail.com, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, sabyasachi.linux@gmail.com
Subject: [PATCH] include/asm/cmpxchg.h: Remove duplicate header
Message-ID: <20181102152637.GA3105@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove asm/xchg.h which is included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 arch/alpha/include/asm/cmpxchg.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/alpha/include/asm/cmpxchg.h b/arch/alpha/include/asm/cmpxchg.h
index 6c7c39452471..bcbdac0744f9 100644
--- a/arch/alpha/include/asm/cmpxchg.h
+++ b/arch/alpha/include/asm/cmpxchg.h
@@ -36,7 +36,6 @@
 #undef ____cmpxchg
 #define ____xchg(type, args...)		__xchg ##type(args)
 #define ____cmpxchg(type, args...)	__cmpxchg ##type(args)
-#include <asm/xchg.h>
 
 /*
  * The leading and the trailing memory barriers guarantee that these
-- 
2.17.1

