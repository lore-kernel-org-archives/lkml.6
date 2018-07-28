Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B818C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 04:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C0F2088E
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 04:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=LenovoBeijing.onmicrosoft.com header.i=@LenovoBeijing.onmicrosoft.com header.b="VM0Bygi7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C0F2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lenovo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbeG1Fcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 01:32:45 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.115]:32055 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726047AbeG1Fco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 01:32:44 -0400
Received: from [67.219.250.198] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-b.us-west-2.aws.symcld.net id 52/D5-01623-31CEB5B5; Sat, 28 Jul 2018 04:07:47 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTfUwbZRzH99xd746XbkcB+9gMErvsD5mtLah
  5jDHRf9xFszj9Rx1mrMCNlpVCekXK9g+kcRoK8uIYg5aXuc1NYKDdYqYWN+osFpkgL+qQ2Y0V
  eVnpMtnieOu867Gpl1zy/T2f7/1+3+fJPTSumKJUNGe3cVaLwawm4wnj3A1MkxzOztbVdu5Av
  YN+HHVdqyXR6NpdgJoqhynU1DgC0A9XK0nUF3HJkONEL4n8I/MEcjU5MDTkLELevgCBxr52k8
  hR/zuF6o47cHR6IIqh+tlVAi39dJhCh7+4B9Dw+oAMTdb5MbR6XzB7v/8Qf0nJuip+Jtj+aR/
  JnjuTwZ7wzmPs2JVSti3wBnuxtZtina4owd6ZmSTY299OkOxQx2WKPffjIXbJk85+cMmJsZ7Q
  IsYOB6PUbmaPzGTJLbbvkxnPfteMlbwvtx8J9mAVIBxfBeJpBRMCcKW7ViYVPgBnOz+nxIJgz
  uAw4vgFrwJxAqnF4PxXdskVBHBptZoUAck8CQNh0RRPpzARDK6snwVigTMXSdh63k+IrmRmP5
  xs6aJEncIUwP6r9whJZ8Ll0FisE8Fsh5dvLsa0nHkXPrjgFPy0MG4fdNfYxeU45jk4s+COfQq
  YNHh0OoiJGmeUsPVoi0zUkGHgSe8wLulUOH8zurGuhtOnfiUknQZH252xnJCpwaF/eg6TwC44
  GO4gJTAA4JdtLpkYAjIZcPzuZlEC5k0YOb9Xsh+Ac+5mXHK8CifrN8amw86aG4TUxYPDkcAxS
  gJboXd9ZgP8JoPt6/1YHdC0/GcPkn4KdnzzFynpHfDT47fwltixJMFAc4joAEQnQLlWU4HRVm
  QwmTV6nU6j12dq9Fnim6U1HNTkakt5TRnH2zSZWkMZr+XLi/LM+VoLZ/MA4R/fJDwXQNCX7wO
  P05g6VT4ezM5WbM4tzi83GnhjjrXUzPE+sJWm1VCuvyWwJCtXwNn3m8zCRXmIIZ2oTpFniljO
  lxiKeFOBhAZBFt32WUMDTq/dbmzAFYSl2MKplPIk0cqIVmOp5VGjh5duFKSpkuVAiKZILOGsR
  Sbb//kCUNJAnSxvXBC6JJostkfzFoQomBBlYO87YhSb4V+kqgDtK3zToSGzrjK1TrZltCwy1e
  t4eWdzwu7FPGVe9ZT8o7eoiT+vD556+04Cl3UkeL+y5/nGtCcMeR8nvFb+bF/VK89s/2S5R1W
  YUJ0DQuFt6ZrxS/wLha8/vbzLuCW8za070P/3H9E4z7VN17nWY1cUWPfsWNeLDTkPHnvvYH3h
  xE7TyTU1wRsN+gzcyhv+AcJ/UDFvBAAA
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-24.tower-346.messagelabs.com!1532750861!1371195!1
X-Originating-IP: [104.232.225.2]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 19286 invoked from network); 28 Jul 2018 04:07:47 -0000
Received: from unknown (HELO maesmtp01.lenovo.com) (104.232.225.2)
  by server-24.tower-346.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 28 Jul 2018 04:07:47 -0000
