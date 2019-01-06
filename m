Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950C9C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 19:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 655D820859
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 19:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbfAFTOS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 14:14:18 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50586 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfAFTOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 14:14:18 -0500
Received: from mail-pl1-f199.google.com ([209.85.214.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1ggDsF-0003wO-IE
        for linux-kernel@vger.kernel.org; Sun, 06 Jan 2019 19:14:15 +0000
Received: by mail-pl1-f199.google.com with SMTP id 12so30354808plb.18
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 11:14:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0ivRVsY/+DJHm8bCFkUQInv0DeBpj/yazrThNw/uVbA=;
        b=lbdpU8IqLR9uj5LzsTT2DKuSrTsXBqcSwN0tdI4of0TSt9Vh5gK3ltqvjGy/qGcNh7
         dViGwTXrn2hSL+0EJO6X7iFVntCP2P/nt75prqvV7RUTSgzzYE2bp45JzL8AEqS8lLGO
         zQrop8bOKqo6v1JFSytEhT2L5SsN6OxV+E+GrhWjW7riI66buXRTHJxlg/sJ3JA5l9JC
         IkFJKZgB3mkApfpHRcLVwxjQkP2thSgmtpjFAJ6KBj6/PtaRXmlt/HOnOyY86kFsAtPX
         BC4bqWDo2YniSgYHZq0etq9grFfj2lk6RJDtDzbpROQjUDBCTS6QzGB5q6X3LGEDO2y6
         sSnA==
X-Gm-Message-State: AJcUukdDdnrXZmYDJ5/zbcWStNrfeEehI7Qz2z1qhiIDuvjQUIMY+l2n
        Tbnpo7YNrPizvhaFhgd2p2hInFzRHmPctUXnCAPVVvUOZems2pCifsZtBwYIZIkP6SAfe757MG+
        uHpjdg/zYJcMeRKF3u2LQWBN6gH5kJhcHyXX0I1sv+w==
X-Received: by 2002:a63:b24a:: with SMTP id t10mr53903355pgo.223.1546802054192;
        Sun, 06 Jan 2019 11:14:14 -0800 (PST)
X-Google-Smtp-Source: ALg8bN7GiyMpKFn1Z0wfVpARiLf8ZmPrcC8CYJew7046TTjicdRkt0MUjEsdc4OeUuTlIPMnRUUVBQ==
X-Received: by 2002:a63:b24a:: with SMTP id t10mr53903331pgo.223.1546802053711;
        Sun, 06 Jan 2019 11:14:13 -0800 (PST)
Received: from [192.168.1.215] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id k24sm97465306pfj.13.2019.01.06.11.14.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 11:14:13 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: r8152: data corruption in various scenarios
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <469a41ea-e97c-23d2-d129-68aad5585fec@pobox.com>
Date:   Mon, 7 Jan 2019 03:14:09 +0800
Cc:     Ansis Atteka <aatteka@nicira.com>,
        Hayes Wang <hayeswang@realtek.com>,
        David Miller <davem@davemloft.net>,
        "greg@kroah.com" <greg@kroah.com>,
        "romieu@fr.zoreil.com" <romieu@fr.zoreil.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        nic_swsd <nic_swsd@realtek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <3D7273C4-D378-42D5-92FA-4ED72041D820@canonical.com>
References: <ed0c9790-57be-8bca-cdd6-3a54ca24f0bd@pobox.com>
 <20161125095350.GA20653@kroah.com>
 <1816ec7e-2733-f4ba-5d30-29dbabd20aad@pobox.com>
 <20161125.115827.2014848246966159357.davem@davemloft.net>
 <0835B3720019904CB8F7AA43166CEEB201057793@RTITMBSV03.realtek.com.tw>
 <CAA=3Oqn5_5w+vrg9_7UtZ-5BEbZ9Pm=qdX3WoVZKaAkxcMXYXA@mail.gmail.com>
 <469a41ea-e97c-23d2-d129-68aad5585fec@pobox.com>
To:     Mark Lord <mlord@pobox.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 5, 2019, at 10:14 PM, Mark Lord <mlord@pobox.com> wrote:
> 
> A couple of years back, I reported data corruption resulting from
> a change in kernel 3.16 which enabled hardware checksums in the r8152 driver.
> This was happening on an embedded system that was using a r8152 USB dongle.
> 
> At the time, it was very difficult to figure out what could possibly be causing it,
> other than that re-enabling software checksums prevented corrupted packets from
> resulting in more serious issues.
> 
> Since that time, more and more reports of similar corruption and issues
> have been trickling in.  Eg.
> 
>   https://lore.kernel.org/patchwork/patch/873920/
> 
> Note that there are reports in the thread above that the issues
> are not limited to only the built-in ethernet chip of the dock.
> 
> There is even now a special hack in the upstream r8152.c to attempt to detect
> a Dell TB16 dock and disable RX Aggregation in the driver to prevent such issues.
> 
> Well.. I have a WD15 dock, not a TB16, and that same hack also catches my dock
> in its net:
> 
>    [5.794641] usb 4-1.2: Dell TB16 Dock, disable RX aggregation

The serial should be unique according to Dell.

> 
> So one issue is that the code is not correctly identifying the dock,
> and the WD15 is claimed to be immune from the r8152 issues.

The WD15 I tested didn't use that serial number though...

> 
> One of the symptoms of the r8152 issue, reported by Ansis Atteka,
> were messages like this:
> 
>   xhci_hcd 0000:39:00.0: ERROR Transfer event TRB DMA ptr not part of current TD ep_index 13
> comp_code 1

This is probably an xHC bug. A similar issue is fixed by commit 9da5a1092b13
("xhci: Bad Ethernet performance plugged in ASM1042A host”). 

> 
> I just got that exact message above, with the r8152 in my 1-day old WD15 dock,
> with the TB16 "workaround" enabled in Linux kernel 4.20.0.

Is the xHC WD15 connected an ASMedia one?

Kai-Heng

> 
> From this I conclude that the workaround is not 100% complete yet.
> -- 
> Mark Lord
> Real-Time Remedies Inc.
> mlord@pobox.com

