Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAC5C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 01:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FD9520823
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 01:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbIjxpZw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FD9520823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbeKAK1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 06:27:44 -0400
Received: from mail-vk1-f182.google.com ([209.85.221.182]:36765 "EHLO
        mail-vk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbeKAK1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 06:27:44 -0400
Received: by mail-vk1-f182.google.com with SMTP id u62so1736163vkb.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 18:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=RvU6Umy07xEJzL+yr5xbrNcH0pkdEEs1SkkHEhcpGXk=;
        b=TbIjxpZwnn4xrrsnCY6R7/8h7Oujw+RinEUj8fkn0VKGzWZZC3DcmSq5okBG1yon1G
         s83gC7rstQo4WdOpIG14C+e2jU+58Y1txzpWOfQBy0L5nKPXGxqIXc2mjuSn9uAz8iuc
         5BwnlHHUOUSDGZr0rDVF70CD8MIbTOULm79ik5u3BtEHKucdKpCGFJ9TUaESDbiotaoK
         0Xd/aDSz7PXr4MaWq/2/0wCXwI3zJSLsoFWNRQwcY7ta0qcPnZpIloqRii1C2MiVTkuj
         DAWN9DPr9F7FE/jxKzBkcm2HrTVMlccwdo0B/ubOxLn5W4sAFQlvQGXjZetJ2RDgKHe3
         zZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=RvU6Umy07xEJzL+yr5xbrNcH0pkdEEs1SkkHEhcpGXk=;
        b=bFBeqPUO1IYqdI33yMXjBgGt44GxA+Kd0Ptx7BaxeM1dH1EWfoqDnpsiSDsjhq34Ft
         vzzYiwR51LH5f0VMzzWHTIWgYRWesdDgwozRO/8tXnNaRFhG+9q9quTpRUPuleAdm7ba
         kixAy22Jfxc8dl0riVp/j4vGqowQz22zmj5chW8qJuFm+UqvqTe067JPU9sypg+M+UEC
         wOplvnV5US/RWrn19MQiC9m6sUZnzWS1ay5/CZHMpMLeaAc6abAK42mpG3ob38OnbV9q
         bBIWoz5sFVH+fSp2SSiBB5q9CkusSrmkgHm75u/2vsS8TnB1VEHjdc1hNHjN5uV5cH/r
         0P3A==
X-Gm-Message-State: AGRZ1gL4k4mQGYlySgjAwOuWb4RME6477xyV6dLgPPQh+JO0n233FhUv
        zEZWW9LvKPBmWnwEp6L4bYfSWonVx2FUPrp+F5FBKT+dwJk=
X-Google-Smtp-Source: AJdET5de8qtFGXfX1bd1ox8v4tYE1W69E1dkYXcDGt21OUmi/yIvnUSAYIqU7z6wpgIboDDZkoDCPy5ptuOEEpUk7Xc=
X-Received: by 2002:a1f:a014:: with SMTP id j20mr2326501vke.64.1541035618730;
 Wed, 31 Oct 2018 18:26:58 -0700 (PDT)
MIME-Version: 1.0
From:   cerberus cerberus <aktiophi@gmail.com>
Date:   Wed, 31 Oct 2018 19:26:47 -0600
Message-ID: <CAC_DqTA-5tMfRKV42EAUYiewTOAZMDjLpsNGrKeMKLOgGQ77zg@mail.gmail.com>
Subject: Randomize address space after each fork
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randomize address space after each fork
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I might be entirely wrong with what I write
and the solution proposed thereafter, yet I
want to raise awareness that with current linux
kernels it is possible to leak (at least) heap
addresses in an attempt to weaken address space
layout randomization. The listed example shows [1]
code, it completely identifies three bytes of
the heap memory mappings, that is enough to weaken
aslr in a way to make it unusable over time.

One idea is to disallow a process to use the
same addresses after a fork and randomize them
after each fork just as during execution stage,
this will render the attack unusable. I know
this sounds nuts but is most probably the most
straightforward way to fix the issue.

real mapping:
55b118238000-55b11827b000 rw-p  [heap]


linux kernel leaking the addresses partial:

Discover first byte in offset

Try Offsets 10ffff to ffffff ...

Try Offsets 20ffff to ffffff ...

Offset 239000 Survived ...

Offset 24d000 Survived ...

Offset 251000 Survived ...

Offset 261000 Survived ...

Offset 27d000 Survived ...

Offset 281000 Survived ...

That's quite exact the heap start to end address.


My apologies for suggesting only the solution,
I'm too stupid to implement this in real life in,
i.e. linux itself :)


[1] testcase: https://www.exploit-db.com/exploits/45671/
(referring to version 4.4.0-116, x86_64)

Have a nice day!
