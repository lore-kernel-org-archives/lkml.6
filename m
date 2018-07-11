Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32805C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D43F720BEC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eI6woNCQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D43F720BEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbeGKKfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 06:35:11 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40018 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbeGKKfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 06:35:10 -0400
Received: by mail-lf0-f65.google.com with SMTP id y200-v6so20866356lfd.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 03:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XlNCsZsaFCrDJsziMLUu/MnTe4MB8y1FLty9T+2t7UM=;
        b=eI6woNCQfMuxyOCbppB5C4b5CxwXkhzMfhZWDJgMOXx7WauiPRf2c+gm9iGBBRnC/7
         btaM9HiVZhRfUeeZTJlb30GOnQHTWKU++nUZzLVuwuDZeGmy18zVRJ5PI7l2pGbrKCP1
         hGj6Vw8r41DucQy0Ctbam4S3f8iPZEgYlVzNS20k44TDbk34eyKx+AnTA/JVlBOd4DHR
         rAWs+F5QY8DHLjFHeoFzBYHnmjZfF1JrPcVRba+wfH5zvE8YSEFjRuZ4H11Ge+/JtA4C
         pfaB19PbRQ0rhONwWj4+61WrB4et45eQ2K7VfW71AlcUkXpULL9v01f2yTNAAzVRBSxg
         EmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XlNCsZsaFCrDJsziMLUu/MnTe4MB8y1FLty9T+2t7UM=;
        b=QU/2kUyxayjJ2ofnl9BSmoMfbTElrgaiY64NvPCXX40G/3Z01d3nr/+Pzided1xD8d
         kkV37vVA+gboXyLoQkSZkEkJWtIk1cxYmgPHX/bpdfH8bve6ligJblOncLfJpE6XsOFt
         MA6Pk14yTBWGU71Stwull7+TJGMuW2jjC7e4PXoQPbTBM6q0yofiOa/EbS6DIrczY++b
         aBkQta8m7fPcRRyyc7rh40dqiRd0kem+CtdmQ7VGEOGc9Ao+rTb/h1VCSyf78TqNesng
         tvueWAIxZBMHfGF6e4dkCnXrlqjD3EqZ11XFhqxPFsOIewZvN9q4dbNbJc6KhvYUSXIG
         Sltw==
X-Gm-Message-State: APt69E1TAlmvZ5YNmYYA5gl+P27thHxeiscmJJQWSLiw78SURv6yuT4q
        x8FIMTmjFX+sWnew0qC+RUUyPKL5zBkJcNMBW5k=
X-Google-Smtp-Source: AAOMgpc/wQogZe2Q8Bj9Tx3/i7MyfP19VvMP9AdSLFUiTIpuLir+IOdV98WXGWYtbzs8LbnouXwYJJNWF7fy77OFzwo=
X-Received: by 2002:a19:5f11:: with SMTP id t17-v6mr5699764lfb.64.1531305090186;
 Wed, 11 Jul 2018 03:31:30 -0700 (PDT)
MIME-Version: 1.0
References: <1531217988-33940-1-git-send-email-ufo19890607@gmail.com>
 <1531217988-33940-2-git-send-email-ufo19890607@gmail.com> <20180710120816.GJ14284@dhcp22.suse.cz>
 <CAHCio2jQO58+npS269Ufyg17unHUeKDRpVjS4-ggBEV8xFMMqQ@mail.gmail.com> <20180711074933.GA20050@dhcp22.suse.cz>
In-Reply-To: <20180711074933.GA20050@dhcp22.suse.cz>
From:   =?UTF-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Date:   Wed, 11 Jul 2018 18:31:18 +0800
Message-ID: <CAHCio2itfdQ-Tk9x=YhZs6dG6GTZXkct++aND=jFC=8ndXq12w@mail.gmail.com>
Subject: Re: [PATCH v13 2/2] Add oom victim's memcg to the oom context information
To:     mhocko@kernel.org
Cc:     akpm@linux-foundation.org, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Wind Yu <yuzhoujian@didichuxing.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal

I think the single line output you want is just like that:

oom-kill:constraint=<constraint>,nodemask=<nodemask>,cpuset=<cpuset>,mems_allowed=<mems_allowed>,oom_memcg=<memcg>,task_memcg=<memcg>,task=<comm>,pid=<pid>,uid=<uid>

Am I right?
