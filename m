Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753808AbeEaEk0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 00:40:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48974 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751053AbeEaEkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 00:40:25 -0400
Date: Thu, 31 May 2018 10:10:12 +0530
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: stewart@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com,
        ego@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: Re: [PATCH] [SCHEME 1] Add support for new idle device tree format
References: <1527735184-24465-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527735184-24465-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170306 (1.8.0)
X-TM-AS-GCONF: 00
x-cbid: 18053104-4275-0000-0000-000002881B37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18053104-4276-0000-0000-0000378F1C8D
Message-Id: <20180531044003.2zpkgzhsxyph3tdc@aksadiga.ibm>
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

On Thu, May 31, 2018 at 08:23:04AM +0530, Akshay Adiga wrote:
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
>        power-mgt {
>             ...
>         ibm,enabled-stop-levels = <0xec000000>;
>         ibm,cpu-idle-state-psscr-mask = <0x0 0x3003ff 0x0 0x3003ff>;
>         ibm,cpu-idle-state-latencies-ns = <0x3e8 0x7d0>;
>         ibm,cpu-idle-state-psscr = <0x0 0x330 0x0 0x300330>;
>         ibm,cpu-idle-state-flags = <0x100000 0x101000>;
>         ibm,cpu-idle-state-residency-ns = <0x2710 0x4e20>;
>         ibm,idle-states {
>                 phandle = <0xff>;
>                     stop4 {
>                         flags = <0x207000>;
>                         compatible = "ibm,cpuidle-state-v1";
>                         psscr-mask = <0x0 0x3003ff>;
>                         handle = <0x102>;
>                         latency-ns = <0x186a0>;
>                         residency-ns = <0x989680>;
>                         psscr = <0x0 0x300374>;
>                  };
> 
>                     ...
>                     stop11 {
>                         ...
>                         compatible = "ibm,cpuoffline-state-v1";
>                         ...
> 
>            };
>            };
> 
> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>

This is intended to be a RFC patch. 
The skiboot patch for the device tree is posted here :
https://patchwork.ozlabs.org/patch/923120/
