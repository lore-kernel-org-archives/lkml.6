Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F81C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C4A2081B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfBVJyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:54:36 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:51345 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfBVJyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 04:54:35 -0500
Received: from orion.localdomain ([77.7.125.227]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M7sQ8-1h0z9K3QNm-004zpY; Fri, 22 Feb 2019 10:54:28 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, dvhart@infradead.org,
        andy@infradead.org, platform-driver-x86@vger.kernel.org
Subject: APUv2/v3 board support v4
Date:   Fri, 22 Feb 2019 10:54:14 +0100
Message-Id: <1550829256-8831-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550181897-2596-1-git-send-email-info@metux.net>
References: <1550181897-2596-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:Jmk9RfY20f+q4Vs+/s4P/sRSW/nam8h39VoLtiDjvnMQafuY6hL
 Od7NewWo+SNIRZC1uO5Vh15GiEgGtz4EVYfq2df8D2G7v5UFXTz77Llb5Jic3r1oKHEcnPY
 otA8u1yZCRp0K65nrA7KAwbhQCE44FEfH3t1QjyGloppgvsjtovpdsdS1eb9LrrPVQPWxNs
 mdlCZnMFOHQS3h9tFqn6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:o4ae0zyLwuk=:lfgXZ53LOANOYxkJUVQ22K
 bd+siW7cm3+ZV0Kf2Gozau8atAv0OXFy6RjkWxdI9YdKjF1U7n9hDBYClUDGXg8GuNC32HaBS
 9ATS3NSMpoIrLjTLwMRhkfK3FSjhBVH2Ay5alqRzfghVBQUK5604We1hYAcQZlpUC53uQY6z1
 TcAdwO/uj7K+zXVyGv2JYxpuGg0TM3t+3qMJeQ6DsCBcrn7qYkIRkjNx/Qfbt7zaYSlkOhbdM
 ToPn84vvGI4/YIL+oUM9N2W7Y/ic4GcCM20n8oIOKwl/5x8Ygd7T++JDi8Gj4PLCsFl2Jd4ew
 l+GXTzq1xBpmpXoXJJeqiDI3oopf1FueilqxQUUWgG4rrTZUhCRrVFChaEY/swWd+lLofcLbC
 bcjKdxt7Yctzeugourwphczm6Cnr8OMzsoCtnFg8ypjCdEOFE/AVVkNX8Ft7vhhuB6gn9R39o
 eG+6QX+iioY2VDyvX51bTioSjFJJvC67AkiOk8W59SwW31USxy4JBbYkZe/NOrP3PvAM0g1Yj
 V68j7ZpttKZziqzlCNE29R1spkDcPXZClyUoivMdM1cd/s1fKhVbRBMs+kwCDlK0s5OAWjjtZ
 m70AUy7GQGPBrEfLSJTAUbhMY2ZCrXkK0WaaW40hAM6S4EdQmTI/b78K9yXvsA/OS+hGMzSjq
 HensHlqrVsbDf2OvcD9sV/2ODLrmYHmu8x2nZVw+MuP7kT6H/U1VuiN/vZ05h/6dI2XpyMe/B
 GJsAEnWVBq/wYYudCRMADFiJglRvDB8O37e7cQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,


this is version 4 of my APUv2/APUv3 series.

changes in v4:

 * fixed spinlocks (using own field instead of gc.bgpio_lock)
 * dropped superflous dependency on GPIO_GENERIC
 * initialize gc.base = -1
 * added Reviewed-By tags

changes in v3:

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

