Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id ED20BC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 20:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF73208D5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 20:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pgAWzluZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF73208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935831AbeFMUkY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 16:40:24 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:33573 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935461AbeFMUkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 16:40:23 -0400
Received: by mail-vk0-f65.google.com with SMTP id 200-v6so2359212vkc.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 13:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=EPeo9UeHKeiHJXFUW5N7la1kCqykKTA5JGuxFV8vwoE=;
        b=pgAWzluZc3AjJ9JC87szu8vT69Q8frK1Ysa47SAJ33gG9DXFRmEQ4vKksFS4RzXfVa
         w5L2IgZr6+MyH5xyGsoAC4CqwwX55CFsMm0nnLw+23fmNRg3iKAaDMm/qStIs6ok+fOt
         XQjxYKuEcNNcxpvjMl2jxFAJngzoojymKs24Mk3L64s2YYUD0q4rgVpcfiWHrpDMVIjK
         5KaJxOKIPBgkhHRtuQyvZBp0EXybE+uDqf7YBc6dyOZSAtnWsT185t+AMYBxOVh9+MdQ
         QTcH9AiszD0KnP2pVFPCfmWJgXuaQb59vkp6Vh45xNLD6Am4Qee4SHydK/90VsuwCjZr
         mwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=EPeo9UeHKeiHJXFUW5N7la1kCqykKTA5JGuxFV8vwoE=;
        b=DYW+JJQyW3qMqIfbRZBZIbByMDZysWofKrSm3vVcaOOlpPxrtNVP8GcKGBNssReCit
         erjJ23jXAS8u+25uRN9iY2tVCs+4+KBeZ+Xm+VfoUt0vc34MNcu1E/q/qYjCyrweQ6Fb
         zyQnUiOyNZZwYJ0yHbBHvL/9QJvPMxk6zyhnpi93VvsF4PJG1Np9c1IITiD777X+5BT9
         MNtrRO/kxOaTxyEHygtxcK0ISapgSvFc0MHNqWojQGkJxyWWjjjf4X5Q7MvUXIdaJVm1
         vkSy5WoMcIh43VE0sRQ+TAwRcbuzs4YyxCxVfnUEh8iZfB7CGLlnpZNCgplxMZbPzyFL
         0gEQ==
X-Gm-Message-State: APt69E08c1YTgNsv+X/IR7YBDAdHsZYJVIRQ9Ej13LjxOKRYXZj2yOjl
        +exEbQu4xp6sCYqXUcqThI0=
X-Google-Smtp-Source: ADUXVKIJjQjQfesmBqDKbY33PT1xn6kq7OtGhY93/ftMlZxBRm/8AuobZzL70E5ZafbkUsfCO/6Esw==
X-Received: by 2002:a1f:2758:: with SMTP id n85-v6mr3966310vkn.117.1528922422807;
        Wed, 13 Jun 2018 13:40:22 -0700 (PDT)
Received: from javier-Z97X ([2601:582:c500:a66c::21e8])
        by smtp.gmail.com with ESMTPSA id j191-v6sm718340vke.6.2018.06.13.13.40.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 13:40:22 -0700 (PDT)
Date:   Wed, 13 Jun 2018 16:40:15 -0400
From:   Javier Martinez <javiermlinux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jhogan@kernel.org, aaro.koskinen@iki.fi,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: octeon-usb: octeon-hcd.c: style fix line length
 warning
Message-ID: <20180613204015.GA15689@javier-Z97X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch.pl issued a warning in the top of the commment within
octeon-hcd.c. This is a simple style fix for that.

Signed-off-by: Javier Martinez <javiermlinux@gmail.com>
---
 drivers/staging/octeon-usb/octeon-hcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
index cded30f145aa..768b0148f3d5 100644
--- a/drivers/staging/octeon-usb/octeon-hcd.c
+++ b/drivers/staging/octeon-usb/octeon-hcd.c
@@ -1,5 +1,5 @@
 /*
- * This file is subject to the terms and conditions of the GNU General Public
+ * This file is subject to the terms and conditions of the GPL
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
-- 
2.17.1

