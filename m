Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89272C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6431120855
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfBTTLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 14:11:34 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39370 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfBTTLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 14:11:34 -0500
Received: by mail-pg1-f193.google.com with SMTP id r11so12338414pgp.6;
        Wed, 20 Feb 2019 11:11:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hs/20xPUFGkf7VRU6vyiN4PEHXTa4O0tdF2WTCqPcf8=;
        b=bFRGXtNXb80TXnPy1YEFXs+yNb3Y8r4h20RDt6RnRe8PRsXqaHJ9IaIMwsSXkYRbPu
         mqBylF1lG1E6YMEnnX5HMk4huRfddh6lZIuTKN7sE6/itB8zZLyBVjKXmLohT5cdxRuK
         H22e5Sh8UJpaQn9Ohw908NRgjVoZfjd2MefXYPV5031oloKNAlGT0eqCUBSPdyKtio63
         3AaZSYpekuzz8VjycmjQInksERXblR1PVkNYWkgDFsRwl6kcm5lmEg2tL3/kjwktxxnF
         zslgq7YCYU/XZ5cFd/kPVSkQiJdQORICzUyU7+hR1btcOCmUJj5iyB5md3r4SvBduum6
         FBrw==
X-Gm-Message-State: AHQUAubyJX9hiXlS3ffriSbFU2+kO7LUYV583SGjtXahapdjJGBorCN4
        +Xmyxlq/g0VS+z1NceU5DVE=
X-Google-Smtp-Source: AHgI3Ib6c2aNdHMYk0KaIhUbVvG7ZDqloKnmgMW1zPrCbDLHqlXikXOUIc1vWpEfFEROTiJXdU8bNg==
X-Received: by 2002:a63:1947:: with SMTP id 7mr6357759pgz.279.1550689893193;
        Wed, 20 Feb 2019 11:11:33 -0800 (PST)
Received: from ?IPv6:2620:15c:2d1:206:bfe1:be9c:5072:1789? ([2620:15c:2d1:206:bfe1:be9c:5072:1789])
        by smtp.gmail.com with ESMTPSA id o2sm26803909pgq.29.2019.02.20.11.11.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 11:11:32 -0800 (PST)
Message-ID: <1550689891.93548.31.camel@acm.org>
Subject: Re: [PATCH] scsi: replace GFP_ATOMIC with GFP_KERNEL for sdev
 allocation
From:   Bart Van Assche <bvanassche@acm.org>
To:     Benjamin Block <bblock@linux.ibm.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Steffen Maier <maier@linux.ibm.com>, linux-scsi@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 20 Feb 2019 11:11:31 -0800
In-Reply-To: <20190220184847.24640-1-bblock@linux.ibm.com>
References: <20190220184847.24640-1-bblock@linux.ibm.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-02-20 at 19:48 +-0100, Benjamin Block wrote:
+AD4 We had a test-report where, under memory pressure, adding LUNs to the
+AD4 systems would fail (the tests add LUNs strictly in sequence):

Hi Benjamin,

There are two more instances of GFP+AF8-ATOMIC in scsi+AF8-scan.c. Have you verified
whether or not it is safe to change these into GFP+AF8-KERNEL too?

Thanks,

Bart.
