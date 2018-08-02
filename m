Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1884C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E0D2151B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPmUbOXj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69E0D2151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbeHBVCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 17:02:16 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46116 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbeHBVCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 17:02:15 -0400
Received: by mail-pl0-f67.google.com with SMTP id t17-v6so1431909ply.13;
        Thu, 02 Aug 2018 12:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=It2+870GXyHsbcyIGM1rZhdPzEg0/Pcu9ya3jofVJRo=;
        b=XPmUbOXj1DqpuKKwt0Q7GfMqEdDDGegizAUxshyX3OCqknptbhonpyPYKdBtauUOWI
         JNvF7wpQ0OPyO86SRLux2l0fejSk/JnvsQqBC+cirAV1oAPN/6o94Pksh9vTd6AI1Aoq
         vtZyB9H8499YjWPJkQ3goi3hxkC6WyzDYPgqfqAJg1Y+LP186deiMYeggz+51tRKimEv
         AS2ZYdo8DT58GBOhPJqQzaX+PDNSLTNkXlaswOF6QlBiOxdV7hZZXrGSQstUTrgsI+q3
         BQa41nbPH46oq5xWLRp4R+AJm/5OVONRSDHYMNwbqlixTAR1wL2GR2bxJVs6T5Qj/wT3
         9iaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=It2+870GXyHsbcyIGM1rZhdPzEg0/Pcu9ya3jofVJRo=;
        b=KcNsfHD0j3LCb4S0ojNVR5NoCu/D7GM/aOPmhII3IOIjrPoJ2s958Ej4Wl+ynR04t2
         xF/vI8oDKGsUrjutVJxySW+vOpoA1BTewPJnCzMs7BBvPlqOk6Glzv8PualklFQ+9PHl
         eAPCP9mu7uP5xhAufRN0L1EskGCJ56pd9E4b9F6TDMTbNpmq4MqSk3d5sbPaEVCDZEGl
         Kd/n3qZRr2RxNW5TEKcJ66OX/GPdFWv8F/WlL7UoFiiT/pPIZ5S/QrgQBo0+14qhj+RV
         eg8atHm+JOFyyB/BJKi0YxoaTJzXHNpxFc6T+LsMDrRSW+U8mFgjCY3sjXyV5SkNUrYt
         vzRw==
X-Gm-Message-State: AOUpUlEzgwnRZgZ2CiYmBH87Fl7V0Tx3Y3Q7qcvXKXUEwT2mnU+guRkw
        bczxMIODBhFwEed7tDFR3n8=
X-Google-Smtp-Source: AAOMgpcGLqQnGRHC+D9Rc/P6SVxstZ40cYiyEdXC9OGeD+ptdfgL2VIklBDFwFHZWkj8AgGF4ppaZg==
X-Received: by 2002:a17:902:904c:: with SMTP id w12-v6mr633590plz.95.1533236988267;
        Thu, 02 Aug 2018 12:09:48 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id h69-v6sm5289379pfh.13.2018.08.02.12.09.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 12:09:47 -0700 (PDT)
Date:   Thu, 2 Aug 2018 12:09:46 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/246] 4.14.60-stable review
Message-ID: <20180802190946.GA25832@roeck-us.net>
References: <20180801165011.700991984@linuxfoundation.org>
 <20180802154325.GB5137@roeck-us.net>
 <20180802182517.GA24531@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802182517.GA24531@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 11:25:17AM -0700, Guenter Roeck wrote:
> On Thu, Aug 02, 2018 at 08:43:25AM -0700, Guenter Roeck wrote:
> > On Wed, Aug 01, 2018 at 06:48:30PM +0200, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.14.60 release.
> > > There are 246 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Fri Aug  3 16:49:18 UTC 2018.
> > > Anything received after that time might be too late.
> > > 
> > 
> > Build results:
> > 	total: 148 pass: 148 fail: 0
> > Qemu test results:
> > 	total: 198 pass: 198 fail: 0
> > 
> > Details are available at http://kerneltests.org/builders/.
> > 
> 
> I spoke too early. parisc images crash after adding some configuration
> options. I don't see the crash with v4.14.59. I'll send another update
> later after figuring out what is going on.
> 

The patch causing the problem is commit 27608f359da88eaf ("fasync: Fix deadlock
between task-context and interrupt-context kill_fasync()"), see bisect log
below.

Kernel log message is as follows.

PDC_CHASSIS: Fault (1), CHASSIS  0
Backtrace:
 [<10267738>] dput.part.5+0x1dc/0x1f0
 [<1026776c>] dput+0x20/0x30
 [<1024f79c>] __fput+0x14c/0x230
 [<1024f8e4>] ____fput+0x18/0x28
 [<1019abe0>] task_work_run+0xa4/0xd8
 [<1016d044>] do_notify_resume+0x7c/0x84
 [<1015c258>] syscall_do_signal+0x50/0x9c

The problem only affects v4.14.60-rc1; all other stable releases and release
candidates are fine.

Guenter

---
# bad: [68285958fc2aaa2d85f795151e1c302d7991f1b5] Linux 4.14.60-rc1
# good: [53208e12faa5b8c6eac4eb1d23d6e3fae450fc5a] Linux 4.14.59
git bisect start 'HEAD' 'v4.14.59'
# good: [77d10fced99b2dc0a8067102073005c44e71f964] rtc: vr41xx: fix possible race condition
git bisect good 77d10fced99b2dc0a8067102073005c44e71f964
# bad: [ae308d8e99f6549bd14fc3c639f53966a49cd260] nvme: lightnvm: add granby support
git bisect bad ae308d8e99f6549bd14fc3c639f53966a49cd260
# good: [ee78ecab4e4f0db3f8dbef8369a90da02a89e07f] media: saa7164: Fix driver name in debug output
git bisect good ee78ecab4e4f0db3f8dbef8369a90da02a89e07f
# good: [7e4011cb50b422efaa08e2ad1c009e73b59403ad] f2fs: avoid fsync() failure caused by EAGAIN in writepage()
git bisect good 7e4011cb50b422efaa08e2ad1c009e73b59403ad
# good: [bca093b5dd86a25b8b81ba8a54e60ee6db095f15] net: hns3: Fixes the out of bounds access in hclge_map_tqp
git bisect good bca093b5dd86a25b8b81ba8a54e60ee6db095f15
# bad: [539f19edd347359502e4b6ce9ce793183e0e0a18] stop_machine: Use raw spinlocks
git bisect bad 539f19edd347359502e4b6ce9ce793183e0e0a18
# bad: [27608f359da88eafd5e344fb7ef1aeea9052bbae] fasync: Fix deadlock between task-context and interrupt-context kill_fasync()
git bisect bad 27608f359da88eafd5e344fb7ef1aeea9052bbae
# good: [73b68f3851b934de3cd2e01d6039d9dff4cf74e5] dt-bindings: net: meson-dwmac: new compatible name for AXG SoC
git bisect good 73b68f3851b934de3cd2e01d6039d9dff4cf74e5
# first bad commit: [27608f359da88eafd5e344fb7ef1aeea9052bbae] fasync: Fix deadlock between task-context and interrupt-context kill_fasync()

