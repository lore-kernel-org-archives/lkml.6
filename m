Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0EF7DC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 04:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C195620693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 04:05:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C195620693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933942AbeFMEFt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 00:05:49 -0400
Received: from mout.gmx.net ([212.227.15.15]:60079 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932079AbeFMEFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 00:05:48 -0400
Received: from juanniu018037.ss.mogujie.org ([122.225.81.134]) by mail.gmx.com
 (mrgmx001 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0M86Cn-1gOL2v1Bi5-00vdKD; Wed, 13 Jun 2018 06:05:45 +0200
From:   Chengguang Xu <cgxu519@gmx.com>
To:     ooo@electrozaur.com
Cc:     linux-kernel@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH 2/2] fs/exofs: only use true/false for asignment of bool type variable
Date:   Wed, 13 Jun 2018 12:05:14 +0800
Message-Id: <1528862714-78150-2-git-send-email-cgxu519@gmx.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1528862714-78150-1-git-send-email-cgxu519@gmx.com>
References: <1528862714-78150-1-git-send-email-cgxu519@gmx.com>
X-Provags-ID: V03:K1:BfFzMoZGi0fD/g/6+iN+UWqA0v+lVEFqa5/0t4snLsHCkBwxEbM
 6vhwoFt/ojm09KfQzj0dKoAPY7ZXY4KIHknRAegV1ZVe3c0X07Z5USitveUJX0tR1XxyXDi
 clzFhekbyKHh5BaFJyKpK1eizFEld3/MmOElRDwwBp2f/QDem+4ifgUpp6sqWHaOlT2b1FN
 MmXqhA4Mi2uB7QIzCYgbA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/DMGFS9T0UE=:prMk0A0t663SSUiua7D4KP
 trL5Oazzvsfn0/EwbgEyrRjCr13JnG8Eao2PsQ1rjvAMewM+LRuZj8sBAb78/Yo1+K8L9trky
 WfjafTD+oq4zMuYIDmbhbkKOKuRxouUVEVWtRGc5uP9LcLoOAeu02x3pI55m3QSLhkaKKhnHp
 rEgGtpb4qRNyKgeuRhFopL9D+saT4k6w5/23DCWvMLCAVFIHrKy39r4vSBZ9abXZBnp1LeVCa
 dOYghzlGK+6s2bS/Pne193RBx828QXxIlyJLUzVq9NEJZXUs+yet8fLqLgAz4R3ULC139vc5H
 TEbTfubYFy21db03zwfrYkWABBIkZqV/b1hzzlAZRbpZePLyfkWW35n6zCeups4vY3KB6FMtJ
 +6TAmIsJucms5bXG7PVe/fmhtKOUoVIG+CLJQ0zVwO9dw0twQEwZKOhx7XD5dY4Xn91cVOoXC
 C05orgbm+wK9VIAn5gVUa7yud8R24oEY07ADLOpYiW+/oXSaGi4hBpX8PIlaMhwbUOvUKgDIb
 V5hIFrfYcFynV2c9inXxHu3mt4XHPTu7MdkAQbw+OKbzGHmYsH8vWaWkYH1XFhH0Oh2b1QRw6
 tvadOEzubfUSkOcVrBDcW3nKqHKpyauzAz5B58OkL5I7lgvJwIK7L7WQUEV9dC6JXHEbtUexc
 MCP5aiRqz3J3EXjyHOIp7EzjtFW9HEX5jTlL4toI/xkhNHIGkjQbp911cCmq8PjUvBP3rVbGW
 lE5NAdzqppBo92fjz1liqwCwyWiFYcpkU3m8SBE/96Qoi7mAIgRiPolAavE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 fs/exofs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exofs/super.c b/fs/exofs/super.c
index f3e17a9..75b5db0 100644
--- a/fs/exofs/super.c
+++ b/fs/exofs/super.c
@@ -118,7 +118,7 @@ static int parse_options(char *options, struct exofs_mountopt *opts)
 					  EXOFS_MIN_PID);
 				return -EINVAL;
 			}
-			s_pid = 1;
+			s_pid = true;
 			break;
 		case Opt_to:
 			if (match_int(&args[0], &option))
-- 
1.8.3.1

