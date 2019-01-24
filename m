Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832CFC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB5B21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqRcvcUF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbfAXSOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 13:14:42 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37755 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfAXSOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 13:14:41 -0500
Received: by mail-lj1-f195.google.com with SMTP id t18-v6so6102749ljd.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 10:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sw2owPsQd1KuZ11D/x67ECsnhxIcb+1a68QbLE51YO4=;
        b=bqRcvcUF50yuKJqptiYyxZxpYJly8T+VWTOnhtbDpSNduaSr5zoW17hKr+9vFZobri
         DTxRNfC2ellhb1wZw10eNHxDaRDFEefR7Z4GMYjY0+wr4CT0YIcrT/6AdeSbkGZYu3Of
         u7FMeK3qQW/EJXdmJRvimLG9By0+8ZW92Kjnp1Y0A/4A8kUcj+ScLRAiwx75SdW/TU2p
         i7RrydeLfClCc/ElRDnILLko95K1KKI2Zj22yRALIz/mTxK+QSoRkVTnqdbmgtqgkAkq
         3NtLs9W6u5K1P4UAhqeMnQLg0n2iVZoOjKaDV+bAVd05pYY3e+Kul39yze38VoEqIGem
         E2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sw2owPsQd1KuZ11D/x67ECsnhxIcb+1a68QbLE51YO4=;
        b=II1WcPmheGm16AzU5h51NDEb17iAkkftwQEkIv7xctD0OfvFQEgacFSTd3wpImfW3m
         Dpq4cyshb/6h4sC0/dGAYLb7jamFq7cRSYrP7xSIcjgMGZ54JdVgj6mEoK604To1PcJ/
         WdaRt8p4YsKbk4c2DRqov1b8IWajELb3bGq+zwYRZgP3mNW6S80vq2Kyb87E2G5pQx1d
         I9CvMGpJ3N5gN7beS5Mg4jsim/Gtrd06estJ0VtECj05376XkuWyxyPpUqciRZt4kq9N
         H7Uz5fi1a5glHX3KKcCbyM15ePAA0fm2AIe0p/CVRKQq91ksSo5KCxKcLsGDTf9+mwxh
         msHQ==
X-Gm-Message-State: AJcUukcv+STfg2N5WivBj8YyCPhLQLHoUckJy+P8BrxvZlFLNBeJedW6
        qvN9H/6fQdfqZQJb8BbgeHw=
X-Google-Smtp-Source: ALg8bN7xyrwuZQ4/zgnnPoKTiSL65urAkbVONAXGrEYwTyNgwFVtsCUudwHiPDxrwxm0W8n0IcFkzw==
X-Received: by 2002:a2e:9603:: with SMTP id v3-v6mr6324854ljh.15.1548353679228;
        Thu, 24 Jan 2019 10:14:39 -0800 (PST)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id b128sm1071651lfe.91.2019.01.24.10.14.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 10:14:38 -0800 (PST)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id D587D460419; Thu, 24 Jan 2019 21:14:37 +0300 (MSK)
Date:   Thu, 24 Jan 2019 21:14:37 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH v2 -next] rcu: rcu_qs -- Use raise_softirq_irqoff to not save
 irqs twice
Message-ID: <20190124181437.GE2332@uranus.lan>
References: <20190124180740.GD2332@uranus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124180740.GD2332@uranus.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rcu_qs is disabling IRQs by self so no need to do the same in raise_softirq
but instead we can save some cycles using raise_softirq_irqoff directly.

CC: Paul E. McKenney <paulmck@linux.ibm.com>
Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
---
The prev patch body has been screwed, sorry.

 kernel/rcu/tiny.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-next.git/kernel/rcu/tiny.c
===================================================================
--- linux-next.git.orig/kernel/rcu/tiny.c
+++ linux-next.git/kernel/rcu/tiny.c
@@ -65,7 +65,7 @@ void rcu_qs(void)
 	local_irq_save(flags);
 	if (rcu_ctrlblk.donetail != rcu_ctrlblk.curtail) {
 		rcu_ctrlblk.donetail = rcu_ctrlblk.curtail;
-		raise_softirq(RCU_SOFTIRQ);
+		raise_softirq_irqoff(RCU_SOFTIRQ);
 	}
 	local_irq_restore(flags);
 }
