Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0B6C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329EB20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3DRVPsl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfANRJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 12:09:23 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:35288 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfANRJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 12:09:23 -0500
Received: by mail-wm1-f52.google.com with SMTP id t200so336911wmt.0;
        Mon, 14 Jan 2019 09:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:reply-to:mime-version
         :content-transfer-encoding;
        bh=cBh/R8QFlqdOJanUFgZG7/gDC9AxWeBJjXXokBd25PE=;
        b=H3DRVPslPl0PgrTxWO1V8PUHDgXn/VjNYoYSiYxOq/Am5I6Q/94JfHVv9XuYbmTx3W
         9sCDT46l+6z0MUt9mQWxa0uu06kDZQ4MBDqPXBohFVpC5w9AFd/L6u+IiT7mnQ+/eUrV
         fGcjphUJ9ODRpZsQdxEqkDlN9Opvk84G6cmkpYv/yngyYAy6Tr1FGMd7zLr1KeF0Q0b5
         CHk40bZ8TCtOPHSIjAJ/yEv7aGtR+ttuPsE4VGRLRhMaS2QeWUgW0bALzLpTvfbAtC5K
         WKh3uMbtI1PDgP+GgFMvKOvSk3KYIMQXDN+PXCZIoZEcecjNNakfTPT0/cwYGUSa9y8O
         y1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :reply-to:mime-version:content-transfer-encoding;
        bh=cBh/R8QFlqdOJanUFgZG7/gDC9AxWeBJjXXokBd25PE=;
        b=O+o3Yk6SloP8oBOhNqMgZDDDf9ZBQ8HfZISzcZBCUNlfFVhtafYtwBwNwzyXfOX3sx
         gNQFyPuRECBvW34NmI4cMTGUZVjyfovv09PIum7u68UBrBWkEpx5qqhP8LFhUGzZZbZy
         eCMlCvvQRi7/XuNBewUxFj6s1nOG/AxFgL9UYah2zxvVfvCeQYeZ8s/NNscXnbwHDf17
         l61E6iLVf+A1SV/4zDXYFXDqYuRitrn8IX0P0T1M18ajx7Jecj+vCFR0GVUfZxhJ4pWx
         jpmHeytC/Zp99JqufivkY6gPJDLy06HMgAcqR/ByJ3J9MR8nT3Y6UpIe6s0CUibEh2fR
         r6NA==
X-Gm-Message-State: AJcUukcwbUwjkYDHeQjzXKMs51SPqK7ZanNbBwkazvnqcWGpYU7rqUVb
        ZqOWplXZx2Dwss9uAyQALKP6eUFm
X-Google-Smtp-Source: ALg8bN6cKXmN9f91OjGEAyjjiIpTr/c8T6kuvPW3GNhZu29wCVoUE09dgU7SQ1mqi7hlsUYb+4gORg==
X-Received: by 2002:a1c:934b:: with SMTP id v72mr95978wmd.5.1547485761058;
        Mon, 14 Jan 2019 09:09:21 -0800 (PST)
Received: from planxty.redhat.com ([2a02:8108:1700:1960:91dd:e2f9:ed05:ee2b])
        by smtp.gmail.com with ESMTPSA id q9sm103717562wrp.0.2019.01.14.09.09.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 09:09:20 -0800 (PST)
From:   John Kacur <jkacur@redhat.com>
To:     Joe Korty <Joe.Korty@concurrent-rt.com>
Cc:     Clark Williams <williams@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "julia @ ni . com" <julia@ni.com>,
        "tglx @ linutronix . de" <tglx@linutronix.de>,
        "oleg @ redhat . com" <oleg@redhat.com>,
        "linux-rt-users @ vger . kernel . org" 
        <linux-rt-users@vger.kernel.org>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
Subject: Re: [ptrace, rt] erratic behaviour in PTRACE_SINGLESET on 4.13-rt and later. 
Date:   Mon, 14 Jan 2019 18:09:07 +0100
Message-Id: <20190114170908.5287-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
Reply-To: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sebastian: I added the test from Joe Korty to rt-tests. Working on integrating it into the build, but I wanted to make it available before that so you
could send me your patches.

Repo:   git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
Branch: unstable/devel/latest

Thanks
John Kacur

