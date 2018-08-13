Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE8CC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3980F2178C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="matBi3dc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3980F2178C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730681AbeHMWQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 18:16:11 -0400
Received: from mail-by2nam03on0121.outbound.protection.outlook.com ([104.47.42.121]:10400
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728763AbeHMWQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 18:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3B2Y9ucQWTmWBzHEdyZOpZ6hLSROcXnwFkas20nro4=;
 b=matBi3dcC2+AuMER49lCPykYn6EL0U6l7UV+hg8RrUfZGSo1rdXG21EsCcItG990AijGHQnadakT2Pjtez1pHwDd6JnvmzjHJcHf+hJtXK0pvaQw0d8Keq9yKKPU1Z9owj7742OnN3/whVxSreeNzZAzQdz596B+333qvNHP+YA=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0278.namprd21.prod.outlook.com (10.173.193.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.1; Mon, 13 Aug 2018 19:30:51 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::9039:1f12:39f1:267f]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::9039:1f12:39f1:267f%9]) with mapi id 15.20.1080.002; Mon, 13 Aug 2018
 19:30:51 +0000
From:   "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
CC:     Stephen Hemminger <stephen@networkplumber.org>
Subject: RE: [PATCH 2/5] vmbus: add driver_override support
Thread-Topic: [PATCH 2/5] vmbus: add driver_override support
Thread-Index: AQHUMP7hUja4hqhYOEGCevbfjkIbnqS+Ebaw
Date:   Mon, 13 Aug 2018 19:30:50 +0000
Message-ID: <CY4PR21MB07739595C31B9B9349604C0ADC390@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <20180810230520.2055-1-kys@linuxonhyperv.com>
 <20180810230611.2114-1-kys@linuxonhyperv.com>
 <20180810230611.2114-2-kys@linuxonhyperv.com>
In-Reply-To: <20180810230611.2114-2-kys@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-08-13T19:30:49.3432975Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:80e8:3:e19a:eef5:264f:f70c]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0278;6:DhbFNpfjoFSSP0P1X7RDKZutNJFXaVMfjCTT9IJR+UcFX/o9PTgYWH6vfQktTNUM0m9xWjzJDAE3zqaLQtF87Xah0ByN77o4ktaVKnYCsoi/KdWsEPrigAIkDrZObkFhVBG4Dh1xkR0DHMHztiIZsShaZ3IAfuO7IZvrgel3WaU3SnkH6pM7VA0UzSBGZscZGtuteIAHFxpBnIZY/QL5hSLfS2CWDXKaElFaTwMNgFctAMRM58cwqdFBPPlaaZ2Yqi4Tyek9FyDgKw3lUD0+c3si1rsspjsYX0TMQgLPaF8QiSGSZSkvh8dyT0YCqULYN7OD7CaC97NAOJKi24430KSrCYszDgUNx2FQfqnK+pEnnntndXf0KDQ4/WGmTEWFuSug2vJ3lrD07idV4jQbIOkAl9MNsm0Fu1AQVeKn241EuVtc+uPLdytK7Oy5fFEaNSwomRMES4hiwk06qaQ7gQ==;5:NEyrlgATL0F+dAVNE0tGShVNgnrblOQ2m+ajzhQ02iEj8ToLpzLkSbzIULGgStVSkRqk1GW0WGY1PH0opLIEM1YDzUHcCxfVksS4kUI4PDNXemjUU6pLTi1bw7gYNXWpBXh+662HUlOQIiQbdqT4QfBHdX7N4l3HTKreltiL17U=;7:fjzOYaMXkxyM+/6mmuvfdY9JaoNsmeEdFvKpIu7tMNfgVmRoHmxKEMzwOQAdwI8HiuQ7o2Fo5YOI/G9M7oFPKhOPWad7ZQHTk6IuwIgGW/0BgN9nqDAHLe4ffP51Uy4k+kUkGxCBmgX1VNs/ceAqADHWXI19VHqRrgWvMGtTvmZw/hjYLxX0O8fO6Gi33O49KlDnBW5LxCxvRDL+DI1/vO3D/YlG2Z5vBM2kCr2SXstg80BEki5q2ybn+BqsRPdK
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 803e3fbb-557c-4516-e271-08d60153477b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0278;
x-ms-traffictypediagnostic: CY4PR21MB0278:
x-microsoft-antispam-prvs: <CY4PR21MB02780279CF0FA2FA17A3B7EFDC390@CY4PR21MB0278.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(4782527817362);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:CY4PR21MB0278;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0278;
x-forefront-prvs: 07630F72AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(366004)(136003)(396003)(189003)(199004)(305945005)(7736002)(6436002)(6116002)(86362001)(7696005)(68736007)(25786009)(76176011)(2906002)(74316002)(2501003)(6506007)(86612001)(446003)(476003)(14444005)(256004)(5024004)(486006)(46003)(2201001)(8936002)(11346002)(102836004)(5660300001)(10090500001)(22452003)(97736004)(2900100001)(53936002)(33656002)(478600001)(316002)(105586002)(106356001)(55016002)(5250100002)(6346003)(14454004)(1511001)(99286004)(10290500003)(4326008)(229853002)(81156014)(81166006)(8990500004)(6306002)(6246003)(966005)(9686003)(72206003)(8676002)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0278;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com; 
x-microsoft-antispam-message-info: ulIiCDUFuc3b2ApHV0GOO06qz+lxDbicM4OEKBXj69e9hWwtLme+UMW9TrXi+7uNRkxxE6iC46IXW5ZyNNoAy2XpIN+je/XW39MRHHY3JrsMV9KudZPY/xTuDCDeInqYJy/SneimD9tPpyK/ebgEdrJJoHQntsi+BEhsdSvYn1SA7gSD+vpUdTirHW2GqlqW64Sf7Mo06JLSSiU+uJjO8nvVlhPDc3UFp2IUwvH/zBvpKgm5A93jmRZqSVq+NAxCPwFC48pJ0ayzCd6jp3PAX3l/9Zr+d1M/utWghZpR3pbppKmsx0ztRuDVF0VaLkpunq2ghf+VhpPyxp1LHbCQeR0jteJlF5xtCDQZNJfrHL8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 803e3fbb-557c-4516-e271-08d60153477b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2018 19:30:51.0466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0278
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kys@linuxonhyperv.com <kys@linuxonhyperv.com>  Sent: Friday, August 1=
0, 2018 4:06 PM