Received: from USEXEDGE02.lenovo.com (unknown [10.62.65.5]) by maesmtp01.lenovo.com with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-SHA)
         id 2ec5_3682_67b076fe_f07a_40b8_81b8_efcda044f269;
        Sat, 28 Jul 2018 04:07:33 +0000
Received: from APC01-PU1-obe.outbound.protection.outlook.com (65.55.88.18) by
 USEXEDGE02.lenovo.com (10.62.65.5) with Microsoft SMTP Server (TLS) id
 14.3.389.1; Sat, 28 Jul 2018 00:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=LenovoBeijing.onmicrosoft.com; s=selector1-lenovo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbZLLgGDeuYLDqcQZBeHjuXEmpiJjUfyC+C+wWd/VW8=;
 b=VM0Bygi7KUQKBLrQlE552T69843EJi7cJo//BXGoTJ/0vTh12R9XMGVJGosPiBRAFnE9jwlqf2bNt/GsB+gvn72BUBnRwQKb8rE6Drhw28uBwIllMVR3R6wTh8ByYemQiALOxHnz/Cb+tTx8WcLRNzImH7okMb80Aq/UlgXU28o=
Received: from TY2PR03MB3343.apcprd03.prod.outlook.com (20.177.20.145) by
 TY2PR03MB3680.apcprd03.prod.outlook.com (20.177.78.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.13; Sat, 28 Jul 2018 04:07:26 +0000
Received: from TY2PR03MB3343.apcprd03.prod.outlook.com
 ([fe80::2970:a034:38d1:9afe]) by TY2PR03MB3343.apcprd03.prod.outlook.com
 ([fe80::2970:a034:38d1:9afe%2]) with mapi id 15.20.1017.010; Sat, 28 Jul 2018
 04:07:26 +0000
From:   Huaisheng HS1 Ye <yehs1@lenovo.com>
To:     "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>,
        "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>,
        "bart.vanassche@wdc.com" <bart.vanassche@wdc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "keescook@chromium.org" <keescook@chromium.org>
CC:     "ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jack@suse.cz" <jack@suse.cz>, "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "NingTing Cheng" <chengnt@lenovo.com>,
        "colyli@suse.de" <colyli@suse.de>,
        Huaisheng Ye <yehs2007@zoho.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>
Subject: RE: [External]  [PATCH v2 2/6] s390, dcssblk: kaddr and pfn can be
 NULL to ->direct_access()
Thread-Topic: [External]  [PATCH v2 2/6] s390, dcssblk: kaddr and pfn can be
 NULL to ->direct_access()
Thread-Index: AQHUJDTYqNzaaZ4Lj0CwoIJqnX/Oo6SkA+uw
Date:   Sat, 28 Jul 2018 04:07:25 +0000
Message-ID: <TY2PR03MB334328133134A67C87E5CC5C92290@TY2PR03MB3343.apcprd03.prod.outlook.com>
References: <20180725162849.8320-1-yehs2007@zoho.com>
 <20180725162849.8320-3-yehs2007@zoho.com>
In-Reply-To: <20180725162849.8320-3-yehs2007@zoho.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [114.240.70.214]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY2PR03MB3680;20:Eu/OpRlYqyaEolkDxUCl8YS9kIorPeT7p+ydjWZ1d/riKy5G7dD6NSioyU7j08CVnDhSL1fr4b4hy6zbwGfcpZxydbWmw6P2SIVNhHMoA+znA8edTZj/iz1pip7JxYwO9JvuZ7Jy/+GA3/weUAvT+guOjH5lMSsYljgglGH6gT6oV0pXksg7CZ7Lha+dveb5yDHgLx/F02pr6vVdGtR5X2zPEZiVS+6X3Gi5Rifrr943WgKdF+YnISyBRF05tQn+rllLYDY0HAzOJt+hyAIDwarysKFHGbo5fbaywB16aPR1HjK7n5xqnTeQ+J++fyGflKLEzYXxmLVVGtLTha8jKg==
x-ms-office365-filtering-correlation-id: 9f814aba-6896-40ed-9012-08d5f43fa10e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:TY2PR03MB3680;
x-ms-traffictypediagnostic: TY2PR03MB3680:
x-microsoft-antispam-prvs: <TY2PR03MB36804E54D8DB8C819A52D24092290@TY2PR03MB3680.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(3940261145250)(247784426924974);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:TY2PR03MB3680;BCL:0;PCL:0;RULEID:;SRVR:TY2PR03MB3680;
x-forefront-prvs: 07473990A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(346002)(376002)(39830400003)(189003)(199004)(4326008)(81166006)(25786009)(229853002)(6246003)(97736004)(8936002)(478600001)(33656002)(81156014)(6436002)(14454004)(9686003)(55016002)(2906002)(7416002)(5660300001)(53936002)(68736007)(106356001)(2900100001)(8676002)(3846002)(7736002)(5250100002)(2501003)(105586002)(6116002)(305945005)(2201001)(74316002)(476003)(76176011)(110136005)(6506007)(54906003)(26005)(102836004)(256004)(186003)(446003)(14444005)(66066001)(11346002)(99286004)(7696005)(486006)(86362001)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY2PR03MB3680;H:TY2PR03MB3343.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: lenovo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: bMVBpwiUOj3lmcJVXSXAKQomQizESXMffbeQ/B8yvuGC3nc6pwgm+iPHeadndDmCQnjFsc9n8jVtDs3h6a8e1u1swUXrfPZrjyCqao2ILX8VoN9Prcrk/5mGEgmscUD357GFNn2GbuYbjTLEGkSKWbKX3pp0/+79ugJYkuk0QI8Riq6BSehRziIls0KwBprpb3zk8CC7WG3jzyz8J/b8qTRDmskgougLoNmjhSpc20bgy64Gr4poopvVk93jAeMPMEGBoRYGTsptModa/l1/LV37mqJlSOgYrp5fmzw+Xp2sKcnLcp6bqLHtKFa8bJvYWF8Ar1NwqqF44SLNQZ6NrxQ3Xp+18YzYU0hd+rGOqnM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f814aba-6896-40ed-9012-08d5f43fa10e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2018 04:07:26.0152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR03MB3680
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Maintainers of Linux-s390,

Greetings.

May I have your ack's for this patch? The whole series would be applied
to libnvdimm if it could get your approval.
And any suggestion is welcome.

Cheers,
Huaisheng Ye

> From: Huaisheng Ye <yehs2007@zoho.com>
> Sent: Thursday, July 26, 2018 12:29 AM
>=20
> From: Huaisheng Ye <yehs1@lenovo.com>
>=20
> dcssblk_direct_access() needs to check the validity of pointers kaddr
> and pfn for NULL assignment. If anyone equals to NULL, it doesn't need
> to calculate the value.
>=20
> If either of them is equal to NULL, that is to say callers may
> have no need for kaddr or pfn, so this patch is prepared for allowing
> them to pass in NULL instead of having to pass in a pointer or local
> variable that they then just throw away.
>=20
> Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
> ---
>  drivers/s390/block/dcssblk.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
> index ed60728..23e526c 100644
> --- a/drivers/s390/block/dcssblk.c
> +++ b/drivers/s390/block/dcssblk.c
> @@ -922,9 +922,11 @@ static DEVICE_ATTR(save, S_IWUSR | S_IRUSR, dcssblk_=
save_show,
>  	unsigned long dev_sz;
>=20
>  	dev_sz =3D dev_info->end - dev_info->start + 1;
> -	*kaddr =3D (void *) dev_info->start + offset;
> -	*pfn =3D __pfn_to_pfn_t(PFN_DOWN(dev_info->start + offset),
> -			PFN_DEV|PFN_SPECIAL);
> +	if (kaddr)
> +		*kaddr =3D (void *) dev_info->start + offset;
> +	if (pfn)
> +		*pfn =3D __pfn_to_pfn_t(PFN_DOWN(dev_info->start + offset),
> +				PFN_DEV|PFN_SPECIAL);
>=20
>  	return (dev_sz - offset) / PAGE_SIZE;
>  }
> --
> 1.8.3.1
