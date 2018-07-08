Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138B5C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 14:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4ED5208CA
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 14:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4ED5208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754171AbeGHOov convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 10:44:51 -0400
Received: from mout.gmx.net ([212.227.15.18]:54863 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752829AbeGHOou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 10:44:50 -0400
Received: from homer.simpson.net ([185.191.217.104]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MZTbR-1fOER23qdZ-00LI4M; Sun, 08
 Jul 2018 16:44:10 +0200
Message-ID: <1531061044.4665.52.camel@gmx.de>
Subject: Re: [PATCH 1/7] mm: allocate mm_cpumask dynamically based on
 nr_cpu_ids
From:   Mike Galbraith <efault@gmx.de>
To:     Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, luto@kernel.org, dave.hansen@linux.intel.com,
        mingo@kernel.org, kernel-team@fb.com, tglx@linutronix.de,
        songliubraving@fb.com, hpa@zytor.com
Date:   Sun, 08 Jul 2018 16:44:04 +0200
In-Reply-To: <1531059232.4665.38.camel@gmx.de>
References: <20180706215658.18018-1-riel@surriel.com>
         <20180706215658.18018-2-riel@surriel.com>
         <1530951813.22672.10.camel@gmx.de> <1530998709.5350.32.camel@surriel.com>
         <1531059232.4665.38.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:dp9/AjJ7Pd1kylMtp3veMLZFqod/hjyaAn1OPsXxSmU3IbrHP1U
 T8l9At5SmQnQ2vyMcEMyR0c/5OX/6PgpFi6ZT5rdvA/7MddYAoiey9v6RQ/9tTCEXia6hMD
 cCuF615hci4LE/26y97wNfeSgFnFS49Rm1RoxyxIvBm7IjDnzvOW1oytY0o11vNO61NczQF
 mmEJmVXT8B87j04+TZiYQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:d/3l5eXCqrs=:47VGJP2ya5fdjv/5SLeOZz
 qMbcE2vi/lvlk/5uE3GpnFwWSNr+0Ftsccf7ZlWEDnhe2xqWRw/ZjCWAi8xepAowuTlr9y3fV
 j+3TIPO0PBtZhsbl1Exc4OodDix8zzq9PF/IupLWsboSkiCGwd9ubCJxyzqfbnmxG8H5s+yc1
 M6FJXfddZdZ4DUDYpR5//9RYVMKr7uYmxp3ke331vucIOgZzCB5f94eU77b81viOT+6tYS9f4
 ZpDUisa2/LvfD3I6yJ4f0bJ0xQ2CTOP33ZBiTSK0gsu2uuy4WHn4wCaISB78YrxbGcFEXLAvI
 oP4dnVD74EWbkomXO72VQUTAs7otU9qibjOsYzYGA+w40dhehUz9KinwZZMQdLnbHanVP1/JR
 6r+GeqC6zfno1JrrbPGi0nIAgF3HFS2w0Ty3qxfBWCZ5mCXxoUyi2W3mN+35dMJ7VF35GENLE
 iC3on9cHFaHx8equ0rWgAKWcuYeKcQn+DZp6jyrRM7648zFVkAkqyl7e9CXwR0fy0LFEZx6JH
 Dp2t0mor8lfJoQztuWWDlMWf/VJUKKFbShlirgSdprAyX3bsYAMWA9wMXVOUpKsSXOc+GFW2M
 IYh7lkbn7is3JF6tGBh5p0XbQ+9SX4YJGl6CLnEZpgS6tS1OrYdzpS6jdx3qoQkvwyGmBo+KD
 PTxlS5tch1ZJXB2dbwfhUjDLklSzpw9yAMzZYC0soJeMBurhbaNnjEBwIANliNgSts3/VVzE6
 rsJsJFhl8MyOPwi4M5+FDwdSHs5B1hOnA7bez8sq/IeBioRLDPaFz3gsBHFiD3ZoQ7qRQTaPr
 mnB9+2h
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BTW, a second gripe ala the first, but wrt mm_init_cpumask(&efi_mm):

In function ‘bitmap_zero’,
    inlined from ‘cpumask_clear’ at ./include/linux/cpumask.h:378:2,
    inlined from ‘mm_init_cpumask’ at ./include/linux/mm_types.h:504:2,
    inlined from ‘efi_alloc_page_tables’ at arch/x86/platform/efi/efi_64.c:235:2:
./include/linux/bitmap.h:208:3: warning: ‘memset’ writing 64 bytes into a region of size 0 overflows the destination [-Wstringop-overflow=]
   memset(dst, 0, len);
   ^~~~~~~~~~~~~~~~~~~

