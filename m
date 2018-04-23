Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754804AbeDWKst (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 06:48:49 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43381 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754701AbeDWKse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 06:48:34 -0400
X-Google-Smtp-Source: AIpwx4/LtWfPSnxlKhsKpyaPBoYCJrCNYQS84Uh9TQugFYDbl9/+KF3WPU9C01CS2objaF+xB5uWIA==
From: Ahmed Abdelsalam <amsalam20@gmail.com>
To: pablo@netfilter.org, fw@strlen.de, davem@davemloft.net,
        dav.lebrun@gmail.com, linux-kernel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Cc: Ahmed Abdelsalam <amsalam20@gmail.com>
Subject: [iptables 2/2] extensions: libip6t_srh: add test-cases for matching previous, next and last SID
Date: Mon, 23 Apr 2018 05:48:23 -0500
Message-Id: <1524480503-1883-3-git-send-email-amsalam20@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1524480503-1883-1-git-send-email-amsalam20@gmail.com>
References: <1524480503-1883-1-git-send-email-amsalam20@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds some test-cases to "libip6t_srh.t" for matching previous SID,
next SID, and last SID.

Signed-off-by: Ahmed Abdelsalam <amsalam20@gmail.com>
---
 extensions/libip6t_srh.t | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/extensions/libip6t_srh.t b/extensions/libip6t_srh.t
index 08897d5..88a379e 100644
--- a/extensions/libip6t_srh.t
+++ b/extensions/libip6t_srh.t
@@ -23,4 +23,8 @@
 -m srh ! --srh-tag 0;=;OK
 -m srh --srh-next-hdr 17 --srh-segs-left-eq 1 --srh-last-entry-eq 4 --srh-tag 0;=;OK
 -m srh ! --srh-next-hdr 17 ! --srh-segs-left-eq 0 --srh-tag 0;=;OK
+-m srh --srh-psid A::2/64 --srh-nsid B2::/128 --srh-lsid C::/0;=;OK
+-m srh ! --srh-psid A::2/64 ! --srh-nsid B2::/128 ! --srh-lsid C::/0;=;OK
+-m srh --srh-psid A::2 --srh-nsid B2:: --srh-lsid C::;=;OK
+-m srh ! --srh-psid A::2 ! --srh-nsid B2:: ! --srh-lsid C::;=;OK
 -m srh;=;OK
-- 
2.1.4
