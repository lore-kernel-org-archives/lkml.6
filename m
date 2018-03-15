Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932418AbeCOOzZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 10:55:25 -0400
Received: from mail-ve1eur01on0083.outbound.protection.outlook.com ([104.47.1.83]:50802
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752736AbeCOOzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 10:55:19 -0400
From: York Sun <york.sun@nxp.com>
To: Borislav Petkov <bp@alien8.de>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>
Subject: Re: [PATCH RFC 1/2] drivers/edac: Add L1 and L2 error detection for
 A53 and A57
Thread-Topic: [PATCH RFC 1/2] drivers/edac: Add L1 and L2 error detection for
 A53 and A57
Thread-Index: AQHTu/Mc+CsInsRsN0uQgig0C2tI2A==
Date: Thu, 15 Mar 2018 14:55:16 +0000
Message-ID: <VI1PR04MB207810C8915A0A19F52680579AD00@VI1PR04MB2078.eurprd04.prod.outlook.com>
References: <1521073067-24348-1-git-send-email-york.sun@nxp.com>
 <20180315010728.GF11061@pd.tnic>
 <VI1PR04MB20785DE79A7D33D453FF79869AD00@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180315101725.GC27816@pd.tnic>
Reply-To: York Sun <york.sun@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=york.sun@nxp.com;
x-originating-ip: [66.235.47.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB3982;7:vTeCobqBxdmBW9bjErrLUHtv7ec+eVYmy6KoKFxp4wbZhkFsres9AHAhmLkY6ev/sPcKkRPeqPqYcQHVPf2zEKXQY7exJUCz0t05+j+CWOy4OTJ9LkCo2cSPH6zIYnUAGWqEC67IjB9WtNv23zGDy1ScecdHqlpC/vWkCuerXMQdBhAZOCA9/e/2pwZDCFQJSN4AccBQXvYSQjEaoaMAmKsp8CKY3qvG7d0MjXH/bGkvQ7K6nfKf6dqYmeZRd9FD
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: c1ec9e14-0288-4d07-c8d0-08d58a84c39d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3982;
x-ms-traffictypediagnostic: VI1PR04MB3982:
x-microsoft-antispam-prvs: <VI1PR04MB3982DDA0D0CC1F02E4D5DAFF9AD00@VI1PR04MB3982.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501244)(52105095)(6055026)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR04MB3982;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3982;
x-forefront-prvs: 0612E553B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39380400002)(366004)(39860400002)(189003)(199004)(43066004)(2900100001)(53936002)(2906002)(7696005)(3846002)(6246003)(7736002)(76176011)(5660300001)(6916009)(86362001)(66066001)(229853002)(478600001)(14454004)(4326008)(25786009)(6116002)(305945005)(5250100002)(74316002)(97736004)(3450700001)(93886005)(99286004)(59450400001)(105586002)(102836004)(81166006)(8676002)(186003)(81156014)(8936002)(6436002)(316002)(54906003)(55016002)(53546011)(3280700002)(9686003)(68736007)(33656002)(26005)(6506007)(3660700001)(106356001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3982;H:VI1PR04MB2078.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: cn8FTPNmdzrrvBwXy0NPi80mK5LbdBwBaV73UKq/x4kMdncRp/VGSwuhFlp2Gt6ePzU1Ve+sj0eiCws7zYgaiPgyJOPeABHeWJttswWVBj+5WzVwBPhKoCl6Zn4lHYdJf/XjtDx5bzzkC0/tduFP2vSPpiJYx+UaRm199JmQdoqFbaj1ReNIRzdYZPklkDs1JIxWSO2KfYzfzQrruEsW4R8ObvgzK2N+YK/T1vkhY31dt718IuHDBcvNx7yoIKiE35YAi4/GYldbOEWE9v0Ejib4i/SxwxOnOWGcddqVsAEwDfg5r4UYKJmSZ4hiZ+i2mdjJu1FRcuSbofMMrSwswA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ec9e14-0288-4d07-c8d0-08d58a84c39d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2018 14:55:16.3756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3982
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2FEtSX6012940

On 03/15/2018 03:18 AM, Borislav Petkov wrote:
> On Thu, Mar 15, 2018 at 01:20:18AM +0000, York Sun wrote:
>> The discussion led to using device tree to specify which cores have this
>> feature. Since this feature is "implementation dependent", I can only
>> confirm it is available on A53 core, and partially on A57 core (lacking
>> error injection). It is not generic to ARM64 cores.
> 
> So my ARM person is telling me A53 is little and A57 is big.
> 
> In any case, I'd like to have a sane collection of RAS functionality,
> either per uarch or per vendor. So I can imagine having edac_a53,
> edac_a57, etc.

Wouldn't we have to duplicate codes if we create edac_a53, edac_a57, etc?

> 
> But not per functional unit. Especially if the functionality is shared
> between core designs.
> 
> In that case, we'll have to do something like fsl_ddr_edac being shared
> between MPC85xx and layerscape.
> 
>> We can leave this patch floating. If someone else finds it useful, we
>> can resume the discussion on how to generalize it.
> 
> Yes. If you want to do a nxp_edac or so which supports your hardware,
> that's fine. And then have the different functional units get built into
> a final edac driver, that's fine with me too. Other drivers will reuse
> those functional units since they're stock and should adhere to the
> design...

I may take this path after addressing other's comments. Thanks.

York
