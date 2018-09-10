Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60227C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 097BD2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 097BD2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbeIJRmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:42:45 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39234 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbeIJRmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:42:45 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fzLcT-0007rd-Oq; Mon, 10 Sep 2018 14:48:45 +0200
Date:   Mon, 10 Sep 2018 14:48:45 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ville Syrjala <ville.syrjala@linux.intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Pavel Tatashin <pasha.tatashin@microsoft.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] Revert "x86/tsc: Consolidate init code"
In-Reply-To: <20180910121925.27682-1-ville.syrjala@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1809101443290.1292@nanos.tec.linutronix.de>
References: <20180910121925.27682-1-ville.syrjala@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1410442286-1536583725=:1292"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1410442286-1536583725=:1292
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Ville,

On Mon, 10 Sep 2018, Ville Syrjala wrote:

> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> This reverts commit 608008a45798fe9e2aee04f99b5270ea57c1376f.
> 
> It breaks wifi on my pentium 3 Fujitsu-Siemens Lifebook S6010
> laptop. Scanning for APs doesn't seem to work most of the time,
> and, even when it manages to find some APs it never manages to
> authenticate successfully. dmesg is just littered with:
> "wlan0: send auth to ... (try 1/3)
>  wlan0: send auth to ... (try 2/3)
>  wlan0: send auth to ... (try 3/3)
>  wlan0: authentication with ... timed out"

I asked for that before and I really do not understand why you do not even
make an attempt to report an issue first and allow the developers to work
with you to figure out what exactly is the problem. All you do is to send
an revert patch with a changelog which describes symptoms and probably
breaks more than it cures. Not really helpful, really.

It's surely helpful to know that you bisected it to that commit and
reverting it helps. Can you please provide more detailes information like
dmesg of an good and a bad boot?

Thanks,

	tglx




--8323329-1410442286-1536583725=:1292--
