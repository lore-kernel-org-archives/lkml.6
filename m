Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01A1C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A8002098B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A8002098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybernetics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732323AbeGJWNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 18:13:15 -0400
Received: from mail.cybernetics.com ([173.71.130.66]:46298 "EHLO
        mail.cybernetics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732242AbeGJWNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 18:13:15 -0400
X-Greylist: delayed 1132 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Jul 2018 18:13:15 EDT
X-ASG-Debug-ID: 1531259598-0fb3b01fb32aa790001-xx1T2L
Received: from cybernetics.com ([10.157.1.126]) by mail.cybernetics.com with ESMTP id YAiPRLmQNCnnvWMw (version=SSLv3 cipher=DES-CBC3-SHA bits=112 verify=NO); Tue, 10 Jul 2018 17:53:18 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
Received: from [10.157.2.224] (account tonyb HELO [192.168.200.1])
  by cybernetics.com (CommuniGate Pro SMTP 5.1.14)
  with ESMTPSA id 8274694; Tue, 10 Jul 2018 17:53:18 -0400
Subject: Re: Re: [GIT PULL] SCSI fixes for 4.18-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
X-ASG-Orig-Subj: Re: Re: [GIT PULL] SCSI fixes for 4.18-rc3
Cc:     Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1530913134.3135.2.camel@HansenPartnership.com>
 <CA+55aFy-o3fRtkQnJU=0zv7CPUtgfKiwhfQi_05K25Y_-mx+_w@mail.gmail.com>
 <CA+55aFxQ8QzGTWsVdVQVok9cLbgZDFjG2g3JZtWJd+G9jHkYoQ@mail.gmail.com>
 <CA+55aFxAy__3hE1OoUFPKZfptLT1cXuoujsnSGXBMzJPQ+Qjzg@mail.gmail.com>
 <1530940958.3135.4.camel@HansenPartnership.com>
 <CA+55aFwg-2GP4ASTdd1pusmZkF7c8AN9febVDCaioDxzYJSLfw@mail.gmail.com>
From:   Tony Battersby <tonyb@cybernetics.com>
Message-ID: <70d566f0-2dda-60c2-7c7a-e09e371f8607@cybernetics.com>
Date:   Tue, 10 Jul 2018 17:53:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFwg-2GP4ASTdd1pusmZkF7c8AN9febVDCaioDxzYJSLfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Barracuda-Connect: UNKNOWN[10.157.1.126]
X-Barracuda-Start-Time: 1531259598
X-Barracuda-Encrypted: DES-CBC3-SHA
X-Barracuda-URL: https://10.157.1.122:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 656
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At my job (https://www.cybernetics.com/), I use the write()/read()
interface to the SCSI generic driver for access to tape drives and tape
medium changers.  For example, the write()/read() interface is useful
for implementing RAID-like functionality for tape drives since a single
thread can send commands to multiple tape drives at once and poll() for
command completion.  We have a lot of code invested in this interface,
so it would be a huge pain for us if it were removed.  But in our case,
everything runs as root (as the firmware of an embedded storage
appliance), so extra permission checks should be OK.

Tony Battersby
Cybernetics
