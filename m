Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58002C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16ADB2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16ADB2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbeKBAaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 20:30:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:46448 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727966AbeKBAaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 20:30:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1BE32AC90;
        Thu,  1 Nov 2018 15:27:09 +0000 (UTC)
Date:   Thu, 1 Nov 2018 16:27:07 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Dave Airlie <airlied@redhat.com>
Cc:     Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Takashi Iwai <tiwai@suse.de>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Performance regression in ast drm driver
Message-ID: <20181101162707.598c1718@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

The following commit:

commit 7cf321d118a825c1541b43ca45294126fd474efa
Author: Dave Airlie
Date:   Mon Oct 24 15:37:48 2016 +1000

    drm/drivers: add support for using the arch wc mapping API.

is causing a huge performance regression for the ast drm driver. In a
text console, if I call "cat" on a large text file, it takes almost
twice as much time to be displayed and scrolled completely.

Can you please check that the ast driver portion of that commit is both
correct and complete?

Thanks,
-- 
Jean Delvare
SUSE L3 Support
