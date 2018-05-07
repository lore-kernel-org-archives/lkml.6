Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752527AbeEGJjB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 05:39:01 -0400
Received: from osg.samsung.com ([64.30.133.232]:53118 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752466AbeEGJgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 05:36:07 -0400
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Jeff Layton <jlayton@redhat.com>, Randy Dunlap <rdunlap@infradead.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "Tobin C. Harding" <me@tobin.cc>, SeongJae Park <sj38.park@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Helmut Grohne <h.grohne@intenta.de>
Subject: [PATCH 05/18] docs: core-api: add cachetlb documentation
Date: Mon,  7 May 2018 06:35:41 -0300
Message-Id: <07b59879d34502828467f0190f941e23e08fdc81.1525684985.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1525684985.git.mchehab+samsung@kernel.org>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1525684985.git.mchehab+samsung@kernel.org>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cachetlb.txt is already in ReST format. So, move it to the
core-api guide, where it belongs.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/00-INDEX                                | 2 --
 Documentation/{cachetlb.txt => core-api/cachetlb.rst} | 0
 Documentation/core-api/index.rst                      | 1 +
 Documentation/memory-barriers.txt                     | 2 +-
 Documentation/translations/ko_KR/memory-barriers.txt  | 2 +-
 5 files changed, 3 insertions(+), 4 deletions(-)
 rename Documentation/{cachetlb.txt => core-api/cachetlb.rst} (100%)

diff --git a/Documentation/00-INDEX b/Documentation/00-INDEX
index 53699c79ee54..04074059bcdc 100644
--- a/Documentation/00-INDEX
+++ b/Documentation/00-INDEX
@@ -76,8 +76,6 @@ bus-devices/
 	- directory with info on TI GPMC (General Purpose Memory Controller)
 bus-virt-phys-mapping.txt
 	- how to access I/O mapped memory from within device drivers.
-cachetlb.txt
-	- describes the cache/TLB flushing interfaces Linux uses.
 cdrom/
 	- directory with information on the CD-ROM drivers that Linux has.
 cgroup-v1/
diff --git a/Documentation/cachetlb.txt b/Documentation/core-api/cachetlb.rst
similarity index 100%
rename from Documentation/cachetlb.txt
rename to Documentation/core-api/cachetlb.rst
diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index c670a8031786..d4d71ee564ae 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -14,6 +14,7 @@ Core utilities
    kernel-api
    assoc_array
    atomic_ops
+   cachetlb
    refcount-vs-atomic
    cpu_hotplug
    idr
diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 6dafc8085acc..983249906fc6 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -2903,7 +2903,7 @@ is discarded from the CPU's cache and reloaded.  To deal with this, the
 appropriate part of the kernel must invalidate the overlapping bits of the
 cache on each CPU.
 
-See Documentation/cachetlb.txt for more information on cache management.
+See Documentation/core-api/cachetlb.rst for more information on cache management.
 
 
 CACHE COHERENCY VS MMIO
diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
index 0a0930ab4156..081937577c1a 100644
--- a/Documentation/translations/ko_KR/memory-barriers.txt
+++ b/Documentation/translations/ko_KR/memory-barriers.txt
@@ -2846,7 +2846,7 @@ CPU 의 캐시에서 RAM 으로 쓰여지는 더티 캐시 라인에 의해 덮
 문제를 해결하기 위해선, 커널의 적절한 부분에서 각 CPU 의 캐시 안의 문제가 되는
 비트들을 무효화 시켜야 합니다.
 
-캐시 관리에 대한 더 많은 정보를 위해선 Documentation/cachetlb.txt 를
+캐시 관리에 대한 더 많은 정보를 위해선 Documentation/core-api/cachetlb.rst 를
 참고하세요.
 
 
-- 
2.17.0
