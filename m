Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AF6ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9193620661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:08:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9193620661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731390AbeGTN4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:56:14 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:35212 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731109AbeGTN4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:56:14 -0400
Received: by mail-io0-f198.google.com with SMTP id y4-v6so2380179iol.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 06:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=H5/HsSzPj1N1lI5mmq+NAHsjyo20tDq+h3cwTzuHkRs=;
        b=IPosEL+KKXGv182kLF3eXk3AZxNw7sKFc9jwnm6PFnpLjg9fqePtV2X5s1z4A9LY7y
         gw0gNy9+688+zFBXNVQorJtj/Ou6BwfwXx/PH+Crd+c3fbmsG6dEFGI/M5we+W4agsBj
         K0kjd+BbZ72BTExO222ncgYdrMe5kF0G9Bn63ZKLYOT3uolQyZ66S0eEL4OIlVvmfhlF
         PFgTgJmeQgDm2olYaRkN1uV9NcLCSacbV5+J2ejkO7FcPzYEgWJsiTyK3tfj0lfxW2ij
         VsOuR9ZhIjIwhHp6zRIC16XkEGokuRq2lZQVMjmREmHcu/x19SYZ8slw+xm6Jv03Trwu
         zj0w==
X-Gm-Message-State: AOUpUlGuE3Uz6uPCjC1J6cV86zRBSaM4MOncIPXqX7InvEIbb7us43w5
        5oOJpF6S7aNXscwZgfBr/GaqqtwMb5yQ04mxb1hS1yzRkhx5
X-Google-Smtp-Source: AAOMgpfsAvG19+98cev5whjk9Fv1s4iYdhG8kmL7AzvAYEZ2BjfyfBMbcGYj+RSUgfCZj7j7lGMLlXWLFV+UFmOC7jlyPY7CMbPW
MIME-Version: 1.0
X-Received: by 2002:a24:5a14:: with SMTP id v20-v6mr928186ita.41.1532092081966;
 Fri, 20 Jul 2018 06:08:01 -0700 (PDT)
Date:   Fri, 20 Jul 2018 06:08:01 -0700
In-Reply-To: <20180720121426.110184758@linuxfoundation.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004f13b305716dfc98@google.com>
Subject: Re: KMSAN: uninit-value in af_alg_free_areq_sgls
From:   syzbot <syzbot+9c251bdd09f83b92ba95@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, smueller@chronox.de,
        stable@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+9c251bdd09f83b92ba95@syzkaller.appspotmail.com

Tested on:

commit:         cf8cd3cd03e2 kmsan: fix CONFIG_KMSAN=n build
git tree:       https://github.com/google/kmsan.git/master
kernel config:  https://syzkaller.appspot.com/x/.config?x=c21487206316bcc3
compiler:       clang version 7.0.0 (trunk 334104)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15fec658400000

Note: testing is done by a robot and is best-effort only.
