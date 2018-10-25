Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA05C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4512083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="UQvFa6o8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB4512083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbeJZFLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 01:11:08 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34895 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbeJZFLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 01:11:08 -0400
Received: by mail-lf1-f66.google.com with SMTP id d7-v6so7859435lfi.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 13:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qwqH7ghNRicmHmNn8jgoDXxPtuAHgcO+Zu5ALu+7dIc=;
        b=UQvFa6o8oFPjOEiJSKFKSTdILmiF+kjVao6/040Fpqp79qCxtTkkDV2CxL75qegIlH
         eP9kU1GGu9nX/Oi8oow3/iHcQdWWYuoxgqxv0PUZM26QjV9Yj7CRPftujB3VM5WaESIs
         VjA2Z4aq/QpFu9892sE3wcKMpptnvx+JftvBrJnXbC7W5/L6LdFWB/HqRasPsFhE+UW3
         hyB9CANtd22SZhR6kNShl+bel4AidQ2VK2PXfl4immH37h+apFy2lKItsKyYznIjcfJz
         QQ/0wbxYKzyJDd3N3lRJwObNpPHZeN0eLfRSrd3WJ5NRkrKcAY49QkCH5lXxlw/R247k
         TBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qwqH7ghNRicmHmNn8jgoDXxPtuAHgcO+Zu5ALu+7dIc=;
        b=abzXSjFJITZ/TvjL5Wcz8MJ4e/c/DkOErvUV6wWmZZfvo4aNTWfu6aMv3MsAojCkI7
         qIK5sZxZ7fJf77pAm56nub95gJkchbrz37BWDnoqb2khsMWwxktelY8Twf6g511S54CN
         66+PesUsBUGvoYDiUsQLTb+Zb7HWr1jQ2H3eqxRmHIFjRyXnS3tuGxT5NWkoNXIjjnni
         RCpNDFxFgZcX+NWSp78iNau66Z7CK37VbQNFT+fx/Men/uBBlbVc6x8sNwd+PAzWd2Yc
         xZsq5uYpA0dZGIkCOHxdZYCdW+mK8fDLkbd6GJ/wLnJ68daJ+P95UvqUqBwU3NpOkY7H
         5XDA==
X-Gm-Message-State: AGRZ1gKO+XniO6gN/Nu6iUOtQkBB/4OAB9gWU5DzKGfwdSyLU36GAXJJ
        ce5CursiiTB9v1bD8bsRKctdUsS9V5tpV37AjNDT
X-Google-Smtp-Source: AJdET5f7fV+cRqfoVPAH4NhWEqidjIT/QQeQo1vp6GspyypWfF9p3/32tTdiffFsP8U8rURqmSphRQcGZHT+Ot++HAE=
X-Received: by 2002:a19:e601:: with SMTP id d1mr455742lfh.71.1540499812266;
 Thu, 25 Oct 2018 13:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAEn-LTqbEmWovu4t7Rs4C211+GRRU4V3B=+WmW0SOhX_b8db5Q@mail.gmail.com>
 <20181024204036.8799-1-palmer@sifive.com> <20181024204036.8799-3-palmer@sifive.com>
 <CAEn-LTovzRncSKCGv8wUTL6FkzcC+Hw1EBGe+Rc4GQyEgcK1uA@mail.gmail.com>
In-Reply-To: <CAEn-LTovzRncSKCGv8wUTL6FkzcC+Hw1EBGe+Rc4GQyEgcK1uA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 25 Oct 2018 16:36:41 -0400
Message-ID: <CAHC9VhT015tz4qZZ=vM6FowsUXLv-RYeBrH4C8d6jvg=XHumHA@mail.gmail.com>
Subject: Re: [PATCH 2/2] RISC-V: Add support for SECCOMP
To:     david.abdurachmanov@gmail.com
Cc:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        aou@eecs.berkeley.edu, Eric Paris <eparis@redhat.com>,
        keescook@chromium.org, luto@amacapital.net, wad@chromium.org,
        wesley@sifive.com, dhowells@redhat.com, tglx@linutronix.de,
        pombredanne@nexb.com, gregkh@linuxfoundation.org,
        kstewart@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 2:31 PM David Abdurachmanov
<david.abdurachmanov@gmail.com> wrote:
> On Wed, Oct 24, 2018 at 10:40 PM Palmer Dabbelt <palmer@sifive.com> wrote:
> > From: "Wesley W. Terpstra" <wesley@sifive.com>

...

> Palmer,
>
> Half of the patch seems to touch audit parts. I started working on audit
> support this morning, and I can boot Fedora with audit traces.
>
> [root@fedora-riscv ~]# dmesg | grep audit
> [    0.312000] audit: initializing netlink subsys (disabled)
> [    0.316000] audit: type=2000 audit(0.316:1): state=initialized
> audit_enabled=0 res=1
> [    7.288000] audit: type=1130 audit(1529665913.772:2): pid=1 uid=0
> auid=4294967295 ses=4294967295 msg='unit=systemd-remount-fs
> comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=?
> terminal=? res=success'
> [    7.684000] audit: type=1130 audit(1529665914.176:3): pid=1 uid=0
> auid=4294967295 ses=4294967295 msg='unit=systemd-sysctl comm="systemd"
> exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
> res=success'
> [..]
>
> I am still working on audit user-space support for better testing.
>
> I suggest we first implement audit and then seccomp.

FYI, while small and far from comprehensive, we do have a test suite
we use for basic validation of the audit kernel bits which may be
helpful while you're working on the audit enablement:

* https://github.com/linux-audit/audit-testsuite

-- 
paul moore
www.paul-moore.com
