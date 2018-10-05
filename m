Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1CFC64EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 00:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B3B20834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 00:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vcgAylkR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B3B20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbeJEHur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 03:50:47 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33478 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbeJEHur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 03:50:47 -0400
Received: by mail-pl1-f196.google.com with SMTP id s4-v6so5992055plp.0;
        Thu, 04 Oct 2018 17:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=QQb6g6cW1TBuQU217oeMX2Ig0M7cA5OxcuM4yibF248=;
        b=vcgAylkR3+T0BJsG/3Cy1tDmecpSCwf5GNjtNGZ2NpUaeEVvRyGfyvVYh0bcEBLdth
         8huEeSbPwasyqWtNrnxVkoZ9ay+Z8xc1NOLsDCxdWyVwNd3Ywkpzc4peAvwgp9Hk+S6W
         Fge7mPhvpiIBkFDPODKespeKTCHNyjGI8jrkRmd2JjQkNaWR1rbE/+jN9rm+5xmQ09C5
         yQhVSZKvk+IV1iUtTPCO2iBavTOqeSZyLFgKzkTYbzuLTB4S8evQLgAaYV1L4/WShNQc
         Mwop+FjPHxr2JGgZ73P+Ddqm6eLK6l+K9WluMnp7DcL0tIe22sbenVdmgAD0jDSPs9gD
         DVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=QQb6g6cW1TBuQU217oeMX2Ig0M7cA5OxcuM4yibF248=;
        b=YbrVT5xyAzxpWeIxPlO0kWzofxXGIa/y21qU2w1JlRvUkvjosmhmXWDrcYyz8bb2Th
         GH5ydB+qvda71UaXWksIBLBnXoRWwsrrFZi1WHxnEHHF04EEfPPqqpp9r/Em/3JqXGJS
         aa+Y9fLnsZywL6RhWHmhldvOPP4XEGF7aVXJsfv2a6kviX5iGDh41agvoz3xvnXFsLFI
         WCdZvoRQzfZv5mh+DpMBqwQeFpGR6aPbGTh5dPCZOaNf6ADkUh2ICjuwAWHmBW59XXQd
         azlx9Jl/2K59ep14VNVNREk8Rw4iYK0J536RmtNHNJRfT8ZpuXhV7X1OHO/fDrdNwI02
         G93A==
X-Gm-Message-State: ABuFfohkSkRHSl61LDvqOP1Y5GrPpsakzGpyUFvrs/OP4Hz5IY5yb27Z
        vaOgVuiuTb+inEsWJTKaVjsj5TUm0hI=
X-Google-Smtp-Source: ACcGV62g5JELQ1kPOcWCEg3nJev0WpHl4PgcQhSTFf/jVc6qVE/3PhcWewmVPpac/2klXTM4a/J/CA==
X-Received: by 2002:a17:902:622:: with SMTP id 31-v6mr8896670plg.43.1538700875547;
        Thu, 04 Oct 2018 17:54:35 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id s2-v6sm10737879pfk.133.2018.10.04.17.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 17:54:34 -0700 (PDT)
Date:   Thu, 4 Oct 2018 17:54:32 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Input: uinput - add a schedule point in
 uinput_inject_events()
Message-ID: <20181005005432.GA218507@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Large writes to uinput interface may cause rcu stalls. Let's add
cond_resched() to the loop to avoid this.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/uinput.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index eb14ddf69346..8ec483e8688b 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -598,6 +598,7 @@ static ssize_t uinput_inject_events(struct uinput_device *udev,
 
 		input_event(udev->dev, ev.type, ev.code, ev.value);
 		bytes += input_event_size();
+		cond_resched();
 	}
 
 	return bytes;
-- 
2.19.0.605.g01d371f741-goog


-- 
Dmitry
