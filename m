Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1092440-1521803932-2-15584831293955785959
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enit,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521803931; b=bXLdmFt8rfcB1HqpjbrTJ+6HPcDXIISqW9jqNPIjoLdu1Fa
    wm7pb6P6/hG/rFEuPcTfHseDFzLBhNE4VdiMNwblz37qMosROLuqE+qkPRBuw1lX
    SUH+weYaHcWXMO2t0N0X8XuLyaKP4iScQQ0Pp9ycSZb8yXvR2PRgKf3sDQgLBcnn
    RRfVsOApIdS/AiLHcJlnwFpoAW5nj2os5RrztM0OlBk5s6AAtUgEsOnEKiQh4r9C
    eVhmoKz5p5nZJjTepwDJY0Z0/Yjh1biaxJvtLFBXpvfAjVuEdyXDHUAttX1JqSpE
    vB66XhIQ4InJPZ9rOczkP6LSJSyIdw9RpXhOLEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521803931; bh=/n5Ob85FiLh5A7r/hU1xBox5en
    BaKFHbq6pB72jsKbY=; b=P3vDNhLx4/zjvMD5ZlYidwmUAYsCpTeRKlyX1hNkh1
    jWgBaYYcuo8xs1J3q3LDhA0z/wor1k2e5zqCG/KzApvdI7tnjvf2g5n8bZZrSB+c
    SsP6oCkeauStIyDQidLlvg1MLXt4n9C5zNOq6i9a5g/+LRzL+KSX2NjwcLhPOnAR
    mqpu0qOHtsNZPuulYLoSND9/JUAr9ZF67q0c4Xvf3Lm8/NmCR1YTwRjZV7kkOWxw
    AK+4B/5lHuHk5MVTDx+/oZv2/jmR5KzVxES6bVASbjk3eK9lQIIEvhfe9bggmX4q
    xLPTjoVtC5hAvRhGeqFNCo1BykiSITKkmz6RAR3k4UbQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
        id S1755690AbeCWKJH (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:09:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41952 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755344AbeCWKJG (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:09:06 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 095/177] IB/rdmavt: restore IRQs on error path in rvt_create_ah()
Date: Fri, 23 Mar 2018 10:53:43 +0100
Message-Id: <20180323094209.483555486@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@oracle.com>


[ Upstream commit f0bb2d44ca26b7090dc7bade8877b77005f07dfc ]

We need to call spin_unlock_irqrestore() instead of vanilla
spin_unlock() on this error path.

Fixes: 119a8e708d16 ("IB/rdmavt: Add AH to rdmavt")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Acked-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/sw/rdmavt/ah.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/sw/rdmavt/ah.c
+++ b/drivers/infiniband/sw/rdmavt/ah.c
@@ -119,7 +119,7 @@ struct ib_ah *rvt_create_ah(struct ib_pd
 
 	spin_lock_irqsave(&dev->n_ahs_lock, flags);
 	if (dev->n_ahs_allocated == dev->dparms.props.max_ah) {
-		spin_unlock(&dev->n_ahs_lock);
+		spin_unlock_irqrestore(&dev->n_ahs_lock, flags);
 		kfree(ah);
 		return ERR_PTR(-ENOMEM);
 	}
