Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5878DECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D7F21550
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9XDpnjk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0D7F21550
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390529AbeIUVpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 17:45:53 -0400
Received: from mail-it1-f171.google.com ([209.85.166.171]:38562 "EHLO
        mail-it1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388909AbeIUVpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 17:45:53 -0400
Received: by mail-it1-f171.google.com with SMTP id p129-v6so2400826ite.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 08:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Dq+kH7/SBYemj/NZlgBSMkoqmF654/WNfntgJrxJ7hM=;
        b=F9XDpnjkM9VFXUnmCvGzSPavpxXOv6rTfwm8w968nHR6Xg+7Q+UG0sAvbFY/uqNHQp
         ceI/V3imxh0ckvGR7CEWHCQGV8iTuGOlXoHy+6PYbLF37Eu03er6fbPNh44moYv1y9m4
         rrFMuIymKBaoeml065sA/sZ2liOFwyKN3ShRF/8+CGrDRDfnEwf0srvYdJ9JqigkC1je
         Qz8qoRhIBfTvAoqnU1XhZgcyqc1gdMzbX5oSP4Iw1KHDphSjab5kKKIcl+bLV4JCAIwM
         ExY7BPiMXnZDBafdjyCc/bShE6F/2N2S1m9xx6ayVNdr722QG7d8c90S5hchJU/roOsG
         BxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Dq+kH7/SBYemj/NZlgBSMkoqmF654/WNfntgJrxJ7hM=;
        b=EEZ/v6d8ErU+LOmS9C2+y3mUMwIBPUX+JqF4/oTzL0dvst4IB4qVfhyX3d5ZyVJL4g
         dv/5EbBnec2UkVLRm4f6H+4QUw785Z/EeqBE/cYuLEB27qkgiPBSTAIIf6ZrzKxfDhiB
         evUgWB6++9Xz/Id7NKb83jWXyQyTRje406gF9vDVil9MB2sdEzAzyZeWX2UX+JKSWiyc
         /fnbHNMTvnyYasvCvJaok0bUH7eUwS8j9Rfu5CHnldbn2apBHdypwNPf3rsc6yoj/E21
         l65lgtLRxOEW9BGxWF1BkoEd1P3J6aZr52jHddYqVySWM+vWEL/0W3ZjMuD3RpylB73p
         jlkw==
X-Gm-Message-State: APzg51D+/wGMZGMamJNzOtCRg1PxXtxwARLvJ9V/ORaVQIOve/9WeFUm
        D1XE52CDeSPgubGsp617jhCNEUGU7FLo48Lcl6l/vq9B
X-Google-Smtp-Source: ANB0VdYar1+sh8HMe38lpGfSdwN0l4q3ohp/ftfvDIFO81Y7KUFmXm6I6ygK12x5hLw7jwokPcBqpP9iWZnxJvexI34=
X-Received: by 2002:a24:c48a:: with SMTP id v132-v6mr6766332itf.72.1537545382959;
 Fri, 21 Sep 2018 08:56:22 -0700 (PDT)
MIME-Version: 1.0
From:   John Lumby <jylumby@gmail.com>
Date:   Fri, 21 Sep 2018 11:56:12 -0400
Message-ID: <CAN55p+JXBO0OO_zbn9V-OnSKMQWhJDQb98yuVPC3XZD3kjo3rg@mail.gmail.com>
Subject: BUG - (suspected) - ORC unwinder with elfutils-0.174 causes ld
 failure during make
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.config has CONFIG_UNWINDER_ORC=y

elfutils version 0.174  (latest)

make of the kernel source fails with errors such as this
arch/x86/kvm/../../../virt/kvm/kvm_main.o: file not recognized: file
format not recognized
emitted by ld

ld is from latest binutils version 2.31
gcc is version 7.3

Found in kernel kver 4.17.10 and also in latest 4.19-rc4

problem is caused by this transformation directed from the Makefile

        ./tools/objtool/objtool orc generate  --module --no-fp
--retpoline "arch/x86/kvm/../../../virt/kvm/kvm_main.o";

make succeeds when CONFIG_UNWINDER_ORC is not set

Cheers,  John Lumby
