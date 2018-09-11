Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F39C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36EBB20854
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="YiS4JrMi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36EBB20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbeIKNDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 09:03:02 -0400
Received: from mail-dm3nam03on0081.outbound.protection.outlook.com ([104.47.41.81]:18944
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726488AbeIKNDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 09:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6Eji2jgaoTwAo9NvrC+KaSVS+nruJ74L3WoKRrD3yM=;
 b=YiS4JrMiiiN3bs7icyyLKfO27nb8+31DMdV0MunqRtpp2YxfGAgbOYtJMeNBj4v2q9boqpDejH6wCYchmlxbgv2r6fdEBJ3HND0tdd6TPH2T47h+SR9RG2vfMyRUJ75yuGZJbdX2QjJyxQ9fv61tP2yNMAsQnBTeWfuHhB5Mi3M=
Received: from BN3PR0201MB0993.namprd02.prod.outlook.com (10.161.207.14) by
 BN3PR0201MB0884.namprd02.prod.outlook.com (10.160.154.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.17; Tue, 11 Sep 2018 08:04:50 +0000
Received: from BN3PR0201MB0993.namprd02.prod.outlook.com
 ([fe80::29f7:170b:ce40:9b2e]) by BN3PR0201MB0993.namprd02.prod.outlook.com
 ([fe80::29f7:170b:ce40:9b2e%7]) with mapi id 15.20.1143.010; Tue, 11 Sep 2018
 08:04:42 +0000
From:   Anurag Kumar Vulisha <anuragku@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     "kishon@ti.com" <kishon@ti.com>, Michal Simek <michals@xilinx.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "vivek.gautam@codeaurora.org" <vivek.gautam@codeaurora.org>,
        "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] phy: zynqmp: Add phy driver for xilinx zynqmp phy
 core
Thread-Topic: [PATCH v3 1/2] phy: zynqmp: Add phy driver for xilinx zynqmp phy
 core
Thread-Index: AQHURTd3PNqvUueTTkW+ldEgMOgvCqTp+5OAgACmGOA=
Date:   Tue, 11 Sep 2018 08:04:41 +0000
Message-ID: <BN3PR0201MB09937FA5CE658BFD974146CBA7040@BN3PR0201MB0993.namprd02.prod.outlook.com>
References: <1536165747-6405-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1536165747-6405-2-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <20180910201523.GA4024@bogus>
In-Reply-To: <20180910201523.GA4024@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN3PR0201MB0884;6:TzUMTaI+LUp1tYV1KvoJTfmOcfW5QUG+9XqnxERuteJELTG4/SaCOVlPCvad3LKwfol+X9YVhzndeikVCP6wOm4RXgMkd7uCkHXuhbgcocgO4/ojLI6FZeYMuqZ3oWLD3IikCRgsDCIRKWSbaTXl+qj9YyxcgPhncudQ2q9brfgzU4H0JQTRwOpziBc2ZwhLwNO9tXRZHyTvAPmGOd0FjY2yD+PgkJoTn9PkCMw/2BQqhNmrVqMMxtyQRlKoGFCEZCrCW4kVGQBC4P2Qwjcanr7dHl/74pOwLY04FtLQOxyD6SlM03/U04cqbDq8ML81LLm58Vg81IWtlZHpC6HAAMnXpJUMzBo02K//cxFvA2lhvdpC/azTn8vv2C0fFA6vHENsjXC/9UWsyC3lkdu5bMBLF2soN2y+D7NKSbXmypir/M8lizCmFjAC0QTlHHIWd8OvGPxUGxmD6wWa+s1k0A==;5:GVMLkigrb4lcHZj47j56puamIKk9C9ptwOS8HlurmcHQQp4IgiezXMw8Ac07IdXSyZGDQA5JY/Zpc+5DV80JhjobN17lvBHPqd5ujLrNSz4pJKWTreRfbucmh7D/qxl2zCzl+DndgTYGXeFUgr3jchNJ4IZtM1F/6MDwbPMDcKg=;7:wT6/2ZLoh9ht9x65aUPDTGCv6DSRQQP5MOLaOfaoTjPR3dJObq599dPmZYV3ENjlN1icXSYr7O8d1ucCdgm3JVOCajLKr1srAHB15XOC+O7fjFRe4RpCKRWrTNTlPPO56fXw6y10kVsA8vYAPwsILjrVspFLehlYIlooHbR7nQGb71nlIYG0P3T1x6xSaEP5NaWUK3dVbqe+AsnRGsm3BbNFQN6CaUyFiUOIwa1+1mCjmxQS5DweQ9fgT1jXlC+4
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 48b36432-d728-4f9a-aa1c-08d617bd3b00
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN3PR0201MB0884;
x-ms-traffictypediagnostic: BN3PR0201MB0884:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BN3PR0201MB0884143EB5481DA263529664A7040@BN3PR0201MB0884.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:BN3PR0201MB0884;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0201MB0884;
x-forefront-prvs: 0792DBEAD0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(366004)(396003)(39860400002)(199004)(189003)(81156014)(81166006)(8936002)(66066001)(25786009)(8676002)(2900100001)(229853002)(7696005)(6246003)(99286004)(97736004)(6916009)(316002)(14454004)(6116002)(3846002)(55016002)(4326008)(5660300001)(68736007)(6506007)(86362001)(478600001)(5250100002)(2906002)(305945005)(7736002)(186003)(486006)(102836004)(54906003)(6436002)(39060400002)(256004)(106356001)(76176011)(105586002)(74316002)(11346002)(446003)(476003)(33656002)(53936002)(9686003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0201MB0884;H:BN3PR0201MB0993.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Z0t7AVf4bZD1wrxeSxfMtpo3T/RMGloHnkZVylbLi3HIydl/zFu6wNgmscPPt0iL64iM8eOhFdys/FB2nuUXDELngXEklnByeuZr1NnObq6szDyGUBATDpDfttpqSmSuBKblzwHT9DXa0xRDuRdBwKw0XiuJ8eEtraHwQUadlZdoIc6+DLwpUeI1rSCX9ogNi+TfR/x4BLGI1DkoEJsAyU+432kEQa/D6Iyf9yusJUYa32prCcNZgSnEaMIo3lD2uCuiNpO2LHifBFjSn3TrxnOnhd4ETNZ0CWwa4qmGrWFBPjaWkz/0jKn06uPqYmesyQfITGUVWAyOvqX3c7+/HYXxI4QDuvC4a5pZXgzUtfw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b36432-d728-4f9a-aa1c-08d617bd3b00
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2018 08:04:41.9456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0201MB0884
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rob,

Thanks a lot for spending your time in reviewing this patch series,=20

>> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
>> ---
>> Changes in v3:
>> 	1. Corrected the Documentation as suggested by Vivek Gautam
>>
>> Changes in v2:
>> 	1. Fixed the compilation error when compiled phy-zynqmp.c as a module
>> 	2. Added CONFIG_PM macro in phy-zynqmp.c driver
>> ---
>>  drivers/phy/Kconfig            |    8 +
>>  drivers/phy/Makefile           |    1 +
>>  drivers/phy/phy-zynqmp.c       | 1581
>++++++++++++++++++++++++++++++++++++++++
>>  include/dt-bindings/phy/phy.h  |    2 +
>
>This goes in patch 2. And patch 2 should come first.
>

Will fix this in the next series of the patch

Thanks,
Anurag Kumar Vulisha

>>  include/linux/phy/phy-zynqmp.h |   52 ++
>>  5 files changed, 1644 insertions(+)
>>  create mode 100644 drivers/phy/phy-zynqmp.c  create mode 100644
>> include/linux/phy/phy-zynqmp.h
