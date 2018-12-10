Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F88C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20DAB20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:02:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20DAB20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbeLJOCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 09:02:35 -0500
Received: from wp227.webpack.hosteurope.de ([80.237.132.234]:53864 "EHLO
        wp227.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727056AbeLJOCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 09:02:35 -0500
X-Greylist: delayed 2326 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Dec 2018 09:02:34 EST
Received: from ip4d142c80.dynamic.kabel-deutschland.de ([77.20.44.128] helo=[192.168.66.118]); authenticated
        by wp227.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1gWLXG-0003qG-UT; Mon, 10 Dec 2018 14:23:46 +0100
To:     postmaster@vger.kernel.org
From:   Thorsten Leemhuis <linux@leemhuis.info>
Openpgp: preference=signencrypt
Autocrypt: addr=linux@leemhuis.info; prefer-encrypt=mutual; keydata=
 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
 JdnmK/o0ppXb0ZYdtg==
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Create a dedicated mailing list for regressions
Message-ID: <3db99597-4518-c092-77b4-f8de1a4c26e8@leemhuis.info>
Date:   Mon, 10 Dec 2018 14:23:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1544450554;2534d030;
X-HE-SMSGID: 1gWLXG-0003qG-UT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave (assuming you are still behind postmaster@vger.kernel.org these
days)!

What do you need from me to create the mailing list
linux-regressions@vger.kernel.org, to create a dedicated place for CCing
regression reports and discussing regression tracking as whole? Creating
such a list was one of the outcomes on the discussions held at last
years Kernel and Maintainers summit; see https://lwn.net/Articles/737666
and https://lwn.net/Articles/738216/ for details. Sadly I didn't find
time to work on regression tracking during the past year, but I plan to
work on it again. Creating a place for discussions and improving the
documentation are among the first few steps I'll plan do to.

Ciao, Thorsten
