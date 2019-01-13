Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455EDC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 00:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B4320836
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 00:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="bqSq3bC2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfAMAOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 19:14:54 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44557 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfAMAOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 19:14:53 -0500
Received: by mail-qk1-f193.google.com with SMTP id o8so8668392qkk.11
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 16:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7w9z2NDwx0EJIbvkz8K7eQM1ra2HveMDSL81v9gmM98=;
        b=bqSq3bC2+/JKdGOABkvJxIEw183XUe/3IF0RdAalXKCvly+/GgmpDS3O8XAzv2KSHW
         EBcqZnO2UleQYObk6HVtPdcBOc9rLKR4xrzeZ9LblNongG6UDXpIs8/47IeNWos0nE4m
         S/9wagDnErOQpoA80Eu8GD4qV3Dlv+hylIH9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7w9z2NDwx0EJIbvkz8K7eQM1ra2HveMDSL81v9gmM98=;
        b=ad23hLwxqjriyCVXuKhltduIZ+BT0kAphdAI/8wnWLXHEvjgswBP50UVHIrFfGhud7
         kjj7lKXmy/l1qO7OwUahf/HkrMb7woSQqQC8KFqK2KAc8JvxuK2qgzGzzUuezl+dYm1H
         acPiERQzfpV3Oq1QqQ53XoKFtrNtQL70Flh71thTu4Pg8pgYp/fzsUt0l2umykATQISl
         r8LhkzqdTDBgD72OOlFqKserijQk9YPWU+9w+sSIRwQlLIXuTZ1E1Az8I8a1W2USsn5u
         6XCGF8VQ5BD6+b4NsrVB3SiZ94D7zoN0o/99W2CZdk2DjWVQpjYUyiAqEGiLTDfXwi8T
         cP4Q==
X-Gm-Message-State: AJcUukeG01ixcPYX0cXVfkTEkWbZzWE2Vg3+Bpq18/0yBYafLGNxTcHV
        U9AI19BBYw1kONokP4Tz73WMLPnQzXc=
X-Google-Smtp-Source: ALg8bN6ol6wOJk1D7ll4sTPt/uNTN0Nn1qcfrjhYKg2eivuSnPRA55rbYvYct3h4slegnWfJ5Md4SA==
X-Received: by 2002:a37:2d82:: with SMTP id t124mr16986662qkh.189.1547338492442;
        Sat, 12 Jan 2019 16:14:52 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:0:1004:1100:cfd0:d2ee:d54d:ab6d])
        by smtp.gmail.com with ESMTPSA id p48sm50525149qtp.62.2019.01.12.16.14.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 16:14:51 -0800 (PST)
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org, mtk.manpages@gmail.com
Cc:     Joel Fernandes <joel@joelfernandes.org>,
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
Subject: [PATCH -manpage 0/2] Document memfd F_SEAL_FUTURE_WRITE seal
Date:   Sat, 12 Jan 2019 19:14:44 -0500
Message-Id: <20190113001446.158789-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

These manpages correspond to the following kernel patches:
https://lore.kernel.org/patchwork/patch/1031550/
https://lore.kernel.org/patchwork/patch/1031551/

This is just a resend with no changes from last time.

Joel Fernandes (Google) (2):
fcntl.2: Update manpage with new memfd F_SEAL_FUTURE_WRITE seal
memfd_create.2: Update manpage with new memfd F_SEAL_FUTURE_WRITE seal

man2/fcntl.2        | 15 +++++++++++++++
man2/memfd_create.2 | 15 ++++++++++++++-
2 files changed, 29 insertions(+), 1 deletion(-)

--
2.20.1.97.g81188d93c3-goog

