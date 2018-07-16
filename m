Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A607FECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6954F208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6954F208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sourceforge.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbeGPSFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:05:13 -0400
Received: from mout.web.de ([217.72.192.78]:38689 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727866AbeGPSFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:05:12 -0400
Received: from [192.168.1.3] ([77.191.164.6]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LtWo4-1g4Eyd0FVc-010saM; Mon, 16
 Jul 2018 19:36:35 +0200
Subject: [PATCH v2 7/8] Coccinelle: atomic_as_refcounter: Use string literals
 directly in two SmPL rules
From:   SF Markus Elfring <elfring@users.sourceforge.net>
To:     kernel-janitors@vger.kernel.org,
        Elena Reshetova <elena.reshetova@intel.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
References: <CAK7LNAT=7E0HFd+MM92VcNdA1i6AME6qyFA9sN-2dabibxkiJg@mail.gmail.com>
 <6043bdc9-529f-e93f-e509-e2dedd290a10@users.sourceforge.net>
 <5ca6ab58-e929-8468-74e2-012f987a0773@users.sourceforge.net>
Openpgp: preference=signencrypt
Message-ID: <a50c134e-fb8a-afb8-c3d5-57ff16cba89a@users.sourceforge.net>
Date:   Mon, 16 Jul 2018 19:36:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5ca6ab58-e929-8468-74e2-012f987a0773@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:eEajwOB8pJJlyc8W0CgFTAUF/CXaUcP94wt/Gswjs1MEXncIbuH
 GZeV2xcxgWpRtxYGfPjriNVlro88z8v4l20ja76Z6PzYapEp10bE6IKZxnYAVe319GfCFzO
 cLVqvNFMzSHWI0VFiuJ91bOnHoECXjkJn0I7FiNWC/x9bdC6VrerSxm5M2UKprPC/9m7ZO8
 PZ7SOFJRePCpb2FF/W5ag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JU+rWx4LSoQ=:5uyqYc/7ZMUGsRRslO3XGa
 0/UmpI8XmDNf34+9wZZHUqDiAe+7ouWDAQRZ500gI6aYOW5uZNLlHT5199s9iyTriwbIEfFsR
 ZbLBfnk+zHQMUuQmAhXCUIqikOpfMVQ7/eXqiZPJ2jMGlUkOVUU9EVHOjP3ibSh2zuUnPmvCO
 bnUrgH4d28EKKf9AvO7qne2aYSBiPtxIUVIaarZkrWPENvLEnbInzU7PoBWN5YPtgx1lZPH0P
 HaUrIjV3dj9mcoBfqHE4cT79AGH0FXJWVbxq5qMRcunS5UDwHMtpfwej3JQulcPkkUZfga6dZ
 ROdaOm3YNqRPK6eQ5WFwwOUS7BvRSO+Hbh5cbQYdcL3rb5HqVRjQhUonKw2YcfrpffPaul05s
 oohLRt8IQfWCcFDlEHgUCfPbqUHBhrh/4VnNNDi4qQXjktTdQ7axoogzrx0O1s8S3YxS/511e
 PRz9TTzgHiArzRhMXuKldJLFrZkLMG/X652S3O9IKgfU6y2uJ/yta/rwPb4stLPpTObRvT0gT
 mQbjBiJ8KeHboVOOsZl9XTkUHE9nbLQIvxDyZwzyAbikQOSfnD2RK4SfW3xiWDTa0fiMw8pxn
 YJWwW8Ac+R9e47D13kEX0WrDGENTgLY8Nxma+1b7UwYAhLqnKPn3PGxQ+EzJyXr+H3FX2adoI
 jDefncNBln8yRGdhROxJ6Hmg4SNYo13rW0Ya1AMXVQlGiUmJbVZo6sKJO1adzn3ZsrhRORr2e
 4pZgiBe7lXVYKtnnAwTrqKmOaE4/pmdv11D6j253/0x+Y2NZ14eaibWvQniVwfTgssisckcrO
 wO7VQsl
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 16 Jul 2018 18:36:41 +0200

String literals were always assigned to the Python variable “msg”
before they were used in two rules of a script for the semantic
patch language.
Delete these extra variables so that the specified string objects
are directly used for the desired data output.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 scripts/coccinelle/api/atomic_as_refcounter.cocci | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/scripts/coccinelle/api/atomic_as_refcounter.cocci b/scripts/coccinelle/api/atomic_as_refcounter.cocci
index 7eae23dc9ea8..c9b838941024 100644
--- a/scripts/coccinelle/api/atomic_as_refcounter.cocci
+++ b/scripts/coccinelle/api/atomic_as_refcounter.cocci
@@ -53,8 +53,7 @@ position p1;
 @script:python depends on report@
 p1 << r2.p1;
 @@
-msg = "atomic_add_unless"
-coccilib.report.print_report(p1[0], msg)
+coccilib.report.print_report(p1[0], "atomic_add_unless")
 
 @r3 exists@
 expression E;
@@ -66,5 +65,4 @@ position p1;
 @script:python depends on report@
 p1 << r3.p1;
 @@
-msg = "x = atomic_add_return(-1, ...)"
-coccilib.report.print_report(p1[0], msg)
+coccilib.report.print_report(p1[0], "x = atomic_add_return(-1, ...)")
-- 
2.18.0

