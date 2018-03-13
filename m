Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
X-Google-Smtp-Source: AG47ELsu/w+FCzCLpX/HMqnRk64WsDtRgc3B75mKRsaeusuVSUrtQo2JBQM0dxMEbYFKAmup5bsG
ARC-Seal: i=1; a=rsa-sha256; t=1520945751; cv=none;
        d=google.com; s=arc-20160816;
        b=TLdx6xrns5KM0/uDz0TMGNFJqrWWyDvwqN+MAfSDSKPQV1W7qT6o4djAzg5B+KkpT5
         kMmpIVdToLlm7IKbhscOLjo0hToR8tdNr2etESvLvpCqonmdbO8+MILJ47MBIEIs4Tv0
         iW38Kt2xCB6exHijmxRiq6/rtTDku5WkCBROjDC/NOopLtit5wTlP+M3mBZMITd1G9vV
         +jw4RqApxYLXeQhoVkUu6rte5t/ygkCL0VUBN2zeMD2maLLG0Eh4LgGs4APu2HY+Dkm/
         yv/VHfskGKb8qd4Gx2X7XTcFwD4MYdmT8sfFgxUDNIjndHzthz12Qno9/93aXhgCBVYq
         nQ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:references:in-reply-to:date:subject:cc:to:from
         :arc-authentication-results;
        bh=0uryX3yqfID8k/gJvxPL1S1vocT4sejXhk351X/JsFQ=;
        b=xre10Dp26JXZbAGGLFGDKRcST3hoYa8mgfkAP/StwgU6B6xdL20JnlnlEfS8Kc/h/r
         gSf0xBsmlewdG3ZmyIcmfBtbhryvGKUXJPb1r66LHb9KYv4qKEVv/2xipKDX9uNpZSLC
         iAmwJaBIebeAjg4F7x0Lu43Ik6K55WI+PLVzMm3glS9zr9QwEQcBT3kpH76HUUlRLJlA
         Wl9lEZJgJ1jOVc9cx4LMdooMh4XkAHaiZlz+kCUNdtHoGbBpNW2IwSLg7qlxyERqLl49
         zlhvf6WxyvPduMPHuP89e+dPMxPLAMiuoRZDPsBxmeVHJEVOwF34aviKCs1ROAY7q5Io
         xq+w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of ravi.bangoria@linux.vnet.ibm.com) smtp.mailfrom=ravi.bangoria@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of ravi.bangoria@linux.vnet.ibm.com) smtp.mailfrom=ravi.bangoria@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
        srikar@linux.vnet.ibm.com
Cc: acme@kernel.org, ananth@linux.vnet.ibm.com, akpm@linux-foundation.org,
        alexander.shishkin@linux.intel.com, alexis.berlemont@gmail.com,
        corbet@lwn.net, dan.j.williams@intel.com, gregkh@linuxfoundation.org,
        huawei.libin@huawei.com, hughd@google.com, jack@suse.cz,
        jglisse@redhat.com, jolsa@redhat.com, kan.liang@intel.com,
        kirill.shutemov@linux.intel.com, kjlx@templeofstupid.com,
        kstewart@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        milian.wolff@kdab.com, mingo@redhat.com, namhyung@kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, pc@us.ibm.com, pombredanne@nexb.com,
        rostedt@goodmis.org, tglx@linutronix.de, tmricht@linux.vnet.ibm.com,
        willy@infradead.org, yao.jin@linux.intel.com, fengguang.wu@intel.com,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH 8/8] trace_uprobe/sdt: Document about reference counter
Date: Tue, 13 Mar 2018 18:26:03 +0530
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
References: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18031312-0040-0000-0000-0000041F00AA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031312-0041-0000-0000-000026222B91
Message-Id: <20180313125603.19819-9-ravi.bangoria@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803130154
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827212550255650?=
X-GMAIL-MSGID: =?utf-8?q?1594827212550255650?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

No functionality changes.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
 Documentation/trace/uprobetracer.txt | 16 +++++++++++++---
 kernel/trace/trace.c                 |  2 +-
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/trace/uprobetracer.txt b/Documentation/trace/uprobetracer.txt
index bf526a7c..8fb13b0 100644
--- a/Documentation/trace/uprobetracer.txt
+++ b/Documentation/trace/uprobetracer.txt
@@ -19,15 +19,25 @@ user to calculate the offset of the probepoint in the object.
 
 Synopsis of uprobe_tracer
 -------------------------
-  p[:[GRP/]EVENT] PATH:OFFSET [FETCHARGS] : Set a uprobe
-  r[:[GRP/]EVENT] PATH:OFFSET [FETCHARGS] : Set a return uprobe (uretprobe)
-  -:[GRP/]EVENT                           : Clear uprobe or uretprobe event
+  p[:[GRP/]EVENT] PATH:OFFSET[(REF_CTR_OFFSET)] [FETCHARGS]
+  r[:[GRP/]EVENT] PATH:OFFSET[(REF_CTR_OFFSET)] [FETCHARGS]
+  -:[GRP/]EVENT
+
+  p : Set a uprobe
+  r : Set a return uprobe (uretprobe)
+  - : Clear uprobe or uretprobe event
 
   GRP           : Group name. If omitted, "uprobes" is the default value.
   EVENT         : Event name. If omitted, the event name is generated based
                   on PATH+OFFSET.
   PATH          : Path to an executable or a library.
   OFFSET        : Offset where the probe is inserted.
+  REF_CTR_OFFSET: Reference counter offset. Optional field. Reference count
+                  gate the invocation of probe. If present, by default
+                  reference count is 0. Kernel needs to increment it before
+                  tracing the probe and decrement it when done. This is
+                  identical to semaphore in Userspace Statically Defined
+                  Tracepoints (USDT).
 
   FETCHARGS     : Arguments. Each probe can have up to 128 args.
    %REG         : Fetch register REG
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 20a2300..2104d03 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4604,7 +4604,7 @@ static int tracing_trace_options_open(struct inode *inode, struct file *file)
   "place (kretprobe): [<module>:]<symbol>[+<offset>]|<memaddr>\n"
 #endif
 #ifdef CONFIG_UPROBE_EVENTS
-	"\t    place: <path>:<offset>\n"
+  "   place (uprobe): <path>:<offset>[(ref_ctr_offset)]\n"
 #endif
 	"\t     args: <name>=fetcharg[:type]\n"
 	"\t fetcharg: %<register>, @<address>, @<symbol>[+|-<offset>],\n"
-- 
1.8.3.1
