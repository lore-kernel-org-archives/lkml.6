Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC0CC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D64B32081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaPylgMT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D64B32081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbeKHSnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 13:43:14 -0500
Received: from mail-pl1-f174.google.com ([209.85.214.174]:41570 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbeKHSnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 13:43:14 -0500
Received: by mail-pl1-f174.google.com with SMTP id p16-v6so9254795plr.8;
        Thu, 08 Nov 2018 01:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OjSNxab0dulnRx7IrdL9nFcuFNvWc9J5o9tlVktOsII=;
        b=EaPylgMTtFvSdAYp7TE2USSwjBVgpRAxSVwU62pXwmW/0ByIR5+lZ5t8JuespKTTiZ
         h409OL0Z5/20CSogJBWjXUOb2bOuYmhRmMiYCgCTQcMJVV52i3U5+Q6eBriHOX/y/K/U
         WoTzX4z1bNx3aaOtYdlkg2DZ4bBNfE+ajL/ji2OZbt4zJe67oeDvB9+UX+aRwkS5EGl7
         TPv5JOJ9ii4YpuNRGXKQhIy44U1QaRD+dSM0uUET57G5ExEZCTiaSqtctFThTbZPVwIX
         ACQKSYIbVasWpsdYd8MuvizAnNvxuOsBGtXyS2O+Kz89DgqEtNPvr0toN+oUXLnevDPS
         Q1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OjSNxab0dulnRx7IrdL9nFcuFNvWc9J5o9tlVktOsII=;
        b=CXu3wfew2TkWihh7T5bqeDId+gnKKaSHV4gwjBFGFmggQRt+2uVVA7wjNPVLRnSY8u
         h6t/vhLLFErlO9UyG3jiJYQvhHfQA6XF22XUC91w/C+r30GXLy136luLS4g0cywrAhuP
         ZRQUtWdn0wN9BWr0qdUqoNIo8Wr5wfpX+mHHA/7sjWo3Ha1mhVwKapxjPhExp5PTHGo+
         EnS9SueZm4cdjZKy1RMWOjFMKyIjWTEffwDnBZpFBw/JPQS1nCWLr3lIVlcjKFmNTaZG
         3n4sIpCpRycm4tAV9dE+zgiOUAnC++Zrvf8wznjiDb7HoxxiebbBflwQKkJvHvH7Fw/n
         rJ7g==
X-Gm-Message-State: AGRZ1gKLoR9i0zl4tP7Q7vck06WRacMDnDVgGbhGkgSlL7ghzuLSj6gC
        +vmyqLYYLdkeXwsGvHRd5eE=
X-Google-Smtp-Source: AJdET5cy45EPUOi3v+KsMT6JmB/O+1brJhvnJW0REBN+QURE5iNCMs1mha5kmYdK5Nksu1Q2QH4IYA==
X-Received: by 2002:a17:902:14e:: with SMTP id 72-v6mr3607346plb.299.1541668122660;
        Thu, 08 Nov 2018 01:08:42 -0800 (PST)
Received: from localhost.localdomain ([2405:204:54a3:4742:28e4:be46:8b17:69ab])
        by smtp.gmail.com with ESMTPSA id 67-v6sm3629906pfk.134.2018.11.08.01.08.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Nov 2018 01:08:42 -0800 (PST)
From:   Suraj Singh <suraj1998@gmail.com>
To:     davem@davemloft.net
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suraj Singh <suraj998@gmail.com>
Subject: Re: net: ipv4: tcp_westwood: fixed warnings and checks
Date:   Thu,  8 Nov 2018 14:38:12 +0530
Message-Id: <1541668092-8661-1-git-send-email-suraj1998@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541425985-31869-1-git-send-email-suraj1998@gmail.com--annotate>
References: <1541425985-31869-1-git-send-email-suraj1998@gmail.com--annotate>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suraj Singh <suraj998@gmail.com>

Regrding why I used "staging: " in the commmit message, I was following Greg Kroah-Hartman's video on YouTube on how to submit your first patch, and in his sample commit, he'd started his commit message with "staging: ", and so I thought it was convention to do so. I'll remove that immediately. I made this same mistake in another patch that I just sent for TCP Vegas, I'll make the change there as well.

I didn't consider the complexities of calling the same function twice. I was looking more towards satisying the scriptpatch.pl's requirements. 

-		tp->snd_cwnd = tp->snd_ssthresh = tcp_westwood_bw_rttmin(sk);
+		tp->snd_cwnd = tcp_westwood_bw_rttmin(sk);
+		tp->snd_ssthresh = tcp_westwood_bw_rttmin(sk);

I've made the same mistake here. I'll make these changes and resubmit. Is there anything else that's wrong? 
