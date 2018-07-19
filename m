Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9A8ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECCE920684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="psgFI1Lf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECCE920684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387871AbeGSSnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:43:50 -0400
Received: from mail-bl2nam02on0064.outbound.protection.outlook.com ([104.47.38.64]:39164
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387747AbeGSSnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrcK7rQIeptoUlYZn3p8QVS29zUs5gltr7iNedhgMaY=;
 b=psgFI1LfgQsTcoJelq1MUpQK0ud1VkjDi+NM7zMJzkd3MX0w/S8q31uJfYx259iDe5l+ZR6fcOZth1mN9gMxBH5spuLC/n9pcXxC/gQmKBeoK49ZnUdGQgS2UbHngr39bW/OPJrAQcUz1Hie0yqNyOQNtLo2m4rp3bsbuZCzpT8=
Received: from SN1PR0701CA0075.namprd07.prod.outlook.com
 (2a01:111:e400:52fd::43) by DM6PR07MB4716.namprd07.prod.outlook.com
 (2603:10b6:5:a1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.16; Thu, 19 Jul
 2018 17:59:28 +0000
Received: from CO1NAM05FT043.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::206) by SN1PR0701CA0075.outlook.office365.com
 (2a01:111:e400:52fd::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Thu, 19 Jul 2018 17:59:28 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 CO1NAM05FT043.mail.protection.outlook.com (10.152.96.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.995.0 via Frontend Transport; Thu, 19 Jul 2018 17:59:27 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxNgE025447
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 19 Jul 2018 10:59:27 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 19 Jul 2018 19:59:31 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 19 Jul 2018 19:59:31 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxFjr006007;
        Thu, 19 Jul 2018 18:59:15 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6JHxFUh005997;
        Thu, 19 Jul 2018 18:59:15 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 24/31] usb: usbssp: added detecting command timeout.
Date:   Thu, 19 Jul 2018 18:57:57 +0100
Message-ID: <1532023084-28083-25-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1532023084-28083-1-git-send-email-pawell@cadence.com>
References: <1532023084-28083-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(346002)(376002)(2980300002)(189003)(199004)(36092001)(1671002)(11346002)(4720700003)(4326008)(36756003)(2906002)(107886003)(109986005)(186003)(126002)(2616005)(48376002)(486006)(476003)(8936002)(336012)(426003)(305945005)(7636002)(356003)(50226002)(50466002)(16586007)(246002)(446003)(6666003)(42186006)(8676002)(316002)(54906003)(26826003)(478600001)(87636003)(5660300001)(86362001)(14444005)(105596002)(106466001)(47776003)(51416003)(26005)(76176011)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4716;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT043;1:6hjgCCradKFD+fqII9KAKtCMXCSManQ7QeyzpP8i+AVsIiLO7koP5UcIl+5wLCHX4vU49dmAbRXuuKp6Nf0zGDusm2ZhM+qq7eOjnKB2K3oNQQ0bR5aSxHy6z0E1PebF
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e6af564-6935-43f2-66a3-08d5eda15ec9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:DM6PR07MB4716;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4716;3:E16rHbYyt6gKXyiUX5K43C8Ga8oiQLlZLQuHrCOD6gCNd5w18ofFiII8+CGB8Sf4dwZ+INOCwhGuSRgXiNxDYrxURkISIRrQxxTXbh6BoLobdCSV76qN3IDu8JTWG6nN6/M0/egSdfLSUS6Wtqd8Rq0fiPtuOBjePpcXWFTYwvy+fep4LnQmQpUQsHx9UA6GvpL1y3/NxpewBNm9A1Shy+TiyQnE/scGYKPgMZ+SGlpaJU4EEtltwy6JWfgTrs9dLklWgGfXf9FkFyqDqyov4p1cmpZAq6Ws7xJO+HsgLnHb9NRVtTwZIX4QyuLcQZ0D3UakDOF6kSKwikIb1/TSkiYJ1lYsFnUli5F2IEZ3Heg=;25:Zfdsh3qreiXMUL/fsllRW3e2Cdz0eTgJWTjfW/pA9tWYjBMRkT+1vPYMVHx/oivtl4/xOrvilr1welz/ZMtQamh1KDLzrXzzO8qFuxbAzuz08ufaYBDN+lk6nkQc53R/p+I6KYnP88WziIYLyrZ7FIhziU9OsnM7tuwo5eHDWTso0YMhvd0VnDwzwzG0VP9X4lk8QtUh9GCqQ+qltQNG6AyViCbwLYJaGKIeQSEqCWpiubbYLYTRRPgSK6HfcCWAcSJ73kMDR1IZ7dXeuTzLX9Pw6YXwfs/Z9vBK3w72aSLfTznu/7nriMfZm7AoqmYJsei1pVJBEMCl+piK2ZDrkw==
X-MS-TrafficTypeDiagnostic: DM6PR07MB4716:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4716;31:A+WlHIoEPdcR7ZM7klcTRbxxwSe32IvT3BsnGaR2JIKs/zqrUOWd4+hFQPZUHDd3bajHvVFuxPgzOnEqDmYY1Tjf0plBNYRexJDMP8xeQRDMYwad6mw5QGtVGfBPJ63hX3Hv17EsyJbwbbigMLhyaRE/hKykGCbY5HnCTMjiGK2tE4igIFixmbzCIcmdno+WKWoq8wPm5SPb4tm37qgIA2lZ+fl8SHYfZ/JMM4w96Xg=;20:EwsAKXEe3j65pxShF4JOG00L1oMO8xAnUX+6Krvz3aX/dhnCQUr9aI5TaCQalxJEDYykqIcWCaCE/uqaaVkaCEEH4A09hOhpoeD3odsA7E3BwpCzoLnWPNi20agqlkxa1Z+8mLZqn6BxcDnTHWJq7pUmIa+/0k7yOTNVYIJqpihrPJBzPTdtlReNk3TE9m3JIcmj/vauHBUEDyuxOH2J8sJqKX5zz8F4xcJQBmKDcA/sZg3YS2/QS4XiLj7vtCAZT/RvNC+QX7T9IFbaHtZMeES5cbIos4cebhm3o49sOgWPdYOvMunD1kbv08lgu053oMBb9J+E/aOngFNEamS3ye+WPk4biFvODNgbBl+KVsSnoEWfda6yNiRdBWf93eRMtoYi+VXoFZNcLmi5018pyFSwhnOhwLo/ErwL5IOxFalkA+AOrbJkAZ3KFW5/CrBp3uHi+A9Q2a+/rTB3kO/qz8V3rFE/eHJrUZPxR5ey5tniwQr+bd2rKyp6SdMbnFss
X-Microsoft-Antispam-PRVS: <DM6PR07MB471646FA1F8BAF60393255CCDD520@DM6PR07MB4716.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93003095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM6PR07MB4716;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB4716;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4716;4:EPtcDbZFwFW4wshOYn1XdikW8mkPnj8EoJca5fER401+kjty+XdhtSwTx7wWUoumNe1JG4cWmQakrlLUcLq3lYu7XjgdngFUXBtiU8ZaHMToRaqbejGcWqVEvIEN741StXF2BPL6PaBiExG0K3YPtfrR76yvcaFwAqWkv66K/6R8BqEfpSprDxSxtzaOFQX5YVRSxJhWitkKRMtmICSPGpXmkler2/4/ZWqb/gj2fbliJbd4ZqCrkej9cAdZdl1fQrgIYojWbUEJ61B0c9RYlrqRJ10RFq1kV3ioLHFBlBWKI8sHnMX+3Z3aRalGdeqH
X-Forefront-PRVS: 0738AF4208
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR07MB4716;23:0fibQ17SfDel3lHdsz9U9DkbW5g0TSIZAVDEaVoe/?=
 =?us-ascii?Q?zkslUYpTPeeLxsMBzwpmFflVF1hBfNw+esDi5M4E1r8BVG0wVpMrRYii30UE?=
 =?us-ascii?Q?IqxB2UH4RQKypLoFn7o8nUzWz3kkF4foXiDWOAcESFSpK3KF/yb9jdKcI/wt?=
 =?us-ascii?Q?iTLLZBTrMXdNyFtKtUAT7x/hxvCY5FMM+/z+ILzhchz5hpwY2tNt5eIhWMT1?=
 =?us-ascii?Q?hOldBO/mTYOxTwQ+6gDsCxEsQjvzJddSXu5qJLs0GeDasppQLE+Y72gTwsGX?=
 =?us-ascii?Q?sD+so9uAce58Z0jLZrYdTwnwg4sK/DxHrCfkFOA+UilL30JEXTcYgOMgQTzs?=
 =?us-ascii?Q?FAL6v97xmW0DYUmVHyucwQvG0aVp8VgFL9nYKkaC/djkv5aTqHRyYTXs4VlD?=
 =?us-ascii?Q?TINbnhUYpg1dNzGSdU2hmFSmSXY8vuJ5pWKnVV/Ej2jfGnD3V1+8XpCQbT7D?=
 =?us-ascii?Q?jth2JPJe/XzppvijL17QkBiN57BlV9kwwVCYfS8fThOwQ+aAS688QN5YJ8Pn?=
 =?us-ascii?Q?R5YfvPFV5RIG24Lo0sjSgdPPjfGbTB0615pfIPS6+rd5oci6nZdm48AScorD?=
 =?us-ascii?Q?HpvW9ercMnxoiqOtT3yIwnJaupBRQJQOxTKNgH6idsNuTTZS7ChVc5isSBuH?=
 =?us-ascii?Q?hfKSKMnbyVqYjZATuGoJNzQ4e5VZfoP72PprhSu5OmbXq6n9K/CGxKGTGCmG?=
 =?us-ascii?Q?9dql6iSz/TJ1g5snyeNJsjahdrOd04gchomJw5QQHDo5WgYNouYnZANHcFe5?=
 =?us-ascii?Q?D/RYeghzqyLWD6fyK2k2rk36aPh8E8Y5xkj4GtywqocLYT0nookP3zxmilCs?=
 =?us-ascii?Q?NhskIOjJbhk4aQmi8SS8zIv4/4DSkNhh1AJ45oeZE598VfIr90OsHf2s9y2C?=
 =?us-ascii?Q?4jC7sEDq2QSc3/9WbC77b7jLF59tzhe3Oh+sK42ZXP+WM61wUWs3NjHqknl9?=
 =?us-ascii?Q?5dBjvcvujNR8dDLUs0E5RouVwImdgx+GJ4ANMqGonOxspYKqLtlIYmOwWDId?=
 =?us-ascii?Q?AWMw2QKYjR33D23chsovqm1RGthfOT7ieUIeJprIVwHpFtVNfoGdqn9/T0nb?=
 =?us-ascii?Q?ssEbQ2R8rLgQLb35RfaUDeKsdgwrzBlQCFTkDpt2eezscnJdI8OhArt/Wcz0?=
 =?us-ascii?Q?TBptTdhcHO87L+Qe6a1S3tKHvEKheoUMGV3lKumMKEWcVXAbtsLkg=3D=3D?=
X-Microsoft-Antispam-Message-Info: iT2+3Gdk2f+5XOeuiFqCuYWWPNFAXRsvP1NynM/PFs0oQm8Zqpepn4qHS07EiQxiYj3OwbqBXlKU1s6H4cK4s75Op4VkqRNBN0xCUYOHfw0puGo2IM455Eyuy7vsRolIcCN7hz83kRYdzmZfTZofXO+dZAfnfnmGGP9ieeRcdlJrTDkvyO+qkE7Se5FN7BaAjKNrq3Qh0xa+TZo1E+c5fwjKGEjU+OEd5oq02XBStSqmqTBPdGLdxU25eAXKHstdDtGdDWJe5jm49bk4r7gN/7RGWNVxBObc2KFMkYrUrRNq7s9DXCRUfbdvmotHS3xjBnwHNa4w/YyJAObCn+mIROaOvSqS69XLjcGr88+e2AaH8KyODwy9ulvRTmVWzkqf6CNiF2k8FrSzK8u5vauAJA==
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4716;6:Qp8nBKyx3sHDm+c7km99VHvrnjsWJNN6WmF+mTQV4ITTYxaOFHzb/wPKjIXGcpiE4yJEy+b7UTqvRGuQExfVxR5MnhGoJEC1eMQXS1ly3Txo+Sgs9dN4cePSbgWL2OuLrwquChmdROgNucnzbqgIVdoGb3TaJv/pZ2CQh2e3xU0M6gl9xvjOoUsOz8X9j5iKy9RH6Nfc0YMNZTrC6s7B4ScWYn7hDa3SVuQnsem28fmV4ilGm3pMS53lsYFId5JqFUs6jRuvYHkNNAL8pcvsnv6z46DKcVVnFaMGLBY4K9PuEYKxMIB1efjvCPbum1G+mrsx403yMSQsAAHp/xteHgaFHv1hGiWdikDlDp8QfSpxTlkyGgxYjlxS665xJPHhMiMPTHjK+WgOKmODxMXpwFFfW1lFGi4hCazspJbVHcY7puVCfmZfj+mYQsaPBXw7LdnvYlxY+KSDBsY2HyoBGQ==;5:II/BZTDn4TXr3mDYV1LUBd3j0mg1NBRSqQ+yAcoGT/w/zLy1qUmOa0Ll6sXnh0x64jMLjRmJkUtTGClKO7BlqT5t6hAB/LFLzKZcjZPQxklAINWAvGqKkC6COU0Pa2/ZaoCS5X6A9Rn5Ep9MY1TKHB1aqyTTw0iWk0Bt4JQu8xE=;7:4dW8rojBIgvt+yY1iJZ14V++LdoutfXw3bB3tlZlexkI0oWlZbBfDW5ef8gJY7o/ftLkOz8OJ4fyIbQYVgA7iPTH6KzuiZ7r1Oqpt0epLjl4IdfS49gq9lF/ijwnYnb/QOXKZlgiQ/Mgn/OkvRnuC1NhkPOa1j/BqGEyi6Aa/9HeNxZXAyFAdYmvY5/4HrEIticho10x6hrC5mvOLuNPn0ZDs7wWz0yAUDH5y3XMMP5bjZtu1BWK7I04xEwJW+iy
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4716;20:C6usKklqbPKwUFDwXe1JtfH0mbYMaDNBq8xogHMM3CeznD5n9L0iFMUfBlPp9T6FoyaVtGEZ2jxQfZUGo8VpsPx3pnCzai7xYxOXWXa24L8YXhOCpslJ2gh9mhd2TJ/lUhgaPWnBnBHujTOkxgMZ7WnOERpDeyIBrsQNWbJI+4UTpuKEfDXIYgZ/E2yilgHrhy1M8KeAf957QQJV098Ta2Mz/3c6I9gAPHLzZXeAPsoyBqeHDsTqi+aZs6kQ5kdn
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 17:59:27.7005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6af564-6935-43f2-66a3-08d5eda15ec9
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4716
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch add functionality responsible for detecting command timeout.
Because command can fail without any command completion event, driver
must handles such case in proper way. For this reason, driver implements
mechanism measuring the command time. If time expired driver aborts
last performed command.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-ring.c | 157 ++++++++++++++++++++++++++++++-
 drivers/usb/usbssp/gadget.h      |   1 +
 2 files changed, 154 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/usbssp/gadget-ring.c b/drivers/usb/usbssp/gadget-ring.c
index 8cc6e4247eef..e7afd185d4ad 100644
--- a/drivers/usb/usbssp/gadget-ring.c
+++ b/drivers/usb/usbssp/gadget-ring.c
@@ -289,6 +289,103 @@ static bool usbssp_mod_cmd_timer(struct usbssp_udc *usbssp_data,
 	return 0;
 }
 
+static struct usbssp_command *usbssp_next_queued_cmd(struct usbssp_udc *usbssp_data)
+{
+	return list_first_entry_or_null(&usbssp_data->cmd_list,
+					struct usbssp_command,
+					cmd_list);
+}
+
+/*
+ * Turn all commands on command ring with status set to "aborted" to no-op trbs.
+ * If there are other commands waiting then restart the ring and kick the timer.
+ * This must be called with command ring stopped and usbssp_data->lock held.
+ */
+static void usbssp_handle_stopped_cmd_ring(struct usbssp_udc *usbssp_data,
+					   struct usbssp_command *cur_cmd)
+{
+	struct usbssp_command *i_cmd;
+
+	/* Turn all aborted commands in list to no-ops, then restart */
+	list_for_each_entry(i_cmd, &usbssp_data->cmd_list, cmd_list) {
+
+		if (i_cmd->status != COMP_COMMAND_ABORTED)
+			continue;
+
+		i_cmd->status = COMP_COMMAND_RING_STOPPED;
+
+		dev_dbg(usbssp_data->dev, "Turn aborted command %p to no-op\n",
+			i_cmd->command_trb);
+
+		trb_to_noop(i_cmd->command_trb, TRB_CMD_NOOP);
+
+		/*
+		 * caller waiting for completion is called when command
+		 * completion event is received for these no-op commands
+		 */
+	}
+
+	usbssp_data->cmd_ring_state = CMD_RING_STATE_RUNNING;
+
+	/* ring command ring doorbell to restart the command ring */
+	if ((usbssp_data->cmd_ring->dequeue != usbssp_data->cmd_ring->enqueue) &&
+	    !(usbssp_data->usbssp_state & USBSSP_STATE_DYING)) {
+		usbssp_data->current_cmd = cur_cmd;
+		usbssp_mod_cmd_timer(usbssp_data, USBSSP_CMD_DEFAULT_TIMEOUT);
+		usbssp_ring_cmd_db(usbssp_data);
+	}
+}
+
+/* Must be called with usbssp_data->lock held, releases and aquires lock back */
+static int usbssp_abort_cmd_ring(struct usbssp_udc *usbssp_data,
+				 unsigned long flags)
+{
+	u64 temp_64;
+	int ret;
+
+	dev_dbg(usbssp_data->dev, "Abort command ring\n");
+	reinit_completion(&usbssp_data->cmd_ring_stop_completion);
+
+	temp_64 = usbssp_read_64(usbssp_data, &usbssp_data->op_regs->cmd_ring);
+	usbssp_write_64(usbssp_data, temp_64 | CMD_RING_ABORT,
+			&usbssp_data->op_regs->cmd_ring);
+
+	/*
+	 * Spec says software should also time the
+	 * completion of the Command Abort operation. If CRR is not negated in 5
+	 * seconds then driver handles it as if device died (-ENODEV).
+	 */
+	ret = usbssp_handshake(&usbssp_data->op_regs->cmd_ring,
+			CMD_RING_RUNNING, 0, 5 * 1000 * 1000);
+
+	if (ret < 0) {
+		dev_err(usbssp_data->dev,
+			"Abort failed to stop command ring: %d\n", ret);
+		usbssp_halt(usbssp_data);
+		usbssp_udc_died(usbssp_data);
+		return ret;
+	}
+
+	/*
+	 * Writing the CMD_RING_ABORT bit should cause a cmd completion event,
+	 * Wait 2 secs (arbitrary number).
+	 */
+	spin_unlock_irqrestore(&usbssp_data->lock, flags);
+	ret = wait_for_completion_timeout(
+					&usbssp_data->cmd_ring_stop_completion,
+					msecs_to_jiffies(2000));
+	spin_lock_irqsave(&usbssp_data->lock, flags);
+	if (!ret) {
+		dev_dbg(usbssp_data->dev,
+			"No stop event for abort, ring start fail?\n");
+		usbssp_cleanup_command_queue(usbssp_data);
+	} else {
+		usbssp_handle_stopped_cmd_ring(usbssp_data,
+					usbssp_next_queued_cmd(usbssp_data));
+	}
+	return 0;
+}
+
 void usbssp_ring_ep_doorbell(struct usbssp_udc *usbssp_data,
 			     unsigned int ep_index,
 			     unsigned int stream_id)
@@ -1060,10 +1157,6 @@ static void usbssp_handle_cmd_reset_dev(struct usbssp_udc *usbssp_data,
 		dev_warn(usbssp_data->dev, "Reset device command completion\n");
 }
 
-void usbssp_handle_command_timeout(struct work_struct *work)
-{
-	/*TODO: implements function*/
-}
 
 static void usbssp_complete_del_and_free_cmd(struct usbssp_command *cmd,
 					     u32 status)
@@ -1086,6 +1179,62 @@ void usbssp_cleanup_command_queue(struct usbssp_udc *usbssp_data)
 		usbssp_complete_del_and_free_cmd(cur_cmd, COMP_COMMAND_ABORTED);
 }
 
+void usbssp_handle_command_timeout(struct work_struct *work)
+{
+	struct usbssp_udc *usbssp_data;
+	unsigned long flags;
+	u64 hw_ring_state;
+
+	usbssp_data = container_of(to_delayed_work(work), struct usbssp_udc,
+				cmd_timer);
+
+	spin_lock_irqsave(&usbssp_data->lock, flags);
+
+	/*
+	 * If timeout work is pending, or current_cmd is NULL, it means we
+	 * raced with command completion. Command is handled so just return.
+	 */
+	if (!usbssp_data->current_cmd ||
+	    delayed_work_pending(&usbssp_data->cmd_timer)) {
+		spin_unlock_irqrestore(&usbssp_data->lock, flags);
+		return;
+	}
+	/* mark this command to be cancelled */
+	usbssp_data->current_cmd->status = COMP_COMMAND_ABORTED;
+
+	/* Make sure command ring is running before aborting it */
+	hw_ring_state = usbssp_read_64(usbssp_data,
+				&usbssp_data->op_regs->cmd_ring);
+
+	if (hw_ring_state == ~(u64)0) {
+		usbssp_udc_died(usbssp_data);
+		goto time_out_completed;
+	}
+
+	if ((usbssp_data->cmd_ring_state & CMD_RING_STATE_RUNNING) &&
+	    (hw_ring_state & CMD_RING_RUNNING)) {
+		/* Prevent new doorbell, and start command abort */
+		usbssp_data->cmd_ring_state = CMD_RING_STATE_ABORTED;
+		dev_dbg(usbssp_data->dev, "Command timeout\n");
+		usbssp_abort_cmd_ring(usbssp_data, flags);
+		goto time_out_completed;
+	}
+
+	/* device disconnected. Bail out */
+	if (usbssp_data->usbssp_state & USBSSP_STATE_REMOVING) {
+		dev_dbg(usbssp_data->dev, "device removed, ring start fail?\n");
+		usbssp_cleanup_command_queue(usbssp_data);
+		goto time_out_completed;
+	}
+
+	/* command timeout on stopped ring, ring can't be aborted */
+	dev_dbg(usbssp_data->dev, "Command timeout on stopped ring\n");
+	usbssp_handle_stopped_cmd_ring(usbssp_data, usbssp_data->current_cmd);
+
+time_out_completed:
+	spin_unlock_irqrestore(&usbssp_data->lock, flags);
+}
+
 static void handle_cmd_completion(struct usbssp_udc *usbssp_data,
 				  struct usbssp_event_cmd *event)
 {
diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
index c4e440db6b23..6737cb05cd27 100644
--- a/drivers/usb/usbssp/gadget.h
+++ b/drivers/usb/usbssp/gadget.h
@@ -1803,6 +1803,7 @@ void usbssp_set_link_state(struct usbssp_udc *usbssp_data,
 void usbssp_test_and_clear_bit(struct usbssp_udc *usbssp_data,
 			__le32 __iomem *port_regs, u32 port_bit);
 
+void usbssp_udc_died(struct usbssp_udc *usbssp_data);
 /* USBSSP DC contexts */
 struct usbssp_input_control_ctx *usbssp_get_input_control_ctx(
 					struct usbssp_container_ctx *ctx);
-- 
2.17.1

