Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CAFC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 15:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 232DC2080C
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 15:56:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 232DC2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeKSCQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 21:16:56 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:52387 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbeKSCQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 21:16:56 -0500
Received: from oxbaltgw36.schlund.de ([172.19.246.44]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M5gAG-1gMlX80TF4-007HPV; Sun, 18 Nov 2018 16:55:52 +0100
Date:   Sun, 18 Nov 2018 16:55:49 +0100 (CET)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-rpi-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        eric@anholt.net, linux-arm-kernel@lists.infradead.org,
        dave.stevenson@raspberrypi.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Message-ID: <1128999886.40745.1542556549581@email.ionos.de>
In-Reply-To: <20181114125942.25163-1-nsaenzjulienne@suse.de>
References: <20181114125942.25163-1-nsaenzjulienne@suse.de>
Subject: Re: [PATCH 00/16] staging: vchiq: dead code removal & misc fixes
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev46
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:4gObjkx3senqIRmVYoaGbltcKyCRouLZ9IwytRhjIYo47vFRyHr
 LpSiezXiJ0xX+gJg363bf5Hj+EAFX5WkADTCNZSN9p4O7zc5Bsv8YuqxDjphgNJ8SBEKTIf
 3BZcj9eVtozCisCsFV0G5ZLHp/zj1Kx3ItqJNNigDkcsGTSiOY+BsufrPrg2sJq2SZMBvla
 KncPs/u3Y48kvwcD19rYQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:873Hfy5wguQ=:1o+tPZxcnxpvyrq8XpyUzQ
 s2a80v1VqAKXwDeSnkVU51Nve1DucrnMZ+ehC4DRGaud0GHh02V+AABgTKuSfesNVqOjKJy92
 krBZAGBn+WJP4NtDZdJMvzT572DXGoh8X2BFoCgqxAgDqka36tZg2ZYunu+fLYZvKe1Dck2U2
 YhTAMpd8GB4esd20KXZNBVe3NaiynMAc4PXtCrYq/gfotGnfpk5LlByWKQYyrV7+5wyuQj2hF
 6MdiuI6/X1h4657/Vft6PxnL7hSsDmz5t9FKm4rsK5t+6wwkMwrjlRVIydmdMoBS/lDttKFE4
 5iofJNEubjWfcdbXZ6pf1fOisAx7WaOTUi67QsjI3/e7qtKKytsqUQr1L7rUBCz3PKqzKvp81
 e9lLSxMCsS0Ijk2pz+Ik/RBpmISzHFdNsy1Yr3F3iIQJLVzE1qDRRbpW9bcJNrQJ1ujH6+LBJ
 UkrPHsY6QUzSa2/+XopFVTTgGS/2ERpDoGLezyHf4Aovp45woWjSqKyTfI5n0hfW1UBvASSAI
 CRzWL0tal9XzgInurCO9RFMC0cJ9sU6qi6P4yLogF1nCmEb1GMkMMuqjpSpHtQLq6Lk9YL2fu
 YTr25Ivwj1jm9soEo5mGXHYekrJkVYS2a1brnXvmQIObApbJn83WdqMPzRujIoeevmvUmeYpa
 qGiosCgeC8cvxjIEMBQ1PmwdxHIGilsV2LHAnJif4giIDLAnNCs3TzqmHIiaR6ZcyMCRHfc4E
 KMyDngWXzQOAm55vK50kNOX9pTu66hS2Vpm0Sq8qfztwGHG1RC+kJmOxop6oBSOb70owT7ggj
 R3znRw50ghGnGnf7JWCma4cH+wLDS21oCPH/4qM3xLni0rQzq0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

> Nicolas Saenz Julienne <nsaenzjulienne@suse.de> hat am 14. November 2018 um 13:59 geschrieben:
> 
> 
> Hi All,
> 
> This series was written in parallel with reading and understanding the
> vchiq code. So excuse me for the lack of logic in the sequence of
> patches.
> 
> The main focus was to delete as much code as possible, I've counted
> around 550 lines, which is not bad. Apart from that there are some
> patches enforcing proper kernel APIs usage.
> 
> The only patch that really changes code is the
> vchiq_ioc_copy_element_data() rewrite.
> 
> The last commit updates the TODO list with some of my observations, I
> realise some of the might be a little opinionated. If anything it's
> going to force a discussion on the topic, which is nice.
> 
> It was developed on top of the latest linux-next, and was tested on a
> RPIv3B+ with audio, video and running vchiq_test.
> 
> Regards,
> Nicolas
> 

without a changelog i won't start a review.

Regards
Stefan
