Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D47C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F5F20873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:15:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F5F20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micron.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933601AbeGIQPc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:15:32 -0400
Received: from mailout.micron.com ([137.201.242.129]:47805 "EHLO
        mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932806AbeGIQPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:15:30 -0400
X-Greylist: delayed 1226 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Jul 2018 12:15:29 EDT
Received: from mail.micron.com (bowex36d.micron.com [137.201.85.223])
        by mailout.micron.com (8.14.4/8.14.6) with ESMTP id w69FsJrV017377;
        Mon, 9 Jul 2018 09:54:19 -0600
Received: from SIWEX4G.sing.micron.com (10.160.29.139) by bowex36d.micron.com
 (137.201.85.223) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 9 Jul
 2018 09:54:18 -0600
Received: from SIWEX5A.sing.micron.com (10.160.29.59) by
 SIWEX4G.sing.micron.com (10.160.29.139) with Microsoft SMTP Server (TLS) id
 15.0.1347.2; Mon, 9 Jul 2018 23:54:11 +0800
Received: from SIWEX5A.sing.micron.com ([fe80::a9c5:8ccb:fd84:268d]) by
 SIWEX5A.sing.micron.com ([fe80::a9c5:8ccb:fd84:268d%25]) with mapi id
 15.00.1347.000; Mon, 9 Jul 2018 23:54:11 +0800
From:   "Bean Huo (beanhuo)" <beanhuo@micron.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>
Subject: Re: [PATCH v6 0/6] mtd: rawnand: support MT29F1G08ABAFAWP-ITE:F
Thread-Topic: [PATCH v6 0/6] mtd: rawnand: support MT29F1G08ABAFAWP-ITE:F
Thread-Index: AdQXnRLnAy8+kBX/RY20g+cq7ZFQJQ==
Date:   Mon, 9 Jul 2018 15:54:11 +0000
Message-ID: <c27f10f9efc14fed817c1a343d8b67d4@SIWEX5A.sing.micron.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.160.29.124]
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-23956.005
X-TM-AS-Result: No--7.417400-0.000000-31
X-TM-AS-MatchedID: 150567-139010-704096-703747-703788-700756-780012-711331-7
        02016-705102-710970-703376-702807-701604-700624-700942-704980-702020-780011
        -707451-707476-702067-702010-703267-702609-707663-704930-105250-708712-7023
        58-700019-139702-700648-710556-148004-148050-148980-20043-42000-42003-29961
        -63
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
x-mt-checkinternalsenderrule: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 137.201.82.98
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Boris and Chris

>>
>> I see 2 solutions to this problem:
>> 1/ Bean provides us a solution to reliably detect when ECC can be
>>    de-actived and when it can't
>> 2/ We only ever expose 64 bytes of OOB to the user and consider that
>>    ECC can be disabled, even if it can't in reality
>>
>
>After reading the doc again, I forgot one thing you can try before deciding to
>go for option #2.
>
>8th bit in byte 5 of READID's result encodes whether the on-die ECC state
>(enabled or not). I remember we had a discussion with Bean where he told us
>this was a runtime status reflecting the on-die ECC state, which is crazy, since
>READID might return different values depending on the NAND state, and most
>of the code in the core assumes READID provides a fixed ID that encodes the
>chip characteristics/capabilities, not its state.
>
>Anyway, if this bit is actually reflecting the on-die ECC state and on-die
>cannot be disabled on your chip, it should stay at 1 even after you have sent
>the SET_FEATURES(DISABLE_ECC) command. Let's hope this works as I expect,
>otherwise we're back to option #2 until Bean suggest something else.

MT29F1G08ABAFAWP-ITE:F is Micron 70s SLC NAND with on-die ECC.
If the bit7 in the byte 5 of READID default is 1(ECC Enabled), it is true on-die ECC
Cannot be disabled by SET Feature command.
In case sending Set Feature command, you can check previous command is success or not by
Get Feature or check this bit7 in byte 5 of READID later.

To check if this device supports on-die ECC or not, you can use inter ECC level (bit 0 and bit1 in byte 5 of READID)  
http://lists.infradead.org/pipermail/linux-mtd/2017-April/073370.html

//beanhuo

