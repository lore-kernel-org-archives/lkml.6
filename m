Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933042AbeCMRDx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 13:03:53 -0400
Received: from g4t3427.houston.hpe.com ([15.241.140.73]:34504 "EHLO
        g4t3427.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932303AbeCMRDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 13:03:50 -0400
From: Toshi Kani <toshi.kani@hpe.com>
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Cc: bp@alien8.de, luto@kernel.org, gratian.crisan@ni.com, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] x86/mm: vmalloc_fault fix for CONFIG_HUGETLBFS off
Date: Tue, 13 Mar 2018 11:03:45 -0600
Message-Id: <20180313170347.3829-1-toshi.kani@hpe.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gratian Crisan reported that vmalloc_fault() crashes when
CONFIG_HUGETLBFS is not set since the function inadvertently
uses pXn_huge(), which always return 0 in this case. [1]
ioremap() does not depend on CONFIG_HUGETLBFS.

Patch 01 fixes the issue in vmalloc_fault().
Patch 02 is a clean-up for vmalloc_fault().

[1] https://lkml.org/lkml/2018/3/8/1281

---
Toshi Kani (2):
 1/2 x86/mm: fix vmalloc_fault to use pXd_large
 2/2 x86/mm: remove pointless checks in vmalloc_fault

---
 arch/x86/mm/fault.c | 62 +++++++++++++++++------------------------------------
 1 file changed, 20 insertions(+), 42 deletions(-)
