Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5F0C64EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 00:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C5FB20834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 00:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sku5nzj2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C5FB20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbeJEHuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 03:50:15 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39921 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbeJEHuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 03:50:15 -0400
Received: by mail-pf1-f195.google.com with SMTP id c25-v6so3900221pfe.6;
        Thu, 04 Oct 2018 17:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=LdaK5SM0cbZ8+uqETqu3XtbCHlOjH067AuPlfgF3kRI=;
        b=sku5nzj2xU4zDB1EqKNnEhVymZZYYaSXNPC6evHgmZI3/NuFlRV6nxkMBmVVktwoNP
         oKozXFAByKdzsjZPtNcFdNwWaY9Qxv9wc0OglKgqpzso9pmhisdDhIO0xgsF2kFKFFy8
         lmH/4wGE2ax611rjNnozrPPQN7+DJ3iOxj1qFcuFxSouwKZ37Sq+o4YyRGDrHYD7lS75
         ABVW2F3JhQf4etJXYZEHQEAaGUFtbU33qmX9c0wz2c3k7fdhJC0d1IWjFLIdPSlX93GS
         5dH+B1odtLX3i72leEJpJ6YDDC6TW1xcl6uYsXbMqJLYS61XKO5CkXw+I6oDLI0r8Ztv
         4KKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=LdaK5SM0cbZ8+uqETqu3XtbCHlOjH067AuPlfgF3kRI=;
        b=LUJBdMscog2avmfe1oi3hnD3lKFyTIAH/FmOqKy0jQZiF3qhcAZv2CMoL7yWC1Ctvn
         L94wjZYtMXDvVhzu8jnmU6vWcVK5ZkCCBM4DgK/6f4fLz9Kht6N5oEjdr157kmIG6cI4
         quxABcDU7GvoVv7wCrtGl2KMXq6BlqdHC0U+T2VAeo+SLke6kerucIjYZH5i6Jg0Iqjt
         RGOTP1j63gySrrl+cRJpr1DC6C4x5y6HHMyNv0VhJGvPVLb3BAODySmFV9K/PKIsusXi
         6AT9cTFcrqgYUOxS1njW+RJbnAIKuTY4yQ648Mfe6fxKIzhfgvm2eMn3qeu2ebuofK3D
         313w==
X-Gm-Message-State: ABuFfog1PtvNYk08dVNITyEg0B36CXpYqmi18z0brLYy7TR4ZHQxosDi
        Q4N50nlJS6VCqyOP6Rf4RowPWBpAaAs=
X-Google-Smtp-Source: ACcGV62lSBm4FgWFm9YvOlPAB3MWvKndljJUPMfbsxg+rLVBF/I1DrMQf7zkoRL/izyPdZPtLBukew==
X-Received: by 2002:a62:939d:: with SMTP id r29-v6mr9324509pfk.55.1538700843200;
        Thu, 04 Oct 2018 17:54:03 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id j188-v6sm8688514pfg.132.2018.10.04.17.54.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 17:54:01 -0700 (PDT)
Date:   Thu, 4 Oct 2018 17:53:59 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Input: evdev - add a schedule point in evdev_write()
Message-ID: <20181005005359.GA218372@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Large writes to evdev interface may cause rcu stalls. Let's add
cond_resched() to the loop to avoid this.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/evdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 370206f987f9..f48369d6f3a0 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -564,6 +564,7 @@ static ssize_t evdev_write(struct file *file, const char __user *buffer,
 
 		input_inject_event(&evdev->handle,
 				   event.type, event.code, event.value);
+		cond_resched();
 	}
 
  out:
-- 
2.19.0.605.g01d371f741-goog


-- 
Dmitry
