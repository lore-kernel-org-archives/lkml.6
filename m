Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB43EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B13216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="F4myLj1J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83B13216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cumulusnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbeKLSYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 13:24:22 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34546 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbeKLSYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 13:24:22 -0500
Received: by mail-wr1-f67.google.com with SMTP id j26-v6so8270421wre.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 00:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=date:in-reply-to:references:mime-version:content-transfer-encoding
         :subject:to:from:message-id;
        bh=Mg6Uxk2gYngckWDv9FiWBXoTzbgw2wyHoktT47rLD04=;
        b=F4myLj1Jy6JQ/1HTS0kg0Wr78g5lFuKERT9rzfIi7JhlAMbHxH9KaG2bQuu0B/A3O2
         ndvNwSPjZkXeKrH34zjYhAmT8TVxGFXhgdE3HPHEKmqR3An5iM5OFAYvSs8y6PEAdqPQ
         TsMhK/+8YSRLwqfggNcZ+ecxcVCp4ecy387Do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:from:message-id;
        bh=Mg6Uxk2gYngckWDv9FiWBXoTzbgw2wyHoktT47rLD04=;
        b=NL1jUCHD/XDJYIpDdaxQrCJjLZar0gubV6323e1Vol1smJmnsa1771u31CSP0zCamu
         vvyIHsrW6nGzBrL6FCHH78Z7gm6xMmIkgMJT6zMwNTeLvgt6p0SCD8cIN66qyhjWFTOB
         WmzWSEGnSqf4/1nZc4BBxPoWO+z7G7U6Y+A8dOxGUcznJTUQR5vXK7bJhjmddFnBcwRb
         /xeaAQz5zqKNbS+Vz8/vW5Yg0I7OpjF1oDBSyhNRZwLWTrq7ZA9lM/6NjVWqWPulG6St
         iDRNt3PkMKanrjp58+OcQPGqeYtdH1rN97ksFOYmKcTHZvtDYQwE0Zgl4Xyn/Wa+BgxK
         ZGuw==
X-Gm-Message-State: AGRZ1gKJYxVFRp1xpf0rNQ0OZwS9DvnXNKox8vCJrkhcYiVN+IAAwG7M
        jTFmMXxQHygumTiewcivzXm3k4IH1/6nwQ==
X-Google-Smtp-Source: AJdET5e94XwQAd2+H166kF+XqmewDKJPQRDUj76CcKvApJFirXLFPQ2NGxd5Ele3LeNTa1bLK7GdCQ==
X-Received: by 2002:adf:9245:: with SMTP id 63-v6mr55675wrj.130.1542011532859;
        Mon, 12 Nov 2018 00:32:12 -0800 (PST)
Received: from localhost ([88.128.80.171])
        by smtp.gmail.com with ESMTPSA id w11-v6sm18875313wrr.96.2018.11.12.00.32.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 00:32:12 -0800 (PST)
Date:   Mon, 12 Nov 2018 09:32:08 +0100
In-Reply-To: <00000000000047feb5057a714975@google.com>
References: <00000000000047feb5057a714975@google.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: KASAN: use-after-free Read in nbp_vlan_rcu_free
To:     syzbot <syzbot+04681da557a0e49a52e5@syzkaller.appspotmail.com>,
        bridge@lists.linux-foundation.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        roopa@cumulusnetworks.com, syzkaller-bugs@googlegroups.com
From:   nikolay@cumulusnetworks.com
Message-ID: <C0C76E26-AE73-4D51-B44A-FFC0EF629A83@cumulusnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 November 2018 06:51:02 CET, syzbot <syzbot+04681da557a0e49a52e5@syzka=
ller=2Eappspotmail=2Ecom> wrote:
>Hello,
>
>syzbot found the following crash on:
>
>HEAD commit:    e12e00e388de Merge tag 'kbuild-fixes-v4=2E20' of
>git://git=2Ek=2E=2E
>git tree:       upstream
>console output:
>https://syzkaller=2Eappspot=2Ecom/x/log=2Etxt?x=3D14cdb6f5400000
>kernel config:=20
>https://syzkaller=2Eappspot=2Ecom/x/=2Econfig?x=3D8f215f21f041a0d7
>dashboard link:
>https://syzkaller=2Eappspot=2Ecom/bug?extid=3D04681da557a0e49a52e5
>compiler:       gcc (GCC) 8=2E0=2E1 20180413 (experimental)
>
>Unfortunately, I don't have any reproducer for this crash yet=2E
>
>IMPORTANT: if you fix the bug, please add the following tag to the
>commit:
>Reported-by: syzbot+04681da557a0e49a52e5@syzkaller=2Eappspotmail=2Ecom

Thanks, I'm about to fly out for LPC=2E Will take a look in a day=2E


