Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C422C282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFFA22084A
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VlS+vM6d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfBBBGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 20:06:31 -0500
Received: from mail-eopbgr1310098.outbound.protection.outlook.com ([40.107.131.98]:28931
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726217AbfBBBGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 20:06:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONp4JLOtPMW1ARvSgJyT0d5+L4ppjOSNf7HC60JAcnE=;
 b=VlS+vM6dPOKwYgqlsJK0Vo4i+O+IPy//TLU66Ju7gnE+i7Gp/Ps/HGDeCehL9dsXTB7XhMBahFBIQeHJ1UQd05NWrg1IxeNjXN75gh6w6/P4N99CWEEiy6n/9rAz2rHhHf3IULE4TvVU66ZroMAMYx2EBVHDtILAz+q6fkc8wOw=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0202.APCP153.PROD.OUTLOOK.COM (52.133.192.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.6; Sat, 2 Feb 2019 01:06:18 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f%9]) with mapi id 15.20.1601.011; Sat, 2 Feb 2019
 01:06:18 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Josh Poulson <jopoulso@microsoft.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Ross Zwisler <zwisler@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>, Len Brown <lenb@kernel.org>
Subject: RE: [PATCH v2] nfit: add Hyper-V NVDIMM DSM command set to white list
Thread-Topic: [PATCH v2] nfit: add Hyper-V NVDIMM DSM command set to white
 list
Thread-Index: AdS3bN9R4nkrWGwLQkueB3AG7WN74AA93MgAAHsdi6AAALlsgAAB+BMAAAs5uIAAAJW/gAABbyoA
Date:   Sat, 2 Feb 2019 01:06:18 +0000
Message-ID: <PU1P153MB0169D661955195EA070E7EF0BF930@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <PU1P153MB01690EDA138D3ABDE5B4A482BF970@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4jD1oRWzA4ZiMYZm1uxsbOdgqzbb9raH70-HBDqapcE_g@mail.gmail.com>
 <PU1P153MB0169977604493B82B662A01CBF920@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4haUouYs_Vfju2SMvjcwc7rqY06zqT8NJ-3uakGMZSu0w@mail.gmail.com>
 <PU1P153MB01694FCAF062E089059CD441BF920@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4gdWJ8qtiASU9ggz56Mkrm9OXfsO74RM9OOrXFmBw_A9Q@mail.gmail.com>
 <PU1P153MB0169D8F7C6E29C22FE122F3FBF930@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PU1P153MB0169D8F7C6E29C22FE122F3FBF930@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-02-02T00:34:12.6429755Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=27c1866a-708c-47ae-aca6-293447c2a175;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [167.220.2.92]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0202;6:E+Rmx9I2H9/KN7c938vonZV4uOrxHkXlyQBRP6iuIi+yiYleDruvLK8rOuYSga1nxCHZErRKNFqUYfahM5R0WsrFblT51hbkxoN92IWNoJHUaVzUS8MCv1HhJ+1wq1Tm/8+93wyZG8u8l5KkweiB2xJK6vQ6dJCHgcnPoR6HYnjhNQ6DtS0DVN4HB2c788tUVNXGjnS7Rrks9XbXwe63OWohq4Y6sTSZ+eDI8GkqgsISiKp9ncCeadL2ooGamFA93fAZIEC4/w+ftW28aJyDQ0zl5vX920uyWTmuDAgNqyIEGS/B3udBHpqrRZtiWAWVSVwO3F8Vok1ZjuGQCmAZNbUsavvogH9eyVisGsULqJgckqRkIy58zaxifngeB6vhTIxLj8hmWVeC7W2sAe+Vz678OeedUqbKczaDtnQ5kZ4bPw3fOL/GyYm6XDG/T23k9C9kSs/YK+QaG97a7aavqQ==;5:rwdQ9UDgPD8c8cL5OX+e4GMdDqLteCYBejyPcBm1Eq9Bkncugw7kJ+IAI0Xivu6BVDJcgNuyI+XcGfUIab0tDFB9GO90L3/Yl6TzzmJUxyZ/t1/ZAKNHoifan0UuynQnWfXDqObdeIcVtS8CiLisWUrqT4X4TAfTRi4nNZJ8cTaeOvbyrMtBZVejEmEd5OyBaA3eRCyjBEDWCXFf9cO4sw==;7:CQr4IwO18qAwgG6WKd4KhqZb348k+uQthUIKqPXtXe0eCjKtf9ciAZqtLmMvwgtV/6EYpHMOJGIzZ0yFmxvRM0xppQX9+PviikF95vLAOQOJhxdR2bJ19CuphP1c1g5Hw8bx1wdJYucAhoQ9dVYHcA==
x-ms-office365-filtering-correlation-id: b9d0a3a1-7149-42db-10cd-08d688aaa385
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0202;
x-ms-traffictypediagnostic: PU1P153MB0202:
x-microsoft-antispam-prvs: <PU1P153MB0202B00B45CD6DC1D45C4E5DBF930@PU1P153MB0202.APCP153.PROD.OUTLOOK.COM>
x-forefront-prvs: 09368DB063
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(39860400002)(346002)(396003)(366004)(199004)(189003)(93156006)(7696005)(186003)(8936002)(76176011)(6506007)(81156014)(81166006)(478600001)(8676002)(102836004)(33656002)(26005)(68736007)(229853002)(256004)(2906002)(217873002)(2940100002)(97736004)(66066001)(14444005)(86362001)(476003)(486006)(11346002)(25786009)(446003)(3846002)(1511001)(6116002)(14454004)(71190400001)(71200400001)(4326008)(10090500001)(105586002)(93886005)(22452003)(9686003)(10290500003)(55016002)(316002)(99286004)(110136005)(54906003)(106356001)(74316002)(53936002)(6436002)(6246003)(7736002)(8990500004)(86612001)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0202;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +vPfFIsq9tw4lJuQtm6YzbT0XI4Yn7SQlnrWHnFvKWujS5WHPrhIXqsBTWR0NnFU+3JfJlrY+DaYjFTSAGl01ryCtLZKfv5l61KEcEA7wuIjgJs2v1INgk9XLOtmv4r3L3T4o+RU04uIvdhAm9WknvRHogprbAtW/r0+F/Ffwa8jJeCYSDgL0ewmuAY7Zc3vunWF1evzu06WmbivdeliziJVX5E5rkGJ9eY2FLSh0FXralr9wqQlhYaSem02rlXrtO7obBEl770Sbf/zW1NazRLKEmYM/tOfIdOz7lwnG/G32bxliOOSud4wS8KQWDew2d5Qba5rTssz6XQIip6q2D6HnyXwxhIaYby6tg+wWFqiu+rfgL4jcbAzdo/dtzOpGcwOqXrdHT+OQe6M7cE4nP4XzsPcoMTwovdBYmBFhSY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d0a3a1-7149-42db-10cd-08d688aaa385
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 01:06:18.4281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0202
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Linux-nvdimm <linux-nvdimm-bounces@lists.01.org> On Behalf Of
> Dexuan Cui
> Sent: Friday, February 1, 2019 4:34 PM
> > > > ...
> > > > Those reads find a namespace index block
> > > > and a label. Unfortunately the label has the LOCAL flag set and Lin=
ux
> > > > explicitly ignores pmem namespace labels with that bit set. The rea=
son
> > > > for that is due to the fact that the original definition of the LOC=
AL
> > > > bit from v1.1 of the namespace label implementation [1] explicitly
> > > > limited the LOCAL flag to "block aperture" regions. If you clear th=
at
> > > > LOCAL flag I expect it will work. To my knowledge Windows pretends
> > > > that the v1.1 definition never existed.

On the libnvdimm-pending branch, I get this:

root@decui-gen2-u1904:~/nvdimm# ndctl list
root@decui-gen2-u1904:~/nvdimm# ndctl list --idle
[
  {
    "dev":"namespace1.0",
    "mode":"raw",
    "size":0,
    "uuid":"00000000-0000-0000-0000-000000000000",
    "state":"disabled"
  },
  {
    "dev":"namespace0.0",
    "mode":"raw",
    "size":0,
    "uuid":"00000000-0000-0000-0000-000000000000",
    "state":"disabled"
  }
]

With the patch that clears the LOCAL label (BTW, the initial value of flags=
 is 0x3,
meaning a read-only local label) :
@@ -2496,6 +2500,7 @@ static int init_active_labels(struct nd_region *nd_re=
gion)
                        if (!label_ent)
                                break;
                        label =3D nd_label_active(ndd, j);
+                       label->flags &=3D ~NSLABEL_FLAG_LOCAL;
                        label_ent->label =3D label;

I get this:

root@decui-gen2-u1904:~/nvdimm# ndctl list
root@decui-gen2-u1904:~/nvdimm# ndctl list --idle
[
  {
    "dev":"namespace1.0",
    "mode":"raw",
    "size":0,
    "uuid":"c258aaab-f72b-e546-bfa5-be5e07761dbc",
    "state":"disabled",
    "name":"Microsoft Hyper-V NVDIMM 1 Label"
  },
  {
    "dev":"namespace0.0",
    "mode":"raw",
    "size":0,
    "uuid":"9f0497a7-4453-7c40-ad35-21a791e00345",
    "state":"disabled",
    "name":"Microsoft Hyper-V NVDIMM 0 Label"
  }
]

The "size" and "mode" still don't look right, but the improvement is that
now I can see a good descriptive "name", which I suppose is retrieved
from Hyper-V.

With Ubuntu 19.04 (4.18.0-11-generic), I get this:
(Note: the "mode" and "size" are correct. The "uuid" is different from
the above "9f0497a7-4453-7c40-ad35-21a791e00345" -- this is weird.)=20

root@decui-gen2-u1904:~# ndctl list
[
  {
    "dev":"namespace1.0",
    "mode":"raw",
    "size":137438953472,
    "blockdev":"pmem1"
  },
  {
    "dev":"namespace0.0",
    "mode":"fsdax",
    "map":"dev",
    "size":33820770304,
    "uuid":"35018886-397e-4fe7-a348-0a4d16eec44d",
    "blockdev":"pmem0"
  }
]
=20
I'm trying to find out the correct solution. I apprecite your insights!

Thanks,
-- Dexuan
