Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CB8C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC2F22BD2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dejNsQtX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DC2F22BD2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934398AbeGFUrn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 16:47:43 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44929 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933833AbeGFUrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 16:47:42 -0400
Received: by mail-pl0-f65.google.com with SMTP id m16-v6so3360581pls.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 13:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:reply-to:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=tDSTachPrP+MUpNcIlR3DtbioKWwuL3BSeLuLUBITxs=;
        b=dejNsQtX/JfRzGQLWmXEocuZhjX5G7YjcxUB276XtLV/wqMTFmGUQSQcbNLnPJHwFE
         uP/Wf6uvUftc/0xYh+PuQPgiwOwnwA9rZnN/pjn7pmcyMmUcXIRF+fzxKgOZGmizj39Y
         IJp+yPORkwf88lzb2uzZxHiYk+W7Cgn4HqHeKOkX83KgGt0zCzSvopTUpWerIsAf2Gy4
         Ja22jSuxwfyMoU3bAHhpom8MSPMHMxFEYn6r7c1pYAItq+Rii4jUuR61i2SLA+5J2VeZ
         CH8BcSPsCKEsfqUWEUy9wHf8mPlL42YcRdLXhd2jNL6Um/SKTUNiCmTyA5+auzokWdsq
         l5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:to:cc:from:subject:message-id
         :date:user-agent:mime-version:content-transfer-encoding
         :content-language;
        bh=tDSTachPrP+MUpNcIlR3DtbioKWwuL3BSeLuLUBITxs=;
        b=XaLn8JMBM8NkZB/nxKhrBkjwUFioQKmz2ab6ZoOBRVLcuCmNIk5D8z3O0JmwJh6t4o
         aRn9olWoSWWB/EOXeUhWw5J16X4uYJhhbJ2z4hFZ5EKrOPcXPu/KkTHBzLr5AIF7vHW0
         icZ9ZdgeeOMUbRwZB9d0oiVp27pZgQqPaUUGHC7H/Gp8qddUHAh5+/jsiAVuCJz5SfFf
         +rVh3Vfbi8vxWxjZVGDyjicE/5YAFJEw9kYUt7ZpAwUqNKXldK79/TW9hyEYxqmhGEKt
         Auzu2h08BcdB60xphfxwNeHRPaZcN/vcG8u+BA/Y6h7nmxcfA0M+zAU9sg8Oh7xX3m5g
         TL0w==
X-Gm-Message-State: APt69E0aIGwV56qBu7RUmFwEESXHZG7zJ/skzUkMCf5LFLd0PyX4JAFB
        QMQSf2B0lHK+++ruCpTwfY7HRHA=
X-Google-Smtp-Source: AAOMgpf684jBhayb9M1qNt7Z9vKYueabDnq//+sUK9Mue8FwBodw3DoPZRBgblnt6SSTHvQWNgcchQ==
X-Received: by 2002:a17:902:8206:: with SMTP id x6-v6mr11404015pln.220.1530910061853;
        Fri, 06 Jul 2018 13:47:41 -0700 (PDT)
Received: from serve.minyard.net ([47.184.170.59])
        by smtp.gmail.com with ESMTPSA id v5-v6sm15495520pfm.14.2018.07.06.13.47.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 13:47:40 -0700 (PDT)
Received: from [192.168.27.3] (t430m.minyard.net [192.168.27.3])
        by serve.minyard.net (Postfix) with ESMTPSA id 611CA8F8;
        Fri,  6 Jul 2018 15:47:38 -0500 (CDT)
Reply-To: minyard@acm.org
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>
From:   Corey Minyard <minyard@acm.org>
Subject: [GIT PULL] IPMI bug fixes for 4.18
Message-ID: <985e5fdd-072c-88d8-c355-b8e35e5706bc@acm.org>
Date:   Fri, 6 Jul 2018 15:47:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few things that came in recently that need to be fixed.

The following changes since commit 9ffc59d57228d74809700be6f7ecb1db10292f05:

   Merge tag '4.18-rc1-more-smb3-fixes' of 
git://git.samba.org/sfrench/cifs-2.6 (2018-06-18 14:28:19 +0900)

are available in the git repository at:

   https://github.com/cminyard/linux-ipmi.git tags/for-linus-4.18-2

for you to fetch changes up to dc0f0a026d33819bb82d5c26ab2fca838e2004be:

   ipmi: kcs_bmc: fix IRQ exception if the channel is not open 
(2018-06-24 18:11:39 -0500)

----------------------------------------------------------------
A couple of small fixes, one to the BMC side of things that fixes
an interrupt issue, and one oops fix if init fails in a certain
way on the client driver.

-corey

----------------------------------------------------------------
Corey Minyard (1):
       ipmi: Cleanup oops on initialization failure

Haiyue Wang (1):
       ipmi: kcs_bmc: fix IRQ exception if the channel is not open

  drivers/char/ipmi/ipmi_si_intf.c |  6 ++++--
  drivers/char/ipmi/kcs_bmc.c      | 31 ++++++++++---------------------
  2 files changed, 14 insertions(+), 23 deletions(-)

