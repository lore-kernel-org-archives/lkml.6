Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098A5C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC3D22085B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="M9wXyYqI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC3D22085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387915AbeKFDnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 22:43:02 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45180 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387862AbeKFDnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 22:43:02 -0500
Received: by mail-pf1-f195.google.com with SMTP id p17-v6so4440318pfj.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 10:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IcHeJPDy1T6WJ8Fq/KWMAHt8XXMgVqCQgxCpPKbKBJs=;
        b=M9wXyYqIKEgqQIEmct5wd2kPiiSHE43E9Lkvrp7BmJdE9NKWkYx3+QVjmoU0tCY9uk
         M+wRAz4dAVV+MkuPtJ7+hPsAb2/On0bruoOvwk0/A3DGI4ZX0qg3siPeJrJwF4aOSt/6
         sk/MXZNbtGWdPd6udNfraOmG5pTpChd1Yc2ayv/EhfyZsuMvlpcsedktv7YAoOpG5gAe
         4mEkvdOKN1edoo+LaV9Uk4IgLd2+hFuqYj4cDNfukkyddBk4z7L1wYH4fklyLzq0deYA
         U0sQbHUuJTgDPhZOYqfdpKV3l1Cv0oJfo/0P/Rcogh/MF/1yzLlaz1vnufZbJU0B9Xxp
         n5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IcHeJPDy1T6WJ8Fq/KWMAHt8XXMgVqCQgxCpPKbKBJs=;
        b=n/4r9l5lVDwkc9nG0ozPHdHl37051e6FQzj6W0/tjtjENy8mJ5ug7JqDTXs0a9NVMY
         MznmOueXD49J05SNN5LvOn0einZVbwxcXHVuEWz8MpBk5Qrfp5ih3RwXfBFypAXrDYom
         FKWYh7+8O3H6+p5ya0TEI9yLWKCxKSUUvI+mWouw+4rsdWr4sHdPPuskrLAkdy47LlaC
         fIREJFNKMiQFcghYwTvskQ4FAGR2OJd6JHgdsSzJSChGXOoPUD+BfoSYnbT6vOlxq4V5
         EWE1ADF2cLS0WaqhAHerdsLlKXUGbWZX83ZaoEv5aHASGANP/ri6m7b8CETSPKoXlskG
         6NVw==
X-Gm-Message-State: AGRZ1gLRaxLp70JTv3cZqy2sYniF7LiO6ynwXyod7kTFThw6NFXRIktf
        eUXIP+rU4hU3sCA5OhIApe69BGuJA68=
X-Google-Smtp-Source: AJdET5dPPg2osdD85x9UsEy7rRMx/EolrukFiEW+nL0YW6oFDOO7veYp8k3xlVrauHis73nim8zf5A==
X-Received: by 2002:a62:7d10:: with SMTP id y16-v6mr22939181pfc.245.1541442127796;
        Mon, 05 Nov 2018 10:22:07 -0800 (PST)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.gmail.com with ESMTPSA id s184-v6sm53788626pfb.46.2018.11.05.10.22.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 10:22:07 -0800 (PST)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Salyzyn <salyzyn@android.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-unionfs@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@android.com
Subject: [PATCH v6 1/2] overlayfs: check CAP_DAC_READ_SEARCH before issuing exportfs_decode_fh
Date:   Mon,  5 Nov 2018 10:21:41 -0800
Message-Id: <20181105182146.233025-2-salyzyn@android.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <20181105182146.233025-1-salyzyn@android.com>
References: <20181105182146.233025-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assumption never checked, should fail if the mounter creds are not
sufficient.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: linux-unionfs@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com

v5:
- dependency of "overlayfs: override_creds=off option bypass creator_cred"

v6:
- rebase
---
 fs/overlayfs/namei.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index efd372312ef1..aa012b6bd46e 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -163,6 +163,11 @@ struct dentry *ovl_decode_real_fh(struct ovl_fh *fh, struct vfsmount *mnt,
 	if (!uuid_equal(&fh->uuid, &mnt->mnt_sb->s_uuid))
 		return NULL;
 
+	if (!capable(CAP_DAC_READ_SEARCH)) {
+		origin = ERR_PTR(-EPERM);
+		goto out;
+	}
+
 	bytes = (fh->len - offsetof(struct ovl_fh, fid));
 	real = exportfs_decode_fh(mnt, (struct fid *)fh->fid,
 				  bytes >> 2, (int)fh->type,
-- 
2.19.1.930.g4563a0d9d0-goog

