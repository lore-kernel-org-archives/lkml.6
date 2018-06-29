Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D91BC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35E527DE3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:18:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F35E527DE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936057AbeF2LSC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 07:18:02 -0400
Received: from mga03.intel.com ([134.134.136.65]:45516 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932531AbeF2LSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 07:18:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 04:17:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,285,1526367600"; 
   d="scan'208";a="68329282"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.68.37])
  by fmsmga001.fm.intel.com with ESMTP; 29 Jun 2018 04:17:53 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Jia-Ju Bai <baijiaju1990@gmail.com>, gregkh@linuxfoundation.org,
        nicolas.ferre@microchip.com, keescook@chromium.org,
        allen.lkml@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: gadget: r8a66597: Fix two possible sleep-in-atomic-context bugs in init_controller()
In-Reply-To: <87a7rdlup1.fsf@belgarion.home>
References: <20180620035453.7721-1-baijiaju1990@gmail.com> <87efh0o6f9.fsf@belgarion.home> <87y3eydrs1.fsf@linux.intel.com> <87efgqkrzl.fsf@belgarion.home> <87k1qhevpd.fsf@linux.intel.com> <87a7rdlup1.fsf@belgarion.home>
Date:   Fri, 29 Jun 2018 14:15:19 +0300
Message-ID: <87bmbtetdk.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Robert Jarzmik <robert.jarzmik@free.fr> writes:
>>> And as bonus question, why is it better to have mdelay() calls in the driver ?
>>
>> As a bugfix, it's the smallest fix possible, right? Ideally, we wouldn't
>> need either of them. Perhaps there's a bit which can be polled instead?
> Ideally yes. Do you remember if a "threaded interrupt" might use msleep() ? I
> seem to remember that they can, so won't that be another alternative ?

yeah, unless, of course, you have a spinlock held. ;-)

-- 
balbi
