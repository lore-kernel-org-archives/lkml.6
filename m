Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE794C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 03:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDEEE21726
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 03:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="FkFoimry"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbeLZDSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 22:18:53 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:45586 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbeLZDSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 22:18:53 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 760385E7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 03:18:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HSypG_6tdUXh for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 21:18:51 -0600 (CST)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 47E1E5C1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 21:18:51 -0600 (CST)
Received: by mail-io1-f71.google.com with SMTP id p4so17939087iod.17
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 19:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=0a6iLoxA6wF1DJBskZp4QRnRWZSuMAttZm8XTbt55IE=;
        b=FkFoimry8UcgsFXwRsAaWHzFwxmQlw82uqijmsUSMqYtQ2+oIjqOFoaTjbXv7yK7RT
         f8xzcOouYTLg8U7l1NIooXGlCT24AkkYdc5c4zK42t3GqXyYc2dxKOpOk+CEcb8HD09j
         lGRNUKooNby8FKMzM0PMQhTnqN6O1S7SzD+566aEoGq92IgPi1I+KzDwsr5sicLEgRhr
         lXlvOEnnaLVeksPuxZsfXE28GWT17cPOXfh0wXE8d8iX596kEcBZKhb13HPTG39uEfCs
         2tYjMk1VJxWkPqC85P7eeyH+HOCbaAZcCiUQ3vcPKiROhBV6XnUI9crraVt0ncU8fueY
         pDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0a6iLoxA6wF1DJBskZp4QRnRWZSuMAttZm8XTbt55IE=;
        b=WbO7VVeE6umUo0eHNsvSm2W2fmPTUE3iY9LmquGvLKmHlZzM9jT0Drkawmdh70czl8
         +W4ESqVZVx+H4HLS0e0Fv+ZIrL44wbhV9jgCQXzadXjR37aU29lJmgm8RkApOPp8dfeN
         PTIyTiqbalFPYZG7HCZZ1grv4sd2Qqc1xIPZUm+KwCpzPRY0HKVVlT2jwTHFss+Tveyk
         bu5Bcfsq6f68N8dqj1T0Vcp6egKCLfbuFGJvagGsVtQEw+JzsYXzbNtsl1Hgw05zu7MB
         vTWoo6lS+T0l4jGtB8FtoeMUYUmFF1NjOgl8RwOJZoSV0mGRooWODxdMpepZKEN1cTID
         FW/Q==
X-Gm-Message-State: AA+aEWYjpBRFSrQ1r/JlWT8SQnEkmcmpS2H/GC7zPe1Mmx84gIYqdr01
        HGm4/CP+QO3TmU9W+L9yvmpOoiOgO5VTzr7Zu/OzdhQKFm49UvTSqGm5j7cRAabIzV5IvJOO0cH
        3d7FVnWIx888rDzus5XpEDPxETJuI
X-Received: by 2002:a24:3282:: with SMTP id j124mr11757069ita.173.1545794330952;
        Tue, 25 Dec 2018 19:18:50 -0800 (PST)
X-Google-Smtp-Source: AFSGD/WftqB9KCTFRY9ZyUZ6oBd5zjtWRNPWRRNttOps53AenS3SuGmlhIEQDMoTrZAAVPRKCpLScw==
X-Received: by 2002:a24:3282:: with SMTP id j124mr11757065ita.173.1545794330743;
        Tue, 25 Dec 2018 19:18:50 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id m37sm12241104iti.6.2018.12.25.19.18.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 19:18:49 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sunrpc: fix a missing check of xdr_inline_decode
Date:   Tue, 25 Dec 2018 21:18:21 -0600
Message-Id: <20181226031823.72962-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xdr_inline_decode() could fail. When it fails, the return value is NULL
and should not be dereferenced.
The fix checks if xdr_inline_decode fails, and if so, returns.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 net/sunrpc/xprtrdma/backchannel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sunrpc/xprtrdma/backchannel.c b/net/sunrpc/xprtrdma/backchannel.c
index e5b367a3e517..bd9be5272ef4 100644
--- a/net/sunrpc/xprtrdma/backchannel.c
+++ b/net/sunrpc/xprtrdma/backchannel.c
@@ -285,6 +285,8 @@ void rpcrdma_bc_receive_call(struct rpcrdma_xprt *r_xprt,
 	__be32 *p;
 
 	p = xdr_inline_decode(&rep->rr_stream, 0);
+	if (unlikely(!p))
+		goto out_overflow;
 	size = xdr_stream_remaining(&rep->rr_stream);
 
 #ifdef RPCRDMA_BACKCHANNEL_DEBUG
-- 
2.17.2 (Apple Git-113)

