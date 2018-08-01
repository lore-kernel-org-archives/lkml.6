Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F94C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EEEE20862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="S0TyEPod"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EEEE20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389899AbeHAR1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:27:19 -0400
Received: from mail-eopbgr690056.outbound.protection.outlook.com ([40.107.69.56]:32235
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389698AbeHAR1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6umbt6cc0cKMUGYoWpSVrxJJ7piLH3VTcvCds69PaSw=;
 b=S0TyEPodYAbL7eK5OR32PKic27ksHFPshHgYsB51Y68/uvNHNLcdBiJHBK72GbX1ERS1YIbmIrZmlBrfh+1aMDRxxCVgwLA2RUMpZtXCG4cuUo38ZpfZsHUHVWyRVuQ7tHZ/u5bmj/3ipe7UI3dp6+pgH/j6oD0+mP56zwLZhUE=
Received: from CY4PR12MB1557.namprd12.prod.outlook.com (10.172.69.23) by
 CY4PR12MB1528.namprd12.prod.outlook.com (10.172.67.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.17; Wed, 1 Aug 2018 15:40:59 +0000
Received: from CY4PR12MB1557.namprd12.prod.outlook.com
 ([fe80::9590:a83f:9048:26ea]) by CY4PR12MB1557.namprd12.prod.outlook.com
 ([fe80::9590:a83f:9048:26ea%6]) with mapi id 15.20.0995.020; Wed, 1 Aug 2018
 15:40:59 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>, "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH] x86/mce: Handle varying MCA bank counts
Thread-Topic: [PATCH] x86/mce: Handle varying MCA bank counts
Thread-Index: AQHUJfJxiibkEK2MV0iFZNwSlQkDKqSjoNMAgAdsq6A=
Date:   Wed, 1 Aug 2018 15:40:59 +0000
Message-ID: <CY4PR12MB1557FDF59F92E81601BD7E10F82D0@CY4PR12MB1557.namprd12.prod.outlook.com>
References: <20180727214009.78289-1-Yazen.Ghannam@amd.com>
 <20180727220833.GA30752@agluck-desk>
In-Reply-To: <20180727220833.GA30752@agluck-desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:3c2:8280:2327:2521:b1c7:1f4e:bd10]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR12MB1528;20:DOSDdg/xW5y4AUsnkK++mQ+4voDm+1IwrV5EEKvW9/41zm8szlizBS4AopxgAxhi9DroJkJQ4m0vlzfjK+uT0TzGoqr5kWoEEyNKPlmTCUpfa0Pr2O6PVquw9zUQC4CfMPvLLiMGie9QT3FQ8H8Sj4xinC7K8B1d2MLp+L1nyYX5E0KxHFhoe9oNWnNnzrVYemXe23ROZcO2lPMcuQNujnmb88OVNHfDNRM9AowxT6LTahgPgXrp4oJOMEhIQoUY
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 17f03ce2-51ff-423e-1836-08d5f7c52e36
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1528;
x-ms-traffictypediagnostic: CY4PR12MB1528:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-microsoft-antispam-prvs: <CY4PR12MB1528813EEAA176BEE52FAFDBF82D0@CY4PR12MB1528.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CY4PR12MB1528;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1528;
x-forefront-prvs: 0751474A44
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(136003)(346002)(396003)(189003)(199004)(13464003)(9686003)(305945005)(53546011)(2900100001)(2906002)(478600001)(55016002)(105586002)(6116002)(102836004)(53936002)(72206003)(33656002)(106356001)(186003)(476003)(81166006)(14454004)(5660300001)(5250100002)(74316002)(25786009)(7736002)(15650500001)(99286004)(6916009)(7696005)(46003)(86362001)(8676002)(97736004)(54906003)(446003)(4326008)(6436002)(486006)(76176011)(256004)(8936002)(81156014)(6506007)(229853002)(316002)(68736007)(11346002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1528;H:CY4PR12MB1557.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: g8bUcmnvPEMBjQhR/77jmm7CY/kkAy6iPjwTw4ki6W/B5ybZo4l+JFKbk6Wi1vNCrhJ/fOiiLb2e2tUE6IdC8LAzrov5TQhJzmVWzTp8iaC8XyxrVJ7DcZvEz8VfjnCr8MYWMRyBSuHO5GCLvy05Dz8obzjY7HZna/xVWPqHjt31AdDQ15LzvvC2nypEqNXEO9tWkPCRBGuMJpUG4NFSWbnDG0JB5o/BlDcW5ndRMGmxS/RkPtHcZMXpMIi7m5ZoqGkpz8YGnQrOFusBsW8o64F38kPV07FNuBzM2qXxcT6pWJfE8t2oAZvcbsQmdvrRvrccYyaNZPBv1kqAuNRnS0NfebP7zC+OhjcV6DgIcdI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f03ce2-51ff-423e-1836-08d5f7c52e36
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2018 15:40:59.7926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1528
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Luck, Tony <tony.luck@intel.com>
> Sent: Friday, July 27, 2018 5:09 PM
> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Cc: linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org; bp@suse.de;
> x86@kernel.org
> Subject: Re: [PATCH] x86/mce: Handle varying MCA bank counts
>=20
> On Fri, Jul 27, 2018 at 04:40:09PM -0500, Yazen Ghannam wrote:
> > -	/* Don't support asymmetric configurations today */
> > -	WARN_ON(mca_cfg.banks !=3D 0 && b !=3D mca_cfg.banks);
> > -	mca_cfg.banks =3D b;
> > +	mca_cfg.banks =3D max(mca_cfg.banks, b);
>=20
> Should we change mca_cfg.banks to be a per-cpu variable?
>=20
> 	DEFINE_PER_CPU(int, mce_num_banks);
>=20
> That would make it easier to make sure the places
> that scan all banks only look at the ones that exist.
>=20

I agree and I'd like to do that in future patches. But it'll require change=
s in
a few other places, and possibly breaking more assumptions in the code.

I'd like to address this issue in a smaller patch and submit it to the stab=
le
branches. And we can redo things as per_cpu going forward.

Thanks,
Yazen
