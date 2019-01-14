Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594F5C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20ED620675
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cP7T5XvO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfANU3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:29:52 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33646 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfANU3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:29:52 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so464773wrr.0;
        Mon, 14 Jan 2019 12:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cLAkezdImgjAZNPsAelp7TW27U5Jn+/8v6IVUEoQBRU=;
        b=cP7T5XvOmTgqDOvn1QQqPWQrzKtEf90OYO8RZ7vyC+x0vIMpowYDzVw1HlRXsw9pgX
         jndxmlzbAnoWv840CWt7Bd40q4YSIsSrBv6E2VVTW3V4MGTiHK8Ruk7d1XKSUD7zlSfg
         BetcUe3c/F6XgnObSY4lnQCjqCXi6y20BCEB3fPI4NRPlq0Lf3/oN3wfcrJdCjZ3XVkk
         ufybF/Q8jTizB/lNu/iGSvrldbTEy1uThTxBnA+Wh2yo4G3SykGWLNaD3V+CnJeuDRTw
         XhNj/ZYIqZh0Evc9Ds4d06CZo+9aLHX5EIknBXTkfvqPyZZzptP4SfUohgBpq9WT1Gn5
         uagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=cLAkezdImgjAZNPsAelp7TW27U5Jn+/8v6IVUEoQBRU=;
        b=emLGTuHg3CcomaQel9vuKjmQVAf2scB7QVAThnCUz3zhfrOP6ty6vk2KucpIQyrsRv
         lu+4DSFOp9tcKUx7IbWhEyz3EyPyxQoTlRCyptME9EK7Cs0i6wjNkaAlxESBz8OSk8Jc
         RmP8lVXLZBafFvExztgq+JOmQrmDn6P0+ZIZnDP3zaUPU0+PhfSyg1+Qfk8d5adANdRw
         yvW0BZFURrxFNyjnMwYDhnA1KYWvil5TEBkcVZnVH8OC5C4pT6MasWZasFS2lcut+spV
         3TN3Nmh1FWcVUCaZoRrI/fgsH3DzDaw5ULSUDHZux5WmEXl+JfP/IR40mbDj3K3c9ruZ
         PUhQ==
X-Gm-Message-State: AJcUukdc3J+hClO7fyT3y8vV3xk+3VvVuha+VlUXQTNG2o6ZsIyTnsyq
        B4t+rw1tHML6OLBYiIJNASOP0tqS
X-Google-Smtp-Source: ALg8bN6YFZbSVnA/XRMSKGOOm0a/GOJjpsLRhiCHkQ2YYxNMqLJ8kcCPzgwC3WGNqaOkk6bjvFzJaw==
X-Received: by 2002:a05:6000:14f:: with SMTP id r15mr203338wrx.53.1547497790564;
        Mon, 14 Jan 2019 12:29:50 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id o15sm61377439wrp.12.2019.01.14.12.29.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:29:49 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id D031011422AD; Mon, 14 Jan 2019 21:29:48 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] bpf: annotate implicit fall through
Date:   Mon, 14 Jan 2019 21:29:40 +0100
Message-Id: <20190114202941.16183-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
this place in the code produced a warnings (W=1).

This commit remove the following warning:

  kernel/bpf/cgroup.c:719:6: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 kernel/bpf/cgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 9425c2fb872f..ab612fe9862f 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -718,6 +718,7 @@ cgroup_dev_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_trace_printk:
 		if (capable(CAP_SYS_ADMIN))
 			return bpf_get_trace_printk_proto();
+		/* fall through */
 	default:
 		return NULL;
 	}
-- 
2.19.2

