Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51E6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819FB21B1C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390621AbfBNWFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 17:05:17 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:45919 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729777AbfBNWFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 17:05:16 -0500
Received: from orion.localdomain ([77.2.75.124]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MWRe1-1ganoj0H99-00XwIP; Thu, 14 Feb 2019 23:05:10 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, andy@infradead.org,
        platform-driver-x86@vger.kernel.org
Subject: APUv2/v3 board support V3
Date:   Thu, 14 Feb 2019 23:04:55 +0100
Message-Id: <1550181897-2596-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550091448-28578-1-git-send-email-info@metux.net>
References: <1550091448-28578-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:uEYITvtrWk26ASRajXMLh6ZMXpJZbY6TW9YIuqTReCkPF78J9lq
 rjFOnO17uDF/3w4gCtkFbRd9sGjMUXojyKXEreYx5LsU3HMfnqjC7wda7nHPkFDW2al+FNS
 ealv4+jDtueq+F2Z+/b5GqNqxCBgboRulhx5K6iIgta0TVhQxUa+PTAqPGHdh+luOYGMkZi
 g4lGVswtvvZ2JFIlqFLeA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8FrKnDbsVpw=:njrrZvEJswGJc5dQaee1SW
 l7QTmhEPaGjtQvopUk7bP8rOkURbx3Rj6A/hABk2hxVMMeVyhyQKRFzK/I3I+5fzgnmORfi6q
 VAD4V324DdRJYLpzdgNC0PTgHiRDEUEkh1LNoKJI1bQZwSK411pw2NYu5Ck6A8rIC6Ey8dfYz
 JnWdUeCGSlywnLyloi+JLPIExSqub1PxuLGu7ZI0OJ/tVUUOIKrJ9UBWCrImJ6DNuC6ka2owP
 Xj3mE4iMRWYfT4HaFfoLS1qoveKvy6wI2ZHcSjgUBgm4P4P8nK5Rt6smHVkLcua2ACVkSJdGs
 hnV0+0ZFi7RjUZnx821RFWItPLlHPNRvo+gQLN6mX7VspEHPnCct2mDiLVzd7B5WIwh+faVtU
 C3wQzN7c+CSmtXfVnwjqbXZILk5D/fARRIZ2Qoq2yXMIOWmL+lHjTEsXQwKRyVMCih4o4TXzZ
 R54s0hbAm2tVyF788CSz7RS7kNDcFLgd2Sw7F0x/grQyloNutWRMn0jkhQE8+Fk0C1m+jEJsI
 9BkJUEftN+lamsE9ACht1h3apa1Y9Px46O4zSEUO2KfsDFTOjIcoAuo4gfV6sKDn5IyHM8BcM
 sVf5ExK3UPvwT/A/cCkOgj9uzpghSBeGAYlsfV/TGK+Cy8dP8ClE/EU/tj7vQXcqH9BcS44ss
 PRHOE/nsn7VFEHHzBE8feGMUV/SCYsMlQlz1aLVwk7S/wG6wvJr3L45Zk1JOmnqMfZe100DRR
 e/LcI0AbuYpTDgjRV40ilFd+1H7Wt7scHO27LQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,


this is version 3 of my APUv2/APUv3 series.

change in V3:

 * gpio driver
   * drop unncessary gpio id checks
   * cleanup amd_fch_gpio_set()
   * move iores outside probe()
   * shorter NULL checks and correct error in probe()
 * apu board driver
   * drop unneeded init.h
   * drop unnecessary comments
   * clean up logging
   * dont need to depend on KEYBOARD_GPIO


--mtx
