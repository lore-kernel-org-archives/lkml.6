Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0967AC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B87A9223A9
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B87A9223A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbeHJL6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 07:58:48 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:20397 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbeHJL6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 07:58:47 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41n0Fb5W2Yz9tvpv;
        Fri, 10 Aug 2018 11:29:39 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Kul64H3IAP40; Fri, 10 Aug 2018 11:29:39 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41n0Fb4ry1z9tvpt;
        Fri, 10 Aug 2018 11:29:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B98818B87A;
        Fri, 10 Aug 2018 11:29:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id dH_6O9jZURsw; Fri, 10 Aug 2018 11:29:43 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.4])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 27A398B872;
        Fri, 10 Aug 2018 11:29:43 +0200 (CEST)
Subject: Re: [PATCH v4 5/6] powerpc: Add show_user_instructions()
To:     Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org,
        Alastair D'Silva <alastair@d-silva.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Cyril Bur <cyrilbur@gmail.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Joe Perches <joe@perches.com>,
        Michael Neuling <mikey@neuling.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Simon Guo <wei.guo.simon@gmail.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        "Tobin C . Harding" <me@tobin.cc>, linuxppc-dev@lists.ozlabs.org,
        Segher Boessenkool <segher@kernel.crashing.org>
References: <20180801213320.11203-1-muriloo@linux.ibm.com>
 <20180801213320.11203-6-muriloo@linux.ibm.com>
 <7209fa95-8d40-14ca-f27a-ce3edb64191e@c-s.fr>
 <20180803004201.GA5891@kermit-br-ibm-com>
 <69cf990b-d4aa-97e7-be3b-7936caa91688@c-s.fr>
 <87pnyzhm9l.fsf@concordia.ellerman.id.au>
 <20180803113141.GA5476@kermit-br-ibm-com>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <1cfa56a3-027d-cf2c-3150-12aa45a35bd9@c-s.fr>
Date:   Fri, 10 Aug 2018 11:29:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180803113141.GA5476@kermit-br-ibm-com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 03/08/2018 à 13:31, Murilo Opsfelder Araujo a écrit :
> Hi, everyone.
> 
> I'd like to thank you all that contributed to refining and making this
> series better.  I did appreciate.
> 
> Thank you!

You are welcome.

It seems that nested segfaults don't print very well. The code line is 
split in two, le second half being alone on one line. Any way to avoid 
that ?

[    4.365317] init[1]: segfault (11) at 0 nip 0 lr 0 code 1
[    4.370452] init[1]: code: XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
[    4.372042] init[74]: segfault (11) at 10a74 nip 1000c198 lr 100078c8 
code 1 in sh[10000000+14000]
[    4.386829] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
[    4.391542] init[1]: code: XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
[    4.400863] init[74]: code: 90010024 bf61000c 91490a7c 3fa01002 
3be00000 7d3e4b78 3bbd0c20 3b600000
[    4.409867] init[74]: code: 3b9d0040 7c7fe02e 2f830000 419e0028 
<89230000> 2f890000 41be001c 4b7f6e79

Christophe

> 
> Cheers
> Murilo
> 
