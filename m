Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10ED3C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 19:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8DEA206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 19:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="XvBjPUSP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8DEA206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbeI2CNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 22:13:32 -0400
Received: from mail-dm3nam03on0053.outbound.protection.outlook.com ([104.47.41.53]:5536
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726496AbeI2CNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 22:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/Nn9Qu6WIfOqLPgOtFNgAFgti8ed5bjroZ7U71H6to=;
 b=XvBjPUSPIuzHS8HTlHEVDfwbKQM/F0EwKzlEgWd9E4v6KoZTbt9iytNSqCjNgl8fwIZ/KGvExQyq4+pmoLkODlEOV+WEZbam9r73LvsmLY/t5PEl/bd5QIPcKzX6kWqDOvmspMpv+uZ80W/eFVSgH4p1yPZxersx3GeRw7f9LxU=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4486.namprd05.prod.outlook.com (52.135.203.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.13; Fri, 28 Sep 2018 19:48:11 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::1cc9:412c:6f6b:e0ae]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::1cc9:412c:6f6b:e0ae%5]) with mapi id 15.20.1185.022; Fri, 28 Sep 2018
 19:48:11 +0000
From:   Nadav Amit <namit@vmware.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Xavier Deguillard <xdeguillard@vmware.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 16/20] mm/balloon_compaction: list interfaces
Thread-Topic: [PATCH v3 16/20] mm/balloon_compaction: list interfaces
Thread-Index: AQHUVc2ED+mU4PcbWEmXX/O1MTP5s6UGHMKA
Date:   Fri, 28 Sep 2018 19:48:11 +0000
Message-ID: <7F67E16F-BC91-47B3-9A68-CF1EA226AB2E@vmware.com>
References: <20180926191336.101885-1-namit@vmware.com>
 <20180926191336.101885-17-namit@vmware.com>
In-Reply-To: <20180926191336.101885-17-namit@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4486;20:/6aVmqIwSHDBVX8RGmj+77UR+2Jt5sb/LUkjol8gOrzSpNZauu+CZJvpbzC7g9zrX4Kr5rwxGqYJuMkMGpvIoaSeImBXxweFZd1ZjunzjjdDuzjQQQd6NXGknVC71s0XGu2EGpwTwqTQ7OlPONLtmLLwKuET2jvN4lbU8Ai/3WI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f7744bea-2b70-461d-f635-08d6257b52a8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4486;
x-ms-traffictypediagnostic: BYAPR05MB4486:
bcl:    0
x-microsoft-antispam-prvs: <BYAPR05MB4486EE4A10F4CD3AFC501739D0EC0@BYAPR05MB4486.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:BYAPR05MB4486;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4486;
x-forefront-prvs: 0809C12563
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(346002)(396003)(39860400002)(189003)(199004)(6116002)(83716004)(53936002)(6346003)(3846002)(34290500001)(105586002)(54906003)(102836004)(186003)(229853002)(6916009)(86362001)(82746002)(8936002)(6512007)(305945005)(97736004)(508600001)(26005)(6486002)(6506007)(7736002)(2900100001)(106356001)(2906002)(71200400001)(6436002)(71190400001)(5250100002)(316002)(14454004)(6246003)(36756003)(2616005)(81166006)(11346002)(4326008)(66066001)(476003)(99286004)(81156014)(8676002)(33656002)(5660300001)(446003)(256004)(68736007)(25786009)(76176011)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4486;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-microsoft-antispam-message-info: GI4nMescYQe9FEn20T6zRzqfLJMLq45GOD+A0N2GcMJoVilGBiSg2dstyokqbUhLQWyIfjzGcRbj/UCFFVFIzDOhkJggjuj9utt4OxiCNPo2JClJum4F66fRQafliRJxO9sHd5vAmfhvsANDBWVnHhNR9iRzg/pjjPpE3WBl2WPHFEDnjGN8ooz+QLsk55XHcelRSa65ZrKAI+Rh0DCxqxb+15mPhTpRDqIB6Wu/X7WphuI6uXwp/2NXYz3e2XqEI8NvnaEd8+ha4IuhwLwVzGyQjdwAUZ8jpSS+kf5SKI0qHMFXeuPhXmkwIo4FDCztl38sW0GVmHc/I13BaVXOg/sIDgBV/6WK6cMKTpC07cc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F1E08C955151A9408EE1F21ABAF9AB52@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7744bea-2b70-461d-f635-08d6257b52a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2018 19:48:11.5362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4486
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 12:13 PM, Nadav Amit <namit@vmware.com> wrote:

> Introduce interfaces for ballooning enqueueing and dequeueing of a list
> of pages. These interfaces reduce the overhead of storing and restoring
> IRQs by batching the operations. In addition they do not panic if the
> list of pages is empty.
>=20
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: linux-mm@kvack.org
> Cc: virtualization@lists.linux-foundation.org
> Reviewed-by: Xavier Deguillard <xdeguillard@vmware.com>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
> include/linux/balloon_compaction.h |   4 +
> mm/balloon_compaction.c            | 139 +++++++++++++++++++++--------
> 2 files changed, 105 insertions(+), 38 deletions(-)
>=20
> diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_c=
ompaction.h
> index 53051f3d8f25..2c5a8e09e413 100644
> --- a/include/linux/balloon_compaction.h
> +++ b/include/linux/balloon_compaction.h
> @@ -72,6 +72,10 @@ extern struct page *balloon_page_alloc(void);
> extern void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
> 				 struct page *page);
> extern struct page *balloon_page_dequeue(struct balloon_dev_info *b_dev_i=
nfo);
> +extern void balloon_page_list_enqueue(struct balloon_dev_info *b_dev_inf=
o,
> +				      struct list_head *pages);
> +extern int balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info=
,
> +				     struct list_head *pages, int n_req_pages);

<snip>

Michael, can we get you ack for this patch (as well as 15/20)?

Thanks,
Nadav=
