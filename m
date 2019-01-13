Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCF0C43444
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 00:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3957A20836
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 00:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="peUl5Dbh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfAMAO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 19:14:57 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:32976 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfAMAOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 19:14:55 -0500
Received: by mail-qt1-f196.google.com with SMTP id l11so22973330qtp.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 16:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BW3VTNVQqX4mnzD/oEEBtMuebL58BPezY1IEYEIRn1w=;
        b=peUl5Dbhq8cdn9j+FdirPsGEoiLj2/d5iPo7dOWlRbvzMM3kRNWD7uhFRaI/qV5yPp
         rhJo5aOABoUlL3GlzJPjpzzWK614fwYCr22/2sewDX8kEySrQ9b2/6VNSv7GqOkTAf4g
         tylwWAhgi7B5toOxRB5y2JgHFUeXq0OGz2d0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BW3VTNVQqX4mnzD/oEEBtMuebL58BPezY1IEYEIRn1w=;
        b=HRcqkUbn8yGP8iSl7wvm4wlOa1nzkCtUKZ98L0wFJ+E1zy5IsjYwMxi8pX4V1p3HX/
         LymmqncpvT/vM9xwc63lJVHCwsQJ0YIZBdldSYoDvWK+Q1f9X2nTQz72OIhucuPlt/j2
         K/5urinqDgDFt6I8BCK55szZMygzOW9/kPnDXYp9ELtOwbY0hBebffLcOJnynWXvqv3U
         bfye2Uae4ccjQZFpknBCAQShx32tRZsMItt39NEOJ2Hi8po922XDoQSchSS9AJI86gDZ
         8TDFGOcrunsaUAlqyDkzRciXSj/RRxs9VwhV3pIn0TVmpmVdzg8U5NhUdfPwQkbA3VbU
         YrkA==
X-Gm-Message-State: AJcUukeHwjm5XUNkEqmRqVKoLAvLJuP3VB4wX+cdb9a5Fa4tBhv6x45g
        eIKWvT7pVPXzkrLTWpYZJb19dqsju18=
X-Google-Smtp-Source: ALg8bN63zgmwpiL216eM6LcblB9NCKYZq4Zp16SueCgHnoD1JPEf6gCnBR4grzg3eQxXpHxpN1tz0Q==
X-Received: by 2002:ac8:2d2b:: with SMTP id n40mr18332053qta.38.1547338494012;
        Sat, 12 Jan 2019 16:14:54 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:0:1004:1100:cfd0:d2ee:d54d:ab6d])
        by smtp.gmail.com with ESMTPSA id p48sm50525149qtp.62.2019.01.12.16.14.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 16:14:53 -0800 (PST)
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org, mtk.manpages@gmail.com
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>, dancol@google.com,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        John Stultz <john.stultz@linaro.org>,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-mm@kvack.org, marcandre.lureau@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH -manpage 1/2] fcntl.2: Update manpage with new memfd F_SEAL_FUTURE_WRITE seal
Date:   Sat, 12 Jan 2019 19:14:45 -0500
Message-Id: <20190113001446.158789-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
In-Reply-To: <20190113001446.158789-1-joel@joelfernandes.org>
References: <20190113001446.158789-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

More details of the seal can be found in the LKML patch:
https://lore.kernel.org/lkml/20181120052137.74317-1-joel@joelfernandes.org/T/#t

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 man2/fcntl.2 | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/man2/fcntl.2 b/man2/fcntl.2
index 03533d65b..54772f949 100644
--- a/man2/fcntl.2
+++ b/man2/fcntl.2
@@ -1525,6 +1525,21 @@ Furthermore, if there are any asynchronous I/O operations
 .RB ( io_submit (2))
 pending on the file,
 all outstanding writes will be discarded.
+.TP
+.BR F_SEAL_FUTURE_WRITE
+If this seal is set, the contents of the file can be modified only from
+existing writeable mappings that were created prior to the seal being set.
+Any attempt to create a new writeable mapping on the memfd via
+.BR mmap (2)
+will fail with
+.BR EPERM.
+Also any attempts to write to the memfd via
+.BR write (2)
+will fail with
+.BR EPERM.
+This is useful in situations where existing writable mapped regions need to be
+kept intact while preventing any future writes. For example, to share a
+read-only memory buffer to other processes that only the sender can write to.
 .\"
 .SS File read/write hints
 Write lifetime hints can be used to inform the kernel about the relative
-- 
2.20.1.97.g81188d93c3-goog

