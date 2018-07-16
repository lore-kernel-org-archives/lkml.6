Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CE6ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2978320846
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2978320846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sourceforge.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbeGPR5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 13:57:15 -0400
Received: from mout.web.de ([212.227.17.12]:53343 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727514AbeGPR5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 13:57:15 -0400
Received: from [192.168.1.3] ([77.191.164.6]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Ls95v-1g2sBq1OAh-013vHI; Mon, 16
 Jul 2018 19:28:41 +0200
Subject: [PATCH v2 3/8] Coccinelle: atomic_as_refcounter: Optimise a
 disjunction in the first SmPL rule
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
Message-ID: <9941258f-9243-6400-3c93-ea0637da3e0d@users.sourceforge.net>
Date:   Mon, 16 Jul 2018 19:28:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5ca6ab58-e929-8468-74e2-012f987a0773@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:uJgxQIIOgA4tvUXop98/G6CrMfpxYGCiANQ6eYvzqpceQB3Rus8
 yX1timK4xBTlHprJclHskFdNQYgf0iqeR/wU6D7J58dlWYmbBXRe24yqmevOVjCl90tvG9l
 XdB6o5T7ReDzB5LXIbbPH5FMDjMuixLQL/Rzua8qyr1i8FYLKeX7+R+D1amwYQH/ASQN8BU
 r6mOz/4AETwWIvwDyVWXQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:f3eMi+j0t64=:R6dBYN2lwQQR5s+1+UP1Ea
 nyItem9cvZBvtYorabJRsGu38HZg9fBRLeqVxSAlK3Xo2gBYvzMIHzVACNtCgHyaL5TXXZ+kr
 Ua9vCHyjIspwnEv73zL3ru3BF27PHMdbCDY1314oGIyOGzmTBJkyhiWgVipE9lUnYHzPoZhZD
 w6lMe50sISHo+gcu8bDzi+1u6upSonf2EuQjWOp5W+uVhja5kzSEuYd0rNyNZoeuIV3/3tOv5
 lSyhJ8VY8vue7PvdMeyl1iLZ6gf884GD6spI535QGi7pJ8vPJJ2F/q1ICuUiwC6Fg2jk66a3I
 Q3OBeJGRppqlkHEq6n+x38OzXt68MCTd7HAGaERBZsXDcghfmKRemkjPApZIEfU4HhzHbQQOH
 GVRDve10Ic6YvOLmosCXP7rHW/rIXGXBbIGGB8wnP8j7kqzX1KJgNH6RyT7ZjxF6JpeVJbZ7h
 6q/bFshYjLO9/nydTvVDxho5IaE6zhUMcA/s2WniX8yZaLDatIdliXI3+Amy4W/1wLqHYBIb+
 eYpl94BrJ+06458luxnVMyfszun91D05c3ybob/PqpQZiWaEynFCBFvfg5GMl+zOErRtdQpV2
 Totu7TfRmbXCMGKpLVoR2Vj1NZb/aTOZ5znqf/SMEtrCNe7eN4H7cDLxWq/ERLsAApb41dO/L
 JsdXWFZiaLNZM/zLp8UsRsfHvZ1ze42F3mscKZYLop4VX0wfL48Oul5qcKIP+ZNR6ICxiDzAH
 k2gKi1WkUn2qYMBsZHAORjT0h7wbiyBt52tKqDe4ucadeZQ875SIBoKUgDP8V7DH6RY2X3gAv
 sbBVO7z
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 16 Jul 2018 17:43:49 +0200

The variables “fname2” till “fname6” do not care for different function
parameters in the disjunction at the end of a rule in a script
for the semantic patch language.
Thus reduce this disjunction by using a regular expression with
an alternation for an optimised constraint.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 scripts/coccinelle/api/atomic_as_refcounter.cocci | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/scripts/coccinelle/api/atomic_as_refcounter.cocci b/scripts/coccinelle/api/atomic_as_refcounter.cocci
index 46d27b2b1dff..4da83ccfa6f6 100644
--- a/scripts/coccinelle/api/atomic_as_refcounter.cocci
+++ b/scripts/coccinelle/api/atomic_as_refcounter.cocci
@@ -13,12 +13,7 @@ virtual report
 identifier a, x;
 position p1, p2;
 identifier fname =~ "free";
-identifier fname2 =~ ".*destroy.*";
-identifier fname3 =~ ".*del.*";
-identifier fname4 =~ ".*queue_work.*";
-identifier fname5 =~ ".*schedule_work.*";
-identifier fname6 =~ ".*call_rcu.*";
-
+identifier fname2 =~ "(?:call_rcu|de(?:l|stroy)|(?:queue|schedule)_work)";
 @@
 
 (
@@ -39,14 +34,6 @@ identifier fname6 =~ ".*call_rcu.*";
  fname@p2(a, ...);
 |
  fname2@p2(...);
-|
- fname3@p2(...);
-|
- fname4@p2(...);
-|
- fname5@p2(...);
-|
- fname6@p2(...);
 )
 
 
-- 
2.18.0

