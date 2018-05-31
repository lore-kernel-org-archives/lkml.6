Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753761AbeEaElr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 00:41:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60806 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750903AbeEaElp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 00:41:45 -0400
Date: Thu, 31 May 2018 10:11:34 +0530
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: stewart@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com,
        ego@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: Re: [PATCH] [SCHEME 2]powernv/cpuidle: Add support for new idle
 state device-tree format
References: <1527735200-24653-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527735200-24653-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170306 (1.8.0)
X-TM-AS-GCONF: 00
x-cbid: 18053104-0008-0000-0000-000002423539
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18053104-0009-0000-0000-000021A7DEB6
Message-Id: <20180531044134.q752bdg5ichp34hm@aksadiga.ibm>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-31_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1805310051
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 08:23:20AM +0530, Akshay Adiga wrote:
> This patch adds support for new device-tree format for idle state
> description.
> 
> Previously if a older kernel runs on a newer firmware, it may enable
> all available states irrespective of its capability of handling it.
> New device tree format adds a compatible flag, so that only kernel
> which has the capability to handle the version of stop state will enable
> it.
> 
> Older kernel will still see stop0 and stop0_lite in older format and we
> will depricate it after some time.
> 
> Idea is to bump up the version in firmware if we find a bug or
> regression in stop states. A fix will be provided in linux which would
> now know about the bumped up version of stop states, where as kernel
> without fixes would ignore the states.
> 
> New idle state device tree format :
> 
>     power-mgt {
>         ibm,cpu-idle-state-names = "stop0_lite", "stop0";
>         ibm,cpu-idle-state-residency-ns = <0x2710 0x4e20>;
>         ibm,cpu-idle-state-latencies-ns = <0x3e8 0x7d0>;
>         ibm,cpu-idle-state-psscr-mask = <0x0 0x3003ff 0x0 0x3003ff>;
>         ibm,cpu-idle-state-psscr = <0x0 0x330 0x0 0x300330>;
>         ibm,cpu-idle-state-flags = <0x100000 0x101000>;
>         ibm,enabled-stop-levels = <0xec000000>;
>         ibm,idle-states {
>           ibm,cpu-idle-state-names = "stop1", "stop2", "stop4", "stop5";
>           ibm,cpu-idle-state-residency-ns = <0xc350 0x186a0 0x989680
>     0x1312d00>;
>           ibm,cpu-idle-state-latencies-ns = <0x1388 0x2710 0x186a0
>     0x30d40>;
>           ibm,cpu-idle-state-psscr-mask = <0x0 0x3003ff 0x0 0x3003ff 0x0
>     0x3003ff 0x0 0x3003ff>;
>           ibm,cpu-idle-state-psscr = <0x0 0x300331 0x0 0x300332 0x0
>     0x300374 0x0 0x300375>;
>           ibm,cpu-idle-state-versions = "ibm,idle-state-v1
>     ", "ibm,idle-state-v1", "ibm,idle-state-v1", "ibm,idle-state-v1";
>           ibm,cpu-idle-state-flags = <0x101000 0x101000 0x207000
> 0x207000>;
>        }
>      }
> 
> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
> ---

This patch is intended to be a RFC.
The skiboot patch has been posted here :
https://patchwork.ozlabs.org/patch/923121/
