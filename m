Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754642AbeDTLIE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 07:08:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39964 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754549AbeDTLID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 07:08:03 -0400
Subject: Re: [gcov_module_notifier] WARNING: CPU: 0 PID: 155 at
 mm/slab_common.c:996 kmalloc_slab+0x1f/0x79
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Riku Voipio <riku.voipio@linaro.org>,
        Frantisek Hrbata <fhrbata@redhat.com>,
        Masahiro Yamada <yamada.m@jp.panasonic.com>,
        linux-kernel@vger.kernel.org, lkp@01.org
References: <20180419025854.uasnqkaflr45zeat@wfg-t540p.sh.intel.com>
From: Peter Oberparleiter <oberpar@linux.ibm.com>
Date: Fri, 20 Apr 2018 13:08:07 +0200
MIME-Version: 1.0
In-Reply-To: <20180419025854.uasnqkaflr45zeat@wfg-t540p.sh.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18042011-0040-0000-0000-0000044FAC61
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042011-0041-0000-0000-000020F40815
Message-Id: <4e2d71d1-e945-e2c3-cf8f-e19df52df6f5@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-20_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804200108
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.04.2018 04:58, Fengguang Wu wrote:
> FYI this happens in mainline kernel 4.17.0-rc1.
> It at least dates back to v4.5 .

This is likely the result of compiling the kernel with GCC 7 while
specifying that gcov-kernel should expect GCC <= 3.4 format data:

dmesg:
> (gcc version 7.3.0 (Debian 7.3.0-1)) #31 Mon Apr 16 23:17:50 CST 2018

.config:
> # CONFIG_GCOV_FORMAT_AUTODETECT is not set
> CONFIG_GCOV_FORMAT_3_4=y
> # CONFIG_GCOV_FORMAT_4_7 is not set

As such, it is an expected test failure. Assuming that this is a
randconfig test, my recommendation would be to blacklist
"CONFIG_GCOV_FORMAT_3_4=y" when using GCC >3.4.

-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany
