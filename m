Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0AEC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3913921756
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3913921756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbeHMPj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 11:39:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:49076 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729393AbeHMPj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 11:39:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B8D54AD57;
        Mon, 13 Aug 2018 12:57:14 +0000 (UTC)
Message-ID: <1534164556.10953.2.camel@suse.com>
Subject: Re: [Query] USB device autosuspend and its runtime usage count.
From:   Oliver Neukum <oneukum@suse.com>
To:     Anshuman Gupta <anshuman.gupta@intel.com>,
        linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Date:   Mon, 13 Aug 2018 14:49:16 +0200
In-Reply-To: <1534157102-29526-1-git-send-email-anshuman.gupta@intel.com>
References: <1534146566.10070.5.camel@suse.com>
         <1534157102-29526-1-git-send-email-anshuman.gupta@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mo, 2018-08-13 at 16:15 +0530, Anshuman Gupta wrote:
> 
> All of its interfaces are in runtime suspend
> 
> root@intel-Kabylake-Client-platform:# cat /sys/bus/usb/devices/1-5\:1.0/power/runtime_status 
> suspended
> root@intel-Kabylake-Client-platform:# cat /sys/bus/usb/devices/1-5\:1.1/power/runtime_status 
> suspended
> root@intel-Kabylake-Client-platform:# cat /sys/bus/usb/devices/1-5/power/runtime_active_kids 
> 0

Is the RESET_RESUME quirk set for this device?
All children idle but the parent active is odd.

	Regards
		Oliver

