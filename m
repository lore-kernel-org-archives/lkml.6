Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2ECC46469
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 23:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678C320855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 23:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PO+/yHzK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 678C320855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbeIKEk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 00:40:27 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33946 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeIKEk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 00:40:27 -0400
Received: by mail-pl1-f194.google.com with SMTP id f6-v6so10463950plo.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 16:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=MJv9XTQcitO3gy5LNlz5Iv9gvth5EHKXzc6g36JI3Fc=;
        b=PO+/yHzKVe6BrtyAYDCrPoH1MS/MgG2SdH2MWE4Pu16baBk2jwxUqndfwe7rrtFeej
         oNi0xoLwWDoh/gd29YEKhez5Fy1B0bGTUGlQS4awi43cRSQ8iOBoIPq5oivMRFj72UY5
         f/VQa99Utf8IKzhwwIc7PqOHfuuG7xBmEB/exPT+8K0id8EJdHbVG4JJatsFCVZDMBi5
         2gMw6sr3IyU1oH20TXT94TN7u7jJ3We/C7qEycP6m4tSiuK2GvyPZIZu3sCMOBGm/r0U
         e8ToHPOnpYI6rp3t/sHjxch8Nt0PHUEgdYOTrCXwZ1s33o4RIGLboXtgZK6qo7kLre/9
         vMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=MJv9XTQcitO3gy5LNlz5Iv9gvth5EHKXzc6g36JI3Fc=;
        b=XesGyFVYgpJ8E/a4FRZ5k4E3ScUPGZzBC10SQ4V55pYcd/gGSMfFfxB6O6TIIsJLAD
         5wcKRIY2n3d1Rhkv5tJZ2/ziwVfzBMQMJfnPsGH5xg0a9FqfNWv0XJEnByNXi1BcTUrO
         AMoShwH1GObg0amJRruAb/O0+l9P9DY41HkbhA9IcF6Wmq5D54kNd9QG8h4JdgzFGQ1o
         TI+IRvBKhXRhFIZBHHR66y5vPFLPN7I8pmOnJkQWgaG54A21SmiOnsQ6JauevDJtBNwe
         5vvp3EVidW6AhOytYLpBG171RlNnSYlCm9LIi3DivUND4Y/6EVEb3aFXaKpKjtcxRH5+
         ZBew==
X-Gm-Message-State: APzg51Ct3cUF2bRdoVYta4BH3HBKUdNcpVf1evB+NLFK173Smm1BQWcP
        t8obgaOqaMdAS39NQakFAp4i0eVI
X-Google-Smtp-Source: ANB0Vdae3zS05W6i/7y646GBZXtkkHI+KeQ/8novIzql8yYtiMRq7VA37016jMUlgSw8jVTKp/3lWw==
X-Received: by 2002:a17:902:7402:: with SMTP id g2-v6mr24285976pll.321.1536623041876;
        Mon, 10 Sep 2018 16:44:01 -0700 (PDT)
Received: from localhost.localdomain (static-50-53-21-37.bvtn.or.frontiernet.net. [50.53.21.37])
        by smtp.gmail.com with ESMTPSA id u184-v6sm21581039pgd.46.2018.09.10.16.44.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 16:44:01 -0700 (PDT)
Subject: [PATCH 4/4] nvdimm: Trigger the device probe on a cpu local to the
 device
From:   Alexander Duyck <alexander.duyck@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc:     pavel.tatashin@microsoft.com, mhocko@suse.com,
        dave.jiang@intel.com, mingo@kernel.org, dave.hansen@intel.com,
        jglisse@redhat.com, akpm@linux-foundation.org, logang@deltatee.com,
        dan.j.williams@intel.com, kirill.shutemov@linux.intel.com
Date:   Mon, 10 Sep 2018 16:44:00 -0700
Message-ID: <20180910234400.4068.15541.stgit@localhost.localdomain>
In-Reply-To: <20180910232615.4068.29155.stgit@localhost.localdomain>
References: <20180910232615.4068.29155.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Duyck <alexander.h.duyck@intel.com>

This patch is based off of the pci_call_probe function used to initialize
PCI devices. The general idea here is to move the probe call to a location
that is local to the memory being initialized. By doing this we can shave
significant time off of the total time needed for initialization.

With this patch applied I see a significant reduction in overall init time
as without it the init varied between 23 and 37 seconds to initialize a 3GB
node. With this patch applied the variance is only between 23 and 26
seconds to initialize each node.

I hope to refine this further in the future by combining this logic into
the async_schedule_domain code that is already in use. By doing that it
would likely make this functionality redundant.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/nvdimm/bus.c |   45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 8aae6dcc839f..5b73953176b1 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -27,6 +27,7 @@
 #include <linux/io.h>
 #include <linux/mm.h>
 #include <linux/nd.h>
+#include <linux/cpu.h>
 #include "nd-core.h"
 #include "nd.h"
 #include "pfn.h"
@@ -90,6 +91,48 @@ static void nvdimm_bus_probe_end(struct nvdimm_bus *nvdimm_bus)
 	nvdimm_bus_unlock(&nvdimm_bus->dev);
 }
 
+struct nvdimm_drv_dev {
+	struct nd_device_driver *nd_drv;
+	struct device *dev;
+};
+
+static long __nvdimm_call_probe(void *_nddd)
+{
+	struct nvdimm_drv_dev *nddd = _nddd;
+	struct nd_device_driver *nd_drv = nddd->nd_drv;
+
+	return nd_drv->probe(nddd->dev);
+}
+
+static int nvdimm_call_probe(struct nd_device_driver *nd_drv,
+			     struct device *dev)
+{
+	struct nvdimm_drv_dev nddd = { nd_drv, dev };
+	int rc, node, cpu;
+
+	/*
+	 * Execute driver initialization on node where the device is
+	 * attached.  This way the driver will be able to access local
+	 * memory instead of having to initialize memory across nodes.
+	 */
+	node = dev_to_node(dev);
+
+	cpu_hotplug_disable();
+
+	if (node < 0 || node >= MAX_NUMNODES || !node_online(node))
+		cpu = nr_cpu_ids;
+	else
+		cpu = cpumask_any_and(cpumask_of_node(node), cpu_online_mask);
+
+	if (cpu < nr_cpu_ids)
+		rc = work_on_cpu(cpu, __nvdimm_call_probe, &nddd);
+	else
+		rc = __nvdimm_call_probe(&nddd);
+
+	cpu_hotplug_enable();
+	return rc;
+}
+
 static int nvdimm_bus_probe(struct device *dev)
 {
 	struct nd_device_driver *nd_drv = to_nd_device_driver(dev->driver);
@@ -104,7 +147,7 @@ static int nvdimm_bus_probe(struct device *dev)
 			dev->driver->name, dev_name(dev));
 
 	nvdimm_bus_probe_start(nvdimm_bus);
-	rc = nd_drv->probe(dev);
+	rc = nvdimm_call_probe(nd_drv, dev);
 	if (rc == 0)
 		nd_region_probe_success(nvdimm_bus, dev);
 	else

