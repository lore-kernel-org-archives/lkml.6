Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953C8C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FE1A20844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbfBEOO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 09:14:56 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:34241 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfBEOOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 09:14:55 -0500
Received: from [192.168.178.52] ([109.104.46.226]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MfHUx-1hJjTa3b4d-00gryI; Tue, 05 Feb 2019 15:14:37 +0100
Subject: Re: [PATCH v2] i2c: bcm2835: Clear current buffer pointers and counts
 after a transfer
To:     Wolfram Sang <wsa@the-dreams.de>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        Eben Upton <eben@raspberrypi.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org,
        Eric Anholt <eric@anholt.net>,
        bcm-kernel-feedback-list@broadcom.com, linux-i2c@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org
References: <20181227154225.5492-1-paul.kocialkowski@bootlin.com>
 <20190205120905.GB1045@kunai>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <3784fe11-bdc4-5751-13b4-f50bdeeee205@i2se.com>
Date:   Tue, 5 Feb 2019 15:14:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190205120905.GB1045@kunai>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:nQmOSq0Sytf9T6z48blffv0JlWaArSj5LejxShFwdHoS44WeU+p
 MdNeW0T1thqMZD9avGYHMeAv8COndE32Qrtg4jonqg51J2Eh08Q6KumI+TRBQ6uyU88q1xg
 hWqNJCPILKg1KVTrhnfqRFHX+Q+zXBkL5vgGHbX6f51sD7akSqSSt21L1wbhr2iGrzpMYIj
 Ard2p4+MtZL8zm6EpTIEA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5pg5KoYkHdQ=:XtBcIpjc/dtUE+Gcxf6LuU
 I0PSQoTfhBUDVbpFoktoWhz0n6SrQygkMmww5bLPfI3g4S6+ucbO1D6TsB8uEt66ujSu1aTv0
 IyDQK/FTEGQLomrAn+6eHeYfDTJuZ15Kfb5kOOdg7+tyBKfrAeP00jyFanUHIVh+0ZBSo6neA
 AWuVbc77B2c78qMt4FGFE1o/c3a9CqZWNxkTCw64GlU4J9zf5wYElqQWk2M1C/o26TwkZmuwC
 QNEArncSnKeKmilrvWhRQcZRqs+7URtFkoRq9ZwEWKY07ZYoefZf2fWEt1B4yjBJGz/Zv0rkx
 5l+D021cLAnx3VqQKgYkT611n2ZVDg6WCN/eP1S5GFki1HPcq738VI2muf3BAi6MQG+tdtkih
 PnUmfhiewQjCtvRkdbooQGaKpVMsJSRxoXiunaEIscdySEe+iGYnreCP8kq4MnsiZa18W9i7A
 EoFB5Y+TYA2ZxHNQooOWe/OFR27Vc2poeud8bYHyWWg29e4fsswv+pzBg/X5qxeC80Ee1Zwcf
 MGbTX+ReKdXGWqQTHkm5VJy/CM1GyG8K8hbzjdQrp3Y4AAnTIB5CMqVIEaptDdSOuGAdwWzxf
 rUgaF9GLQz5Bi+b07/XmZegXCtxwWGEdeXM5O8Buy61vvBU0TthkXMe6B+LWIh75t4+2pzqt9
 LF6oDj5NWSizkTr1JyoAScZ2qx+PwiQ7dnhEqAo/DEE5yJ52HD2j0zaPP6z95FSXouTFk+eyT
 utSDjO4wa/UOopOC+ZmRiF4Y891DwJApThgH/H+Yfg13eHDZejfsLz0FJOc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 05.02.19 um 13:09 schrieb Wolfram Sang:
> On Thu, Dec 27, 2018 at 04:42:25PM +0100, Paul Kocialkowski wrote:
>> The driver's interrupt handler checks whether a message is currently
>> being handled with the curr_msg pointer. When it is NULL, the interrupt
>> is considered to be unexpected. Similarly, the i2c_start_transfer
>> routine checks for the remaining number of messages to handle in
>> num_msgs.
>>
>> However, these values are never cleared and always keep the message and
>> number relevant to the latest transfer (which might be done already and
>> the underlying message memory might have been freed).
>>
>> When an unexpected interrupt hits with the DONE bit set, the isr will
>> then try to access the flags field of the curr_msg structure, leading
>> to a fatal page fault.
>>
>> The msg_buf and msg_buf_remaining fields are also never cleared at the
>> end of the transfer, which can lead to similar pitfalls.
>>
>> Fix these issues by introducing a cleanup function and always calling
>> it after a transfer is finished.
>>
>> Fixes: e2474541032d ("i2c: bcm2835: Fix hang for writing messages larger than 16 bytes")
>> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Stefan, Florian, any comment about this patch?

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

Thanks

