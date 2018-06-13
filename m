Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A6E6DC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED96208D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ED96208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935496AbeFMSeD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 14:34:03 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:55542 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935123AbeFMSeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 14:34:02 -0400
Received: by mail-io0-f197.google.com with SMTP id a10-v6so2799956iod.22
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 11:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=4YPpOzx1880meLg4RGnVQ0irsplxLOZ06FwcGJlfZWA=;
        b=KIS4C0NS/3skOlbF1Qi796w27KTpf8TAOebkPR/b3O2du4aRZq9gdpFG2r6mEdMXxO
         aVPa7NjlibBTl7soHGfBq4agm9g4bNY6V7EIr+MeEQmfvhcoRoOlMtIHPR3hXvkeL+Ec
         x2Uu1JzXYJ4S30eYUBY0wqlWlUqzdWCSbPkNqFaFOTAbx8ra86I1u1CloAuWX+aDDZo8
         +wFJTKDkA76Qps37OnQnDbiu14nz4w+YE1FLkIF1Wf19/FyvZceGYBRrYN+H9f4WSQ6j
         l5fpGXf4s3Dcxr/mqWLW44S56EphqVpdwH5XVffUqElxFxJc10dtyBpd5I5r2aBWgTET
         F3RQ==
X-Gm-Message-State: APt69E2iKRIizc7dmFP9LBurGmO99OQTO2WSq7IIrAwj/y3sUrpmpapO
        nXZAzP3q7goBt33BU+ZfV/QLc6gaMKWHWY7ZgVQXMWsYyC/e
X-Google-Smtp-Source: ADUXVKI243xNJ3AGSRbOOp21XTDmNtGgJA4j87pMs3X/MQa4sX3l4AV6+G2Mdb9MplCNGzx0CbtnH1mn8mplpoNua0tvuKb2xRv2
MIME-Version: 1.0
X-Received: by 2002:a24:6f8d:: with SMTP id x135-v6mr2605410itb.3.1528914841979;
 Wed, 13 Jun 2018 11:34:01 -0700 (PDT)
Date:   Wed, 13 Jun 2018 11:34:01 -0700
In-Reply-To: <b3af0f35-b0f8-859d-4f8f-b919d35ebaaa@iogearbox.net>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000c58c2056e8a3a27@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in bpf_skb_vlan_push
From:   syzbot <syzbot+76de61614cb1abdd73fc@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+76de61614cb1abdd73fc@syzkaller.appspotmail.com

Tested on:

commit:         be779f03d563 Merge tag 'kbuild-v4.18-2' of git://git.kerne..
git tree:        
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/--
kernel config:  https://syzkaller.appspot.com/x/.config?x=68d8eba98e3f8e88
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Note: testing is done by a robot and is best-effort only.
