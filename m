Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id gEL/AzORG1vrDgAAmS7hNA
	; Sat, 09 Jun 2018 08:34:59 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 014C96089E; Sat,  9 Jun 2018 08:34:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 93EFA6032D;
	Sat,  9 Jun 2018 08:34:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 93EFA6032D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=CARNet.hr
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753246AbeFIIez (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 04:34:55 -0400
Received: from mail.CARNet.hr ([161.53.123.6]:59117 "EHLO mail.carnet.hr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753178AbeFIIey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 04:34:54 -0400
X-Greylist: delayed 1324 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Jun 2018 04:34:53 EDT
Received: from cnzgrivvl-t440p.carpriv.carnet.hr ([161.53.12.131]:39640 helo=gavran.carpriv.carnet.hr)
        by mail.carnet.hr with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <Valentin.Vidic@CARNet.hr>)
        id 1fRYzN-0005ZX-1b; Sat, 09 Jun 2018 10:12:45 +0200
Received: by gavran.carpriv.carnet.hr (Postfix, from userid 1000)
        id CF486246EE; Sat,  9 Jun 2018 10:12:44 +0200 (CEST)
Date: Sat, 9 Jun 2018 10:12:44 +0200
From: Valentin Vidic <Valentin.Vidic@CARNet.hr>
To: Hugo Lefeuvre <hle@owl.eu.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernelnewbies@kernelnewbies.org
Message-ID: <20180609081244.GP14048@gavran.carpriv.carnet.hr>
References: <20180602175649.GA2816@hle-laptop.local>
 <20180607124216.GA2329@hle-laptop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607124216.GA2329@hle-laptop.local>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: 161.53.12.131
Subject: Re: [PATCH v2] staging: pi433: add mutex fixing concurrency issues.
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 08:45:03AM -0400, Hugo Lefeuvre wrote:
> After discussing this issue on the kernel newbies mailing list[0] we
> came to the conclusion that it is very unlikely that pi433_release and
> pi433_ioctl would ever run concurrently in this case. This is also
> true for read/write. Unless one can find a situation where this might
> happen, I think we should not add this potentially unnecessary lock.

Yes, so we should than drop the TODO comment on this issue?

-- 
Valentin
