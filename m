Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668FEC61CE4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 09:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E5C2085B
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 09:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+ETn9eF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730480AbfATJpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 04:45:07 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44623 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730461AbfATJpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 04:45:05 -0500
Received: by mail-pl1-f195.google.com with SMTP id e11so8338389plt.11;
        Sun, 20 Jan 2019 01:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Uuj5qeyPQRNMgSOvskIjreOxX4tQJ5q841j1HWFRaJs=;
        b=B+ETn9eFnkyGXbFKkShNkgobCVLVyCEk0x5FgM3WdrFeu3QsQGg9Xzd2rJrZuKZ874
         MOujsPAfYoLda8eenq7wGYdvxB0jGJ9GDkJ0Zt6sqMIfk1OfG6+C9++OcDPmS6/d9UVY
         xHTdfxgHvssX2Gg5rtEVveNOjwmH2EfXZ4VPnz6kbcNmCbwnSQJ991vYPedvUIz93BEm
         wDGN9xHXFqUmIJPBtLBpI8a1xUHlytXDtTIvdkJGYMO8BGjRNmvk3mKZjh9v2af4Ujbl
         HQGWaBbYrvQXnlgwTwjTQa9QX7wC7/OIN3gy5OBlVfuyNfQDFBixqmRuD0Gqs/FzIZf+
         kwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Uuj5qeyPQRNMgSOvskIjreOxX4tQJ5q841j1HWFRaJs=;
        b=JtuxPsFxfT8v4g2VVbeP6TA5v8mBC1JXsfb0NEdY8vzaqpO0YqC+yj06xvsPK6MIFO
         g/to/qpl3QntuLdNvUjbBxbXuPz4+DSASo3n24EVm241GCaW2K1rM5yPxBexh8o21flJ
         gEazSDx5TAWTjsdyr0izphG07MKBoWveCugU2tYh+N/AMVdOw6A2tnR+RrxPAW6Pkv/k
         h28zDa+aT63I3TlIRGz0QGS6cd6qfmdi71bd/05BB5FDr0HRVZZNfGg+9dV3He2BZyzk
         U6I0CL0q8x/oRDNR44eg94HvRxFBAn/RSUz8GZyqeHd9P2HrDxRGVR17o5Xj6a7OAhHa
         ZEeA==
X-Gm-Message-State: AJcUukf75O2MVXu/cEVVsDggAQGip0XyEsK/FwgDIeWeql1Eole8i1Od
        svbjS/4YUPvl7KTBGcqIdmw3Nxs6
X-Google-Smtp-Source: ALg8bN78uIMhjBG7tPJtnVKpUrefmGaJ9o+gTHomnL0ak7v1Ercl08Bm44CMSQmYQ4GIVuiccGarqA==
X-Received: by 2002:a17:902:128c:: with SMTP id g12mr24656538pla.146.1547977503984;
        Sun, 20 Jan 2019 01:45:03 -0800 (PST)
Received: from myunghoj-Precision-5530 (cpe-76-176-3-80.san.res.rr.com. [76.176.3.80])
        by smtp.gmail.com with ESMTPSA id m3sm19444921pff.173.2019.01.20.01.45.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 Jan 2019 01:45:03 -0800 (PST)
Date:   Sun, 20 Jan 2019 01:45:00 -0800
From:   Myungho Jung <mhjungk@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_uart: Add a local variable to store the
 result of h4_recv_buf()
Message-ID: <20190120094459.GA22129@myunghoj-Precision-5530>
References: <20190111065514.GA26542@myunghoj-Precision-5530>
 <09FCB21A-2184-4CDB-8BF0-75C403DF39F9@holtmann.org>
 <20190119081919.GA10681@myunghoj-Precision-5530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190119081919.GA10681@myunghoj-Precision-5530>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2019 at 12:19:20AM -0800, Myungho Jung wrote:
> On Fri, Jan 18, 2019 at 10:19:41AM +0100, Marcel Holtmann wrote:
> > Hi Myungho,
> > 
> > > In h4_recv(), if h4_recv_buf() returns error and h4_recv() is
> > > asynchronously called again before setting rx_skb to NULL, ERR_PTR will
> > > be dereferenced in h4_recv_buf(). Check return value in a local variable
> > > before writing to rx_skb.
> > > 
> > > Reported-by: syzbot+017a32f149406df32703@syzkaller.appspotmail.com
> > > Signed-off-by: Myungho Jung <mhjungk@gmail.com>
> > > ---
> > > drivers/bluetooth/hci_h4.c | 11 +++++++----
> > > 1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > patch has been applied to bluetooth-next tree.
> > 
> > Can you actually fix all callers of h4_recv_buf since they all suffer from the same issue.
> > 
> > Regards
> > 
> > Marcel
> > 
> 
> Hi Marcel,
> 
> Sure, let me check other callers and fix them if applicable.
> 
> Thanks,
> Myungho
> 

Hi Marcel,

I found there are many callers that need to be fixed. So, how about checking
error code in h4_recv_buf() instead?

diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
index fb97a3bf069b..dea48090d2dc 100644
--- a/drivers/bluetooth/hci_h4.c
+++ b/drivers/bluetooth/hci_h4.c
@@ -174,6 +174,10 @@ struct sk_buff *h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
 	struct hci_uart *hu = hci_get_drvdata(hdev);
 	u8 alignment = hu->alignment ? hu->alignment : 1;
 
+	/* Check if socket buffer is not reset yet from previous error */
+	if (IS_ERR(skb))
+		skb = NULL;
+
 	while (count) {
 		int i, len;


It is tested and verified by syzbot. The previous commit is no more needed if
this looks better. 

Thanks,
Myungho
