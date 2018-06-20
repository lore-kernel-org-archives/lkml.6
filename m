Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C429C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2925920874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+3Rcsf/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2925920874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753853AbeFTNOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:14:47 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55818 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751841AbeFTNOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:14:45 -0400
Received: by mail-wm0-f66.google.com with SMTP id v16-v6so5932200wmh.5;
        Wed, 20 Jun 2018 06:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=vModIYwNf2G9ulmo7bErgfk/Ud/H1mRpTXfcxVefyXM=;
        b=Z+3Rcsf//j14iyZENV1Mzhd/rJ8DSIMiScMX/E7w7m6mKOHuDE6ynQU9JhLsjKNhsA
         yUnYOGHXVtHQaLct35NfWS7FLgh8Plr1uP8G/kS6ZuWHvZC/gxtjmsvIoRgKQzLelouk
         Gi8pWPa3VxxdLipqP9S8rKUdoOG56RwPQEnkvOsVFR2tvpR/USbcAUK/uGM9E1isisN1
         lZXsyLp4rDAg7p7Qo1gTIWvq42yucpsWYgii6sdJM65JGa9dJOqpFc7EdvWRYbe7+Alt
         AsGOXEJRVZrXujgh7ipPzVBu/WOV6Vw8iiyHfs3x8y6SfV8rhSLA5jVwGBabLhZlkUjX
         3iDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=vModIYwNf2G9ulmo7bErgfk/Ud/H1mRpTXfcxVefyXM=;
        b=uBDpPE9H7VMhy3CSjTCGjvgM3Iq3+CBTjY4s/uTRYJkVi8bvKK2dkXIygvF6DuDHhL
         MddRkar9DhZJGsb/eTkU1e9ZI/aAlLiBIAC5lAf/9ERt6m8cxXNfYviGbcGHiWNxwGsa
         cyJITcf+/qFFWpgwBEmEyvIp2ptOnoMUEjFsJ36Es8gLnTHEhyNhXM+nnxxTGwmY+XX5
         e9/hlkjlm2RwEet0w6ZE0JoycwbeXTnhAoSH0gF6MfQR7zXv5SMvqPIamGs2wUNh2GPw
         vBs2xiHB+WE41uEsoqVsWMj1y68QBMMfeA0I1NVjrYJp6srV+u9w78kg6F1n/O1DomUh
         B2AA==
X-Gm-Message-State: APt69E0eL0FGUEvR+jF+0a36cTeJMnTw91PRWZawrsgSlZStXJcksPsP
        XWRAL97/NJZe1KI0K6A334DjZA==
X-Google-Smtp-Source: ADUXVKLXyj+IJsruI9Ef2RHWerS/zzAS2sUXeD9M/IO9wVVwbnh9xOcl6G/aDknpd+Z+m0AOLPEZlQ==
X-Received: by 2002:a1c:d543:: with SMTP id m64-v6mr1621320wmg.12.1529500484450;
        Wed, 20 Jun 2018 06:14:44 -0700 (PDT)
Received: from kidega-PC ([196.43.135.103])
        by smtp.gmail.com with ESMTPSA id j13-v6sm3535140wre.38.2018.06.20.06.14.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 06:14:43 -0700 (PDT)
Date:   Wed, 20 Jun 2018 19:14:35 +0300
From:   kidega <kidegamoses88@gmail.com>
To:     axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH 4.17.0-rc3 1/1]partition: Remove trailing spaces and correct
 indenting
Message-ID: <20180620161434.GA3513@kidega-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reply-To:

>remove trailing spaces
>correct indenting 

Signed-off-by: kidega <kidegamoses88@gmail.com>
---
 block/partitions/mac.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/block/partitions/mac.c b/block/partitions/mac.c
index b609533..ec6dea5 100644
--- a/block/partitions/mac.c
+++ b/block/partitions/mac.c
@@ -97,16 +97,14 @@ int mac_partition(struct parsed_partitions *state)
 			int goodness = 0;
 
 			mac_fix_string(part->processor, 16);
-			mac_fix_string(part->name, 32);
-			mac_fix_string(part->type, 32);					
-		    
+			mac_fix_string(part->name, 32); mac_fix_string(part->type, 32);
 			if ((be32_to_cpu(part->status) & MAC_STATUS_BOOTABLE)
 			    && strcasecmp(part->processor, "powerpc") == 0)
 				goodness++;
 
 			if (strcasecmp(part->type, "Apple_UNIX_SVR2") == 0
-			    || (strncasecmp(part->type, "Linux", 5) == 0
-			        && strcasecmp(part->type, "Linux_swap") != 0)) {
+				|| (strncasecmp(part->type, "Linux", 5) == 0
+				&& strcasecmp(part->type, "Linux_swap") != 0)) {
 				int i, l;
 
 				goodness++;
-- 
2.7.4

