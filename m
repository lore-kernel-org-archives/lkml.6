Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE54C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E5B2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfAVKBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:01:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56540 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727991AbfAVKBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:01:08 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0M9x3Bu086592
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 05:01:07 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q60p691n4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 05:01:06 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <joeln@il.ibm.com>;
        Tue, 22 Jan 2019 10:01:03 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 22 Jan 2019 10:01:01 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0MA0xZA59637954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Jan 2019 10:00:59 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBBAD11C05B;
        Tue, 22 Jan 2019 10:00:59 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 268D911C066;
        Tue, 22 Jan 2019 10:00:58 +0000 (GMT)
Received: from tal (unknown [9.148.32.96])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 22 Jan 2019 10:00:58 +0000 (GMT)
Received: by tal (sSMTP sendmail emulation); Tue, 22 Jan 2019 12:00:57 +0200
From:   Joel Nider <joeln@il.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Joel Nider <joeln@il.ibm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] docs-rst: driver-api: Add infiniband interface documentation
Date:   Tue, 22 Jan 2019 12:00:34 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548151235-386-1-git-send-email-joeln@il.ibm.com>
References: <1548151235-386-1-git-send-email-joeln@il.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19012210-0020-0000-0000-00000309B942
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012210-0021-0000-0000-0000215AED54
Message-Id: <1548151235-386-3-git-send-email-joeln@il.ibm.com>
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-22_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901220081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A short document regarding the user verbs interface implementation on
the kernel side. Also, the corresponding index entry in the
documentation tree.

Signed-off-by: Joel Nider <joeln@il.ibm.com>
---
 Documentation/driver-api/index.rst      |  1 +
 Documentation/driver-api/infiniband.rst | 73 +++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)
 create mode 100644 Documentation/driver-api/infiniband.rst

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index ab38ced..ecb3f8a5 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -28,6 +28,7 @@ available subsections can be seen below.
    regulator
    iio/index
    input
+   infiniband
    usb/index
    firewire
    pci/index
diff --git a/Documentation/driver-api/infiniband.rst b/Documentation/driver-api/infiniband.rst
new file mode 100644
index 0000000..2de47ff
--- /dev/null
+++ b/Documentation/driver-api/infiniband.rst
@@ -0,0 +1,73 @@
+==========================
+Infiniband Interface Guide
+==========================
+
+This guide is for people who wish to understand the implementation details of
+handler functions in the Infiniband subsystem. There are currently two system
+calls for executing Infiniband commands: write() and ioctl(). Older commands
+are sent to the kernel via write()s on the device files described in
+:doc:`../userspace-api/rdma_user_verbs`. New commands must use the ioctl()
+method. For completeness, both mechanisms are described here.
+
+The interface between userspace and kernel is kept in sync by checking the
+version number. In the kernel, it is defined by IB_USER_VERBS_ABI_VERSION
+(in include/uapi/rdma/ib_user_verbs.h).
+
+Write system call
+-----------------
+The entry point to the kernel is the ib_uverbs_write() function, which is
+invoked as a response to the 'write' system call. The requested function is
+looked up from an array called uverbs_cmd_table which contains function pointers
+to the various command handlers.
+
+Write Command Handlers
+~~~~~~~~~~~~~~~~~~~~~~
+These command handler functions are declared
+with the IB_VERBS_DECLARE_CMD macro in drivers/infiniband/core/uverbs.h. There
+are also extended commands, which are kept in a similar manner in the
+uverbs_ex_cmd_table. The extended commands use 64-bit values in the command
+header, as opposed to the 32-bit values used in the regular command table.
+
+Ioctl system call
+-----------------
+The entry point for the 'ioctl' system call is the ib_uverbs_ioctl() function.
+Unlike write(), ioctl() accepts a 'cmd' parameter, which must have the value
+defined by RDMA_VERBS_IOCTL. More documentation regarding the ioctl numbering
+scheme can be found in: Documentation/ioctl/ioctl-number.txt. The
+command-specific information is passed as a pointer in the 'arg' parameter,
+which is cast as a 'struct ib_uverbs_ioctl_hdr*'.
+
+The way command handler functions (methods) are looked up is more complicated
+than the array index used for write(). Here, the ib_uverbs_cmd_verbs() function
+uses a radix tree to search for the correct command handler. If the lookup
+succeeds, the method is invoked by ib_uverbs_run_method().
+
+Ioctl Command Handlers
+~~~~~~~~~~~~~~~~~~~~~~
+Command handlers (also known as 'methods') for ioctl are declared with the
+UVERBS_HANDLER macro. The handler is registered for use by the
+DECLARE_UVERBS_NAMED_METHOD macro, which binds the name of the handler with its
+attributes. By convention, the methods are implemented in files named with the
+prefix 'uverbs_std_types_'.
+
+Each method can accept a set of parameters called attributes. There are 6
+types of attributes: idr, fd, pointer, enum, const and flags. The idr attribute
+declares an indirect (translated) handle for the method, and
+specifies the object that the method will act upon. The first attribute should
+be a handle to the uobj (ib_uobject) which contains private data. There may be
+0 or more
+additional attributes, including other handles. The 'pointer' attribute must be
+specified as 'in' or 'out', depending on if it is an input from userspace, or
+meant to return a value to userspace.
+
+The method also needs to be bound to an object, which is done with the
+DECLARE_UVERBS_NAMED_OBJECT macro. This macro takes a variable
+number of methods and stores them in an array attached to the object.
+
+Objects are declared using DECLARE_UVERBS_NAMED_OBJECT macro. Most of the
+objects (including pd, mw, cq, etc.) are defined in uverbs_std_types.c,
+and the remaining objects are declared in files that are prefixed with the
+name 'uverbs_std_types_'.
+
+Objects trees are declared using the DECLARE_UVERBS_OBJECT_TREE macro. This
+combines all of the objects.
-- 
2.7.4

