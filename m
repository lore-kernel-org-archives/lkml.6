Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8D0C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B671220659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uC8hJcVZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfANUaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:30:00 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38118 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfANU36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:29:58 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so426583wrw.5;
        Mon, 14 Jan 2019 12:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7cWXqdMhc+t6PzNIIuVC7ci/8hrKuBb2fONAXRsDxMI=;
        b=uC8hJcVZ2Sw9BXpEcj1BvM5JWZ2VPVTfkIxtuIhSFcAv4sWMSFR0z4Apa9yYQci01m
         1QJ/aEt6RcxrAFUNGLbPh/lX/H0HPno8XVHZrQk9fLUiFeW4R3gUvxMMVpxkbO7OX6Tu
         T0MBVhKSvSCkaRL7D6bnvSq17Lh/MORvSBissDQyyS4nVkHUH1+oTd4yPhmN86apFAop
         7BSdccQNrUdRkYyTK3KaBkB8b1dlWjNefcY5K+t9lflvP8sfZKy8fAuGcW8vPjmZHaKZ
         3BwFHgGej941COOp1dYnHoVZGtZ/ipqMDJ+7W48NzwhwuTgRtUBgHYaPkKp5mxBVwIbR
         Q/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=7cWXqdMhc+t6PzNIIuVC7ci/8hrKuBb2fONAXRsDxMI=;
        b=XFu+jPhhWkOQ7PaDLH7mSmYnnyYQkI4PaNmIMJYu9dsZ9yWhgsgfinlrsWtq44332p
         NXI5tOBx5ix82uiK7E0hnCRHXZm9Fhg5IWqznd9ZjIVvpFcqRbmudHoFWhoRTmERd5XM
         DvVTvWLSYQqxbCnmc3sRhDIfbLLGgHiwIDs+tNEnZpflIy26TKXv+lmh5fYdyUHUp7Dr
         e2YuLO298sf2DwhvzZuSip+HP+oxGDrY9Mxy/+mxUV/TdkVksrbkqShvbjJya6iGceDT
         8GqXHpa3Zs80MetIYWq71qn7/TeYqS1Ziu5cCKW3I4JDrgbUm+qxja1eTIfRtyid31T1
         oHSQ==
X-Gm-Message-State: AJcUukdz7LA9sbbDiY2/0ITrEF7bZ6jCMNwV+yepQJkrd8gchX6Hcv5t
        P6r2/FhI6d/ecEwFgoP3n9QGA6CN
X-Google-Smtp-Source: ALg8bN5sF1uoUmayNjfV7YieiEMu7LGIb0VxQYRSvMC0jqZ3A63U7T49GnZ40LPd3giJ+z5GGZJZKQ==
X-Received: by 2002:adf:9f10:: with SMTP id l16mr209517wrf.206.1547497796605;
        Mon, 14 Jan 2019 12:29:56 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id n82sm29061952wma.42.2019.01.14.12.29.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:29:55 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id EFD0011422D0; Mon, 14 Jan 2019 21:29:49 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] bpf: annotate implicit fall through
Date:   Mon, 14 Jan 2019 21:29:41 +0100
Message-Id: <20190114202941.16183-2-malat@debian.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190114202941.16183-1-malat@debian.org>
References: <20190114202941.16183-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
thise place in the code produced a warnings (W=1).

In this particular case change a ‘:’ with a ‘,’ so as to match the
regular expression expected by GCC.

This commit remove the following warning:

  net/core/filter.c:5310:6: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 net/core/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 447dd1bad31f..c8069a142994 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5309,7 +5309,7 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 	case BPF_FUNC_trace_printk:
 		if (capable(CAP_SYS_ADMIN))
 			return bpf_get_trace_printk_proto();
-		/* else: fall through */
+		/* else, fall through */
 	default:
 		return NULL;
 	}
-- 
2.19.2

