Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932839AbeBVOON (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 09:14:13 -0500
Received: from lhrrgout.huawei.com ([194.213.3.17]:27178 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932604AbeBVOOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 09:14:12 -0500
From: Igor Stoppa <igor.stoppa@huawei.com>
To: <mhocko@kernel.org>
CC: <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Igor Stoppa <igor.stoppa@huawei.com>
Subject: [Question PATCH 0/1] mm: crash in vmalloc_to_page - misuse or bug?
Date: Thu, 22 Feb 2018 16:13:23 +0200
Message-ID: <20180222141324.5696-1-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While trying to change the code of find_vm_area, I got an automated
notification that my code was breaking the testing of i386, based on the
0-day testing automation from 01.org

I started investigating the issue and noticed that it seems to be
reproducible also on top of plain 4.16-rc2, without any of my patches.

I'm still not 100% sure that I'm doing something sane, but I thought it
might be good to share the finding.

The patch contains both a minimal change, to trigger the crash, and a
snippet of the log of the crash i get.

Igor Stoppa (1):
  crash vmalloc_to_page()

 mm/vmalloc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.14.1
