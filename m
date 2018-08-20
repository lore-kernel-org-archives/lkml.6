Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401CBC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07471208AC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07471208AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbeHTTp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:45:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:39550 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726686AbeHTTp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:45:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4F377AD05;
        Mon, 20 Aug 2018 16:29:07 +0000 (UTC)
Date:   Mon, 20 Aug 2018 18:29:06 +0200
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Erik Schmauss <erik.schmauss@intel.com>,
        Lv Zheng <lv.zheng@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
Subject: Regression: 18996f2db918 ("ACPICA: Events: Stop unconditionally
 clearing ACPI IRQs during suspend/resume" breaks resume from suspend
Message-ID: <20180820182906.48f7743f@kitsune.suse.cz>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

after commit 18996f2db918 ("ACPICA: Events: Stop unconditionally
clearing ACPI IRQs during suspend/resume") I am no longer able to
resume from suspend.

Reported in bugzilla https://bugzilla.kernel.org/show_bug.cgi?id=200841

Reverting this on top of 4.18 fixes the issue. acpidump output is
attaches in the bugzilla.

Is there anything else that can be done to diagnose the issue?

Thanks

Michal
