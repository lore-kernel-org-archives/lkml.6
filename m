Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51010C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C90520833
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoPUyIkf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbfA3PjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:39:15 -0500
Received: from mail-lf1-f45.google.com ([209.85.167.45]:36500 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfA3PjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:39:15 -0500
Received: by mail-lf1-f45.google.com with SMTP id a16so17726250lfg.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 07:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=xHon2lKnek+1BJiY7RW8bxnCOvdBRRagpO+HQdREhzo=;
        b=QoPUyIkfh8UoX3h0N4j4dKWlkBD4P6gE/EUKOhUef+Op9wLCsWnUPgdvt/kH1lLAVl
         1tOhKc+JFShCKMQvjNtvIo3O0cpW/1Iji2T3LbfYf9YF/00xwJpqVEnTK2HLSAfg4wnb
         ZnLboFPCtSbLdfTiRaEB4CY7RQfqHyM6sMaqj3y3xn95SBKyDS+FuzLv160gu3VIK2Yl
         nL+9dQxSBoJTLMfe4V+U9OjvHvID/S4s0nK/8ycIXmGLTsQETv/Grd5RrBLV7xa85065
         TDHo/8uGqbQIVW6+h3nS/F9a1OzuA0liJ04AS8HqTrha+X5B2TEgJ9l+HOfIKOhHGqEd
         FQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=xHon2lKnek+1BJiY7RW8bxnCOvdBRRagpO+HQdREhzo=;
        b=fM6ZKtYYdpX2/tn/DKJQji//EESSr2PyXlPZJYjTezaQlS0xsJyakpcqZYUoj08YUe
         Z80LleAugsEDFD0bilqOSWP60AVgchZjt9/7beRB2MZdJBs4IA/V6vEchpBeKdr5HEVB
         ZDd68nuq1OMltpH9WqV8Gl4Brqnb1I7+lnzWTrlTFtcz2KJEpW4XbGdDWXG5P1/koSfJ
         44EtdpfFaAqdmmqNgQ55B/gWfVQSRRUu6doCkn/FmurmgPWo2c3tbPxImXEyRd8U420h
         J0GZaZsWZ1/fpyi2eOMZ0Kjo53lGmOJKdyeYjzkyn5lzSpbTu8QQ/Suy4K97bPN9rMro
         5Xsw==
X-Gm-Message-State: AJcUukecQqGIGY2fWJcgIDOtj3NwMEgSEDoL+CKyGkhNXchV/XH14KvW
        QS+IkkNkXYd7fZ/Hll8d8MMQIGMx
X-Google-Smtp-Source: ALg8bN5cUQMs353s4zAMLhyq5LM6nPylBi9r/fyXGBYfgTTmb612qCvaqzpOKaNBGm4YVqPwbE6LPA==
X-Received: by 2002:a19:3809:: with SMTP id f9mr24147815lfa.148.1548862752851;
        Wed, 30 Jan 2019 07:39:12 -0800 (PST)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id o17sm342115lff.77.2019.01.30.07.39.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 07:39:12 -0800 (PST)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id A27C246077D; Wed, 30 Jan 2019 18:39:11 +0300 (MSK)
Date:   Wed, 30 Jan 2019 18:39:11 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH next] fs/splice: iter_to_pipe -- Use PIPE_DEF_BUFFERS instead
 of hardcoded number
Message-ID: <20190130153911.GJ2332@uranus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And use ARRAY_SIZE for easier code modification if we ever need in future.

CC: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
---
 fs/splice.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-next.git/fs/splice.c
===================================================================
--- linux-next.git.orig/fs/splice.c
+++ linux-next.git/fs/splice.c
@@ -1203,12 +1203,12 @@ static int iter_to_pipe(struct iov_iter
 	bool failed = false;
 
 	while (iov_iter_count(from) && !failed) {
-		struct page *pages[16];
+		struct page *pages[PIPE_DEF_BUFFERS];
 		ssize_t copied;
 		size_t start;
 		int n;
 
-		copied = iov_iter_get_pages(from, pages, ~0UL, 16, &start);
+		copied = iov_iter_get_pages(from, pages, ~0UL, ARRAY_SIZE(pages), &start);
 		if (copied <= 0) {
 			ret = copied;
 			break;
