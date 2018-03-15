Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751790AbeCOBUX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 21:20:23 -0400
Received: from mail-ve1eur01on0076.outbound.protection.outlook.com ([104.47.1.76]:36440
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751449AbeCOBUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 21:20:21 -0400
From: York Sun <york.sun@nxp.com>
To: Borislav Petkov <bp@alien8.de>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 1/2] drivers/edac: Add L1 and L2 error detection for
 A53 and A57
Thread-Topic: [PATCH RFC 1/2] drivers/edac: Add L1 and L2 error detection for
 A53 and A57
Thread-Index: AQHTu/Mc+CsInsRsN0uQgig0C2tI2A==
Date: Thu, 15 Mar 2018 01:20:18 +0000
Message-ID: <VI1PR04MB20785DE79A7D33D453FF79869AD00@VI1PR04MB2078.eurprd04.prod.outlook.com>
References: <1521073067-24348-1-git-send-email-york.sun@nxp.com>
 <20180315010728.GF11061@pd.tnic>
Reply-To: York Sun <york.sun@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=york.sun@nxp.com;
x-originating-ip: [172.92.81.50]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1278;7:oj0GV4IUUWrThFjkKyuMId794aCCTJ/tQ1Nrd6cit9EuCp//Zx1/e0CoRWYNdY4FV7UWSSlu8UVfBhfnhdGs8ThuWRJQaV7wkDU7ldlXGXdJQfEYcFB0bHonXV2Eq/woDjHNFfaP+URIWWLmhka2T1O1OVIP7Dl6i/wCSJZxQVPFNhe6oJf3ZMuORIlLbmi05Du6ai3CBYKMNtPUTKcLTH3aYU/hy7LDc/oOS3ufnDlDQjhkOBu3jB8s7AD4Pb92
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a11fccd8-8bf4-4e6a-2688-08d58a12ea26
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1278;
x-ms-traffictypediagnostic: VI1PR04MB1278:
x-microsoft-antispam-prvs: <VI1PR04MB127880A7E240FC4A388B959E9AD00@VI1PR04MB1278.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501244)(52105095)(6055026)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR04MB1278;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1278;
x-forefront-prvs: 0612E553B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(366004)(346002)(396003)(39860400002)(199004)(189003)(53936002)(66066001)(76176011)(106356001)(7696005)(2906002)(43066004)(6916009)(3846002)(5660300001)(4326008)(102836004)(26005)(25786009)(3660700001)(33656002)(186003)(86362001)(6506007)(6116002)(3450700001)(97736004)(3280700002)(14454004)(53546011)(99286004)(8676002)(5250100002)(305945005)(74316002)(478600001)(105586002)(8936002)(68736007)(81156014)(59450400001)(6246003)(6436002)(7736002)(55016002)(81166006)(9686003)(54906003)(316002)(2900100001)(229853002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1278;H:VI1PR04MB2078.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: uonqjlbH3Fs9VFW9I366JbRYKJyy5QHvv5fSmKOEXGshs3yXV5GyEQWnPGBMC3cNgX1fUrhwamkOAo4J4TJ6uwLT7EuWXHeYsNWbkPid9Uac7V1UCh3L9gTchwYH4XReA+M1bf+oIM6UAbHbDDYXutckPVm9KwHBE4Oe9bYHTGmtEl2bodL2JrPL3SoMjjL1Fq3/lBjAdVrZ49gqOlxKrg+QN+TD+B8QCZyy4Skdo12ghqoCGKDQmSBCc3lprdJQJjEsOVlfmJqQclL57OU5gHBzuITmBedZ4HP5gEYMk2ekpQLW446LREm1DTHefXl+Z96VTZvFh5HqW0xaAN58Kg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a11fccd8-8bf4-4e6a-2688-08d58a12ea26
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2018 01:20:18.2393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1278
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2F1KTIK024970

On 03/14/2018 06:08 PM, Borislav Petkov wrote:
> On Wed, Mar 14, 2018 at 05:17:46PM -0700, York Sun wrote:
>> Add error detection for A53 and A57 cores. Hardware error injection
>> is supported on A53. Software error injection is supported on both.
>> For hardware error injection on A53 to work, proper access to
>> L2ACTLR_EL1, CPUACTLR_EL1 needs to be granted by EL3 firmware. This
>> is done by making an SMC call in the driver. Failure to enable access
>> disables hardware error injection. For error interrupt to work,
>> another SMC call enables access to L2ECTLR_EL1. Failure to enable
>> access disables interrupt for error reporting.
>>
>> Signed-off-by: York Sun <york.sun@nxp.com>
>> ---
>>  .../devicetree/bindings/edac/cortex-arm64-edac.txt |  37 +
>>  arch/arm64/include/asm/cacheflush.h                |   1 +
>>  arch/arm64/mm/cache.S                              |  35 +
>>  drivers/edac/Kconfig                               |   6 +
>>  drivers/edac/Makefile                              |   1 +
>>  drivers/edac/cortex_arm64_l1_l2.c                  | 741 +++++++++++++++++++++
> 
> I don't want per-functional unit EDAC drivers. Also, what happened to
> talking to ARM people about designing a generic ARM64 EDAC driver?
> 
> If this is going to be it, then it should be called edac_arm64.c and it
> should contain all the architectural RAS functionality in it.
> 

The discussion led to using device tree to specify which cores have this
feature. Since this feature is "implementation dependent", I can only
confirm it is available on A53 core, and partially on A57 core (lacking
error injection). It is not generic to ARM64 cores.

We can leave this patch floating. If someone else finds it useful, we
can resume the discussion on how to generalize it.

I don't have access to any products with RAS extension. So I cannot
speak for those.

York
