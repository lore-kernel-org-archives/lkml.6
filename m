Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D75C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E927A20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s0yzK3Oe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E927A20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388624AbeKGDtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 22:49:36 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44167 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387722AbeKGDtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 22:49:36 -0500
Received: by mail-pl1-f193.google.com with SMTP id s5-v6so6576761plq.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 10:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=CoVnvYCkA+xclP0EInzqIbqHhQMHbFD8XdtM2ielRoo=;
        b=s0yzK3OexW6n8Wz8rjSey8f/vnw+W9AblYR6FBxhSXZOQuHBATEUhyiaHrZLK1qLxC
         xRn7EZdrN+jhggvE7BX5MslA96jGEewiOsPookzV9cx3PAPQWTneB7+1QOg8MMGv2ytA
         m4o2Q7F4PqG8sAsZAMrZst2pQdwnACI7bz7jHigIzUwoLoab/a2xr8zSm+QU5OvkShLm
         c30lOXdCxtLlFI7zozigIhle8zoYb2Pbetk1SzwpudWi64v9FCZRNIHPTrZGt7moutw3
         GLiwhWxPxJFoifiSrBcZu4pQl3hIeMj889421BbTqdg3WL5pm+6luZIMMtMOPmEb9fV7
         H6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=CoVnvYCkA+xclP0EInzqIbqHhQMHbFD8XdtM2ielRoo=;
        b=VjV61UflfGi6uGveDRCv98dRP914rtLMPLU8+esWzV6tIbij0+cNwQgoCM/Mfa1lG1
         b7Q0fCKXj6EEKs1Bw401CPYGUpwHFsfUKPi9OxPJ/2YdGIbD5t/jS4zSLdwIFEHKLKcM
         NOoFq6URP2GG1hc9PKOcKk+2ggu5wYJX/XfxdDHokewniUTT0knmN8ykN0A+uCtMaQ+X
         /C+k1fciZnERGMZrvjmfkAvm7h47Symq/VWk2GbbU7Ia+C2n8iM8qdX2sACvCbSNuX87
         tSANc1wMA1MMr1mcixAFDLsnPVVZJucALV4IVjYoeF7Vk1iovGQs0TMhxWhHRZd42fJo
         Tf7Q==
X-Gm-Message-State: AGRZ1gKo6bz3jJm+PkW0ZkGK9B4Dx4dV10uPNeHbtLxraL5K6pbUQpis
        egoU3m0OzC9YYOlvTeeZevpSfy22qZQ=
X-Google-Smtp-Source: AJdET5fU2ILkV1Lskoa3DEza8SltXohLlo9BhWOaliKZlsozN9UapH4ChNyVM5dVOcGC9AJr8KkPTw==
X-Received: by 2002:a17:902:654a:: with SMTP id d10-v6mr26269239pln.302.1541528585171;
        Tue, 06 Nov 2018 10:23:05 -0800 (PST)
Received: from SARKAR ([1.186.17.108])
        by smtp.gmail.com with ESMTPSA id h7-v6sm63991498pfd.35.2018.11.06.10.23.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 10:23:04 -0800 (PST)
Date:   Tue, 6 Nov 2018 23:53:00 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     rohitsarkar5398@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: wlan-ng: Fix a typo.
Message-ID: <20181106182300.GA29776@SARKAR>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Exiting" instead of "Exitting"

Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
---
 drivers/staging/wlan-ng/prism2fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wlan-ng/prism2fw.c b/drivers/staging/wlan-ng/prism2fw.c
index f99626ca6bdc..a2c851c74bef 100644
--- a/drivers/staging/wlan-ng/prism2fw.c
+++ b/drivers/staging/wlan-ng/prism2fw.c
@@ -559,7 +559,7 @@ static int mkimage(struct imgchunk *clist, unsigned int *ccnt)
 	for (i = 0; i < *ccnt; i++) {
 		clist[i].data = kzalloc(clist[i].len, GFP_KERNEL);
 		if (!clist[i].data) {
-			pr_err("failed to allocate image space, exitting.\n");
+			pr_err("failed to allocate image space, exiting.\n");
 			return 1;
 		}
 		pr_debug("chunk[%d]: addr=0x%06x len=%d\n",
-- 
2.17.1

