Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1386ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 759F52083E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gv1hr69M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 759F52083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbeJSQdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 12:33:07 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36749 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeJSQdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 12:33:07 -0400
Received: by mail-ed1-f68.google.com with SMTP id c26-v6so30669959edt.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 01:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pxm8OxNPhDlCMIXjR236o8IyUth6vkB7eMrUlqg5uso=;
        b=gv1hr69MFKcSm74CqGvswaxTLKy88OJdvvVtYUML/T9kffLmcTwN2EJunEzYjFHQS/
         jKNXSd/Zx9qry5WusBXpKNiWnycUwwT1sRk0Xno4ec5I6Mv093GcGi1Hlh3bxzEj7tAt
         ruDxzdbGg3WvMgTk3Ms0c8JUgU2c6mau8yeAR2GhuvAogAU75qhsCHrL70r4e0T9nlcO
         X267SJ8I7cGVkL+vbguaSjIIfDlobJWzgiu093xgeQl/Lo6rwYvVnyl0cnQgg51++L1w
         mH36z5MvRWK92Se9d9rVSKllWaLQllLN7IUawBY8jkAsA8xFmTdI0cv9hSYVEUP7Wnaf
         Iu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=pxm8OxNPhDlCMIXjR236o8IyUth6vkB7eMrUlqg5uso=;
        b=ueO+DfOQ+ABvmTEtpW1ryJjLNcM1t01Ck/1YrDt/GW649PxFrUfAq1LITwno854tTm
         O+7iLShKc/wJvso+p102X4nAOCAPvFSok/TVxxrpCI7ZP7IXgb9J2K5q4Plr0wjD16t+
         HrcmFC2taw8GLniN+770aOidxh9aboX5bqXM1EZQhc4KMxsAERSEpLaIIcamtQ3tgMTP
         LDWnh/y/82H2FoWLZVwj/I7eUhSBSbSvynQXVs47vUMCWyDpiAzsu62cqSuvKOlVirwI
         SHGvCN0i+R7jsOl9VPphm1K6NEsxbWbYhfEaAuRFyipZSfVn+GwWGr8KeV9sjs9oxv2k
         lhJA==
X-Gm-Message-State: ABuFfojql46I++nUIWGkDOQ8RkTT3VzGcEs8BWw8kkNCOhsuBOUvf+jZ
        yiPLK0S5mjywON1P3KrHKiA=
X-Google-Smtp-Source: ACcGV60pl9djdmv6DZ7sfChPgH9nsJxDQ7rSqNMpUkyKsFcuUFSPQMRmIzW0uyqD+Tq/MLjwotsIyA==
X-Received: by 2002:a50:8465:: with SMTP id 92-v6mr5410298edp.97.1539937682760;
        Fri, 19 Oct 2018 01:28:02 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id z7-v6sm8135011edd.71.2018.10.19.01.28.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Oct 2018 01:28:02 -0700 (PDT)
Date:   Fri, 19 Oct 2018 08:28:01 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Pavel Tatashin <pasha.tatashin@gmail.com>
Cc:     penghao122@sina.com.cn,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        pasha.tatashin@oracle.com, osalvador@suse.de,
        LKML <linux-kernel@vger.kernel.org>, peng.hao2@zte.com.cn
Subject: Re: [PATCH] mm/sparse: remove a check that compare if unsigned
 variable is negative
Message-ID: <20181019082801.kbnqxx5ozghy3p3b@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <1539447319-5383-1-git-send-email-penghao122@sina.com.cn>
 <CAGM2reYqEpY9KbMDU6uSaCuzsyN6qcXit930vbWk54PLhvZxZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGM2reYqEpY9KbMDU6uSaCuzsyN6qcXit930vbWk54PLhvZxZg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 01:04:45PM -0400, Pavel Tatashin wrote:
>This is incorrect: next_present_section_nr() returns "int" and -1 no
>next section, this change would lead to infinite loop.

Yes, the -1 is a very special value.

-- 
Wei Yang
Help you, Help me
