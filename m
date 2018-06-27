Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AC1C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC97260DA
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gqbhb9aX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DC97260DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934906AbeF0Pgr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:36:47 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40593 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934391AbeF0P17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:27:59 -0400
Received: by mail-wm0-f65.google.com with SMTP id z13-v6so5958334wma.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 08:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g7vPJ6C9yMPpfGQpi9Z8sz0LII9z4TumPUUp9BsvfwU=;
        b=Gqbhb9aXnJfMO6pKKEt0uRfxI1aVQIrRN5q1Ey1ZrPsYwVjBG/MAHsqP/pJipr9+QL
         nMDFKNaxNdUSZrVa0HW1cZrhSyAimojk/XJFSUCl//J5fEdYpHH7hZWemYjlLwkiO7vN
         wt+szt/f/KwK9XSYw3K9aq0FWOaL8RlhHq5R0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g7vPJ6C9yMPpfGQpi9Z8sz0LII9z4TumPUUp9BsvfwU=;
        b=lOafkUguOFK7pCVQaDq83iu8iRsuCfNXAeiwWlX2GiH15oNN53FZPX1ffdSB/59giG
         6EVW/SVFJ3U4gGbok6EEZSb8FccJVx34UAgY22r1JSKfe973VBsBbwEEIrnQ9TGZTlRq
         1e14kT32LJrO2/3trbnB8LwiDMz+BZGiVedRi0X3DBHcr20isF+KVGAmGyC7gfFuV3tJ
         03Ctm6oos/3MKBrhH0bgbXDHA+5ylS/uOcUTecIlW8PXUgOoAoz6FvMiQ8Sh56FuvOTW
         pwq2bYPAXBOZ3lvf67JwN1o1/grVRe75q7c/+wmzrSGbdWr5opc2kg2Fzq6756b+BRK+
         Qirw==
X-Gm-Message-State: APt69E0lxhNRwx9i+4F4Hx1diTPIwZGnxcP5qItGUl7QPT+TVWXeJ509
        cYfni8feTu2feN9aE51oPj1eBQ==
X-Google-Smtp-Source: AAOMgpcDSQ+zM4O1EjFXgEA7W6oWEQ7D9ONy0933jRmADoys1j5t4DTkaepKbiXvUZVN8DUuWOlMSw==
X-Received: by 2002:a1c:1815:: with SMTP id 21-v6mr5450216wmy.72.1530113278650;
        Wed, 27 Jun 2018 08:27:58 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id o203-v6sm2916075wmd.30.2018.06.27.08.27.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 08:27:58 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v4 01/27] venus: hfi_msgs: correct pointer increment
Date:   Wed, 27 Jun 2018 18:26:59 +0300
Message-Id: <20180627152725.9783-2-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
References: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Data pointer should be incremented by size of the structure not
the size of a pointer, correct the mistake.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/media/platform/qcom/venus/hfi_msgs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.c b/drivers/media/platform/qcom/venus/hfi_msgs.c
index 90c93d9603dc..589e1a6b36a9 100644
--- a/drivers/media/platform/qcom/venus/hfi_msgs.c
+++ b/drivers/media/platform/qcom/venus/hfi_msgs.c
@@ -60,14 +60,14 @@ static void event_seq_changed(struct venus_core *core, struct venus_inst *inst,
 			frame_sz = (struct hfi_framesize *)data_ptr;
 			event.width = frame_sz->width;
 			event.height = frame_sz->height;
-			data_ptr += sizeof(frame_sz);
+			data_ptr += sizeof(*frame_sz);
 			break;
 		case HFI_PROPERTY_PARAM_PROFILE_LEVEL_CURRENT:
 			data_ptr += sizeof(u32);
 			profile_level = (struct hfi_profile_level *)data_ptr;
 			event.profile = profile_level->profile;
 			event.level = profile_level->level;
-			data_ptr += sizeof(profile_level);
+			data_ptr += sizeof(*profile_level);
 			break;
 		default:
 			break;
-- 
2.14.1

