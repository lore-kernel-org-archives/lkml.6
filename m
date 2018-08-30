Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B50C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B0C2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CQDTthRq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B0C2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbeH3PnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 11:43:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38557 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728623AbeH3PnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 11:43:16 -0400
Received: by mail-wr1-f67.google.com with SMTP id w11-v6so7755690wrc.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 04:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZXrp1luYhJIP4n0GyXQgKnJADxNlE5pIywVcPCMS+cU=;
        b=CQDTthRqqtcN1ufs2a01fqxdr/kNs6fWI4tuV05Bl51I45yCRaOhwJeuVLq2COoKxl
         frBJ/N/y1s89YtLmD61lAycbLOLLTF0db8371mdV5CkrUHIB4OqvgwpMqa2HqEJ5erXV
         cz73I1vf0Q3YRNllcJW9lajKpvoVIc6JFbWD0GQ32BBzzM/YZKvg69fdsbCB+jAY2CJ4
         qa5p1DPRxkB3fubKdY5z69yjcIW9inj4czCTZ8Pk2Y9ND/FF3DeAxxNEolW//bI2AMaQ
         R4nqHfd2pTi6R4MWd0G82haf4q4xC1vvoOFkFWodc62D052G9nhiMGMdvmjrksHp4cNx
         yWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZXrp1luYhJIP4n0GyXQgKnJADxNlE5pIywVcPCMS+cU=;
        b=Fz5XnkVAOvXPb7uXVTe4AQZqsP6iQmgbUsH8DjNnGIi4K1llKz4OzJ2Oa9FfJ4dWyV
         nHXhXayDfbFTAyBTpm5IJ8pFX61JrieshrOB6+6cCcuen+krO9B4KHRxgf9ZwSsQn8tK
         Rdv7oE37MLHd/btPpp3iMCo+8uTaKbaxvqV1QfdAIjp7/JetqgEwZtI2bNjHqYKMykOj
         29Z4JbJTQhcsOzhEQdnC+kG4t0qt2OHcAo/LanU4eoFNlMZPUh38ij3YxUTHfVqjRGCe
         DiF7sNYO6W4Wz6ZpK4tOHlTr8/KkCY9erXoW6FjQ3C57BnXx+hYRC/A/a5sPKtTWNaxd
         4J/Q==
X-Gm-Message-State: APzg51Ciw9ato1pjZfLCY3AnvpW6mieONCQd8/hDzBgsuGDYekc/VbeY
        PUlkiXzXb0wsv3AyR7sK6p41nw==
X-Google-Smtp-Source: ANB0VdZIxUKmp3XzvRVWDwkfAyMU2reSwM08s9a8no0z5/OE5Qno5M+2uM5JSbSFxxrvsRq8MTkiyA==
X-Received: by 2002:adf:ff0b:: with SMTP id k11-v6mr7791832wrr.15.1535629292576;
        Thu, 30 Aug 2018 04:41:32 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id z184-v6sm2175218wmz.0.2018.08.30.04.41.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 04:41:31 -0700 (PDT)
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
Subject: [PATCH v6 08/11] usb, arm64: untag user addresses in devio
Date:   Thu, 30 Aug 2018 13:41:13 +0200
Message-Id: <c0396442f9143244bdfdf0ea3bfab55b583a328f.1535629099.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
In-Reply-To: <cover.1535629099.git.andreyknvl@google.com>
References: <cover.1535629099.git.andreyknvl@google.com>
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
index 6ce77b33da61..ed5ab7c8100b 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -1405,7 +1405,7 @@ find_memory_area(struct usb_dev_state *ps, const struct usbdevfs_urb *uurb)
 {
 	struct usb_memory *usbm = NULL, *iter;
 	unsigned long flags;
-	unsigned long uurb_start = (unsigned long)uurb->buffer;
+	unsigned long uurb_start = (unsigned long)untagged_addr(uurb->buffer);
 
 	spin_lock_irqsave(&ps->lock, flags);
 	list_for_each_entry(iter, &ps->memory_list, memlist) {
@@ -1634,7 +1634,8 @@ static int proc_do_submiturb(struct usb_dev_state *ps, struct usbdevfs_urb *uurb
 		}
 	} else if (uurb->buffer_length > 0) {
 		if (as->usbm) {
-			unsigned long uurb_start = (unsigned long)uurb->buffer;
+			unsigned long uurb_start =
+				(unsigned long)untagged_addr(uurb->buffer);
 
 			as->urb->transfer_buffer = as->usbm->mem +
 					(uurb_start - as->usbm->vm_start);
@@ -1713,7 +1714,8 @@ static int proc_do_submiturb(struct usb_dev_state *ps, struct usbdevfs_urb *uurb
 	as->ps = ps;
 	as->userurb = arg;
 	if (as->usbm) {
-		unsigned long uurb_start = (unsigned long)uurb->buffer;
+		unsigned long uurb_start =
+			(unsigned long)untagged_addr(uurb->buffer);
 
 		as->urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
 		as->urb->transfer_dma = as->usbm->dma_handle +
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

