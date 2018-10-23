Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14780C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D003820813
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D003820813
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbeJXCgp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 22:36:45 -0400
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:36835 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbeJXCgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 22:36:44 -0400
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g9t1613g.houston.hpe.com (Postfix) with ESMTPS id 007D360387
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 18:12:15 +0000 (UTC)
Received: from G2W6311.americas.hpqcorp.net (g2w6311.austin.hp.com [16.197.64.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g9t5008.houston.hpe.com (Postfix) with ESMTPS id 0F8AD56;
        Tue, 23 Oct 2018 18:12:14 +0000 (UTC)
Received: from G9W8667.americas.hpqcorp.net (16.220.49.26) by
 G2W6311.americas.hpqcorp.net (16.197.64.53) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 23 Oct 2018 18:12:15 +0000
Received: from G2W6311.americas.hpqcorp.net (16.197.64.53) by
 G9W8667.americas.hpqcorp.net (16.220.49.26) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 23 Oct 2018 18:12:14 +0000
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (15.241.52.13) by
 G2W6311.americas.hpqcorp.net (16.197.64.53) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Tue, 23 Oct 2018 18:12:14 +0000
Received: from AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM (10.169.8.145) by
 AT5PR8401MB1220.NAMPRD84.PROD.OUTLOOK.COM (10.169.9.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.18; Tue, 23 Oct 2018 18:12:11 +0000
Received: from AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::b426:5845:8612:bde8]) by AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::b426:5845:8612:bde8%9]) with mapi id 15.20.1250.028; Tue, 23 Oct 2018
 18:12:11 +0000
From:   "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
To:     'Dan Williams' <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
CC:     Tom Lendacky <thomas.lendacky@amd.com>,
        "Hocko, Michal" <MHocko@suse.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        "zwisler@kernel.org" <zwisler@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fengguang Wu <fengguang.wu@intel.com>
Subject: RE: [PATCH 0/9] Allow persistent memory to be used like normal RAM
Thread-Topic: [PATCH 0/9] Allow persistent memory to be used like normal RAM
Thread-Index: AQHUakRyq0s0KYewh0KpVd2TMyN44aUsBFyAgAEU+xA=
Date:   Tue, 23 Oct 2018 18:12:11 +0000
Message-ID: <AT5PR8401MB11694012893ED2121D7A345EABF50@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
References: <20181022201317.8558C1D8@viggo.jf.intel.com>
 <CAPcyv4hxs-GnmwQU1wPZyg5aydCY5K09-YpSrrLpvU1v_8dbBw@mail.gmail.com>
