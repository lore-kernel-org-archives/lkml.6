Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36428C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22A52147C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zv7yuVmV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F22A52147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbeJFAA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 20:00:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45542 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729340AbeJFAA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 20:00:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id q5-v6so14246279wrw.12;
        Fri, 05 Oct 2018 10:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version;
        bh=nLBTRPT7U0mTbbndU1Y3gTLw1WDjXpU6IRvYSfHj1bw=;
        b=Zv7yuVmVzF7ui5YJuU9HGiuedXcFqFt8TnW51hUqdznbbQUC/yvVQAJyxnMrSGqnxw
         vv1384WQcxcAvv1XwtDmdnFx+YISU6TNB6DkE/pnn1VIoIXAqta1JzilqeFgIeN598a/
         V4ketf4JEEqrs9RHOUbsK/lWsju5qrPBJy5Fb+cLERr5yzyAIb8tK601n1mnLQNhbWKb
         JvgaeDp6Y6InN/RfgAYIv/c/VepYbhpwHTMfMwOdFXSbVFnJdUnXunLK18riEz+mLeYu
         8nLCoN0Q6Xz9Sk3n5VpWlrNHSbExf8iPmOh1ao8ckSL6fcCGJCkfZFKOL5vY+085eEOX
         RPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :user-agent:mime-version;
        bh=nLBTRPT7U0mTbbndU1Y3gTLw1WDjXpU6IRvYSfHj1bw=;
        b=nCbnDRkvGP+PnAdy563x9nsCt2YSdp91Z1Po9Om4cTlezccZBtfpS/zAEOhDKAXURY
         27QGrIU+2VL9oCsBhx/rpmUyq0sp4VkygELq0xNZcc1rnoFTc4pLgCVaR0JQXpRs4TiL
         A8FHAMzoqZlwqT8BrjXSNmBiDZ/Z2l9fsD1WxEBpiS6eK5Izj7gh4Jddl3Hlx2dtagUK
         cyv455rMJmyK4P0ZD/a5nG2vd4PFPjU/3rRfXjM2YBgnA5WC3dwjVc4Sk72iVTGL/CSs
         oHva/i92tt99JmnPF8G28IkTh8qkJodVqiF6vaY73KQp1/RwjF2pR3hRvoui9JRbvro7
         Bx3Q==
X-Gm-Message-State: ABuFfoh6/vS14qHGZhd9WvzyneCNZe0EijiYeUu+x+VMP/igx17by/yo
        oPogDjDl0WKfj5L7cd70oVq4ulMFgVg=
X-Google-Smtp-Source: ACcGV62oRG7/0K4jPkmTqm5XIEArKzxZz4BRXTC3RJBQXjqJWdXlXQtN5vLjdKSolP+/I8pEmV2cig==
X-Received: by 2002:adf:bb02:: with SMTP id r2-v6mr8897957wrg.24.1538758879911;
        Fri, 05 Oct 2018 10:01:19 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p9-v6sm7592119wrt.10.2018.10.05.10.01.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 10:01:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: [Announce] Git 2.14.5, 2.15.3, 2.16.5, 2.17.2, 2.18.1, and 2.19.1
Date:   Fri, 05 Oct 2018 10:01:18 -0700
Message-ID: <xmqqy3bcuy3l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These releases fix a security flaw (CVE-2018-17456), which allowed an
attacker to execute arbitrary code by crafting a malicious .gitmodules
file in a project cloned with --recurse-submodules.

When running "git clone --recurse-submodules", Git parses the supplied
.gitmodules file for a URL field and blindly passes it as an argument
to a "git clone" subprocess.  If the URL field is set to a string that
begins with a dash, this "git clone" subprocess interprets the URL as
an option.  This can lead to executing an arbitrary script shipped in
the superproject as the user who ran "git clone".

In addition to fixing the security issue for the user running "clone",
the 2.17.2, 2.18.1 and 2.19.1 releases have an "fsck" check which can
be used to detect such malicious repository content when fetching or
accepting a push. See "transfer.fsckObjects" in git-config(1).

Credit for finding and fixing this vulnerability goes to joernchen
and Jeff King, respectively.

P.S. Folks at Microsoft tried to follow the known exploit recipe on
Git for Windows (but not Cygwin or other Git implementations on
Windows) and found that the recipe (or its variants they can think
of) would not make their system vulnerable.  This is due to the fact
that the type of submodule path require by the known exploit recipe
cannot be created on Windows.  Nonetheless, it is possible we have
missed some exploitation path and users are encouraged to upgrade.
