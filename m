Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF5AC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 681872086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dE8Od7GC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 681872086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbeJPWYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:24:46 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49599 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeJPWYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:24:46 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181016143400euoutp01acf85c79d3bef5a50032a55df2f45622~eHWSqyRjt2614726147euoutp014
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 14:34:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181016143400euoutp01acf85c79d3bef5a50032a55df2f45622~eHWSqyRjt2614726147euoutp014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539700440;
        bh=3eZpMwFGek65dIVIDUmOpSSewJhyWl4pTZt7KOUQx9s=;
        h=To:Cc:From:Subject:Date:References:From;
        b=dE8Od7GCkf1pXsT6/0ZzWbTjmqNxXsyJRubadtprVC3KeMZUoYVyewiftHF1gTAi7
         b4PGVlO0CjU7T7AsrWg0g+DwXirN72QeMaDtszSOlcVfGc/J4TuGojSu3SSuASrxGj
         SLCJIPhXZuoZycRAzyTcSA3yo5VZBILiQ5dxXANg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181016143400eucas1p21937ca741a1055fb9154cafece294be1~eHWSVhO0B3235432354eucas1p2X;
        Tue, 16 Oct 2018 14:34:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id F6.1E.04806.8D6F5CB5; Tue, 16
        Oct 2018 15:34:00 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181016143359eucas1p1b2033a69cc7b03c090125e1b9566fc1d~eHWRlFIki1482014820eucas1p1q;
        Tue, 16 Oct 2018 14:33:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181016143359eusmtrp2f01f2f0ec00fd46696e9771677c693d5~eHWRTdQHL2541125411eusmtrp2Y;
        Tue, 16 Oct 2018 14:33:59 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-f0-5bc5f6d87c2a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E6.A7.04128.7D6F5CB5; Tue, 16
        Oct 2018 15:33:59 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181016143359eusmtip19ad854c4ba387bdd3f801766fbdd4fb5~eHWRDYK6n2294522945eusmtip18;
        Tue, 16 Oct 2018 14:33:59 +0000 (GMT)
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] xen: remove redundant 'default n' from Kconfig
Date:   Tue, 16 Oct 2018 16:33:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleLIzCtJLcpLzFFi42LZduznOd0b345GG6zax21xcXori8Wcm0YW
        l3fNYbP4vmUykwOLx+EPV1g8Pj69xeKxfstVFo/Pm+QCWKK4bFJSczLLUov07RK4MlpuzWIs
        2C1V8e90F0sD406RLkZODgkBE4mTt2aydjFycQgJrGCUeDF1ARuE84VRYv/r40wQzmdGidMv
        G9hgWg6uWMsIkVjOKPHl/HkmkISQwHtGiXdrA0FsEYFgiV+PJ7GD2MwCDhKXe7+B1bAJWElM
        bF/FCGILC9hLfN33E6yGRUBVYvWSKyxdjBwcogIREv1n1EHCvAKCEidnPmGBGCMvsf3tHGaQ
        vRICr9kkZr38zwZRVCZx6eA0RojjXCQWNJ9lhbCFJV4d38IOYctI/N85nwmieTqjxJtfS1kg
        nPWMEmvOHGOCqLKWOHz8IivIFcwCmhLrd+lDhB0lXu1cCxaWEOCTuPFWEOIgPolJ26YzQ4R5
        JTrahCCq1SQ2LNvABrO2a+dKZgjbQ+Lg71ZWSFDFSnTcWsY8gVFhFpI3ZyF5cxbCDQsYmVcx
        iqeWFuempxYb56WW6xUn5haX5qXrJefnbmIEJpDT/45/3cG470/SIUYBDkYlHt4f149EC7Em
        lhVX5h5ilOBgVhLhTb90NFqINyWxsiq1KD++qDQntfgQozQHi5I477J5G6OFBNITS1KzU1ML
        UotgskwcnFINjOnHhK/+aeM9P2mFedPua/flrt2aUGcTsPLukqKPv3Ud5kyLmaviy36xYNfk
        jwaxczx9V3z5bnuq6/rSc6ve2tSszf/O3bVXlLuJ5VbJ/88fj/7bZaae92SKh2Lk72Vvtqfv
        e194e3r3wqe7V7Ro5y5ewnOm65Jr8pOn/DtLP0/OcTg5QXSpzUMNJZbijERDLeai4kQAW+tS
        gRwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsVy+t/xu7rXvx2NNrj0UMDi4vRWFos5N40s
        Lu+aw2bxfctkJgcWj8MfrrB4fHx6i8Vj/ZarLB6fN8kFsETp2RTll5akKmTkF5fYKkUbWhjp
        GVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZbTcmsVYsFuq4t/pLpYGxp0iXYycHBIC
        JhIHV6xlBLGFBJYySmz/yd7FyAEUl5E4vr4MokRY4s+1LrYuRi6gkreMErebGplAakQEgiXW
        7k4CqWEWcJC43PuNCcRmE7CSmNi+CmyksIC9xNd9ECN5BewkJq0RAgmzCKhKrF5yhQXEFhWI
        kLj1sAPM5hUQlDg58wkLxEh1iT/zLjFD2PIS29/OYZ7AyD8LSdksJGWzkJQtYGRexSiSWlqc
        m55bbKRXnJhbXJqXrpecn7uJERji24793LKDsetd8CFGAQ5GJR7eH9ePRAuxJpYVV+YeYpTg
        YFYS4U2/dDRaiDclsbIqtSg/vqg0J7X4EKMp0OETmaVEk/OB8ZdXEm9oamhuYWlobmxubGah
        JM573qAySkggPbEkNTs1tSC1CKaPiYNTqoGx50WW79HMHjet1QyHN514JD7nUpbP9o2XJwlv
        F268GvIr96D67c6Os61P9Qx2tl5YJfVilfHu89VHXrvZvXjGo9hxTp1lRlrfNNEnDvrTJxhx
        zX214MqaTr7pf88culj5vXPhHSG/Jx++bUtY+dqv+WtfeZ2YeUrr+g9ZvmUMullKx1/PNOPr
        VmIpzkg01GIuKk4EAFyeuqGHAgAA
