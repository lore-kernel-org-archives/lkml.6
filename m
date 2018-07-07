Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35131C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 07:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C148224B3
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 07:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C148224B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chris-wilson.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753630AbeGGHBj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 03:01:39 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:63304 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750973AbeGGHBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 03:01:38 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 12280725-1500050 
        for multiple; Sat, 07 Jul 2018 08:01:20 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <1525410499-18632-4-git-send-email-baolu.lu@linux.intel.com>
Cc:     ashok.raj@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
        "Balestrieri, Francesco" <francesco.balestrieri@intel.com>
References: <1525410499-18632-1-git-send-email-baolu.lu@linux.intel.com>
 <1525410499-18632-4-git-send-email-baolu.lu@linux.intel.com>
Message-ID: <153094688126.17577.10340360451966114779@cwilso3-mobl.ger.corp.intel.com>
User-Agent: alot/0.6
Subject: Re: [PATCH 3/4] iommu/vt-d: Clean up pasid quirk for pre-production devices
Date:   Sat, 07 Jul 2018 08:01:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lu Baolu (2018-05-04 06:08:18)
> The pasid28 quirk is needed only for some pre-production devices.
> Remove it to make the code concise.

Every skylake mixing iommu and i915 is now inoperable on boot. Reads
by the GPU from iommu map pages return zero, writes disappear into the
void, no errors flagged.

Please revert until the matter is resolved.
-Chris
