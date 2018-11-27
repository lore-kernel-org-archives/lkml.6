Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C67C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 03:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ADC0208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 03:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gC7lSGDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ADC0208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbeK0OJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 09:09:16 -0500
Received: from mail-it1-f182.google.com ([209.85.166.182]:52816 "EHLO
        mail-it1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728381AbeK0OJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 09:09:16 -0500
Received: by mail-it1-f182.google.com with SMTP id i7so32044475iti.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 19:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NNAWz4bNphCZgg4Do+WXUyrCjrYbs6eXG7DZYC1W2d4=;
        b=gC7lSGDCGEN8/WqM/VK/CqRkeQVGS2AygTDQSo4I/IG0lIsRW3W6sPGkDV5009qhn1
         oQyzdfGKi7sJCGMqL2iSRl5PqWJ9AUZUwG5c377OCkmZboCT1m0uC3QXnKRAC+c2uv35
         0faL5kMre9wg74fk0DWQt1kesfKMebUJco2fo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NNAWz4bNphCZgg4Do+WXUyrCjrYbs6eXG7DZYC1W2d4=;
        b=Bqj8yb+iuaobjAs1mr0rTHaaEYqfS09qb8+OU3qcwGW0BPyZDiPCRYZxocX2BfKUUi
         DuFfoxGVT6/0RYDB2MGKhKfju4EP72+dpz+zoeLUf9cfGD9mSDt34T/kcXdk6N5sc6af
         cV5/lkoVD+owZOZ6kXb9GH2Dcm6ioPzNCqNaqTkVhVB1GdxSjUCJM7Ds1DcPpmRDoF2/
         B74UqmpuWNVEjFG1jZNTQw4k8rVMhrMYif31ZYnJKs5rTEGBCMrXFZh7bl3p623aQuM/
         S3ZCnPUs4RykB5IU/mmb7iL7f9xFg5ru8KHzE5UhVpy8B0WJfSAUDjhQZ5Px7hfD9iiI
         QWfw==
X-Gm-Message-State: AGRZ1gIsaGL6nWQoGpCycdRCCKRfxBqf3Z86OB0shn5HdR7semXTkgyt
        I99zpfmBy0S9mJZbYRAB4bs1J9xS3JQ=
X-Google-Smtp-Source: AJdET5cFPL811Xw2oQt+4K+fjuyrrZjFKNo+AqTNpnDbX428gIekDUiqC8zLAqA6R2/n6XVzMSyfOw==
X-Received: by 2002:a24:e38f:: with SMTP id d137mr24740403ith.69.1543288372071;
        Mon, 26 Nov 2018 19:12:52 -0800 (PST)
Received: from localhost (c-107-2-67-121.hsd1.mn.comcast.net. [107.2.67.121])
        by smtp.gmail.com with ESMTPSA id m11sm3702045itb.24.2018.11.26.19.12.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 19:12:51 -0800 (PST)
From:   Dan Rue <dan.rue@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dan Rue <dan.rue@linaro.org>, Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 0/2] selftests: firmware: fw_filesystem fix for busybox
Date:   Mon, 26 Nov 2018 21:12:14 -0600
Message-Id: <20181127031218.24419-1-dan.rue@linaro.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix fw_filesystem.sh to run in an automated environment under busybox.

After this change, fw_run_tests.sh still fails at some point in fw_fallback.sh,
with error "usermode helper disabled so ignoring test". This is coming from
fw_lib.sh:verify_reqs() because $HAS_FW_LOADER_USER_HELPER is set to no.

Dan Rue (2):
  selftests: firmware: remove use of non-standard diff -Z option
  selftests: firmware: add CONFIG_FW_LOADER_USER_HELPER_FALLBACK to
    config

 tools/testing/selftests/firmware/config           | 1 +
 tools/testing/selftests/firmware/fw_filesystem.sh | 9 +++------
 2 files changed, 4 insertions(+), 6 deletions(-)

-- 
2.19.1

