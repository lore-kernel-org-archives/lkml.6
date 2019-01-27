Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91937C282C0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 04:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52DB621473
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 04:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfA0Ebj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 23:31:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35070 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726404AbfA0Ebj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 23:31:39 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0R4T5lV121326
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 23:31:37 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q95fhgaac-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 23:31:37 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <andrew.donnellan@au1.ibm.com>;
        Sun, 27 Jan 2019 04:31:35 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 27 Jan 2019 04:31:32 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0R4VVsC58982558
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 27 Jan 2019 04:31:31 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFE414C040;
        Sun, 27 Jan 2019 04:31:31 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24FD34C044;
        Sun, 27 Jan 2019 04:31:31 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 27 Jan 2019 04:31:31 +0000 (GMT)
Received: from [9.81.215.119] (unknown [9.81.215.119])
        (using TLSv1.2 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 57A8CA0190;
        Sun, 27 Jan 2019 15:31:29 +1100 (AEDT)
Subject: Re: [PATCH v2 1/5] drivers/accel: Introduce subsystem
To:     Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org
Cc:     linux-accelerators@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>, ogabbay@habana.ai,
        airlied@redhat.com, jglisse@redhat.com,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <20190125211335.65783-1-olof@lixom.net>
From:   Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date:   Sun, 27 Jan 2019 15:31:28 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190125211335.65783-1-olof@lixom.net>
Content-Language: en-AU
X-TM-AS-GCONF: 00
x-cbid: 19012704-0028-0000-0000-0000033EA29C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012704-0029-0000-0000-000023FBEB38
Message-Id: <e3fc7e58-4d7e-f8aa-b96c-e515deb0494e@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-27_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901270036
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+ linuxppc-dev, because cxl/ocxl are handled through powerpc - please 
cc on future versions of this series]

On 26/1/19 8:13 am, Olof Johansson wrote:
> We're starting to see more of these kind of devices, the current
> upcoming wave will likely be around machine learning and inference
> engines. A few drivers have been added to drivers/misc for this, but
> it's timely to make it into a separate group of drivers/subsystem, to
> make it easier to find them, and to encourage collaboration between
> contributors.
> 
> Over time, we expect to build shared frameworks that the drivers will
> make use of, but how that framework needs to look like to fill the needs
> is still unclear, and the best way to gain that knowledge is to give the
> disparate implementations a shared location.
> 
> There has been some controversy around expectations for userspace
> stacks being open. The clear preference is to see that happen, and any
> driver and platform stack that is delivered like that will be given
> preferential treatment, and at some point in the future it might
> become the requirement. Until then, the bare minimum we need is an
> open low-level userspace such that the driver and HW interfaces can be
> exercised if someone is modifying the driver, even if the full details
> of the workload are not always available.
> 
> Bootstrapping this with myself and Greg as maintainers (since the current
> drivers will be moving out of drivers/misc). Looking forward to expanding
> that group over time.
> 

[snip]

> +
> +Hardware offload accelerator subsystem
> +======================================
> +
> +This is a brief overview of the subsystem (grouping) of hardware
> +accelerators kept under drivers/accel
> +
> +Types of hardware supported
> +---------------------------
> +
> +  The general types of hardware supported are hardware devices that has
> +  general interactions of sending commands and buffers to the hardware,
> +  returning completions and possible filled buffers back, together
> +  with the usual driver pieces around hardware control, setup, error
> +  handling, etc.
> +
> +  Drivers that fit into other subsystems are expected to be merged
> +  there, and use the appropriate userspace interfaces of said functional
> +  areas. We don't expect to see drivers for network, storage, graphics
> +  and similar hardware implemented by drivers here.
> +
> +Expectations for contributions
> +------------------------------
> +
> + - Platforms and hardware that has fully open stacks, from Firmware to
> +   Userspace, are always going to be given preferential treatment. These
> +   platforms give the best insight for behavior and interaction of all
> +   layers, including ability to improve implementation across the stack
> +   over time.
> +
> + - If a platform is partially proprietary, it is still expected that the
> +   portions that interact the driver can be shared in a form that allows
> +   for exercising the hardware/driver and evolution of the interface over
> +   time. This could be separated into a shared library and test/sample
> +   programs, for example.
> +
> + - Over time, there is an expectation to converge drivers over to shared
> +   frameworks and interfaces. Until then, the general rule is that no
> +   more than one driver per vendor will be acceptable. For vendors that
> +   aren't participating in the work towards shared frameworks over time,
> +   we reserve the right to phase out support for the hardware.
How exactly do generic drivers for interconnect protocols, such as 
cxl/ocxl, fit in here?

cxl and ocxl are not drivers for a specific device, they are generic 
drivers which can be used with any device implementing the CAPI or 
OpenCAPI protocol respectively - many of which will be FPGA boards 
flashed with customer-designed accelerator cores for specific workloads, 
some will be accelerators using ASICs or using FPGA images supplied by 
vendors, some will be driven from userspace, others using the cxl/ocxl 
kernel API, etc.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

