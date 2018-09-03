Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37663C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 11:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8AA720645
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 11:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=zendesk.com header.i=@zendesk.com header.b="Z7hfMjDt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8AA720645
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=zendesk.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbeICPip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 11:38:45 -0400
Received: from us-smtp-delivery-110.mimecast.com ([63.128.21.110]:27782 "EHLO
        us-smtp-delivery-110.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726961AbeICPip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 11:38:45 -0400
X-Greylist: delayed 445 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Sep 2018 11:38:44 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zendesk.com; s=mimecast20150210; t=1535973541; h=from:from:sender:reply-to:subject:subject:date:date: message-id:message-id:to:to:cc:cc:mime-version:  content-type:content-type: content-transfer-encoding:content-transfer-encoding:in-reply-to: references; bh=1MzCF8XXs0vwa2rdmaj8XMDxlnAGxLSPWe4E2Kz/Dek=; b=Z7hfMjDtP68ZHfq5wb/yX1tDnhhNqOnqnRozo0SjFf4Nptmic08bSbv6i1yhCj2ytdwmNC9yQmHxWJZ22+A1Q7zFMrvTRfNTcZW41r9rLBGCzXore5F15ef/KIsSMMp16OKzh9jMwunfJUucH8tbtCU3KcVJajqeDI1OAWZBKYk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by us-smtp-1.mimecast.com with ESMTP id
 us-mta-8-xZe3DBzrO1q7hgST3Gt4nA-1; Mon, 03 Sep 2018 07:11:37 -0400
Received: by mail-pl1-f200.google.com with SMTP id 3-v6so103091plq.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 04:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cEzLh08orMDdNDTWgxYEB8Qf4lSpF1SBQuIXRFlCaCM=;
        b=LiaqvqdfkmPY1MMlM2wpnQlYWxA7S+I/mTFiPxhriS69cHQbsQ2R6mD18zJIdUsNt4
         vQxENVY8DF7k6oBqHJzWLbCdYUQPHQ4gzm8wwGQUdV97cpXOzrCJJDdbrnnWuGkGwCK0
         lBDz5adyxK1/dPLT7x9Q8utcEkqKR9UA/j4yYIdq1vEf7TYVwYV1IJOHkJMAAgECC5yY
         GrT0RB5zx0/xpiNOjV+epRgKg3aU6+wL7sr7xyS133hgVAALx8A24hoEehmJqICTKPHF
         y9XigmDiscIvw2E4ZIOB/ZmMXszdePMNB0dYLDCcO3wJWjIF6Dd2u+3u6edrCQyilJ2D
         2wcw==
X-Gm-Message-State: APzg51BQiya0nN/gMgjf1i1kCHeAuiUgkVTORECKQivfW4OGAJk1px14
        NxmNQvVBtrh1QsWbBT1Ee8faOQgqW4ev3y8AZ/pWB2mrYdX+eaNHyPjp1kdSojEvlevzi6qXFu7
        n5SBQpHKDcR2K10l2q1idhx0rLzYFPNlbYCyOg2M=
X-Received: by 2002:a63:1d3:: with SMTP id 202-v6mr25803477pgb.136.1535973095877;
        Mon, 03 Sep 2018 04:11:35 -0700 (PDT)
X-Google-Smtp-Source: ANB0VdausTD5izPb7B+uI5v1nTcxP9ZQvqypNa0CablnEu9vRiIwmMDgJor/HvZ9tWJJSdJwDFnsDg==
X-Received: by 2002:a63:1d3:: with SMTP id 202-v6mr25803454pgb.136.1535973095557;
        Mon, 03 Sep 2018 04:11:35 -0700 (PDT)
Received: from ubuntu.localdomain ([144.132.98.235])
        by smtp.gmail.com with ESMTPSA id y3-v6sm37181667pfi.24.2018.09.03.04.11.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 04:11:34 -0700 (PDT)
From:   ktsanaktsidis@zendesk.com
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org, KJ Tsanaktsidis <ktsanaktsidis@zendesk.com>
Subject: [PATCH] fork: report pid exhaustion correctly
Date:   Mon,  3 Sep 2018 04:10:16 -0700
Message-Id: <20180903111016.46461-1-ktsanaktsidis@zendesk.com>
X-Mailer: git-send-email 2.17.1
X-MC-Unique: xZe3DBzrO1q7hgST3Gt4nA-1
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KJ Tsanaktsidis <ktsanaktsidis@zendesk.com>

Make the clone and fork syscalls return EAGAIN when the limit on the
number of pids /proc/sys/kernel/pid_max is exceeded.

Currently, when the pid_max limit is exceeded, the kernel will return
ENOSPC from the fork and clone syscalls. This is contrary to the
documented behaviour, which explicitly calls out the pid_max case as one
where EAGAIN should be returned. It also leads to really confusing error
messages in userspace programs which will complain about a lack of disk
space when they fail to create processes/threads for this reason.

This error is being returned because the alloc_pid function uses the idr
api to find a new pid; when there are none available, idr_alloc_cyclic
is returns -ENOSPC, and this is being propagated back into userspace.

This behaviour has been broken before, and was explicitly fixed in
commit 35f71bc0a09a ("fork: report pid reservation failure properly"),
so I think -EAGAIN is definitely the right thing to return in this case.
The current behaviour change dates from commit 95846ecf9dac ("pid:
replace pid bitmap implementation with IDR AIP") and was I believe
unintentional.

This patch has no impact on the case where allocating a pid fails
because the child reaper for the namespace is dead; that case will still
return -ENOMEM.

Fixes: 95846ecf9dac ("pid: replace pid bitmap implementation with IDR AIP")
Signed-off-by: KJ Tsanaktsidis <ktsanaktsidis@zendesk.com>
---
 kernel/pid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/pid.c b/kernel/pid.c
index de1cfc4f75a2..cdf63e53a014 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -195,7 +195,7 @@ struct pid *alloc_pid(struct pid_namespace *ns)
 =09=09idr_preload_end();
=20
 =09=09if (nr < 0) {
-=09=09=09retval =3D nr;
+=09=09=09retval =3D (nr =3D=3D -ENOSPC) ? -EAGAIN : nr;
 =09=09=09goto out_free;
 =09=09}
=20
--=20
2.17.1

