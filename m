Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A77FC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 08:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D808C20820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 08:41:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D808C20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408670AbeKWTYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 14:24:30 -0500
Received: from mx2.cyber.ee ([193.40.6.72]:54128 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393741AbeKWTYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 14:24:30 -0500
Subject: Re: NO_BOOTMEM breaks alpha pc164
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-alpha@vger.kernel.org
References: <8c8e3dba-7adf-96c6-195c-311050256743@linux.ee>
 <20181123071448.GE5704@rapoport-lnx>
From:   Meelis Roos <mroos@linux.ee>
Message-ID: <3af253ac-a884-c76a-2ed6-789203fb4be3@linux.ee>
Date:   Fri, 23 Nov 2018 10:41:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181123071448.GE5704@rapoport-lnx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: et-EE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There was actually more this time, after 27s:

[   35.310528] watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [swapper:0]
[   35.310528] Modules linked in:
[   35.310528] CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-06942-g6471f52af786 #114
[   35.310528] pc = [<fffffc000085ee10>]  ra = [<fffffc000085eda4>]  ps = 0000    Not tainted
[   35.310528] pc is at _etext+0xb0/0x360
[   35.310528] ra is at _etext+0x44/0x360
[   35.310528] v0 = 0000000000000007  t0 = fffffc0000a776c8  t1 = fffffc0000aa5448
[   35.310528] t2 = 000000000000000a  t3 = 0000000000200102  t4 = fffffc0000a75270
[   35.310528] t5 = 00000000fffb721e  t6 = 0000000000003503  t7 = fffffc0000a48000
[   35.310528] a0 = 0000000000000000  a1 = 0000000000000001  a2 = 0000000000000000
[   35.310528] a3 = fffffc0000a590b8  a4 = 0000000000000000  a5 = fffffc00005bd6e0
[   35.310528] t8 = 0000000000000000  t9 = 00006dc5acff0000  t10= 00000000d40d303b
[   35.310528] t11= 0003ba1a0002641d  pv = fffffc000036e070  at = 0000000000000000
[   35.310528] gp = fffffc0000a976c8  sp = 00000000af7577de
[   62.227507] watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [swapper:0]
[   62.227507] Modules linked in:
[   62.227507] CPU: 0 PID: 0 Comm: swapper Tainted: G             L    4.19.0-06942-g6471f52af786 #114
[   62.227507] pc = [<fffffc000085ee10>]  ra = [<fffffc000085eda4>]  ps = 0000    Tainted: G             L
[   62.227507] pc is at _etext+0xb0/0x360
[   62.227507] ra is at _etext+0x44/0x360
[   62.227507] v0 = 0000000000000007  t0 = fffffc0000a776c8  t1 = fffffc0000aa5448
[   62.227507] t2 = 000000000000000a  t3 = 0000000000200102  t4 = fffffc0000a75270
[   62.227507] t5 = 00000000fffb721e  t6 = 0000000000003503  t7 = fffffc0000a48000
[   62.227507] a0 = 0000000000000000  a1 = 0000000000000001  a2 = 0000000000000000
[   62.227507] a3 = fffffc0000a590b8  a4 = 0000000000000000  a5 = fffffc00005bd6e0
[   62.227507] t8 = 0000000000000000  t9 = 00006dc5acff0000  t10= 00000000d40d303b
[   62.227507] t11= 0003ba1a0002641d  pv = fffffc000036e070  at = 0000000000000000
[   62.227507] gp = fffffc0000a976c8  sp = 00000000af7577de
[   89.111282] watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [swapper:0]
[   89.111282] Modules linked in:
[   89.111282] CPU: 0 PID: 0 Comm: swapper Tainted: G             L    4.19.0-06942-g6471f52af786 #114
[   89.111282] pc = [<fffffc000085ee10>]  ra = [<fffffc000085eda4>]  ps = 0000    Tainted: G             L
[   89.111282] pc is at _etext+0xb0/0x360
[   89.111282] ra is at _etext+0x44/0x360
[   89.111282] v0 = 0000000000000007  t0 = fffffc0000a776c8  t1 = fffffc0000aa5448
[   89.111282] t2 = 000000000000000a  t3 = 0000000000200102  t4 = fffffc0000a75270
[   89.111282] t5 = 00000000fffb721e  t6 = 0000000000003503  t7 = fffffc0000a48000
[   89.111282] a0 = 0000000000000000  a1 = 0000000000000001  a2 = 0000000000000000
[   89.111282] a3 = fffffc0000a590b8  a4 = 0000000000000000  a5 = fffffc00005bd6e0
[   89.111282] t8 = 0000000000000000  t9 = 00006dc5acff0000  t10= 00000000d40d303b
[   89.111282] t11= 0003ba1a0002641d  pv = fffffc000036e070  at = 0000000000000000
[   89.111282] gp = fffffc0000a976c8  sp = 00000000af7577de

and so on, repeating itself.

-- 
Meelis Roos <mroos@linux.ee>
