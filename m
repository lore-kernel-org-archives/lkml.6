Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752109AbeBZPsV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 10:48:21 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:38590 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751706AbeBZPsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 10:48:19 -0500
X-Google-Smtp-Source: AG47ELvBu/0Ypyqerw1G2lSDDeZE0+DLOcKNR5BzZ7L1Hst64fk4TZtila0+zAB42AcrWfXKiWPNqQ==
From: Ilya Smith <blackzert@gmail.com>
To: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Ilya Smith <blackzert@gmail.com>
Subject: [PATCH 0/1] Additional strict check on ELF file.
Date: Mon, 26 Feb 2018 18:46:58 +0300
Message-Id: <20180226154659.10218-1-blackzert@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, this patch implements strict check on segments order in ELF file.
Current implementation doesn't check the order of ELF segments and compute
totalsize as difference between last one and the first one. If ELF file
has wrong order it allows to re-mmap existing memory region with one
from ELF file.

Ilya Smith (1):
  Additional strict check on ELF file. Checks segments are followed in
    order of 'p_vaddr ' value ascending. It fixes erorr in
    total_mapping_size with computation total size. This error happens
    if segments in ELF file are not in order.

 fs/binfmt_elf.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

-- 
2.14.1
