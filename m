Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751466AbeEREjm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 00:39:42 -0400
Received: from ext-host0001.ascade.co.jp ([218.224.228.194]:61305 "EHLO
        ns.ascade.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750838AbeEREjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 00:39:40 -0400
Subject: [PATCH v2 6/7] Documentation, hugetlb: describe about
 charge_surplus_hugepages,
To: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, David Rientjes <rientjes@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Marc-Andre Lureau <marcandre.lureau@redhat.com>,
        Punit Agrawal <punit.agrawal@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org, tsukada@ascade.co.jp
References: <e863529b-7ce5-4fbe-8cff-581b5789a5f9@ascade.co.jp>
From: TSUKADA Koutaro <tsukada@ascade.co.jp>
Message-ID: <07466cce-ca82-9024-a04a-c17291e64f84@ascade.co.jp>
Date: Fri, 18 May 2018 13:39:21 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <e863529b-7ce5-4fbe-8cff-581b5789a5f9@ascade.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a description about charge_surplus_hugepages.

Signed-off-by: TSUKADA Koutaro <tsukada@ascade.co.jp>
---
 hugetlbpage.txt |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/vm/hugetlbpage.txt b/Documentation/vm/hugetlbpage.txt
index faf077d..af8d112 100644
--- a/Documentation/vm/hugetlbpage.txt
+++ b/Documentation/vm/hugetlbpage.txt
@@ -129,6 +129,11 @@ number of "surplus" huge pages from the kernel's normal page pool, when the
 persistent huge page pool is exhausted. As these surplus huge pages become
 unused, they are freed back to the kernel's normal page pool.

+/proc/sys/vm/charge_surplus_hugepages indicates to charge "surplus" huge pages
+obteined from the normal page pool to memory cgroup. If true, the amount to be
+overcommitted is limited within memory usage allowed by the memory cgroup to
+which the task belongs. The default value is false.
+
 When increasing the huge page pool size via nr_hugepages, any existing surplus
 pages will first be promoted to persistent huge pages.  Then, additional
 huge pages will be allocated, if necessary and if possible, to fulfill
@@ -169,6 +174,7 @@ Inside each of these directories, the same set of files will exist:
 	free_hugepages
 	resv_hugepages
 	surplus_hugepages
+	charge_surplus_hugepages

 which function as described above for the default huge page-sized case.

-- 
Tsukada
