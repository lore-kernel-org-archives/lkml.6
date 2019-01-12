Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA84C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 20:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB5D20870
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 20:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="E8mhyDNE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfALUid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 15:38:33 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33323 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbfALUid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 15:38:33 -0500
Received: by mail-qt1-f196.google.com with SMTP id l11so22681935qtp.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 12:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iDfQAm97H4o7dVA5ibXAUXRtADRsDfZK0W4lOHvCcyE=;
        b=E8mhyDNEc/DZK512mhs6N+jydr1x5ATsXKDHMHrN1k0N6w+JULc8c09ZB/9D8DG6H0
         /Kmxsnf3ed5QaJnpY4Naw6hSllSj9hACDJTKOVQFNhdZELtZ5ZsMgEVaBFD4c+KvS3S9
         Kmo/0G02HbyHxLnG/CGRM/iB3XUP5IHyN1GOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iDfQAm97H4o7dVA5ibXAUXRtADRsDfZK0W4lOHvCcyE=;
        b=afdSkmoab8pxQi1FvZQnUVlYTzETfotMNSdntZ108JHzcVdOAZCUZ/4SF1uCoxkqDh
         AmwZZeckOIn41qzd8Jigfdf6gbZX3j2MRr0f92uNmAW9lUnSkYq93Z6cq8Luu1/ChdvD
         f5fnj9ShIEwvG5zc4zNOYVBavd3MVeKD4qlBYqs2XAfsiTsBg79QYxDy1aa9XBBBv+wN
         kk+4F0YC7Fk2jKvzSwXnVzqc/va4X6yow/HGj5hX61Sc9iLq0wbvA+/Ia5+4rX4wdAza
         k9qYqXGTZtDIbehSU6qMoSHqjyeaiWnXnzYsEvIUivfgYSLtdK8gkH65pOd+TNblI4TP
         qRqg==
X-Gm-Message-State: AJcUukfSg6zL/3ZIB/uDpdTTsg+WgMj4+vvj+1Ax8sVjbfdpiqwFGhVn
        hlF7lq2cVEiBTu8crFUTPBjYXMMg81o=
X-Google-Smtp-Source: ALg8bN4E7rn9pHV+7ZlfIT/KIoyJGYP8hJ85YnG6ffaAiQtLgKGsihB8TYFh6+nRMYpYS3uJtEbPqg==
X-Received: by 2002:ac8:6151:: with SMTP id d17mr18325188qtm.194.1547325511908;
        Sat, 12 Jan 2019 12:38:31 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:0:1004:1100:cfd0:d2ee:d54d:ab6d])
        by smtp.gmail.com with ESMTPSA id c12sm55883402qka.42.2019.01.12.12.38.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 12:38:30 -0800 (PST)
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>, dancol@google.com,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>, minchan@kernel.org,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH v4 0/2] Add a future write seal to memfd
Date:   Sat, 12 Jan 2019 15:38:14 -0500
Message-Id: <20190112203816.85534-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

This is just a resend of the previous series at
https://lore.kernel.org/patchwork/patch/1014892/
with a small if block refactor as Andy suggested:
https://lore.kernel.org/patchwork/comment/1198679/

All,
Could you please provide your Reviewed-by / Acked-by tags?

I will also resend the manpage changes shortly.

Joel Fernandes (Google) (2):
mm/memfd: Add an F_SEAL_FUTURE_WRITE seal to memfd
selftests/memfd: Add tests for F_SEAL_FUTURE_WRITE seal

fs/hugetlbfs/inode.c                       |  2 +-
include/uapi/linux/fcntl.h                 |  1 +
mm/memfd.c                                 |  3 +-
mm/shmem.c                                 | 25 +++++++-
tools/testing/selftests/memfd/memfd_test.c | 74 ++++++++++++++++++++++
5 files changed, 100 insertions(+), 5 deletions(-)

--
2.20.1.97.g81188d93c3-goog

