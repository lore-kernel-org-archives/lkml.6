Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE28C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1EA9206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="GvwFoIU2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1EA9206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbeK2Krd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:47:33 -0500
Received: from com-out001.mailprotect.be ([83.217.72.83]:40441 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbeK2Krd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:47:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=2y7rvCLBGpq1oF7Ba/TMcwgeiigDm9cbslIvcwgujy4=; b=GvwFoIU22RKv
        tch4YNNAA8bZ9TRW+aQSlD/8UZs+QhGUR1UGwug6qpdu5M/EhiL/XRUV/39XwdMvcy6qIp2oD/5sr
        G/Qb7FJPy9TKRX0QiI+Z8a8muZe+n3b9tdXPk9R5yNDDmMUCErVIt1zZvMfJQmoVfsoBK7mvkzmIO
        ymww2yAzmdj0L4ZXEWwUfnkC+b0nytMg0PZg9FElIFkYQBdAoxnhKiL/UxP1bcdNWPfFWZQn/jARg
        ghCpyuR6Xl9Tm7oTOTVhwNbB2GHZbT+55IgseHwMRGwn8t16Z/zKhiIxpjhTFGT6tBQYe4bWtWMm+
        M2peF2YH/2Q9SoA+ggAzLw==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gS9Uy-0001zB-PD; Thu, 29 Nov 2018 00:44:04 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id A3830C11D1;
        Thu, 29 Nov 2018 00:44:02 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 14/27] locking/lockdep: Remove a superfluous INIT_LIST_HEAD() statement
Date:   Wed, 28 Nov 2018 15:43:12 -0800
Message-Id: <20181128234325.110011-15-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <20181128234325.110011-1-bvanassche@acm.org>
References: <20181128234325.110011-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: unsure
X-SpamExperts-Outgoing-Evidence: Combined (0.30)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5gjVvzj+P/rI6HT49Fpy4A9602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyB41b1wEpWO6ik9HITpMsqebHcXK5F5szpMR3
 ucwUCaulpCLw+Xb9GLNy0GASgpn9t8C9mOBdONdnsxgsk1D2p09kN7MM31r8n6t5T2S20aUz5oje
 3vd99if8HRiHmyfWq2ydL+V39l/HBScm+SV6be+d9aVwS6cHCn1lU19HAi2wFVccsCAZ2dyI5DAR
 qfkZNCNwpGn8jfSb3NCl2WUq0y0n+6u17EFNvY1xrVxHOMjdaWolaEIooNu/YQK5hGs0PEg+PVRT
 iaxPY52n0Pp/86b+Sk5ZBXUgt9/X6plqv8Jl041btgY00t8ZwQGEpPruR7mZSGBusUHA+NPQl8o3
 izVTzFcj6net3F9ovBQqv/AvhAXLR4H+Kw/zd724csQF4dM8j+vMkhFuGi1fREQKLve0CQqSo6to
 OMFDRXomXpw1d/TEuR+B72bMzWq28zMaJjFPun+z0diyrw+k3/1ATt1mHTcTFOoOq4AKk2yYOuVy
 e1nMP7x65Dc9Mkf58ZkYcxw3qqhc+N6cuEg4XWh5FmLD9qwDeCqIKxJqFsM2HnWV+P2P9SBBs8Oz
 zUidUBZeATR67OWo4wtMxyEU4pn+rg7hVZcN8GkHJZ17udP+VPgzN9VLYXnPHpe/XBgPmmCA3Jw7
 Ye1IFL3HxH/03qw6iNM+m4WpRRDP6YzwkAPgQJaydDKhkpC6ZK0vgiNE77t7Egv/f0uPlQkRpefH
 P6UKGC/NINCRLLfeUEAa+H0fy0Dd/mueyGbNQ+jefh+n1BYaXPWlFdaGOH191uXjgjQN/b5kfqj0
 tQktPXSRRMZmIod9z0N3x+lSwvgy8Ecc60m8vKp6CzkBdR79Dd1EhPQVxcFEFmAKKS84AwX/iljz
 3fdsSUzEa5K05YrDPck7Lv+Kvwd4T8p4Z8LmMjMaXp2HQpA5Fxib54hor19Rav1EA3WkjMUFfitz
 ioh1hkkIolmNinSTXZ3wVkojfhVRgl45nYoMd+TaWpBmaym2YQD09BA=
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initializing a list entry just before it is passed to list_add_tail_rcu()
is not necessary because list_add_tail_rcu() overwrites the next and prev
pointers anyway. Hence remove the INIT_LIST_HEAD() statement.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/locking/lockdep.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 41fd3b279220..83ffcc7f1ced 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -790,7 +790,6 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 	class->key = key;
 	class->name = lock->name;
 	class->subclass = subclass;
-	INIT_LIST_HEAD(&class->lock_entry);
 	INIT_LIST_HEAD(&class->locks_before);
 	INIT_LIST_HEAD(&class->locks_after);
 	class->name_version = count_matching_names(class);
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

