Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2D7C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD38823E9F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD38823E9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752625AbeF1EJw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 00:09:52 -0400
Received: from mo-csw1515.securemx.jp ([210.130.202.154]:58574 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751626AbeF1EJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 00:09:51 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id w5S49CFv031294; Thu, 28 Jun 2018 13:09:13 +0900
X-Iguazu-Qid: 34tIVOFt9hpNu8vuk6
X-Iguazu-QSIG: v=1; s=0; t=1530158952; q=34tIVOFt9hpNu8vuk6; m=furpkksFRmWMjKJh5uEpFl3Er7SK9cFgpF8SyMaHiIs=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1510) id w5S49AJo035177;
        Thu, 28 Jun 2018 13:09:11 +0900
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by imx2.toshiba.co.jp  with ESMTP id w5S49AvS005328;
        Thu, 28 Jun 2018 13:09:10 +0900 (JST)
From:   "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To:     "'Ben Hutchings'" <ben.hutchings@codethink.co.uk>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Cc:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <stable@vger.kernel.org>
References: <20180614132724.483802160@linuxfoundation.org> <1529418520.2289.296.camel@codethink.co.uk>
In-Reply-To: <1529418520.2289.296.camel@codethink.co.uk>
Subject: RE: [PATCH 4.4 00/24] 4.4.138-stable review
Date:   Thu, 28 Jun 2018 13:09:09 +0900
X-TSB-HOP: ON
Message-ID: <000c01d40e95$c3aabe90$4b003bb0$@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGUQj4igkaupq7EehpFPqRFc6I8UgIoYKhxpONhg3A=
Content-Language: ja
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: stable-owner@vger.kernel.org <stable-owner@vger.kernel.org> On Behalf Of Ben Hutchings
[..]
> 3.18 and 4.4 are still missing this important fix to early parameter
> parsing:
> 
> commit 02afeaae9843733a39cd9b11053748b2d1dc5ae7
> Author: Dave Hansen <dave.hansen@linux.intel.com>
> Date:   Tue Dec 22 14:52:38 2015 -0800
> 
>     x86/boot: Fix early command-line parsing when matching at end

I have cherry-picked that commit into both 3.18.y and 4.4.y (it applies cleanly) and tested them on my machine. Both worked correctly.

Test method: 
- Added printks to the functions that detect noxsave, noxsaves and noxsaveopt
- Booted both kernels with and without the commit, and adding the kernel parameter "noxsave"
- Checked that "noxsaves" and "noxsaveopt" do not appear on dmesg anymore after the commit.

Thanks,
Daniel



