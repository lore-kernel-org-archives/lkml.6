Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C24EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35DF620657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732562AbfAORTh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:19:37 -0500
Received: from mail-gw1.esolutions.de ([178.239.73.50]:23603 "EHLO
        mail-gw1.esolutions.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbfAORTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 12:19:37 -0500
X-Greylist: delayed 359 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jan 2019 12:19:37 EST
Received: from DEGAMES01.eso.local (degames01.eso.local [10.2.0.245])
        by mail-gw1.esolutions.de (Postfix) with ESMTPS
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 18:13:37 +0100 (CET)
Received: from DEGAMES02.eso.local ([::1]) by DEGAMES01.eso.local ([::1]) with
 mapi id 14.03.0408.000; Tue, 15 Jan 2019 18:13:37 +0100
From:   Tschigirinski Jewgeni <Jewgeni.Tschigirinski@esolutions.de>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: kexec: relocate_kernel fails
Thread-Topic: kexec: relocate_kernel fails
Thread-Index: AdSs9Uw1CCu/l200R5qa9FU+q25jpQ==
Date:   Tue, 15 Jan 2019 17:13:36 +0000
Message-ID: <A019E0A5E55E844784593A3634C1DB07465D604B@DEGAMES02.eso.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.2.14.182]
x-esetresult: clean, is OK
x-esetid: 37303A29B2331A6B65706B
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am not able to get kexec to work.

For x86_64 relocate_kernel fails to store information for jumping back.

Kexec stops in movq %r9, CP_PA_TABLE_PAGE(%r11).
