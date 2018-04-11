Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3397032-1523481506-2-12969655684116318055
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523481505; b=QDOHj0+dOsCy9cExFdxTA9cwU/JDLg5iKzuSG7viRf9IQDfu9/
    f5jhttt2BAxVdwSe6ONq2L0GvmwLyvynPn0iozEdTXPboIQpP8r1pYBP11MFZFQt
    iua8Z9zrCgUhrSg3cHt0NK+taGFMKx7/KvKaELk4X8cuEwv/dfjWt+iXlL+dedrq
    M5GytCxN07bbL888HSMR2nkRLk5ybwFYAFAbrRqHqLUC6tbt0tTKNAoUi1kR0Wbc
    q9WDNlpNs2TXAX4ndmb/JAkPj013q7Pzhi6q4d8XlpEYzPcbHExc05Ag1Jo7sotK
    I3FqTI3pPoAcCRMiAbo5UxE0NvfIq/NT2Rkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523481505; bh=kixzw0vmsQZVwCg+oXzgDvkFFdtTWW
    +8Kbv/zxOMkW8=; b=EEmG6L/wPYS900RtfE7LfJaBZtR15rreLIHxcTtxKrrjEU
    5fetQUacP0a9adSyU7FToiwcRlZ9G3GBRvs6TJTJIdOduzKyOW2EYDv5Plmx1Vui
    kRwnlsgZuhVM36DDOQAAnsBsK72Ua5I6umltAY5LQWhZPlTB1iNKyzQCq+f6mDbV
    2U0U67qmIQc7ODiIxCZAfbLHNR4/A5d2A3GeBAUxS2ufmvc0/DZrkBziOZv0PzJi
    0cfwU8wOov9mXw7JEtnJo0GTyI/9g6C2M4RWkPVGSZRMLnnlvxShN2E8OicLSOu0
    4iPV87bwRjosMGxglt9ooTXIulpbqTMmSjOEYpFg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLZv1cs6J2Mg7CSZ3BWNsOz6MESqW8uZ7wBNGupujnNjwUiu43lDqXzyEA9fksSM8EHYSeP2sDeiOwYYFUEho0cBd1XriEV86uKLXnMcLTeYE7Upl9az
    KNclDyMpyMZeVKH4HtHH6OvcXwif1bYGBcI2VC0GbAxOvdpbZRKVQmm05HyWj+Xe6ndp0wsbcSAI6d+ph3jn+lGSyr/Rq7PX5DDi+w7FGNfkvPf+DKrNLO6I
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=e4JcQNwn_gKbhmeX78YA:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753017AbeDKSkD (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:40:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56280 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753241AbeDKSkB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:40:01 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 018/121] PowerCap: Fix an error code in powercap_register_zone()
Date: Wed, 11 Apr 2018 20:35:21 +0200
Message-Id: <20180411183457.250306103@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>


[ Upstream commit 216c4e9db4c9d1d2a382b42880442dc632cd47d9 ]

In the current code we accidentally return the successful result from
idr_alloc() instead of a negative error pointer.  The caller is looking
for an error pointer and so it treats the returned value as a valid
pointer.

This one might be a bit serious because if it lets people get around the
kernel's protection for remapping NULL.  I'm not sure.

Fixes: 75d2364ea0ca (PowerCap: Add class driver)
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/powercap/powercap_sys.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/powercap/powercap_sys.c
+++ b/drivers/powercap/powercap_sys.c
@@ -538,6 +538,7 @@ struct powercap_zone *powercap_register_
 
 	power_zone->id = result;
 	idr_init(&power_zone->idr);
+	result = -ENOMEM;
 	power_zone->name = kstrdup(name, GFP_KERNEL);
 	if (!power_zone->name)
 		goto err_name_alloc;
