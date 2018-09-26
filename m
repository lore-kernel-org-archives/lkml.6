Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40023C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF82C214DC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLH2UXRT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF82C214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbeIZVIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:08:50 -0400
Received: from mail-vs1-f46.google.com ([209.85.217.46]:42696 "EHLO
        mail-vs1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbeIZVIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:08:50 -0400
Received: by mail-vs1-f46.google.com with SMTP id w16-v6so6619973vso.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 07:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=x1Vz3KFDQdLEHkcEOLuGZECs8D2WF6kywoplavOvh78=;
        b=cLH2UXRTKEiwIcfm8xEh5rMoP2Vw8Gizb57RlgwtbrXLSwuzWTHBjNiiqra+SavVof
         hhIPsQ/hdhPMB4bEXL3x/YzRTg1x/hyz2yhR4rAyPqXEUTAtLzlA2p+8BPR2MerNOcfg
         chzq68tK79fBuno5t/UHNPo2oMnhKD5CEfkACyZ3sgjpeCb2Ved/Y/t6Kh4W+SpKxF/+
         eAkJeLjLiqdEq1fOJi12a4kzHZ8jKnn/TqliR/fJA0YhLemr1Oi4hoLxvEC4jyDpBa85
         HHtIU8cCI+CMCFUDmhvkK0Mp/kzn9cukkMZBXMRTOTCELt5N9XtRJMMFyYnaHy7HxX0A
         L1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=x1Vz3KFDQdLEHkcEOLuGZECs8D2WF6kywoplavOvh78=;
        b=OAAY3NKHeir7xrMP+i8AYsyyB0PwpdtsP2BxL0Y/d6uT/mBGrZ6SieytYEoYG1wUZc
         3OsUJLqEWDZBZ+UFUQWwm8vupT6v/ShQAiYInnoe8makPTzj9mJU4NK1XUu939Q97fZU
         mI0rMXO8uK2QLoahhsAUvIpFpnmkxpk2bEO/GZHA81U6YDKBppH7JRuN503SZBDi0pG0
         lLs8B//OdsQ02xCWONxq18YicL8S5EnRG2GguZslepwie0bbqET3WnFO6B9iDXH/Hmd0
         EI9EpetYFWORBUmuDcFSXX7bNHV9uSJRplF67AJzySTGDZG/uKa0h/4W96/wxp4f8UFl
         hkpg==
X-Gm-Message-State: ABuFfoikBkEYsmK4vLHjMrWOP9jadylsJo7kBYENkTCypTXv29ikMu4Y
        UH4103HUC6tWQP3KH6C6YYmkFrbsPYYWBslgwi/dKWI+
X-Google-Smtp-Source: ACcGV61bL0ORiSHcGoJC/hiIRHTjigtE9g5qPjVV6sLW5d9gVN3Zdd94eWAdjIbNapqVttV+k2ZO+22UoGE8Y1YMpI0=
X-Received: by 2002:a67:8906:: with SMTP id l6-v6mr1770338vsd.239.1537973729979;
 Wed, 26 Sep 2018 07:55:29 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?0JTQvNC40YLRgNC40Lkg0JvQtdC+0L3RgtGM0LXQsg==?= 
        <dm.leontiev7@gmail.com>
Date:   Wed, 26 Sep 2018 17:55:18 +0300
Message-ID: <CA+JonM0_4GSeQ5veX3aDjJ_RBoL065YLNFMuyVftQBn-pCcA=A@mail.gmail.com>
Subject: Maybe a copyright attack on linux
To:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Or: "Why you should not use "kill switch" option proposed by smdy to
protest against CoC"

Hello.

I'm neither a great software developer nor a lawyer, but I'm not a
novice and I'm very annoyed whan I see this:

https://www.reddit.com/r/programming/comments/9iqr3u/linux_developers_threaten_to_pull_kill_switch/

Or something like this:

https://lulz.com/linux-devs-threaten-killswitch-coc-controversy-1252/
(sorry, lazy to google other links)

Anonymous posts about "linux developers" who want to kill linux(kill
switch means kill linux) are extremely dangerous because some of
developers may "revoke" their commits and here is why whis is wrong:

First: even it you have right to revoke the patches, it will be linux
affected, not the sjws.
Second: even if someone claims that you can revoke your patches
because "it is a contract breach", it will be you who broke the
contract.

And the second case is the worst, because I am aftaid it can be used
as a reason for other kernel commiters to make their code proprietary.
As far as I know, most of linux sources are made by developers who are
either paid by corporations or are employeed by the corpotations.

What if they own 90%(or 80 or 70) of linux code? They can say: oh
look, the essential patches were revoked and it is a breach of
contract, so we revoke 90-80-70% of linux source(modern linux
source!). The "klll switch" can kill linux. Do not use it!

Please do not try to "revoke" your commits. It's not an option, it's
something bad people are trying you convince you.

Sorry for bad english.

Regards,
Dmitry
