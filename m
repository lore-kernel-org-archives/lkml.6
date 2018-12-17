Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC38C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 236722146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="WExSAj2f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732945AbeLQROD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:14:03 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45082 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbeLQROD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 12:14:03 -0500
Received: by mail-qt1-f194.google.com with SMTP id e5so14874803qtr.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 09:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2ILbHKpZz/Vfxxba49MQaUviJO+oVjIR/iaCOroSFRE=;
        b=WExSAj2fWNIb50lovFGdzbiHglNPHpTw7L7SfUU8lcSRy2jNzaJwF1lsy90ZWkEQC8
         Ucjlx1yI+gxS2JcqR4uSQa8E4pC3JDC6ZP214K0vfBwno9iGbbWmc3iAot+tyiZh2ia2
         txBvkt2jDMxbuTZxGCFeKl4+bkcKSgDxn/dxLJoPX0zhqYBl4jC/pgDzMiR9aASagUgc
         8IOdKrQzErcDIyz7KDhsvVlwGq3h1RnrxLTY+KIBL13yZNYbI+l9gw51qpMJFMAXGCV4
         pPt5ZYX3cougxhp2pKTEMs64TG8kjrpIxOPgKamZlWw4e9KYlvTKBTsu5vMps6O9X4fX
         t7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ILbHKpZz/Vfxxba49MQaUviJO+oVjIR/iaCOroSFRE=;
        b=aZd7n2YKtjwNywE7YWSl5U+9H0KWk9V+A6Elaetlrfr3zJvFKVjdAz0ooY8nB76361
         yA1yjC7KnilcLxGKoF7QBrGKyb8f02POcmr4uSIQbXFtDzP94CHE9rWszHCiuVBmvesn
         mBHFUXsx49gcPOE33OuAWhuXaulgMcir7l2/ZNJzjrKgbuCQM1Jof5ZxWpIfuj0qNcAF
         rz9Ey8CWyeYcmM81fVEuFOcUwWojkyCULYq3d7wlcPXnov3ENRgeQWv9HErwFpu3RDzH
         x8qmaBax6Z4p3uhUpRQc3gUhKQNUZit5EcsRHAPpkfyE02SFEeGB8qD83i6uGNsSSHlx
         KYgQ==
X-Gm-Message-State: AA+aEWZsYIWxgaF7gEgXkrzhw+IoCRXzz44qJqh5eguM+uu6Yn1Vucyd
        4+ziz3rR/xt2cf84wLP6kcdlHw==
X-Google-Smtp-Source: AFSGD/V99XxA94G0umbBkD1xgsw5zqf5t0C5vdJ8GW9t0+C8206dcKevBvi9S9jcd2zn3XPKYjaSZQ==
X-Received: by 2002:ac8:2353:: with SMTP id b19mr13973026qtb.187.1545066841798;
        Mon, 17 Dec 2018 09:14:01 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id k6sm11313139qkk.60.2018.12.17.09.14.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 09:14:01 -0800 (PST)
Message-ID: <1545066839.18411.17.camel@lca.pw>
Subject: Re: [PATCH] kbuild: error for CONFIG_ORC_UNWINDER is too much
From:   Qian Cai <cai@lca.pw>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        mingo@kernel.org, bp@alien8.de, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Date:   Mon, 17 Dec 2018 12:13:59 -0500
In-Reply-To: <20181217170305.chni6e5vmev7hp4r@treble>
References: <869bc700-1d6d-b950-76c7-5d0fc589152c@lca.pw>
         <20181217161728.6875-1-cai@lca.pw> <20181217170305.chni6e5vmev7hp4r@treble>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-17 at 11:03 -0600, Josh Poimboeuf wrote:
> On Mon, Dec 17, 2018 at 11:17:28AM -0500, Qian Cai wrote:
> > Since ifdef will be evaluated immediately in the first phrase of the
> > Makefile read-in, there is no guarantee that the value for
> > CONFIG_ORC_UNWINDER will be up-to-date until in the second phrase that
> > this recipe is ran.
> > 
> > include/config/%.conf: $(KCONFIG_CONFIG) include/config/auto.conf.cmd
> > 	$(Q)$(MAKE) -f $(srctree)/Makefile syncconfig
> > 
> > Hence, change error to warning as this is essentially a best guess. The
> > original bug can be reproduced this way,
> 
> But this still doesn't fix the root of the problem, that the check
> relies on a stale auto.conf.
> 

Yes, but it at least let people to be able to continue compiling kernel without
prematurely being terminated incorrectly. The good thing is that that check will
be triggered again to print out the right message once auto.conf has been synced
up.

# make
Makefile:966: "Cannot generate ORC metadata for CONFIG_UNWINDER_ORC=y, please
install libelf-dev, libelf-devel or elfutils-libelf-devel"
  HOSTCC  scripts/kconfig/conf.o
  HOSTLD  scripts/kconfig/conf
scripts/kconfig/conf  --syncconfig Kconfig
Makefile:968: "Cannot use CONFIG_STACK_VALIDATION=y, please install libelf-dev,
libelf-devel or elfutils-libelf-devel"
