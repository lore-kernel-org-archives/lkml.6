Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23D0C282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66DC920868
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="IMtI7D8W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfAWA00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 19:26:26 -0500
Received: from rcdn-iport-5.cisco.com ([173.37.86.76]:1249 "EHLO
        rcdn-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfAWA00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 19:26:26 -0500
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Jan 2019 19:26:25 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2884; q=dns/txt; s=iport;
  t=1548203185; x=1549412785;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UXIDgAFCzv7M9D2qKTtl0eSw7BN4HelhTYI3g6MwBPM=;
  b=IMtI7D8WqgUQeUX4g2niLXOa0/zR1nyFtFoWY901xOItDki2JI+r6Ql1
   YLG5+UYMscMJNd/QWGlaq7WTF1VP6xBi1jQacY9ZsFhB/W0A5uV+ySgUT
   Lb64CkwaM0B2hEsOtxBfwLi1tb+0nb39LEQAMPbGvfonWhQR92fBaVToD
   g=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0ADAADtsUdc/49dJa1jGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAQGBUQQBAQEBAQsBggOBaCcKjBGLbYINmAGBewsBAYRsAoJ?=
 =?us-ascii?q?tIjQJDQEDAQECAQECbSiFSgEBAQECAScTPwULAgEIGB4QMiUCBA4FgyKBegi?=
 =?us-ascii?q?uXTOKMIxBF4FAP4ERJx+CTIUBgzqCJgKJWwqBe4YCkD4JApIZGJIULZpJAhE?=
 =?us-ascii?q?UgScfOIFWcBVlAYJBgicXE44LQTGJeIEfAQE?=
X-IronPort-AV: E=Sophos;i="5.56,508,1539648000"; 
   d="scan'208";a="290294756"
Received: from rcdn-core-7.cisco.com ([173.37.93.143])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jan 2019 00:16:54 +0000
Received: from XCH-RCD-020.cisco.com (xch-rcd-020.cisco.com [173.37.102.30])
        by rcdn-core-7.cisco.com (8.15.2/8.15.2) with ESMTPS id x0N0Grs2020024
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 23 Jan 2019 00:16:53 GMT
Received: from xch-rcd-018.cisco.com (173.37.102.28) by XCH-RCD-020.cisco.com
 (173.37.102.30) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 22 Jan
 2019 18:16:53 -0600
Received: from xch-rcd-018.cisco.com ([173.37.102.28]) by
 XCH-RCD-018.cisco.com ([173.37.102.28]) with mapi id 15.00.1395.000; Tue, 22
 Jan 2019 18:16:53 -0600
From:   "Parvi Kaustubhi (pkaustub)" <pkaustub@cisco.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Christian Benvenuti (benve)" <benve@cisco.com>,
        "Nelson Escobar (neescoba)" <neescoba@cisco.com>
Subject: Re: [PATCH 7/8] infiniband: usnic: no need to check return value of
 debugfs_create functions
Thread-Topic: [PATCH 7/8] infiniband: usnic: no need to check return value of
 debugfs_create functions
Thread-Index: AQHUsmW8RX8zdsvpDkSafppKoQ9GC6W8YaoA
Date:   Wed, 23 Jan 2019 00:16:53 +0000
Message-ID: <A20ACC86-F6C9-4C38-8D63-535BB8CC42F9@cisco.com>
References: <20190122151800.15092-1-gregkh@linuxfoundation.org>
 <20190122151800.15092-8-gregkh@linuxfoundation.org>
In-Reply-To: <20190122151800.15092-8-gregkh@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.155.164.169]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ECB2F791956F1D4A98417EA95093D4D1@emea.cisco.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Outbound-SMTP-Client: 173.37.102.30, xch-rcd-020.cisco.com
X-Outbound-Node: rcdn-core-7.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usnic driver was tested with this change.

Acked-by: Parvi Kaustubhi <pkaustub@cisco.com>

> On Jan 22, 2019, at 7:17 AM, Greg Kroah-Hartman <gregkh@linuxfoundation.o=
rg> wrote:
>=20
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
>=20
> Cc: Christian Benvenuti <benve@cisco.com>
> Cc: Nelson Escobar <neescoba@cisco.com>
> Cc: Parvi Kaustubhi <pkaustub@cisco.com>
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: linux-rdma@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> drivers/infiniband/hw/usnic/usnic_debugfs.c | 26 ---------------------
> 1 file changed, 26 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/usnic/usnic_debugfs.c b/drivers/infini=
band/hw/usnic/usnic_debugfs.c
> index a3115709fb03..e5a3f02fb078 100644
> --- a/drivers/infiniband/hw/usnic/usnic_debugfs.c
> +++ b/drivers/infiniband/hw/usnic/usnic_debugfs.c
> @@ -113,42 +113,21 @@ static const struct file_operations flowinfo_ops =
=3D {
> void usnic_debugfs_init(void)
> {
> 	debugfs_root =3D debugfs_create_dir(DRV_NAME, NULL);
> -	if (IS_ERR(debugfs_root)) {
> -		usnic_err("Failed to create debugfs root dir, check if debugfs is enab=
led in kernel configuration\n");
> -		goto out_clear_root;
> -	}
>=20
> 	flows_dentry =3D debugfs_create_dir("flows", debugfs_root);
> -	if (IS_ERR_OR_NULL(flows_dentry)) {
> -		usnic_err("Failed to create debugfs flow dir with err %ld\n",
> -				PTR_ERR(flows_dentry));
> -		goto out_free_root;
> -	}
>=20
> 	debugfs_create_file("build-info", S_IRUGO, debugfs_root,
> 				NULL, &usnic_debugfs_buildinfo_ops);
> -	return;
> -
> -out_free_root:
> -	debugfs_remove_recursive(debugfs_root);
> -out_clear_root:
> -	debugfs_root =3D NULL;
> }
>=20
> void usnic_debugfs_exit(void)
> {
> -	if (!debugfs_root)
> -		return;
> -
> 	debugfs_remove_recursive(debugfs_root);
> 	debugfs_root =3D NULL;
> }
>=20
> void usnic_debugfs_flow_add(struct usnic_ib_qp_grp_flow *qp_flow)
> {
> -	if (IS_ERR_OR_NULL(flows_dentry))
> -		return;
> -
> 	scnprintf(qp_flow->dentry_name, sizeof(qp_flow->dentry_name),
> 			"%u", qp_flow->flow->flow_id);
> 	qp_flow->dbgfs_dentry =3D debugfs_create_file(qp_flow->dentry_name,
> @@ -156,11 +135,6 @@ void usnic_debugfs_flow_add(struct usnic_ib_qp_grp_f=
low *qp_flow)
> 							flows_dentry,
> 							qp_flow,
> 							&flowinfo_ops);
> -	if (IS_ERR_OR_NULL(qp_flow->dbgfs_dentry)) {
> -		usnic_err("Failed to create dbg fs entry for flow %u with error %ld\n"=
,
> -				qp_flow->flow->flow_id,
> -				PTR_ERR(qp_flow->dbgfs_dentry));
> -	}
> }
>=20
> void usnic_debugfs_flow_remove(struct usnic_ib_qp_grp_flow *qp_flow)
> --=20
> 2.20.1
>=20

