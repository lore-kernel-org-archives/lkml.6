Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-68338-1527703463-2-2763644307328566904
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527703463; b=iE83weyeg3IBzTdkiYLzPG9cvCFSWX5T7UQJjyUTDaMt33Vb6A
    tYMGrJhpDL4LRWX90l7er8WTJuWWhWkWn6FNHuphHkp+GKwSrvcSDZKs9B1+EkK8
    nKujf68c3qUNga3/G1RFZ1CXxC7TUw7+0/eJSqYG8BPZqUaNV3BmPDxNUiNUvlCz
    0Sa4dbUdM9eSeVP4Oo5eSB5YEi3l+UFfDmHPkCM7z1+jZxFXeUlD9YEKyGcpRIWF
    AAkH1ueh4q8lGKCUJu9KqSz2DWjrXvK236F/m03Q9M1PHWVZ/x1BXubhk0jlRpdy
    NE1dFT/zaW2E1L8AsDL+ihdro/NLWzG9SQAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1527703463; bh=yV7VQmrwsnj5VQDWVJ5ddcVinYo57U
    vzlGM56rbipgY=; b=bARJbfCMiywPZDuobpz2oSq+b5YmwJiQHoef73BKnqY/mE
    mY3nBfEwnglulIStJ5fTSXrjsda7ubuVsmsfu7Fx16U5fXsN5iuMdEhZl9FR31Cd
    D1ivO/XdM4ZqVM788PTWGfFD2w79+FcNEKLO5twrU6goZ9JF51cxSB8eztejO2r5
    ZIytynf+pcGPFKlZ3DOjr96Qsk6KIVmQy9c1M4BxrTA+qH/542Ek8jI3KUzisSkV
    jY1uY4veQFlN2K8Ty1ZIibAXZpBDiYAmUizBjskkD22ZyHiStrojXTNGu88XjX0F
    DmkGgbQ+5ZoQPaNG3CTzcA5DjEdyAAdMKTvR6M7A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=canonical.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=canonical.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH5ZmIGiPFcpVAZ0YK4vptRcj72w7d2nfTNpP+5d/6tRQ9ss1X9h8RcOb71c7BJjBXC+sQu23wLjdfWSL7ZDB8jjbpeHGIy6uym4wjQx5szl14KaYqaL
    guoCKvwJu+oXI9B22NTnbc335Yl7Qj/DX8AxD1mmwwrb+hKcrA9y1N98UtS70U94SFwvLdYT+FTa9DNq0QpPBAw6DzIoUTcT77CYkzU/9qlVPdgn6XYjJR6w
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=DfNHnWVPAAAA:8 a=FYp9HXgfHIqVHw_XUeoA:9 a=QEXdDO2ut3YA:10
    a=rjTVMONInIDnV1a_A2c_:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753487AbeE3SET (ORCPT <rfc822;linux@kroah.com>);
        Wed, 30 May 2018 14:04:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41466 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750752AbeE3SES (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 May 2018 14:04:18 -0400
From: Colin King <colin.king@canonical.com>
To: Benjamin LaHaise <bcrl@kvack.org>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] aio: fix missing break in switch statement
Date: Wed, 30 May 2018 19:04:15 +0100
Message-Id: <20180530180415.17572-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

The addition of the IOCB_CMD_POLL command removed the break
statement for the IOCM_CMD_FDSYNC. From my understanding, this
should not have been removed as the fall-through does not seem
to make sense.  Fix this by adding the break back again.

Detected by CoverityScan, CID#1469469 ("Missing break in switch")

Fixes: 2c14fa838cbe ("aio: implement IOCB_CMD_POLL")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/aio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/aio.c b/fs/aio.c
index 8274d09d44a2..e0b2f183fa1c 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1785,6 +1785,7 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 		break;
 	case IOCB_CMD_FDSYNC:
 		ret = aio_fsync(&req->fsync, iocb, true);
+		break;
 	case IOCB_CMD_POLL:
 		ret = aio_poll(req, iocb);
 		break;
-- 
2.17.0
