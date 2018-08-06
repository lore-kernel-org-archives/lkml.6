Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BFEC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1D021A6C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="imLs9/aO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C1D021A6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387860AbeHFSvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:51:02 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54936 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387720AbeHFSvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:51:01 -0400
Received: by mail-wm0-f66.google.com with SMTP id c14-v6so14471510wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 09:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MRLVSCH0Nl1kzAwRQQajvguDlRs+/L7hQOGZ466Yf5o=;
        b=imLs9/aOpxfxymi3Jm6LL6Cl+HPgYBfHrn/Rg9Cv1bIX3BAGWdVj4LT09FPkG31amJ
         2CoFZRgddIiWLsCzIWVXY1G1pFFxYVV8Mfp0qYuiZKiuMWN8Z0EzTMIHLKSlNuRG8u8T
         xollaHvv6gm2kjD0sMtaDFY/wRtfr0zOBGh8hemHLeRmD0Zq4K/I636KJEl/+SUtHWlK
         uPEVc4iPimcP9RTeAqVnlD6hx+VF6k8mnbMDmCCsv5pwcAQHCBhjwC3K4bOq0jwDBs8d
         fWI2OUe+eqE4h6JB7APAHwjbDL+As93F2/61VDpaxx+VJF3TJmmPJ82EujRrL8QyfY81
         0kXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MRLVSCH0Nl1kzAwRQQajvguDlRs+/L7hQOGZ466Yf5o=;
        b=R+i1EErpPvaCKgwmkGRUiLS2GcahXyhX2caVE1cLQkYtjktkcrAD5GpGvzxEQvOrGg
         0NpPiFodxYZhL+82sphulhZZbQkzfNFgAoH7KgEEp/q7vUi7Msk9tYvVa5CyP/2c6VCD
         4k3krLchVNeUXrDUNosnDT+24Rd63UubkgdY1hP7kX0YToQrevYb9H/cS2PDroDofsf8
         g+XZpOzSyNdU0DQxsA3iFvYsbWnT1g4sToEW3QaPCcil/xVHfUKLigxwb3dckl22v4p0
         WG5ND90+l0SbI/QJs2xsx0vV2AkRwcW+JjiWE79YLnWZOUsCHU/72N/URl6xVvHvs+oF
         c7wA==
X-Gm-Message-State: AOUpUlHY8qAQJn/xZX3uv2ZVbWGGOgCevZe5rnTt8b+ef+SemH8CTtFq
        wMgI4BEeRbmwhh0ta/CfUnn+Ng==
X-Google-Smtp-Source: AAOMgpdwhViAs+BEk/dzpjpUJqfDn+Z0f2edpJCMumu9mOlf7GNNn7B6rxYD936ltUhmZIL38rBNtg==
X-Received: by 2002:a1c:b756:: with SMTP id h83-v6mr13169480wmf.8.1533573665078;
        Mon, 06 Aug 2018 09:41:05 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id 66-v6sm16385790wmw.34.2018.08.06.09.41.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 09:41:04 -0700 (PDT)
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v5 08/10] usb, arm64: untag user addresses in devio
Date:   Mon,  6 Aug 2018 18:40:43 +0200
Message-Id: <39bbae2c9d880bd3c27ac3ee03d4be72e161491c.1533573460.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <cover.1533573460.git.andreyknvl@google.com>
References: <cover.1533573460.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devio allows to mmap memory regions and keeps them in a list. It also
accepts a user address through an ioctl call and searches the memory
region list for the region that contains this address. Since the addresses
provided to mmap must not be tagged, and the addresses provided to ioctl
might be tagged, we might compare tagged and untagged addresses during the
search.

Untag the provided addresses before searching.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 drivers/usb/core/devio.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 476dcc5f2da3..357c2e7b87b8 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -1404,7 +1404,7 @@ find_memory_area(struct usb_dev_state *ps, const struct usbdevfs_urb *uurb)
 {
 	struct usb_memory *usbm = NULL, *iter;
 	unsigned long flags;
-	unsigned long uurb_start = (unsigned long)uurb->buffer;
+	unsigned long uurb_start = (unsigned long)untagged_addr(uurb->buffer);
 
 	spin_lock_irqsave(&ps->lock, flags);
 	list_for_each_entry(iter, &ps->memory_list, memlist) {
@@ -1633,7 +1633,8 @@ static int proc_do_submiturb(struct usb_dev_state *ps, struct usbdevfs_urb *uurb
 		}
 	} else if (uurb->buffer_length > 0) {
 		if (as->usbm) {
-			unsigned long uurb_start = (unsigned long)uurb->buffer;
+			unsigned long uurb_start =
+				(unsigned long)untagged_addr(uurb->buffer);
 
 			as->urb->transfer_buffer = as->usbm->mem +
 					(uurb_start - as->usbm->vm_start);
@@ -1712,7 +1713,8 @@ static int proc_do_submiturb(struct usb_dev_state *ps, struct usbdevfs_urb *uurb
 	as->ps = ps;
 	as->userurb = arg;
 	if (as->usbm) {
-		unsigned long uurb_start = (unsigned long)uurb->buffer;
+		unsigned long uurb_start =
+			(unsigned long)untagged_addr(uurb->buffer);
 
 		as->urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
 		as->urb->transfer_dma = as->usbm->dma_handle +
-- 
2.18.0.597.ga71716f1ad-goog

