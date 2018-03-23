Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521804295-2-7766492727658363709
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521804295; b=MogdGS2RYzseQn90tiLJQXaMAUuDxaYMzj4O0R26K/sipgm
    8A1oql3/80Eh4HAMrziMafG1mxsNd21AZbPIzjF7ckgZSxanj6c54Q0HSPyihAlL
    Ycot6cqvhQ74t7Qn/3Fk2n5QVZgVKGVH/pzBwnw7eJ59GfkiyB1BAzyngnkM6WIP
    t5lDP5LjozFYlH72W+1mg9kMEP88U9h4rioqkW1KJeF92gRaeFQBD5B42ruE4ORi
    J6Mplt5z3CkXq9Y8YAF834THilNm5cFGVxs3mlaPJhpaCgoRiDcvvow/FnfNwCmi
    breD15wIAs2bGzetZbwwaxgPUISdXS8C7bm019g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804295; bh=8s3pVBmvcFL1amwLprvhZqb+sb
    fi8HfzdiTzFk/wPqE=; b=vElCQI5Czg1LTNkLcoP90ywFEQL8T6LX1QCs5jnkjq
    hNhZ6GNS8PryvgaviaFOl2/rLjyIW8ub9grDyBe/ag1pWAJKyDaSofqwFx34fsOV
    DNtqSb4uBtWDUtOIBWtkBHpEvkGQZWWmxT21dPE6EAZpUmYQuUeHyXs7Ly4ge9M2
    t+KKdEvyMHxH0kQWJ0QPG5f8UDjHwo8LhC5YpOh1uCW8MGFj4vv02ynWvRmADSAR
    bDM8cMxxufjnQo4wm88wi46xBrhMATst6IZ6MvbebyyFa5Rc/Bjxwy3tBg3Gi3pe
    Oq7GzvHDoGwyZqOId7iuY0ry6pWpQPr/VCQictuAUCVw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbeCWLYl (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:24:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41358 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755348AbeCWKHo (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:07:44 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 082/177] iio: hid-sensor: fix return of -EINVAL on invalid values in ret or value
Date: Fri, 23 Mar 2018 10:53:30 +0100
Message-Id: <20180323094208.925699837@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>


[ Upstream commit c894acc7bf400d039bf740420b22f0b71b7fb504 ]

Ensure that when an invalid value in ret or value is found -EINVAL
is returned. A previous commit broke the way the return error is
being returned and instead caused the return code in ret to be
re-assigned rather than be returned.

Fixes: 5d9854eaea776 ("iio: hid-sensor: Store restore poll and hysteresis on S3")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/common/hid-sensors/hid-sensor-attributes.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -215,7 +215,7 @@ int hid_sensor_write_samp_freq_value(str
 	ret = sensor_hub_set_feature(st->hsdev, st->poll.report_id,
 				     st->poll.index, sizeof(value), &value);
 	if (ret < 0 || value < 0)
-		ret = -EINVAL;
+		return -EINVAL;
 
 	ret = sensor_hub_get_feature(st->hsdev,
 				     st->poll.report_id,
@@ -265,7 +265,7 @@ int hid_sensor_write_raw_hyst_value(stru
 				     st->sensitivity.index, sizeof(value),
 				     &value);
 	if (ret < 0 || value < 0)
-		ret = -EINVAL;
+		return -EINVAL;
 
 	ret = sensor_hub_get_feature(st->hsdev,
 				     st->sensitivity.report_id,
