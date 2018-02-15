Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967556AbeBOLMi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 06:12:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37694 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755378AbeBOLMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 06:12:36 -0500
Subject: Re: [PATCH v2 1/3] Kconfig : Remove HAS_IOMEM dependency for Graphics
 support
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Farhan Ali <alifm@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-fbdev@vger.kernel.org,
        geert@linux-m68k.org, stefan.kristiansson@saunalahti.fi,
        tomi.valkeinen@ti.com, schwidefsky@de.ibm.com,
        dri-devel@lists.freedesktop.org, Chen Liqin <liqin.linux@gmail.com>,
        Lennox Wu <lennox.wu@gmail.com>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        user-mode-linux-devel@lists.sourceforge.net
References: <cover.1517508744.git.alifm@linux.vnet.ibm.com>
 <CGME20180202080007epcas5p306896fe66e4bbf4bf5f8d91306a5d016@epcas5p3.samsung.com>
 <246f92c9-15dc-223f-59d9-b2f0756cdf5e@de.ibm.com>
 <1610039.4trOurtpys@amdc3058>
 <2324e2cc-ff55-4d57-2807-c7f72f9ea0ca@de.ibm.com>
Date: Thu, 15 Feb 2018 12:02:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <2324e2cc-ff55-4d57-2807-c7f72f9ea0ca@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18021511-0016-0000-0000-0000052304F0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021511-0017-0000-0000-0000285FD2A0
Message-Id: <b1a3933e-6a8f-bd24-3629-5da730398f32@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-15_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802150138
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An even simpler approach would be:

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index cbe1d978693a..35b7aba4b6a0 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -952,6 +952,10 @@ config S390_HYPFS_FS
 
 source "arch/s390/kvm/Kconfig"
 
+config DUMMY_CONSOLE
+       bool
+       default y
+
 config S390_GUEST
        def_bool y
        prompt "s390 support for virtio devices"
