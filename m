Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FA3C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301C520870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 301C520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbeLMSuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 13:50:24 -0500
Received: from mout.gmx.net ([212.227.17.22]:40131 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbeLMSuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 13:50:24 -0500
Received: from localhost ([130.180.45.238]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lxgnf-1hUXjA0KNP-017Hhs for
 <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 19:50:23 +0100
Date:   Thu, 13 Dec 2018 19:50:22 +0100 (CET)
Message-Id: <20181213.195022.492897188175961278.hartrumpf@gmx.net>
To:     linux-kernel@vger.kernel.org
Subject: Re: Can we drop upstream Linux x32 support?
From:   Sven Hartrumpf <hartrumpf@gmx.net>
In-Reply-To: <20181213.103731.734229932284065893.hartrumpf@gmx.net>
References: <20181213050313.GA21201@ip-172-31-15-78>
        <CAFLxGvy2sMW1nyMpxGN7xHPdUea713g89MdE3EcUNHJDCvZ3jA@mail.gmail.com>
        <20181213.103731.734229932284065893.hartrumpf@gmx.net>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:QdfRhXBL1DdDpgKVshKQK1J5pM7xusv/HTd25EFIxnVht230Kbk
 UrYqhtjT/ER7awA8gL3jtpSCbkYem6gPPhmWliYg100KRbcQcGChBUngp1Sn4D13VO7KgvZ
 O31t8or9CLs9i2a8mcE6mTJBqDfL6b55WSnyFlbP4xmM7jEbi0IQRxWwmSxxR6IV9NAHoHU
 7WbKcRQSYwNwk+s5G62nA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cSB6lsYv4io=:+FtQjIk+1EP9Vq+zuY2YDA
 7TRkLZdLEknmhD2dVeI6IajiTrhePyM8KP+GC19mmk/GJ70STfgNYdw4U0CKhlYbVWQDyOmHM
 SQ82PZUIyVkzr7kolUPvmuGHXTI+6sx8lHY5tb/XD/ZXSX2x/4jVAGgVOJlXuXsqsAaLBVdUX
 F84S3Mwu6BpJq6XXNk7zWNOAFyzGJ/n5wk62RVMz401I0+R6FU6Db878uROluYNE9rtQ+T3zt
 43xlcjn3gi6YAtNcegQbysbT3Zbz1NggDi7C1Hk9jTG0R0TV4Kd20bUsX/Hpov+gPq7OSXGuA
 ZT0csjHIQnVw15Ph3AHhp6HLqV2IQtHXqVZ1UTRfI1Q+jmN1DhcOMpxtmDzj4BhnUob0KEYvv
 uP8YluBWiW1BYUTnvPX+hxxEFS1mWSOlXh52ooy2zdvWuEx3mBof0BriAWz7kqoqL0B5TS4wx
 D9wTt5aqajmP5gpZUVc87+M5q6VkTFZ60qcKMPrNOHwpUTnQVmsvrWRPJfKiGII+aauafQAY5
 ovpY7IUewbvumJoB4mExfDZU5kbWgRG5p4G744NfcJPXEe7g319stc9SmmyDmTjgh6iSWdaJc
 xxo8VRIoG3ei96cx9jyzOMpXJ6o/xaKYMdC88jiqifhZFOhKDQ7hBMD32CT5MCeHTnLdYkFRB
 OSGk6XpEPcGWh7AjPrJ7PKccpOm0D3R4CbjPbuSq9qI+FRKNqCqQ8o6t4Uox5cxRBB1O9jg8s
 Zm+NXPQZluElVttUkg8eCXJ85si/rabQVOYV5fuviZ2GFFjRroDV33A+P9biUcQmvMrvqwPVt
 /zmWKOInEbHRX8xxNGCeelEjmngKya6r4VEyaTNZ2asE9UkPlIkP42Lm2sMd/LZhI2hMR5adv
 dOyArF1JP1no54gOVQE/jDTnz4QnN1ezdJen8RhRM4Iiy1H1DkU1asAgoCq5uR
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I reported several significant speedups gained by the x32 ABI
for Scheme-based applications (compiled via a gcc backend), e.g.

https://lists.nongnu.org/archive/html/chicken-users/2015-09/msg00000.html
https://www.mail-archive.com/bigloo@inria.fr/msg00427.html
https://forum.manjaro.org/t/why-is-there-no-kernel-support-for-the-x32-abi-config-x86-x32/55156/9

As a tech startup in cognitive search and NLP (https://www.sempria.de/),
the benefits of the x32 ABI in terms of saved compute time and costs are
vital for us.

It's a pity that x32 has not gained the momentum that it deserves.
Two suggestions to change this:

1. One could extend a prominent page like https://sites.google.com/site/x32abi/
   with positive and negative results for applications w.r.t. the x32 ABI.
   I am willing to rewrite and update the results that I reported over the years.

2. The name x32 is too short, not search-engine friendly, and ambiguous (most
   people think it's about i386 ...). Is not there a better name?

Ciao
Sven
