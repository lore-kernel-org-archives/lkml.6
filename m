Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC96FC46475
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 02:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C7E20651
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 02:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lVcKdgVH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C7E20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbeJXLNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:13:20 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:39580 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbeJXLNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:13:19 -0400
Received: by mail-yb1-f201.google.com with SMTP id z14-v6so2237922ybp.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 19:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vBydf9KuEP2KuBwgTcowx8br1a1tyHlSyFUG3Clz44Y=;
        b=lVcKdgVHO2DaUlBtN4U5DVmfk4Z1jkrX7mApd/K3DeYeH022pqytoSEAT2gFW1rKN2
         eTmifj3cSQqi8t/OIah0HRr52B0Rwd8sXt6gBYguVodtXOX24T++XTtWECioO/XABhTh
         QUMVy9lbOnyHBCyswR1Ul482xDbfeynK14NSH5hODnKEzKwmjmBWdJKq6pxJHyaiaOuy
         cm7TZ79MjjHAWPPZp5f+XmTv7jGPnJyMwsxHJnKGeYhgZgqxq3Fe+Ze7jkEOgHG/pa9w
         KRUGZUS93Ottoq0o/UMDTxIKDrDHPZjq518EGRmEabm9+zkFkcae/352Gw3nR27UrQcD
         UMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vBydf9KuEP2KuBwgTcowx8br1a1tyHlSyFUG3Clz44Y=;
        b=HMVP9aHwlJf0l8Y3aqN7el3eL9RmPRM+gcAzLE2TFnpKauH2t/qylsYEIRG86kDL2t
         +v8xnGVS//xI40gQKSPlc+ccu+TX5T+obobVg6ojd17E/FmaLKxcqkkpCsMjUNSOEhZa
         WrWWZpCtY7Ey8xOqEFmVtP5fd2jFAIIph+U3PfQm4Xln/9fflKyuPVLlN5uk8J9Owu6p
         jHwDYsTWHUPvhFyL7sf3piIY4Y6dCT2D2rmuyIcaM+q29XepqwJuVlRpXZikzf2wyuu4
         qos44BHYl92sIGPX4wL7WXC6Wl1pteip2HkPpCup3XN2Kaxi12zkHkMbJaOFSk632OGG
         2M8g==
X-Gm-Message-State: AGRZ1gJAIHNgN1aB5zumzuINVMkaTRYD9LT7w9gsiAGIpQp05Z7DIGr1
        G3mtFx5WCinRR8LgwJiv5CrE1Vz73saHsqMIWTEICQ==
X-Google-Smtp-Source: AJdET5cjUYjtOj5NTcj6bEB/n3zO3Xea0roDSgFGojaZl3nCi8WKcwooJkIC1bamOYWZOTU4UKLqXp5ltTXU+vm0eg6veQ==
X-Received: by 2002:a25:70c6:: with SMTP id l189-v6mr282878ybc.5.1540339211988;
 Tue, 23 Oct 2018 17:00:11 -0700 (PDT)
Date:   Tue, 23 Oct 2018 16:57:50 -0700
In-Reply-To: <20181023235750.103146-1-brendanhiggins@google.com>
Message-Id: <20181023235750.103146-15-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181023235750.103146-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
Subject: [RFC v2 14/14] MAINTAINERS: add entry for KUnit the unit testing framework
From:   Brendan Higgins <brendanhiggins@google.com>
To:     gregkh@linuxfoundation.org, keescook@google.com, mcgrof@kernel.org,
        shuah@kernel.org
Cc:     joel@jms.id.au, mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        julia.lawall@lip6.fr, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org, robh@kernel.org,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        kieran.bingham@ideasonboard.com,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as maintainer of KUnit, the Linux kernel's unit testing
framework.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b2f710eee67a7..8c9b56dbc9645 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7988,6 +7988,16 @@ S:	Maintained
 F:	tools/testing/selftests/
 F:	Documentation/dev-tools/kselftest*
 
+KERNEL UNIT TESTING FRAMEWORK (KUnit)
+M:	Brendan Higgins <brendanhiggins@google.com>
+L:	kunit-dev@googlegroups.com
+W:	https://google.github.io/kunit-docs/third_party/kernel/docs/
+S:	Maintained
+F:	Documentation/kunit/
+F:	include/kunit/
+F:	kunit/
+F:	tools/testing/kunit/
+
 KERNEL USERMODE HELPER
 M:	"Luis R. Rodriguez" <mcgrof@kernel.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.19.1.568.g152ad8e336-goog

