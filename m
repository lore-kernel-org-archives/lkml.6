Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9044C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9433120657
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vMCnhZd/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9433120657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbeHXAJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 20:09:06 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:38056 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeHXAJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 20:09:06 -0400
Received: by mail-oi0-f42.google.com with SMTP id z185-v6so11178260oia.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 13:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=srsUOfkueUvuKHgRZ2kT0yrPrLY33WwBffzB4eHUD4g=;
        b=vMCnhZd/u1av/n0EwS0q7iJYfXVeYcl6mNbDEJLyhSrEWN53IlYUdjxSxZo5sihgcU
         pe0VjTCPt38ldVVDIFcAYlW8r6rj3REomCf/vA0cWu0kfDEV1NK9zwOH11NQ6ZaljF+J
         uG/LlMpJB2u4Hj3PTAc+9RYuxi0xxW9TO8KFp9wfjvo5qiVfyGrEcEdvcffa+MlSUTTA
         TsBWXhtRDP+6zLc+eK4DRCmQ+dRsBucnHYMGurVLTHWLFSoe1lLp1GzvuDOSkYxzzy+i
         hi5wNisG0xfDEFMiPh0R0LMx+mBw5xHRj78dMcQ3NUZiT/KiQdVctCg1vMbi6N3DP+yR
         +8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=srsUOfkueUvuKHgRZ2kT0yrPrLY33WwBffzB4eHUD4g=;
        b=Ve0qRrF6AWIsu0wFSlyW279lyYOZvzsc0fKC9Eawv/ksFU91YLBmC/Yv/Ghdwu+aJF
         yYJKlAvgZ/LXmfulebDY7QU4h7sI5lbo0w3EJ5kQYGjbYOJFD7xk6l/5DT/Fw9UPBqb5
         B2kPpNezjX6ZXCFDv0UTF9I3JI9QelWS0U00Ld5TV8pQzeFOSEEBuLmvOS8UcGENh1/W
         jmkAI33tJMLnDFc1SohpjwP+brMkg9Ax7ZAc3USsTKdjao43biR1PClBsL6LTYBhC3Bf
         OnlogN2LkTL+MuksP9WS95TySj+lOUItfO1M17nxTxE+2Mr6Y8NkbTDFFWOly2NnSUT+
         WsFA==
X-Gm-Message-State: APzg51AYLorM3T9T3KcHRx0dyHTi3bKFwqFzQPcsXU/WG1T8K2PI5yxa
        4z80A9pm7N5xU8lScPPL2A==
X-Google-Smtp-Source: ANB0VdbumppgI15ZMN3mgOcxsbwBJ/fFA1foKVbKXHR067EOOjjWh0bX8qck6VZImE6l/Pa0/V04XQ==
X-Received: by 2002:aca:f58f:: with SMTP id t137-v6mr9421244oih.244.1535056663591;
        Thu, 23 Aug 2018 13:37:43 -0700 (PDT)
Received: from serve.minyard.net ([47.184.170.128])
        by smtp.gmail.com with ESMTPSA id r187-v6sm3852626oie.43.2018.08.23.13.37.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 13:37:42 -0700 (PDT)
Received: from t430.minyard.net (t430m.minyard.net [192.168.27.3])
        by serve.minyard.net (Postfix) with ESMTPA id 23E2495B;
        Thu, 23 Aug 2018 15:37:11 -0500 (CDT)
Received: by t430.minyard.net (Postfix, from userid 1000)
        id A014C3000CD; Thu, 23 Aug 2018 15:37:09 -0500 (CDT)
From:   minyard@acm.org
To:     Andrew Banman <abanman@hpe.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, rja@hpe.com, frank.ramsay@hpe.com,
        justin.ernst@hpe.com
Subject: [PATCH 0/2] ipmi: Fix issues in the BT code.
Date:   Thu, 23 Aug 2018 15:37:01 -0500
Message-Id: <1535056623-26634-1-git-send-email-minyard@acm.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first change fixes the race condition at startup between
capabilities detection and the startup of the upper layers of
the IPMI driver.

The second is cleanup code that I'm doing as I touch things in the
driver.

