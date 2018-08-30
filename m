Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F72C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83A820837
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gD6FWtG1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E83A820837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbeH3Vfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 17:35:41 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:42085 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbeH3Vfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 17:35:40 -0400
Received: by mail-oi0-f65.google.com with SMTP id k81-v6so10742715oib.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 10:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=nRD3tcypqo55z7g9IorPcB7zReB6RcBUxjJv7QVV2rw=;
        b=gD6FWtG14YBdUy2Y7fJAiR1949ul+0wl8zaOrH0TtFqzTWK9TI0rFK1TKKYV8J6aOG
         k7F0jcOOFLoj1y0VXOyOTSHPL0djR9Z1mlS/wSxluKOD+tmhYGW135Wq40kKyztSA9FY
         cRjCJjbJOP4mG/GVv4sqyZwy0/9gO1fnEgtQYXnBlU8Ty7yJ7e34r/GAPfteJ/FiQh7r
         LfF54a+GlEN24D70Fw5p0oDE5mv0IHxciNv7t0Iv1tFQFqLBBTT9pypEmJ9GmFdodn3g
         oiXoIDXpigIkFjtKr/MjQo8gtEJHur4wAuAH6il0ztoxT84cuBHeyRAJELBsgNFhYOe7
         sXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=nRD3tcypqo55z7g9IorPcB7zReB6RcBUxjJv7QVV2rw=;
        b=gncxY6SQewCzn7rI5QEBNtp9QDMqq+TwjCxVrHq6U8Iz7pygCL29lKwCn4W6kG9iKX
         gHjD1iMMmcuxBmoFwhAswYI8mYvpB5KojvVBBX25orLx8pRQFfDk4b8/3yHpnCbZh46t
         FejKw/TuTMLv1zyweW3X9fPIw+WCEjXq09w86T+BSteZlUEJx0tfz1/I1CM+toDO7YLj
         Rfz9I6ins6jMBQeNcHPVG6UeL82miHog2O5QrIaLeHKLz+qBbQyFYFZoXiC048YZWPBu
         +zlxZn+JH5uERBFOx1eof/tYdUJahdXIvmguaqqDjpVg9ts1tUcqy/c9/JaS+LPZT+q8
         cPTA==
X-Gm-Message-State: APzg51BKRFgG931gNvkFp9Puj+l/Ouop+qm3Hw0qTUNWPpbyKb1P2vW2
        rgUKcoTKhXyRfMx61cT5hZ+qoFK+dtwsjp9Q1Nu3nwxb
X-Google-Smtp-Source: ANB0VdZ9oTO2RQNvTpk6JYTRmIrX/qLDxhxFGiDh1Vi9dfhwTiVHxoarh6BS26CL4SAvPaCa4yKokuPGl03lUeB0k2k=
X-Received: by 2002:aca:edd8:: with SMTP id l207-v6mr3684363oih.65.1535650348090;
 Thu, 30 Aug 2018 10:32:28 -0700 (PDT)
MIME-Version: 1.0
From:   Ray Clinton <mr.ray.clinton@gmail.com>
Date:   Thu, 30 Aug 2018 13:32:24 -0400
Message-ID: <CAPMnawsv0CYrqEHiWbnUp8uj1zmjPqifsATO=qiQLvQJpO9OWg@mail.gmail.com>
Subject: [PATCH 4/4] staging: comedi: Correct multiline dereference as per TODO
To:     Greg Kroah-Hartman <greg@kroah.com>
Cc:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using checkpatch.pl I was able to find a multiline dereference which goes
again the coding style for the kernel. I'm still working on my email client so
the indentation looks bad here (in gmail) but the arguments for
comedi_check_trigger_arg_min should go just under the opening (


Signed-off-by: Ray Clinton <mr.ray.clinton@gmail.com>
---
 drivers/staging/comedi/drivers/rtd520.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/comedi/drivers/rtd520.c
b/drivers/staging/comedi/drivers/rtd520.c
index bb400e0..b53bf5d 100644
--- a/drivers/staging/comedi/drivers/rtd520.c
+++ b/drivers/staging/comedi/drivers/rtd520.c
@@ -815,9 +815,9 @@ static int rtd_ai_cmdtest(struct comedi_device *dev,

                if (cmd->scan_begin_src == TRIG_TIMER) {
                        arg = cmd->convert_arg * cmd->scan_end_arg;
-                       err |= comedi_check_trigger_arg_min(&cmd->
-                                                           scan_begin_arg,
-                                                           arg);
+                       err |= comedi_check_trigger_arg_min(
+                                                          &cmd->scan_begin_arg,
+                                                          arg);
                }
        }

-- 
2.7.4
