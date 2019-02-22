Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A24C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27750206BB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfBVUx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:53:58 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35331 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfBVUx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:53:58 -0500
Received: from mail-wr1-f70.google.com ([209.85.221.70])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1gxHpU-0000KP-AW
        for linux-kernel@vger.kernel.org; Fri, 22 Feb 2019 20:53:56 +0000
Received: by mail-wr1-f70.google.com with SMTP id m7so1512896wrn.15
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 12:53:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M4VJ9JmshK8eifbcs0LbzgsfhsoR86SEK3Zw3F0Q9Js=;
        b=izCrLpROHk3n6SBr6jWDZhPEdFnlZV2CKLZMnj41Kfvq/G6jZlLnWPcp4mg8fCvsMh
         2k6AodBrgVXHkE3bkF3zwUBmbnunPehJoaEsaOqAqQ526wuLa0w0A5/OKxEh8xk6X3Qz
         XYyIBXOj1xPtl33cG0pn8bOyaQ5rFEAsceS1pa4rcwzQ4lWidhZ3arnsaS181YWVyHXG
         c4fouxVDv09SjFllgR+K7N6awtcSiOd/zqYObcyyKcjvmm/Z9df9PY91UV/+XSLae5g6
         3g7+b0PWUPIR07qA+fDSIMB+gZ0xsZfLG33kdBQJRSE9+Ph9OtlbD++EB570DLkNz0be
         lEPw==
X-Gm-Message-State: AHQUAuYIzUnBFX4yHTBEUpXfwrkPkrumBfPRKvY5pTbRK4QYEiNIBDNR
        N+cwDYWsST411n52U+etURCn+62/3wzRdLruk88RHkRArfqL2N9GCOEZhY6uyW7eOr/popH7vWI
        o80zY34AWaOWvDkgO1aciT2zXUdNayvkV6K4jV22oPg==
X-Received: by 2002:adf:edd1:: with SMTP id v17mr4306227wro.300.1550868835695;
        Fri, 22 Feb 2019 12:53:55 -0800 (PST)
X-Google-Smtp-Source: AHgI3IYd6zS1nBcKydzgiOVu9V2xelIUwnUMMZiZ3JL+DzBE3NxXWXMpitKB2Hx8iWfH6Qd9Oi1Dkw==
X-Received: by 2002:adf:edd1:: with SMTP id v17mr4306214wro.300.1550868835560;
        Fri, 22 Feb 2019 12:53:55 -0800 (PST)
Received: from smeagol.c.hoisthospitality.com ([194.158.46.138])
        by smtp.gmail.com with ESMTPSA id r14sm1432990wrv.77.2019.02.22.12.53.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 12:53:54 -0800 (PST)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, mhiramat@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Juerg Haefliger <juergh@canonical.com>
Subject: [RESEND PATCH v2 0/2] selftests/ftrace: Make ftracetest POSIX compliant
Date:   Fri, 22 Feb 2019 21:53:49 +0100
Message-Id: <20190222205351.743-1-juergh@canonical.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190222091021.10178-1-juergh@canonical.com>
References: <20190222091021.10178-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add shuah@kernel.org and linux-kselftest@vger.kernel.org.

The recent addition of colored output introduced some non-POSIX-compliant
constructs. Fix that.

Juerg Haefliger (2):
  selftests/ftrace: Replace echo -e with printf
  selftests/ftrace: Replace \e with \033

 tools/testing/selftests/ftrace/ftracetest | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

-- 
2.19.1

