Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA31C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 03:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160D320881
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 03:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 160D320881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933053AbeGJD3r (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 23:29:47 -0400
Received: from mout.gmx.net ([212.227.17.22]:39013 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754558AbeGJD3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 23:29:44 -0400
Received: from homer.simpson.net ([185.221.151.167]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MMoU7-1fj4aJ29CZ-008Xzb; Tue, 10
 Jul 2018 05:29:00 +0200
Message-ID: <1531193337.9619.8.camel@gmx.de>
Subject: Re: [PATCH 1/7] mm: allocate mm_cpumask dynamically based on
 nr_cpu_ids
From:   Mike Galbraith <efault@gmx.de>
To:     Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, luto@kernel.org, dave.hansen@linux.intel.com,
        mingo@kernel.org, kernel-team@fb.com, tglx@linutronix.de,
        songliubraving@fb.com, hpa@zytor.com
Date:   Tue, 10 Jul 2018 05:28:57 +0200
In-Reply-To: <1531172317.5350.33.camel@surriel.com>
References: <20180706215658.18018-1-riel@surriel.com>
         <20180706215658.18018-2-riel@surriel.com>
         <1530951813.22672.10.camel@gmx.de> <1530998709.5350.32.camel@surriel.com>
         <1531059232.4665.38.camel@gmx.de> <1531172317.5350.33.camel@surriel.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:CMKtyu/+5Iqg8vGnD40FHY6PB99TWawUOBVt5sXpiLn2EbUN5+H
 NdoguBCsUp5SE85NWQv0PTWX6QEQul9UVrTfG1uM/4B9CHbhIJHaDJHk2x31JIJ8h4+KWL7
 7XAjH2AWrqb98/2komzHZqpEcLEZ3oYXovaukT0pBXt5WxNNAGq+5HyaO93x3umzEH+wxQs
 lSqJTC3aqx3UmKy1ZmSRA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bODwEg8ymwU=:5VkRgUfTaYB46g62Bi6itC
 1SrR6dWk9PwpARxdcQAUha4eknh20r/Ihmgm1vpNw1Jj4lWVWc0rkdP78uimoHLrxGGJJkPmu
 fslUhaUlyhIUPi0FdA3YT6s5HxBcD3WJhG3MYoM6B5Ytk1AOj2Y5AvbGe81EE+PZWzHRD5Gui
 5N766E3jIvlnlVewcIszokqSAuJvRrYO9Rojr2TbBSmJwu1LnN70wrJTCuzeN/rUZhQ+Z3w6i
 ubrx9aW4J92UkrLJYjKNjX/NoZUTSxpK/dBS/T3Rx/ch4QWjxSwgFua2TJpXZtqPVoII4kLnI
 xBeqdsFuJSC2IVrak82adJTZ0hr72fGGF+p/ihBaxhIaQnBmXHLKwJb1FRkrO82VbbyK+z7nB
 EQaEJW7PiZIkIvpxbXHp9EkV4jxwa9lMqnStO5GcV74D9dw/QJM+WOAHVX4GYHID83lb6pceU
 2Vc2tq/zT49xj6MqGsLIqlm+bayHN22AlQRO8AOse4UzdrrLn68lYSqwfAe1P9G5/woKIMckd
 zTrVA35cdJ02RQWg2t/HJfcSF3+kPe8o5m/vK354/U6UFPA8tPGbuL/8JS6gy5S7xOelAyios
 n72sTYjQOi/M6llQMq7qasnVNwRFG/bPBAj/ImvB2MPBoOnoE3yJdhTEeEfL4TMci+r8Y+iri
 OOfKiT1b3MlT/yHXtHRYTtLYsDb7uDyVuVKbQHhw8LanDXzvDOGQVsLGbVAyqdph6yYrDs6Qg
 1U+sbAx8GUU3l87OAM01UTTI86KuYv6WJ+bmaA5uETY+wqj7ZlOeFVL3Ycp1F0aW/l8LSZLha
 wdzpdf6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-09 at 17:38 -0400, Rik van Riel wrote:
> 
> I added your code, and Signed-off-By in patch
> 1 for version 5 of the series.

No objection, but no need (like taking credit for fixing a typo:).
