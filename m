Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143F7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1BCA222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394730AbfBNIgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:36:31 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:38699 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390579AbfBNIgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:36:31 -0500
Received: from orion.localdomain ([77.2.75.124]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mxpqo-1hI4Pr0XUM-00zCgu; Thu, 14 Feb 2019 09:36:29 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Subject: gpio-keys-polled enhancements v2
Date:   Thu, 14 Feb 2019 09:36:17 +0100
Message-Id: <1550133379-1793-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:dI5ojCDffsqITVbSxrJsa4CNjtR5OqREKF4s6SeRXZtoyEWvX5Q
 4iTEQ+K4XvG4b4hUMsXyrHPVsTBFyFTCuyb76KfEKUJcsk11xpDJ+ihqTjWbls67dcCScZM
 WOP4Dg0H5ZHbjO4rTwbbuPV1ByhPQwr+76EX8RZKKCUVCBpkZdC2tDSqn0Nyr8noCG1YV0Y
 PiAG7tU/qFBulQS5S1tHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7kFhVpj8ej8=:KTvvnKnJi2udG6bi0bKjbz
 ZDyeNKRnlnATh2U2Tb9LGabBeZpfoRw5VlyUOc8huburCaI42BBLYXvsziSBaMvGdtenz1uSJ
 m5w/4fntRldd/bNwxmVJj1H+pWcMX6Iwyqd3+yUlhENTm9vhqmNjz1ULHMZFifisNEKM/AL7B
 caeaev4vpDI4nMno9PDh5YA0QR7ocEN/W6/9vQA++QAedWLFbNExugnStbfRlJjNT2FRdLb9k
 +N+n97+e1poWein+ZBaYvsNAuxQuIjKX27SdZPxdZeFpnUQOXhQw+hanFVET3hXFgQUoJdKmS
 aRZtct+irsUvhFSb/g2yjZntFSSOGwyZ3wJrblHDYd0fy0PLVosjBi/Twco3ypGdfKu9mg9MG
 O0o3PtvhB9sfuC08DktaxAXQ+aaerArjMByMShahAcTl06jkIBbR4b4h/EeYfW+E4s5F8Njnf
 Dy/tRX4eIkI3nW9FdTSwdm9qAfVBvw2GswM5Klo+ZvqTJPwoYfSHxeyFkytk/wzd8O2VQA/AG
 PivLaoPAurJ6UMcLn9utbancxhN4a5fCGDAlGDHQJxskwsPF3joLC2Y0Wq6+bZqZTEVhjcDvS
 ZWKel0jSWp+98B8zwtsXUnEfN8QVoZbrOVihoDxpnTNRVgk7gPA6XG9wPi+0hzRzcuKUXwrhG
 bA8ju5mPsFRnLPNH4uarULQL1++qTjnbjXrnMS5P4+amVDnRBagCm56qLJIIWQVJUyBac+5fU
 550EjD8UBwtgeAnZmfysAeEDsr97eQdhfpUEmQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,


here's v2 of my gpio-keys-polled enhancements queue.

I'm using this to allow it to be initialized by some other platform
driver (in my case for the APUv2 board), when no proper fw data
(oftree or acpi) is available.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
