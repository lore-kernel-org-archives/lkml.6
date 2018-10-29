Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFDBC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE702082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:45:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BE702082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=profihost.ag
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbeJ2TdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 15:33:15 -0400
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:46527 "EHLO
        cloud1-vm154.de-nserver.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729146AbeJ2TdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 15:33:14 -0400
Received: (qmail 17991 invoked from network); 29 Oct 2018 11:45:05 +0100
X-Fcrdns: No
Received: from phoffice.de-nserver.de (HELO [10.11.11.62]) (185.39.223.5)
  (smtp-auth username d.aberger@profihost.ag, mechanism plain)
  by cloud1-vm154.de-nserver.de (qpsmtpd/0.92) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) ESMTPSA; Mon, 29 Oct 2018 11:45:04 +0100
Reply-To: d.aberger@profihost.ag
From:   Daniel Aberger - Profihost AG <d.aberger@profihost.ag>
Subject: MCE reports errors that can't be verified
Organization: Profihost AG
To:     tony.luck@intel.com, bp@alien8.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     s.priebe@profihost.ag, n.fahldieck@profihost.ag,
        p.kramme@profihost.ag
Message-ID: <6ccf5413-ce2a-bbb9-0203-b0cc9fe2e641@profihost.ag>
Date:   Mon, 29 Oct 2018 11:45:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-User-Auth: Auth by d.aberger@profihost.ag through 185.39.223.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We currently have several servers reporting faulty memory through MCE.

Example dmesg output:

[Mi Aug 22 13:54:47 2018] mce: [Hardware Error]: Machine check events logged
[Mi Aug 22 13:54:47 2018] mce: [Hardware Error]: CPU 12: Machine Check:
0 Bank 7: cc027c0000010091
[Mi Aug 22 13:54:47 2018] mce: [Hardware Error]: TSC 0 ADDR 70fc337d80
MISC 50202086
[Mi Aug 22 13:54:47 2018] mce: [Hardware Error]: PROCESSOR 0:306f2 TIME
1534938887 SOCKET 1 APIC 20 microcode 3d
[Mi Aug 22 13:54:47 2018] mce: [Hardware Error]: Machine check events logged
[Mi Aug 22 13:54:47 2018] mce: [Hardware Error]: CPU 14: Machine Check:
0 Bank 7: 8c00004000010091
[Mi Aug 22 13:54:47 2018] mce: [Hardware Error]: TSC 0 ADDR 70fb117d40
MISC 4268e886
[Mi Aug 22 13:54:47 2018] mce: [Hardware Error]: PROCESSOR 0:306f2 TIME
1534938887 SOCKET 1 APIC 24 microcode 3d
[Mi Aug 22 13:54:47 2018] mce: [Hardware Error]: CPU 15: Machine Check:
0 Bank 7: cc00008000010091
[Mi Aug 22 13:54:47 2018] mce: [Hardware Error]: TSC 0 ADDR 70fb1b3ec0
MISC 142189886
[Mi Aug 22 13:54:47 2018] mce: [Hardware Error]: PROCESSOR 0:306f2 TIME
1534938887 SOCKET 1 APIC 26 microcode 3d

Normally we verify those errors by checking IPMIs event log, but no
errors are showing there.

Neither IPMI nor ras-mc-ctl report any errors.

We encountered this problem running Kernel 4.12.0 based on openSUSE
SLE15 on commit a906b62b3f80679eac4f38373492a871c5f3568e.

Is this an MCE Kernel bug?


-- 
Mit freundlichen Grüßen
  Daniel Aberger
Ihr Profihost Team

-------------------------------
Profihost AG
Expo Plaza 1
30539 Hannover
Deutschland

Tel.: +49 (511) 5151 8181     | Fax.: +49 (511) 5151 8282
URL: http://www.profihost.com | E-Mail: info@profihost.com

Sitz der Gesellschaft: Hannover, USt-IdNr. DE813460827
Registergericht: Amtsgericht Hannover, Register-Nr.: HRB 202350
Vorstand: Cristoph Bluhm, Sebastian Bluhm, Stefan Priebe
Aufsichtsrat: Prof. Dr. iur. Winfried Huck (Vorsitzender)
