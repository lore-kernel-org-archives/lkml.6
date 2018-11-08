Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A747C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FDA620685
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZQEYtut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FDA620685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbeKHSvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 13:51:52 -0500
Received: from mail-pl1-f169.google.com ([209.85.214.169]:44418 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbeKHSvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 13:51:52 -0500
Received: by mail-pl1-f169.google.com with SMTP id s5-v6so9244582plq.11;
        Thu, 08 Nov 2018 01:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OjSNxab0dulnRx7IrdL9nFcuFNvWc9J5o9tlVktOsII=;
        b=RZQEYtutxYI/HJnMGfl1VBk3TP3b2n0nNRzcBkwoILJQJGeRynrdZAjQGenfOh40E5
         Ac+FoirbzsK++ru3U1AEEocdXgy2uF84horzTLLYbClOuhj6LkWOo690fE1wG0MzS0XA
         vENkBZO64gjk2cihwdPfoy72/+2DvSBAOWjgTianf6BtFCtWPEaOt0RkmCCD4qaJb3A7
         9RSNBfvn5xaeg5YkWTCGAkzTQQlmbc/qphPKo4txg3w1DOX5UVFKhIWL5yOteB0/fIAF
         HmAjZdcHyR/Go/Pd3+Ps5+rZQO9yuJ7pABbR1A7xXD8ZGniay7HMW+M6NrV+NUJUGmy0
         i2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OjSNxab0dulnRx7IrdL9nFcuFNvWc9J5o9tlVktOsII=;
        b=gXqQc6reYMHFPFQBm/1K+PRpq7STXIjrppktQLVlja55C+g6/T4KSIz/b1j3xQk4jX
         pZMncEkrILiel+b9oKL+Tg4dx/lKrHzPDvisRiBgr5kIWnuCqFSAdLRjixTf/xz8Me+J
         XvaewTDtXIQYeAc303VTs0yBFZ8dXa+RPHCcjfwSSYWeBcwFUBM5pYBPZJ3wrCfR2cJL
         LnPVXf7nkRe7/Y2J1T3wTmVOjQpESwmKMdBtUJ/Yx6rg0mj78RczL2JWvaDso0jVo2A5
         QyTK/gu/KhbnF9mlZUM2SchEHducteQFKNzTz3DOonh1w53eY35tOy/DU5PH5BsaIZvS
         znbQ==
X-Gm-Message-State: AGRZ1gJ++kPNz15095scwnaa58F9Fmte5Xc47439M/wUsPDDrzXsjByh
        8BB9rasucpDg4YDwkPd0OSWQGbalUK0=
X-Google-Smtp-Source: AJdET5e3qjuIYLipsvdNYQYqo7LfszV3cogDp3+jwSUV9JtGa0kugC3gjWYC19wpNqDxH4XNUOL13A==
X-Received: by 2002:a17:902:930a:: with SMTP id bc10-v6mr3882065plb.17.1541668636914;
        Thu, 08 Nov 2018 01:17:16 -0800 (PST)
Received: from localhost.localdomain ([2405:204:54a3:4742:28e4:be46:8b17:69ab])
        by smtp.gmail.com with ESMTPSA id 27-v6sm4278815pfm.36.2018.11.08.01.17.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Nov 2018 01:17:16 -0800 (PST)
From:   Suraj Singh <suraj1998@gmail.com>
To:     davem@davemloft.net
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        suraj1998@gmail.com, Suraj Singh <suraj998@gmail.com>
Subject: Re: net: ipv4: tcp_westwood: fixed warnings and checks
Date:   Thu,  8 Nov 2018 14:46:56 +0530
Message-Id: <1541668616-9229-1-git-send-email-suraj1998@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541425985-31869-1-git-send-email-suraj1998@gmail.com>
References: <1541425985-31869-1-git-send-email-suraj1998@gmail.com>
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
