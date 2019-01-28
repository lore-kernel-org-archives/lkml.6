Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D39C282CF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709D92086C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ve27AqqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388017AbfA1QQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:16:41 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:56127 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387984AbfA1QQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:16:38 -0500
X-IronPort-AV: E=Sophos;i="5.56,534,1539673200"; 
   d="scan'208";a="26011205"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 28 Jan 2019 09:16:37 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 28 Jan 2019 09:16:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91aA2Xt8OnWpsWyNlgfmkHt3zTMfFCBDks5elU6JjHk=;
 b=ve27AqqZAmUz5fZZz5aCYsbLUj/OXhXYHNr43VjUNmLtmYRhUW5M3MpxIXhNfOSSaH1rVactsPgMlTQMqKjuVg3yGr7Oxhng/K1FVqdOPiBjI7rhMarIpLbIqJAS54T+2rL5kdPTj8VJqxxVLv6NgSHe0fSH1UBRuMmE+sTkr9w=
Received: from SN6PR11MB2767.namprd11.prod.outlook.com (52.135.92.154) by
 SN6PR11MB3437.namprd11.prod.outlook.com (52.135.127.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.18; Mon, 28 Jan 2019 16:16:34 +0000
Received: from SN6PR11MB2767.namprd11.prod.outlook.com
 ([fe80::509:4b08:4635:d702]) by SN6PR11MB2767.namprd11.prod.outlook.com
 ([fe80::509:4b08:4635:d702%4]) with mapi id 15.20.1558.023; Mon, 28 Jan 2019
 16:16:34 +0000
From:   <Don.Brace@microchip.com>
To:     <natechancellor@gmail.com>, <axboe@kernel.dk>,
        <aacraid@microsemi.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <manoj@linux.ibm.com>,
        <mrochs@linux.ibm.com>, <ukrishn@linux.ibm.com>,
        <linuxdrivers@attotech.com>, <don.brace@microsemi.com>,
        <brking@us.ibm.com>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <esc.storagedev@microsemi.com>,
        <ndesaulniers@google.com>, <bvanassche@acm.org>
Subject: RE: [PATCH v4] scsi/ata: Use unsigned int for cmd's type in ioctls in
 scsi_host_template
Thread-Topic: [PATCH v4] scsi/ata: Use unsigned int for cmd's type in ioctls
 in scsi_host_template
Thread-Index: AQHUtUw5Iv4omr4Hm0S7EARd/t3s86XE3how
Date:   Mon, 28 Jan 2019 16:16:34 +0000
Message-ID: <SN6PR11MB2767DF2A2BEF95EE07C15172E1960@SN6PR11MB2767.namprd11.prod.outlook.com>
References: <20190114044206.6351-1-natechancellor@gmail.com>
 <20190126075256.29608-1-natechancellor@gmail.com>
In-Reply-To: <20190126075256.29608-1-natechancellor@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Don.Brace@microchip.com; 
x-originating-ip: [216.54.225.58]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR11MB3437;6:2ozdthxINxmpblUdpMo275V0ZfWCdjIt5AZh3YbaJO6PBRUshE1mxCcuwJtmGTxmLAwueTw1TVCvc88gkWFgB4oGIYJs7Mf9o07uxMeRCisH7YF+T3g28CXUF0HuvDEN88/YzPFsLqvZVmfVgyTSWw/usC8spRHm8MF9aBfsLYWCltBKkz7YOleMHhDp4W2zuTdcLlC/0JvME1ec+Us/LAUkWpdkbe2lLhGiARL2zAH2FlkebwUOUb3mtzJIRywMxhtZrjN1QAY9ZEwihE97EFYLqWUkUUQR0rnywdM8TXIPf929Z2VXXIlvLIrApYnCSlsjb/cOoARtbkfjx5+L9qBwd4k4RqS1Ay86ro54LNQd1aBAC6AVwh5oZLDom5hKrL0OYdx10QlYfsSJEJCPilXOsenInVrGUh/fWp02P3Cdd8eDOVdpqHPFKa3RXPx2NsvyoE5fy9R54pq5frZvkw==;5:2OoIWjFDo5OttXiFA5fbW826o/fvjuT/q4g+89oH4yUXREX6mHXN3Op9p43rMuFTtUmk6M/QYkyiXWyTb8q8WbfOU0TaeTJPHYQaD6AJx20tdFeFnQ++627EdL9WwS/ZUbBBwGXgE1PUuMz1joWJrex4Z9VizURvkHnAKc9+ZglM8eKcUGiYwjbXnlQdFwFj/82BuWxwTzOqwFOM1VWYfQ==;7:oWMryqbSxQMG2CAHB4MuVmUulijAZb8whn7tBZaYtBRksfOAjFOWCMLzAfc5Ocy+0EIWJkkZiZDurjfrIEVjCO96wI9qSv5gNWkWytpzsbZHd1Exb/Ha+e5OQgLRh0eX85n06U5Pb8dDMBQRzlFY+w==
x-ms-office365-filtering-correlation-id: b3259446-ee3d-46d8-dbb4-08d6853bf8cc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:SN6PR11MB3437;
x-ms-traffictypediagnostic: SN6PR11MB3437:
x-microsoft-antispam-prvs: <SN6PR11MB3437BF92AAA8D514C96BCE79E1960@SN6PR11MB3437.namprd11.prod.outlook.com>
x-forefront-prvs: 0931CB1479
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(396003)(366004)(39860400002)(199004)(189003)(2906002)(106356001)(102836004)(110136005)(54906003)(99286004)(11346002)(97736004)(74316002)(478600001)(7736002)(305945005)(256004)(14444005)(26005)(316002)(446003)(14454004)(86362001)(486006)(105586002)(6506007)(3846002)(6116002)(53936002)(966005)(229853002)(6246003)(55016002)(39060400002)(476003)(72206003)(76176011)(6306002)(33656002)(9686003)(8676002)(186003)(8936002)(81156014)(81166006)(25786009)(6436002)(66066001)(7416002)(71190400001)(71200400001)(7696005)(68736007)(4326008)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR11MB3437;H:SN6PR11MB2767.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VjIxO/54x9i4ABoEdxdE6quXK63XIjIKthDbBefJAS2KnBOOQVNLN7rbRg4ffPXyEqqFzObbfmI6VijLf3OfUnABfyGhDGGOzMobGybogKNchyuzY5mhBkd3yByfuABypTafug1A+v31pEw4HW2jU910DbUwGoT9ZMFRHqNUAaQv4BayS10HsibrKstm1SBytFV79V10SdqYOz6H7Z05RSogG+JeqF8ASY/U0QblsrjNN8iN3TcmWrY5CbaB1QErLcxxka1uqsM5yggsaPdk3QZoFyaUrWWk1UaAQz8GWHVv5ArzEqPEG7yXVOl+ngXE7vQFBAZk9G1kJ/5/Ziqxet8HNrsQhvoB/W0tqiAh/R1rfOuSmhkSfuliaxt5kwN6Lv8NyQQBrjcyrB4m5ZYAN7nQBxOW8/DKxZ766CoMbVw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b3259446-ee3d-46d8-dbb4-08d6853bf8cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2019 16:16:34.1852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3437
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Clang warns several times in the scsi subsystem (trimmed for brevity):

drivers/scsi/hpsa.c:6209:7: warning: overflow converting case value to swit=
ch condition type (2147762695 to 18446744071562347015) [-Wswitch]
        case CCISS_GETBUSTYPES:
             ^
drivers/scsi/hpsa.c:6208:7: warning: overflow converting case value to swit=
ch condition type (2147762694 to 18446744071562347014) [-Wswitch]
        case CCISS_GETHEARTBEAT:
             ^

The root cause is that the _IOC macro can generate really large numbers, wh=
ich don't find into type 'int', which is used for the cmd paremeter in the =
ioctls in scsi_host_template. My research into how GCC and Clang are handli=
ng this at a low level didn't prove fruitful. However, looking at the rest =
of the kernel tree, all ioctls use an 'unsigned int' for the cmd parameter,=
 which will fit all of the _IOC values in the scsi/ata subsystems.

Make that change because none of the ioctls expect to take a negative value=
, it brings the ioctls inline with the reset of the kernel, and it removes =
ambiguity, which is never good when dealing with compilers.

Link: https://github.com/ClangBuiltLinux/linux/issues/85
Link: https://github.com/ClangBuiltLinux/linux/issues/154
Link: https://github.com/ClangBuiltLinux/linux/issues/157
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>

 static void __exit esas2r_exit(void)
diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c index ff67ef5d5347..=
28cfd3d01c5a 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -251,10 +251,11 @@ static int number_of_controllers;

Acked-by: Don Brace <don.brace@microsemi.com>

=20
diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/=
smartpqi_init.c
index f564af8949e8..5d9ccbab7581 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -6043,7 +6043,8 @@ static int pqi_passthru_ioctl(struct pqi_ctrl_info *c=
trl_info, void __user *arg)
 	return rc;
 }

Acked-by: Don Brace <don.brace@microsemi.com>
=20

