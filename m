Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31315ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1B521526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA1B521526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbeJQQyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 12:54:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58482 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbeJQQyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 12:54:14 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 44DE530F8BE0;
        Wed, 17 Oct 2018 08:59:32 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-246.ams2.redhat.com [10.36.116.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ACA1517142;
        Wed, 17 Oct 2018 08:59:30 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] ACPI / scan: Create platform device for INT33FE ACPI nodes
Date:   Wed, 17 Oct 2018 10:59:27 +0200
Message-Id: <20181017085928.13406-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 17 Oct 2018 08:59:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael, Andy,

For the why and what of this patch see the (somewhat long) commit message.

The single patch in this set both touches drivers/acpi/scan.c and
drivers/platform/x86/intel_cht_int33fe.c, this is done this way to avoid
regressions when bisecting.

The main change here really is to ACPI change and intel_cht_int33fe.c is
modified to follow suit. Also I do not expect intel_cht_int33fe.c to see
much changes this cycle. As such I believe it would be best to merge this
patch through Rafael's tree (after review).

Andy is that ok with you and we have your ack for this?

Regards,

Hans

