Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F3EC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B46219E8
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="m2AKtCxr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7B46219E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbeHHR24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:28:56 -0400
Received: from mail-eopbgr10074.outbound.protection.outlook.com ([40.107.1.74]:21977
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727295AbeHHR2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:28:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjCzRUrN2m/rVnXmQNgnQcZ2fljFxPaOeDwax9HYItY=;
 b=m2AKtCxrKzTyunEXZBT+ciHTJ1dbvb2htxnaQMrZE/EZ2gnSTPewEiXOfxGIVzdd44K9PJVbNRJU9pNvqTapK4i6IPxhZXZLIHVioJm5mxtuMU9PAwz+e4o5QYsbsdjUDbrz0p8Tpp+PjWyIcQRSms5TvEYQ+xah+pIX6212hM8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
Received: from localhost (193.47.165.251) by
 AM6PR05MB4982.eurprd05.prod.outlook.com (2603:10a6:20b:10::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.18; Wed, 8 Aug 2018 15:08:42 +0000
Date:   Wed, 8 Aug 2018 18:08:36 +0300
From:   Ido Schimmel <idosch@mellanox.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     davem@davemloft.net, jiri@mellanox.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] mlxsw: spectrum_flower: use PTR_ERR_OR_ZERO()
Message-ID: <20180808150836.GA6929@splinter.mtl.com>
References: <20180808122908.13664-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808122908.13664-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: HE1PR08CA0051.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::22) To AM6PR05MB4982.eurprd05.prod.outlook.com
 (2603:10a6:20b:10::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69e2435f-c570-4d47-ac93-08d5fd40d466
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB4982;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4982;3:/mIP+kE58DjfgtUtDwkWd74m0dveeSmq1MgCU7oYEbvdchcwOizjKChcefpuCQxW3X4yUAlDWVmtNCKm4LJ1q5EYXlyk7TA68mLz+NDDBlppQGvc+2RUAn6aDOoVfZxAKbAMI6JN+BoCplyKgkwVmOnJLX4Dxk1qeaZBc0JucIkmKtOZefkwaWD7SnkRamUK0Xqy+kYbMQkUO7uZw70P6my+8MiQDZC8HOdPaXXQ2l1ng4NJmUYu1ck6dzYr/kW/;25:Fa1ytZr2upiWXEOoPMXcuLLOPW71qRl7y4nXtdj3YI1NsowRkOrhawk+oYXGbA96c8uLVom/ZHP5VnG7ImrzhMxyiFEANNed/9cMayWfvRa39uc1QZYuGEPrGrn1JYZDILWxgVxsWhW6OEzGh3bYMNmMmibs7j564rXXIjbMd4yhOHPc1X5uz2lki8W1TTLrElBvEL/OHp88oUmo4I/+Qx2plp+lesp7WIH5/L46fliL5Va9UgilWqL6iiOHSXfICPOdBdGHBJrKd3at7AM9UuDAnbA2iI2HZu4wSahlIQuaYY6NxqS6v9IBMQrkWUtmZoQv6+E/Mc16YHjZrL77oQ==;31:nYj9XQts28QNKAFiE+pKy+3hH5VysZz43xcohENKevUZIcNtSPATqSGRalC8pr57EveVLToibXR3eZNS5wl9u70fFx0RxJW7Lb9zPJxHChIAWiWllQmBepuiexHyruFBGkPZd6VzDYHu5ZEWMlan4DYbWcqZNn/SjZD0VOIEpBIlIlzzhl13X4Q47E8jH2xrpvXpocCufUsE2VC/Xqs4nZQSyscp3pORbCfug3Xr69w=
X-MS-TrafficTypeDiagnostic: AM6PR05MB4982:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4982;20:uDYbSnwHlhdflCeG1NGkYEFBZIkNioslUo1MtW7P6OMqXbo+8gSYeNaRmEBdZrk/iSXlREEdv9dqLPb4i0RfXL5aKJBQnaRniyOhuluzzKv9T6ipCYW/yjauIkAiBV5SxeTUoN54IqbFSQxzgaqdqseHrIrZPXw9hDE/3pE4LlgPvP5JzYVlp8tqvINlcs4fhTmKTNCqBjgwl364t+xRQs1RuZUbf9ObKlsA7+y6wHrn1SkS3aJ/T1JLKMh/P/or0TZvk3i/2kH7m6Iadl4co2n1Mzhdfclu35EKXpz56VdJDPG6qJQwRpfNTcI+bzwSKElI1SC3znU9AQ2KYJqmkBQSaZD1wY/R5RbOdsvlojOo6JHPExHtctCWQLp7ogXELgOBW2IFJ7FEl3kQ0xlr72zyr6+U1h9YMtocaw0uv4Q6OTdOC1WQj45Np9n6NBO+x4ThIJdcVYgWID/LSaMOWyKGFsb9mD1CCrIwY/SBJwWSRC8UAoHxIkpsJ6oaz9ld;4:ghqJFL7p/TNPhPcagzWoL6a6HQcpR8rWKRvEmb2ngporZqzCEmEz+fkO1E8+kYpfZJ/5mX0u+Y9usU2J/0m0I//PhkIuoIL0V4EhvGBlA1wwpoZKXhGIuiopc8fZpcymYeMvUk3VnAPcmSnavP29CKdmuitGC8K196QLrF9fqsePQzQACcIX4JsyWE/3toPmcwIRyGSL+5uB6YR2GqOjCwKmJSzFnDhuQ6FxWiG31vZyb6NpvdUiE6qWYYh41fe+/Lbl43CU7ae5VQzx2E9XMhk3L/0nS9SeuNmcwC0g/PRTN3uDfJ56PObe0w5/ltqA
X-Microsoft-Antispam-PRVS: <AM6PR05MB4982C642DB0CABB1F535B72EBF260@AM6PR05MB4982.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(50582790962513);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM6PR05MB4982;BCL:0;PCL:0;RULEID:;SRVR:AM6PR05MB4982;
X-Forefront-PRVS: 07584EDBCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(366004)(39860400002)(136003)(346002)(396003)(376002)(189003)(199004)(33656002)(7736002)(23726003)(86362001)(105586002)(47776003)(6916009)(478600001)(6486002)(6116002)(386003)(558084003)(6666003)(76506005)(14444005)(3846002)(1076002)(229853002)(106356001)(8936002)(68736007)(97736004)(33896004)(81166006)(50466002)(76176011)(26005)(8676002)(6246003)(58126008)(476003)(4326008)(66066001)(81156014)(52116002)(25786009)(16526019)(16586007)(486006)(316002)(956004)(6496006)(5660300001)(9686003)(53936002)(2906002)(186003)(11346002)(446003)(305945005)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4982;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR05MB4982;23:UBSmRlo5pKeptESxQAwF7J8yKB4BtcYFbYEASxGmt?=
 =?us-ascii?Q?2AKuB71+mor93pw1DzxttHscX5EJZZ6b0GCIbWDXkzs7Q4X5G7wm38vhKOmn?=
 =?us-ascii?Q?NB0rhaUbyeWs3YN6GsQCK58nWU8M3wtAvvpW/GN+1XTwF0ZXDh2Xw4Vq5UlX?=
 =?us-ascii?Q?Q2PHJGvKq8Ze3Vqv/+WjLxDi/2o3uFgremPNdika36dst5MgJzqWsgNVXWBQ?=
 =?us-ascii?Q?OotO1mZFa6oZZgtHm0+WvaXmW3vXMWFmcKtDVNpFN6B1wGSf97VayEDpmDAk?=
 =?us-ascii?Q?L4yh637tKXWGguii8McbrjEV/mQeDiK7g6FZn5tptk8mApaYgSNAgr194TC1?=
 =?us-ascii?Q?DV+mu3kIlSHVxEwnrT4y/opz6D7CVaKNETvVg1bwZ9TfsROF9x43XXrDMRw5?=
 =?us-ascii?Q?oJ3eBjdVU8wQaBmtk3OY59w8V0XGV+cHKNlIGvpGA9EK4FsmEr/ToUeMfXlD?=
 =?us-ascii?Q?XpsNJb8prIDeHzQ28RPjJjl7MGqknurX+1LcP5FihG5PtAAocc9ZEC4nncmp?=
 =?us-ascii?Q?euZtZZHIo6E+YxnReqtb38Rf++hX6pKyF7l62HanPRyBxfjkVkWznME2lFjs?=
 =?us-ascii?Q?BbMyk5HlmKi11PuiP5duXYCPibGD9IciO8W5t+folsLP4cf6IgEGxKdX3c8c?=
 =?us-ascii?Q?ynYEZTbSv7Gu69R4goUznDi3OHdwN+jUpmQ4l6ielYJ8JEUjJIrKW7TI9Wx0?=
 =?us-ascii?Q?w12lVCD9xSE6SdboQQzr8g4VJN7oQgYwXf5TGYID6pKeMIQgR7FpKtD1dkpJ?=
 =?us-ascii?Q?W1w1FAVyBxuUtHyq9F6enmw4syUUUs+fYFhEd+YeAJ34gRdp4yV7sTpNihIy?=
 =?us-ascii?Q?Vwp1chg5njUQvxrppnBtxnctWJHZ7bZN2bLkcfK6OO+nBm3mQ0An4AUVQfZA?=
 =?us-ascii?Q?dXfPID82L+lKTq8xG3N+zadsOgMAHEDuVLqtvfKm0ysVCBmFzGjXO39Excs1?=
 =?us-ascii?Q?GnBZeEajbXE0IIcgS4RJmrLQSfEPsfRDTOv3RnB9k3sMFYWuL3RO16v8HczS?=
 =?us-ascii?Q?x0h5EdmsX0RaVtrXQPIZ1N8EoCZLYaxLGT8U7L+0NhPqbNQeSrrUdpl4dOlQ?=
 =?us-ascii?Q?gZmmpQNMCe04kD//ankk3XulN4zRhKeAlt9eMhfGxHnar8B/euTAk7YnRcva?=
 =?us-ascii?Q?S41n12Up7Ps6CIzsg4zEsmwKh/pD/erT00tzIGRuNNIQuC2ycaojgtvd+0TZ?=
 =?us-ascii?Q?CDou739DxqZCz3z+GiGQbFIAUQNrK4azG/tUSVKwIp+8s8dDKINZQL5YWma7?=
 =?us-ascii?Q?tDBATCVDhifPA/A5QXp+hAevZyjYcbBSJA3gU8NHx7hzHYvvmw9YGDlTfPW7?=
 =?us-ascii?Q?p2MLyZj/VHYx+GlnL7ka7w=3D?=
X-Microsoft-Antispam-Message-Info: T6MYeKQe6KszyRb7R4+fGCnVG66GHNUXxwSHS0tPbspJYd4ZUpTMtDO4UGAODw7KboKX/fs61mwkPvUED9iiGDTQVR3AGvlGkQrHljPKeFisxZsGB1eL5GNK5y+lXzhOCkII4/rKsGHvKIV4Qbqfs9ulR+pLft+Ck6tXVJEWpnX7K6k7kSXhZUUNANPMBXkEnffq7qFoUSd5XWddCjA+opqym8yNB1u0rbZ/Lv/7YIhp3qYt9L70Z0OX4gKRqw4AcEEimwsOZPPJfOIlzDaNrDi1MKfqIUh2djvLTGmu+DamadOK6C++vbIbnFfchYjcRKQ9Yihfdq6yI0nNOm65MlLiAkXtvAvm2MH+zJLrNSQ=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4982;6:kVKbp/OSjLtwNDXqeYx/cLxTK4txF6fMdVdJgvdrEYBOUA3xtSTfb4lyFIxZjFVbgvyp4p3yarfp/xjjd6UGKSDOtpyvGjYTv6yI/kMGOok0d/vjQjuh4kwYD+2gsohDNiNxrFG1I7Mzp5RZMhCzogQa9xPuWU+FA2kGfnX2elU3N5/c3wpvFU4nm0jGNr6dKkhTzDwh5usgTyJ7H5sXxLEWE7Y1wdYMoZoO0F0YVCzxIyq/ouZ3ZY4oSQLZULYh9wkT+8I8CyxuH4cmzjhuwKzCmmFOHtbCeHJIRpglFzFM2wBmCiCbeAVuMe4umfOddqigOiU4PRJtjZFf7IS5cNB8dH+B7ZZPEnQvvQoT5tqxs3SZpo9PphvrmNQiTaGAbGBJgGr+xVZQRah9lKR7JhRb6/mn8WfwRA5cthR7kUcqs9Kneq2Rv3D4+GRv/I91JVWybXpVXL2NElInMImWYg==;5:RqyHLGoJQI40nkqMCqzKY7uU/d0lZW8hj87Y1whZfUAM8AKiS7izA9m5tcdvs8usSYDzEhgJ21m7aMsm29+gN+iXP4ktrPZccgsx88zNJKAf6idTucjBGGSgmlRnd1r3hfAEg6uY3kDPy7p2GLg1WuwOUsO8/7UtmScoY7jBvG4=;7:jDLcxTyd2vKh3tmN+JVAZ6zGHeQGqX4BVFmjPzRY0j1VAptHODNJBTOjYOsecig+xCq/g/b/enc1E72+BZAgwwwGDtI9kWiFiuwo/hq12Yyz5KAsvRDD3AsTnqOe+flnC+yiWhOwReyQxoPD59GvsAZWb687NNVXf6pNk0F2PnU8tjiHIcPGGRTA92i9Dz+aq+48xpYuVvveTkbKok4w0k+0XQzBJR6e+sstHrZukinRvLuB6N4lnX8AqfvQVgsG
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2018 15:08:42.2233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e2435f-c570-4d47-ac93-08d5fd40d466
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4982
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 08:29:08PM +0800, YueHaibing wrote:
> Fix ptr_ret.cocci warnings:
>  drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c:543:1-3: WARNING: PTR_ERR_OR_ZERO can be used
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Ido Schimmel <idosch@mellanox.com>

Thanks!
