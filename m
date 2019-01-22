Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99284C37122
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F4DD20870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyuPwi0A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfAVCDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 21:03:39 -0500
Received: from mail-qk1-f172.google.com ([209.85.222.172]:32975 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfAVCDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 21:03:38 -0500
Received: by mail-qk1-f172.google.com with SMTP id d15so13503323qkj.0;
        Mon, 21 Jan 2019 18:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=vMXTUdQBC4BXyHNbBMQ0XrGVf60Zpt7KDR3UM3phiVQ=;
        b=UyuPwi0AUrLxQgf5ntCss4N40wjFpfBvd5d58tfaEVPW/5EhOAuvTPTWObIdQrrcdA
         4d4biyHa8OOKQJ+87ca4+Ox+hg09nKLVx/DwkTXzbB0e0Z7CDZjI3vgEci3q5yj8Mabo
         V7otlIAuw/Q9nwwpSqvT2zmqz0If5J7tfKrpFRU3hi1N8toalez8VF+qsMhNaOmWOAag
         EysCEbcFqt20+/r2dk3vJsYHVN4CN2/J5RUKIgdJ9ZFPGM/UJzPUE4mAeCa4Jg9ja5eI
         vCH/FBReCa4GO5K+vF8276lJpzB9ympCnxr+N3Ncd6z6aipKEyUSeRpzq8AQUgRmTxZT
         mn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=vMXTUdQBC4BXyHNbBMQ0XrGVf60Zpt7KDR3UM3phiVQ=;
        b=t2JnzxjpWccLdo+HtVNbv3Sw7FVMI93HypIbgCGXxNjjDudCsZdYtijudI2RusqMYR
         5DekTHZc54crzVKBeiWq+UXtAsG6vnXCYTojtizBNeSwFmgGgfI+yJr9mHo4arXMrh0G
         iqeV8tS0qaCSeN2o1zHoWWhqWbuxiYq+i2I0KrWydoxPrvx8PujShDAzNo7oBo6cTZIB
         4Rg2krqPXHGz9HQZ09Up75jBiqp9JgQvKyt92zMVOEm5EXaObNmSBquHM6Ep4cZez3Iz
         OR+yGNOkJBEWCzpVzNOg65qZ83+kYENBJ+wSDU1ImYmGJb5F/K7uaiXbuQAe6Pe0GeGL
         dqWA==
X-Gm-Message-State: AJcUukd78pVJGkHLODqc85qUui+Odr7tZhRLVpLnxbe+qntOhbqR+omo
        qFJJwxD6Jg63NSVm+X7Gh2v92V1I
X-Google-Smtp-Source: ALg8bN7/J2zeknIwaV+Y0fGeP03hxmMcpQXkLjDmyaMogm0XkxMvyWAlmKRrCpHiOGrFUb9lbtf4uQ==
X-Received: by 2002:a37:ae41:: with SMTP id x62mr25276869qke.354.1548122617166;
        Mon, 21 Jan 2019 18:03:37 -0800 (PST)
Received: from eaf ([190.19.101.95])
        by smtp.gmail.com with ESMTPSA id p47sm85267069qta.36.2019.01.21.18.03.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 18:03:36 -0800 (PST)
Date:   Mon, 21 Jan 2019 23:03:26 -0300
From:   Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-apfs@googlegroups.com
Subject: [ANNOUNCE] Read-only APFS module
Message-ID: <20190122020326.3dyswrfo64zbbk5k@eaf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

We've been working on a read-only module for the Apple File System.  It's
reasonably full-featured (no compression or encryption yet) but not very
well tested, so I'm hoping to find some interested users.  Questions and
criticism are welcome.

Git tree:	https://github.com/eafer/linux-apfs.git
Mailing list:	linux-apfs@googlegroups.com
Patchwork:	https://patchwork.kernel.org/project/linux-apfs/list