In-Reply-To: <CAPcyv4hxs-GnmwQU1wPZyg5aydCY5K09-YpSrrLpvU1v_8dbBw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=elliott@hpe.com; 
x-originating-ip: [15.211.195.7]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB1220;6:u1yTbmjXksbJFWfsgNftgydo5AbY3y/HOT5ADaanr7+LCc2RE/HEpJI1Luq/9nRWsmQ98W6JTWZBCPoGdZb+zMwDug4RzUCn/0OEbmF2FTiE0ti1ZS1uLF7LseU+KQNfb+RdbdpefLSs2OBFNg/NMjLxYUjCjdT8RBDWmEfexEfrCKFhd4t8wS0eylIjAwrAnLo8bPjT8H+WowpdYx2a0iQyevMv2S/mc4c/pJ0LrqEmiFe77B026u20z/L3AJxnVwk6Ea4Z3E8SWb04hxBUQFFy5I2Eq7QUyTf0rP/dsxYxGOyJS5lSrAW8ofEKC+LDptyUaOt5EE85VtfpJNXC4mUa8+TcH/KnvJyQzvROSgy/G/0NKmoMzMNb+N0sTPKZx9lbzcr6xRroTPIHg0OJCW/cyrTSbxeIQ5r7sj0r1WS9uNH/sm3N5ph1aJK3p9o3k4xvJVZEdxOEdOJj07MhbQ==;5:lw/VTEatNpwJPsNHW4S/gBW70r1wj0nCdvMcUllam1adYguPASE3p95cxT+adPYQsUqbsjQuYunSvAgaHD80EGtZ//w3IQr8CFFZ0Um7vpvBAIip3eqwrHNoPLQ/1s737vWba0JyVcby49oEWkXNT8CC0NIILGCBhYrt/iaCdjw=;7:lfEEnkwN8i5+4VuuHQoudAQknk7PEYRk5yQJ+AZ/3sa1/TMf5Ls2DDTGogSxvDXUAg8z3z6S0WM42hODApoOnQaJ/4bpHUuvT3LVSv/SJq8dke7PUY5pGDWfm7g/jNQPap4VmsyA3WD4kHoGHZpnOg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 151121a2-6348-45f7-d980-08d639130dac
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB1220;
x-ms-traffictypediagnostic: AT5PR8401MB1220:
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-microsoft-antispam-prvs: <AT5PR8401MB12208F67F442D8933B3232A4ABF50@AT5PR8401MB1220.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(162533806227266)(278428928389397)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AT5PR8401MB1220;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB1220;
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(136003)(396003)(39860400002)(376002)(189003)(199004)(13464003)(8676002)(486006)(66066001)(11346002)(2906002)(5660300001)(476003)(478600001)(6246003)(71190400001)(71200400001)(106356001)(105586002)(14454004)(316002)(110136005)(102836004)(68736007)(8936002)(305945005)(7416002)(86362001)(53546011)(186003)(26005)(54906003)(25786009)(81156014)(256004)(5024004)(74316002)(81166006)(7736002)(76176011)(4326008)(7696005)(446003)(6506007)(229853002)(53936002)(55016002)(2900100001)(97736004)(99286004)(6436002)(33656002)(9686003)(5250100002)(6116002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB1220;H:AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SSHQ51lU0MtNhS0wN95vgd8enrRL8yk/GKyL/6eXXDnqLS0eipfqfjgTCdHuxnkgBLyEGwlxr+04VxMCiHazUjubt9NqGCGGuj3sohqosRvpeFdDxsmYElGUZ6gHH2SCq1a/mEb9KtHH7byGexovxrYf/3jAbuDLaFRg2ms2dtYVIsbxJvjyrWjGfz4o6in6vnDBIGU3/ZxakAHNpknbZFD+4XxQp6V9T68BoaYGGI8RLY1EdNXXxMZnK2EgRsATA9sHSTmmX81fTj5rH4tu7S92WuAwPak1Nam8QGH56GwN0l/KXaTNN7cmoCwDJB8sxNOY8TzwlBnCdk7M7v5KPVjzQUt0HArZd2FIyulShpk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 151121a2-6348-45f7-d980-08d639130dac
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2018 18:12:11.4691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB1220
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Linux-nvdimm [mailto:linux-nvdimm-bounces@lists.01.org] On Behalf Of Dan Williams
> Sent: Monday, October 22, 2018 8:05 PM
> Subject: Re: [PATCH 0/9] Allow persistent memory to be used like normal RAM
> 
> On Mon, Oct 22, 2018 at 1:18 PM Dave Hansen <dave.hansen@linux.intel.com> wrote:
...
> This series adds a new "driver" to which pmem devices can be
> attached.  Once attached, the memory "owned" by the device is
> hot-added to the kernel and managed like any other memory.  On

Would this memory be considered volatile (with the driver initializing
it to zeros), or persistent (contents are presented unchanged,
applications may guarantee persistence by using cache flush
instructions, fence instructions, and writing to flush hint addresses
per the persistent memory programming model)?

> > 1. The device re-binding hacks are ham-fisted at best.  We
> >    need a better way of doing this, especially so the kmem
> >    driver does not get in the way of normal pmem devices.
...
> To me this looks like teaching the nvdimm-bus and this dax_kmem driver
> to require explicit matching based on 'id'. The attachment scheme
> would look like this:
> 
> modprobe dax_kmem
> echo dax0.0 > /sys/bus/nd/drivers/dax_kmem/new_id
> echo dax0.0 > /sys/bus/nd/drivers/dax_pmem/unbind
> echo dax0.0 > /sys/bus/nd/drivers/dax_kmem/bind
> 
> At step1 the dax_kmem drivers will match no devices and stays out of
> the way of dax_pmem. It learns about devices it cares about by being
> explicitly told about them. Then unbind from the typical dax_pmem
> driver and attach to dax_kmem to perform the one way hotplug.
> 
> I expect udev can automate this by setting up a rule to watch for
> device-dax instances by UUID and call a script to do the detach /
> reattach dance.

Where would that rule be stored? Storing it on another device
is problematic. If that rule is lost, it could confuse other
drivers trying to grab device DAX devices for use as persistent
memory.

A new namespace mode would record the intended usage in the
device itself, eliminating dependencies. It could join the
other modes like:

	ndctl create-namespace -m raw
		create /dev/pmem4 block device
	ndctl create-namespace -m sector
		create /dev/pmem4s block device
	ndctl create-namespace -m fsdax
		create /dev/pmem4 block device
	ndctl create-namespace -m devdax
		create /dev/dax4.3 character device
		for use as persistent memory
	ndctl create-namespace -m mem
		create /dev/mem4.3 character device
		for use as volatile memory

---
Robert Elliott, HPE Persistent Memory