Message-Id: <20181016143359eucas1p1b2033a69cc7b03c090125e1b9566fc1d~eHWRlFIki1482014820eucas1p1q@eucas1p1.samsung.com>
X-CMS-MailID: 20181016143359eucas1p1b2033a69cc7b03c090125e1b9566fc1d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181016143359eucas1p1b2033a69cc7b03c090125e1b9566fc1d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181016143359eucas1p1b2033a69cc7b03c090125e1b9566fc1d
References: <CGME20181016143359eucas1p1b2033a69cc7b03c090125e1b9566fc1d@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'default n' is the default value for any bool or tristate Kconfig
setting so there is no need to write it explicitly.

Also since commit f467c5640c29 ("kconfig: only write '# CONFIG_FOO
is not set' for visible symbols") the Kconfig behavior is the same
regardless of 'default n' being present or not:

    ...
    One side effect of (and the main motivation for) this change is making
    the following two definitions behave exactly the same:
    
        config FOO
                bool
    
        config FOO
                bool
                default n
    
    With this change, neither of these will generate a
    '# CONFIG_FOO is not set' line (assuming FOO isn't selected/implied).
    That might make it clearer to people that a bare 'default n' is
    redundant.
    ...

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/xen/Kconfig |    8 --------
 1 file changed, 8 deletions(-)

Index: b/drivers/xen/Kconfig
===================================================================
--- a/drivers/xen/Kconfig	2018-10-09 15:58:51.191123246 +0200
+++ b/drivers/xen/Kconfig	2018-10-16 16:32:13.387726147 +0200
@@ -12,7 +12,6 @@ config XEN_BALLOON
 config XEN_SELFBALLOONING
 	bool "Dynamically self-balloon kernel memory to target"
 	depends on XEN && XEN_BALLOON && CLEANCACHE && SWAP && XEN_TMEM
-	default n
 	help
 	  Self-ballooning dynamically balloons available kernel memory driven
 	  by the current usage of anonymous memory ("committed AS") and
@@ -27,7 +26,6 @@ config XEN_SELFBALLOONING
 
 config XEN_BALLOON_MEMORY_HOTPLUG
 	bool "Memory hotplug support for Xen balloon driver"
-	default n
 	depends on XEN_BALLOON && MEMORY_HOTPLUG
 	help
 	  Memory hotplug support for Xen balloon driver allows expanding memory
@@ -226,7 +224,6 @@ config XEN_PCIDEV_BACKEND
 config XEN_PVCALLS_FRONTEND
 	tristate "XEN PV Calls frontend driver"
 	depends on INET && XEN
-	default n
 	select XEN_XENBUS_FRONTEND
 	help
 	  Experimental frontend for the Xen PV Calls protocol
@@ -237,7 +234,6 @@ config XEN_PVCALLS_FRONTEND
 config XEN_PVCALLS_BACKEND
 	bool "XEN PV Calls backend driver"
 	depends on INET && XEN && XEN_BACKEND
-	default n
 	help
 	  Experimental backend for the Xen PV Calls protocol
 	  (https://xenbits.xen.org/docs/unstable/misc/pvcalls.html). It
@@ -263,7 +259,6 @@ config XEN_PRIVCMD
 config XEN_STUB
 	bool "Xen stub drivers"
 	depends on XEN && X86_64 && BROKEN
-	default n
 	help
 	  Allow kernel to install stub drivers, to reserve space for Xen drivers,
 	  i.e. memory hotplug and cpu hotplug, and to block native drivers loaded,
@@ -274,7 +269,6 @@ config XEN_STUB
 config XEN_ACPI_HOTPLUG_MEMORY
 	tristate "Xen ACPI memory hotplug"
 	depends on XEN_DOM0 && XEN_STUB && ACPI
-	default n
 	help
 	  This is Xen ACPI memory hotplug.
 
@@ -286,7 +280,6 @@ config XEN_ACPI_HOTPLUG_CPU
 	tristate "Xen ACPI cpu hotplug"
 	depends on XEN_DOM0 && XEN_STUB && ACPI
 	select ACPI_CONTAINER
-	default n
 	help
 	  Xen ACPI cpu enumerating and hotplugging
 
@@ -315,7 +308,6 @@ config XEN_ACPI_PROCESSOR
 config XEN_MCE_LOG
 	bool "Xen platform mcelog"
 	depends on XEN_DOM0 && X86_64 && X86_MCE
-	default n
 	help
 	  Allow kernel fetching MCE error from Xen platform and
 	  converting it into Linux mcelog format for mcelog tools
