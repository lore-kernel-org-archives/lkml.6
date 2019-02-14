Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DB9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF2FB2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="HKpIFuuo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393734AbfBNS11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 13:27:27 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42334 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393497AbfBNS10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 13:27:26 -0500
Received: by mail-qt1-f196.google.com with SMTP id b8so7945716qtr.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 10:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WwrYbdyI3iXMxOWcsdMqbFH0v/lw7uNgd4iS3S28kfg=;
        b=HKpIFuuos6PZX6ja9Am54gXeK5iqVDq+S7qdCXrtbgr8YZnVeijKrwOB49/4IZg0lv
         P81BhWImbBlr8JykpmrSWVKlNb6otJB+bEcy2rwayuGyH9mRG6ONrFMjDM2Jh9Al6+EB
         wZADh3Bloo4ekCfMqm0cLO4RyLYt7BP50J0/en/W1TkMEeEFD5KEHMicCvDy4NobNMoi
         7erutqJL/WtRKKFOsJanX36swVzhZF0e3TSRQS8qxlY7LSVUW3zSuAVELQaNqPXLVurA
         xsOEd/p0AISk9z6hskWQ1TNEY5a5ZcYfRsdcWUNIIE8WAomNYhN7136jXj3p4Nj/0g+P
         lkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WwrYbdyI3iXMxOWcsdMqbFH0v/lw7uNgd4iS3S28kfg=;
        b=WM2xPSVD0y4+yYSSvJozC3WP0PSSG+DCS1gfePglk0HwGuBrg/YNLeFIkOS7O4BqB8
         2/anIASR9haQKXyVHqeL9dLtvmALLF/7RahfSWfqwWCvL2ktStOFqcmd0h8cCN5ktxO/
         QkgVhjJ08nm+yBTAHT6bJXgrUiempOz26MBGKE7zjpGxsXp1rGmqdNrFS27xSjZOPGPv
         R22lacHwdlDjGxLRi1EXjWe3AwgSAaAAQBXcS2Ipihv3coXhKIT3jGEx939bjBeQgY5z
         Qq8uydqYvXXK89QdaBgK3AJaCowajdwZYMSC9NzBgJTm0xV8EzmCvXR3HiFPQ/nElEW7
         JwuQ==
X-Gm-Message-State: AHQUAuYah1jcT4lxYUZO6iSPqy14on7xUYdmHPz9jgtaA36CNpv4UPOI
        td6XzRA55hUFKoLZyIui+xcvCjAndIesguTHnQSTpg==
X-Google-Smtp-Source: AHgI3IYnBssnQMpoZFspD9aup//Uj4OZ2RjzYsky5xPfFgZPxkG/seDisB/PSsdWgRLf0B8rAqss9R3s025zos8F+VU=
X-Received: by 2002:ac8:2598:: with SMTP id e24mr4360506qte.27.1550168845185;
 Thu, 14 Feb 2019 10:27:25 -0800 (PST)
MIME-Version: 1.0
References: <20190131183109.10919-1-jeffrin@rajagiritech.edu.in> <20190211214002.GV11489@garbanzo.do-not-panic.com>
In-Reply-To: <20190211214002.GV11489@garbanzo.do-not-panic.com>
From:   Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date:   Thu, 14 Feb 2019 23:56:46 +0530
Message-ID: <CAG=yYwkYwiB1dfDJg=VB_Kd1Hu+i-WrFN8SyKT9hKP55WzyA3w@mail.gmail.com>
Subject: Re: [PATCH v2] error message found related
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Your subject is too long.
ok . i have changed it


> Please upgrade bash?
anyway now i have an upgraded one.

here  is a clipping related to the error
---------------------x-------------------x----------------
Thu Feb 14 23:49:13 IST 2019
Running test: kmod_test_0007 - run #4
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
./kmod.sh: line 529: [[: 1 0002:3:1 0003:1:1 0004:1:1 0005:10:1
0006:10:1 0007:5:1 0008:150:1 0009:150:1: syntax error in expression
(error token is "0002:3:1 0003:1:1 0004:1:1 0005:10:1 0006:10:1
0007:5:1 0008:150:1 0009:150:1")
./kmod.sh: line 529: [[: 1 0002:3:1 0003:1:1 0004:1:1 0005:10:1
0006:10:1 0007:5:1 0008:150:1 0009:150:1: syntax error in expression
(error token is "0002:3:1 0003:1:1 0004:1:1 0005:10:1 0006:10:1
0007:5:1 0008:150:1 0009:150:1")
Test completed
$
------------------x---------------------x----------------------




-- 
software engineer
rajagiri school of engineering and technology