> From: Stephen Hemminger <stephen@networkplumber.org>
>=20
> Add support for overriding the default driver for a VMBus device
> in the same way that it can be done for PCI devices. This patch
> adds the /sys/bus/vmbus/devices/.../driver_override file
> and the logic for matching.
>=20
> This is used by driverctl tool to do driver override.
> https://gitlab.com/driverctl/driverctl
>=20
> Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> ---
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index b1b548a21f91..e6d8fdac6d8b 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -498,6 +498,54 @@ static ssize_t device_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(device);
>=20
> +static ssize_t driver_override_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t count)
> +{
> +	struct hv_device *hv_dev =3D device_to_hv_device(dev);
> +	char *driver_override, *old, *cp;
> +
> +	/* We need to keep extra room for a newline */
> +	if (count >=3D (PAGE_SIZE - 1))
> +		return -EINVAL;

Does 'count' actually have a relationship to PAGE_SIZE, or
is PAGE_SIZE just used as an arbitrary size limit?  I'm
wondering what happens on ARM64 with a 64K page size,
for example.  If it's just arbitrary, coding such a constant
would be better.

> +/*
> + * Return a matching hv_vmbus_device_id pointer.
> + * If there is no match, return NULL.
> + */
> +static const struct hv_vmbus_device_id *hv_vmbus_get_id(struct hv_driver=
 *drv,
> +							struct hv_device *dev)
> +{
> +	const uuid_le *guid =3D &dev->dev_type;
> +	const struct hv_vmbus_device_id *id;
>=20
> -	return NULL;
> +	/* When driver_override is set, only bind to the matching driver */
> +	if (dev->driver_override && strcmp(dev->driver_override, drv->name))
> +		return NULL;

This function needs to be covered by the device lock, so that
dev->driver_override can't be set to NULL and the memory freed
during the above 'if' statement.  When called from vmbus_probe(),
the device lock is held, so it's good. But when called from
vmbus_match(), the device lock may not be held: consider the path
__driver_attach() -> driver_match_device() -> vmbus_match().

Michael
