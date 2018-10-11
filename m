Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4D0C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E24020841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="OyperUh5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E24020841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbeJKVhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 17:37:45 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:37686 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeJKVhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 17:37:45 -0400
Received: by mail-wr1-f49.google.com with SMTP id y11-v6so9859595wrd.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 07:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=pdYBk+dezCgk8ON1mox5hLprXM3lnDsejSHwPVeWrvw=;
        b=OyperUh5YuWSjE2j+nCHvajz5r2Q6WxD0ul8+UL8NbyLrTr5uh6Onxum9EJTYuKQGq
         qkovjEun95qu4HKjIct/BaJlQ2X9UUpwfhSdJHLX7B3u7XgJX4u7B6sxnFs/Y8SRjlas
         5ZQ1aepfmdor+CMlaMbSHRs51maaJQHN0LkYttCTnhHpr5V97Q06JcULl3Hxqas2Rscc
         6UcTjVRaUCbibmKGVL+vzS3VhyvuRgJgdyQHeSG+PG45BxSnrgvAdQpzp8esX4oM3kUu
         Kw5BjqaB6qyBd9zJputH23y2zs2/qddaWz3KEEX9YAzvaG+bA6wn2jUWkl66saYXQJaO
         HQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=pdYBk+dezCgk8ON1mox5hLprXM3lnDsejSHwPVeWrvw=;
        b=ITKC0BfKtTqoAPw1yYfGQSa0L+Omz+VHJSUXSVHtxI9B6E/pmFoZod2sPQISD8PPtZ
         CJwup7GY2O8N/+yH+t+BJdzQur+AbBWTen/veM5+LLT2J8AittTp2Mds4Efps/RS5yqn
         IkZHK3JnAnLKYjfTYDX9G2EjOGe4OqAuyf1Pq4CSbdzwJ35tahFztimew04qEhT4/8ca
         YskmdudW9qfAOr7KyBXve74u66cfytAMKTNLyG/r13bG6aUr76Fw+u4HXk12KIUzeNfo
         QHopfQqQXJK5cO67/Cm5Xrvpxa5FmV7LgQ/WNfvBe9BgnvrDf8zrV/Z2rw2ZZR1hTYXB
         CRAQ==
X-Gm-Message-State: ABuFfogfpPR3zvG1LlhlHQGxGpjiildCLT6FOjMcG/MSzpdKjV8FgdQR
        hrjeBIgY3+hltZHRhas+sGabwZIA38rHZQ==
X-Google-Smtp-Source: ACcGV61km9z1WrV8vaYq4A6xfb6uKDhnVMNPAyTs9wtFLkMsELkGoiE6EHjGo6iMyQknz0p3EO5K6w==
X-Received: by 2002:a5d:4409:: with SMTP id z9-v6mr1636846wrq.227.1539267022430;
        Thu, 11 Oct 2018 07:10:22 -0700 (PDT)
Received: from brauner.io ([2a02:8070:8895:9700:8197:8849:535a:4f00])
        by smtp.gmail.com with ESMTPSA id 4-v6sm16828844wmt.16.2018.10.11.07.10.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 07:10:21 -0700 (PDT)
Date:   Thu, 11 Oct 2018 16:10:15 +0200
From:   Christian Brauner <christian@brauner.io>
To:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Subject: overflow on proc_nr_files
Message-ID: <20181011141014.4big6jogmsnx25z5@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

I've just got pinged by Lennart who discovered that you can get your
system into an unuseable state by writing something that exceeds a s64
into /proc/sys/fs/file-max. Say,

echo 20000000000000000000 > /proc/sys/fs/file-max

which will trigger an overflow and percpu_counter_read_positive() will
return 0 and cat /proc/sys/fs/file-max will return 0.

That effectively means you write that number and it succeeds and all is
well and a few seconds/minutes later your system just dies or gets into
an unuseable state pretty quickly

I wonder if we shouldn't accept overflows or - if we have no way in this
codepath to detect them - set it to some pre-defined hard-coded value.

Or maybe this is even a known issue and by design but before I work on a
patch here I just wanted to check.

Christian
