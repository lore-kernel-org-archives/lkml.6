Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3A3C2BC61
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 21:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C9E620672
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 21:00:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C9E620672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbeJ2FqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 01:46:22 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:59669 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbeJ2FqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 01:46:22 -0400
Received: from null ([212.227.220.15]) by mrelayeu.kundenserver.de (mreue001
 [213.165.67.97]) with ESMTPSA (Nemesis) id 0M9j7n-1gQTLw3hyJ-00Cwl1; Sun, 28
 Oct 2018 22:00:11 +0100
Received: from null ([212.227.220.15]) by mrelayeu.kundenserver.de (mreue001
 [213.165.67.97]) with ESMTPSA (Nemesis) id 0M9j7n-1gQTLw3hyJ-00Cwl1; Sun, 28
 Oct 2018 22:00:11 +0100
Date:   Sun, 28 Oct 2018 22:00:10 +0100 (CET)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, eric@anholt.net,
        dave.stevenson@raspberrypi.org
Cc:     linux-rpi-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Message-ID: <646164838.4217.1540760410870@email.ionos.de>
In-Reply-To: <20181026134813.7775-12-nsaenzjulienne@suse.de>
References: <20181026134813.7775-1-nsaenzjulienne@suse.de>
 <20181026134813.7775-12-nsaenzjulienne@suse.de>
Subject: Re: [PATCH RFC 11/18] staging: vchiq_arm: use completions instead
 of semaphores
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev39
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:/5N3B9OX1SeVKvEc8cP+3WfKHk73DBpJzvWUR/J3nCTAhOrQJ3G
 2TbjbySLazTZJgP7wTzCTXNznGi3g5m8cyeSsNQvzjmfakaXl5H/f+yh6FtGRQ8jhSU5OSU
 A1eUlv5N/Fw7sAEXXH23gYAXAL1tOdLIIpzQyl6E/WYkcYXmO10bwCPq/8wN0+CIrxDK1hx
 BN7FFy3JDzcBm2lTOH7Xg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+8gVdqKyQ2s=:ipfnBK/QnBtE2pzjgVUHRb
 xJ+qK5CEdeLeTqZ8HiDPCgJ15970ZFTPmtZialzDc1CS004n6llqyIRFEqVP7Fmkpo5wh31IW
 K8Tx6DlpXaY5WeNS+1AnLjgXGHYlWjJEPTz068oi18BDCE53hDZt7TT2Y9lvpaIYgQbWAsNii
 hIl75qxa/W0ln/GhEj1N0U3InVfPTfpoKhEHV72QfGqdC+1CfHbPi2oqvTHkZNag0bKPJPFUy
 Cu0obKK4a0I4U14ZtjkjazfFoIhyNcx4hO49rsQFvy+yenfd7xcG8nnheECFDIP+xGTODJrg0
 Bw78IJ74eIDUOvSGpsHAk7F+lAeA6kO7yNSTCAtR+lJr6e6GmC/ax97t2x8EBmpom2OehRdOp
 KX/hJQY3urDIOkL+G9qZa0ezlzAywaY1CNYSI9O48jcP7HSIk80NAqiWApMBzWlvBP2N5Hl2x
 +ABuwHWl47Xavfw+CDYod/W84Esqsn0LtUwUf+y51vvF1fkbRoigNQyfWmcjAVpDGx+O/lXWf
 UCL1hIn/4dttheNEozqxoIE0ufNo492ZmWSNtKIUbGA62+VwtCo9beu5PeyHwTXARKrEp40QF
 sXjdP3sGetUeOcWaGbPw8OpGqj1k1OWR7AMK7vAwtGPKtFF9D0GLdnYcy8aEhuFmvzI3wLCZ6
 XkAy0jvX/Z2d3/9HFnFfVN+m+qXZ4IofS9Br/SBDF6hPZfT++kg3Oa2QRsgxSG90xoMHUIkpW
 efGJDw/eb0ADT363
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Nicolas Saenz Julienne <nsaenzjulienne@suse.de> hat am 26. Oktober 2018 um 15:48 geschrieben:
> 
> 
> It is preferred in the kernel to avoid using semaphores to wait for
> events, as they are optimised for the opposite situation; where the
> common case is that they are available and may block only occasionally.
> FYI see this thread: https://lkml.org/lkml/2008/4/11/323.
> 
> Also completions are semantically more explicit in this case.
> 

Since patch #11 #12 and #13 doing the same, they could be fold.
