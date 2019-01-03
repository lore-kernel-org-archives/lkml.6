Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801EBC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5690F21479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfACTtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 14:49:25 -0500
Received: from mout.gmx.net ([212.227.17.22]:51789 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727032AbfACTtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 14:49:24 -0500
Received: from [185.6.148.228] ([185.6.148.228]) by web-mail.gmx.net
 (3c-app-mailcom-bs01.server.lan [172.19.170.58]) (via HTTP); Thu, 3 Jan
 2019 20:49:23 +0100
MIME-Version: 1.0
Message-ID: <trinity-fd67cbaa-5164-40ca-b198-ded5998d2578-1546544963406@3c-app-mailcom-bs01>
From:   "Hussam Al-Tayeb" <hussam.altayeb@gmx.com>
To:     linux-kernel@vger.kernel.org
Subject: Excessive swapping under Linux 4.14.91 (no issues in 4.14.90).
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 3 Jan 2019 20:49:23 +0100
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:ByogewiN9P5NpemabEToXUrJbEhweaFo1Kkdc1luy/+P948X/eUxKyeTFHxDd/qKnjoBo
 Bh7rLMknq3ImEnC4u+4ktoC/z0y43NUYmCsjF/aO9E7vLSdDRSYHyrFwDOOMUcuw6x1tB6pBa3Kd
 CBuV0qDm6vTVEK03T5w5RmjvLeZTsY9W6XLAJfh4j+PUlvGXFhJx7QZcktKN7JBqGRVX7Ot0IVdL
 +caXT0NlAJJ6fRO+dPDfnh4g9F4GAo4UTIfKe3CsoqxzNJvTgMiGCDlYbrlQ0WcfRoe+s4CsDop1
 cc=
X-UI-Out-Filterresults: notjunk:1;V03:K0:vJpbHLOKf8w=:HazA8hlxRNNKB/DUgR3vuB
 nyqmrbOmQszoJgbNecP3Y5WqvmKNFBxtSPZirvf/6En6Mk7nLz6A5dZ5zgwVycqN8Idgr4bLD
 7JYPqTPWdKNHKU+JfiCCnAu+SHcOB/pOZumdkC4zDK4D2Nq9Etpj8Z++UtxFb293ci0ecTt0x
 1TRvugURiZRwioCnNlLAdAJapUlXNsPD6gq091LssHXAHjOmiYVRPJL6YBMdnMB/v4AGXtpNi
 Fv5q8ZvBmqTlKL0B7j0wF3FXGgJgs2z5Hqv2rA7Brf9i+Xu8Ahucgse1OEr30SjtqylVFibAy
 /D2SVvi1w/A6zCbBbknwHEAz+bXsJaBWnSE5Xc+40jGUmZd6b5X5XMcj88MxI/WKaH3qtiwC4
 N+mNzfFsjdK/pKPPiJTw4L6ulmfruI/1lrufgEPv7kPqp0GZWb7LSWki/BMbCQtPvoqBlVQhD
 2YIGuDcRiFniAr9pkUj+rE+Y1Rac0P4Nrk2DJStuxAavyBYcgNTAlDt+C5o+9/q9QGpzV2GFc
 Y9Gc2/NPjRsu26s7agKHufxZE+V5HpyS0iKN4/JSzlL3bkCu0NcZFrGYl8s2KqFsLPBxpfZsD
 2kQznHsj43ZCk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello. My system has 16GB of ram. Before kernel 4.14.91, it would use about 700KBytes to 1MB of the swap if the memory usage was 4 to 5GB in use out of 16GB (15.6 actually).

After upgrading to 4.14.91, I am seeing 500 to 700MB of swap usage even under low memory pressure situations. For example, 3.5GB used out of 16GB.

I downgraded to 4.14.90 and the excessive swapping stopped. I upgraded to 4.14.91 and the heavy swapping came back.

Any idea how I can gather information to tell what is happening?

The machine always has the same services and applications running so I am sure this is a kernel issue. It hasn't received any non-kernel updates in months. This narrows the issue down to the kernel.

Thank you.
