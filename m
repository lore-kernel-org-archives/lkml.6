Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA05C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A80B20874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A80B20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753879AbeFTNRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:17:09 -0400
Received: from mga04.intel.com ([192.55.52.120]:7972 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751422AbeFTNRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:17:07 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2018 06:17:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,247,1526367600"; 
   d="scan'208";a="50488064"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga007.jf.intel.com with SMTP; 20 Jun 2018 06:17:02 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 20 Jun 2018 16:17:01 +0300
Date:   Wed, 20 Jun 2018 16:17:01 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Christian Kellner <christian@kellner.me>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] thunderbolt: Notify userspace when boot_acl is changed
Message-ID: <20180620131701.GP2558@lahna.fi.intel.com>
References: <20180618144404.21055-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618144404.21055-1-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 05:44:04PM +0300, Mika Westerberg wrote:
> The commit 9aaa3b8b4c56 ("thunderbolt: Add support for preboot ACL")
> introduced boot_acl attribute but missed the fact that now userspace
> needs to poll the attribute constantly to find out whether it has
> changed or not. Fix this by sending notification to the userspace
> whenever the boot_acl attribute is changed.
> 
> Fixes: 9aaa3b8b4c56 ("thunderbolt: Add support for preboot ACL")
> Reported-by: Christian Kellner <ckellner@redhat.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied to thunderbolt.git/fixes.
