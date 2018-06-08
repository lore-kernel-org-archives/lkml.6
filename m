Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id blu8FYRbGltMWQAAmS7hNA
	; Fri, 08 Jun 2018 10:33:40 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3D12D6089E; Fri,  8 Jun 2018 10:33:40 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="D4vxWxiM"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B192E601C3;
	Fri,  8 Jun 2018 10:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B192E601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752642AbeFHKdh (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 06:33:37 -0400
Received: from mail-by2nam03on0083.outbound.protection.outlook.com ([104.47.42.83]:52160
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751115AbeFHKdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 06:33:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/imJKXFeUUe7JaWGWqJXTgb2trQKCSVeYYFTk8iymQ=;
 b=D4vxWxiMolWAeRexXQADzy2jUo1dWNXS/h33NF663ivN5mW+JFp5Tz0RKhFKje3U8R+c26KewyPBuXFkW69LgbUfGDOqt5LXNgJn6a6H0Qd1aMrJ32kQLGftwaY3LkVagSHp5UcPV1DnweTE9wqab2tUO1rbhiy4aQZfWuG3vC0=
Received: from DM5PR07CA0058.namprd07.prod.outlook.com (2603:10b6:4:ad::23) by
 CY4PR07MB2967.namprd07.prod.outlook.com (2603:10b6:903:27::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.15; Fri, 8 Jun 2018 10:33:31 +0000
Received: from CO1NAM05FT041.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::204) by DM5PR07CA0058.outlook.office365.com
 (2603:10b6:4:ad::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.841.13 via Frontend
 Transport; Fri, 8 Jun 2018 10:33:30 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=fail action=none header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 CO1NAM05FT041.mail.protection.outlook.com (10.152.96.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.863.7 via Frontend Transport; Fri, 8 Jun 2018 10:33:30 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w58AXRND028401
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 8 Jun 2018 03:33:29 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 8 Jun 2018 12:33:40 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Fri, 8 Jun 2018 12:33:39 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w58AXQHR016941;
        Fri, 8 Jun 2018 11:33:26 +0100
Received: (from kwitos@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w58AXOof016895;
        Fri, 8 Jun 2018 11:33:24 +0100
From: Krzysztof Witos <kwitos@cadence.com>
CC: Krzysztof Witos <kwitos@cadence.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:CADENCE MIPI-CSI2 BRIDGES" <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] cadence: csirx: Add Cadence dphy support 
Date: Fri, 8 Jun 2018 11:33:02 +0100
Message-ID: <20180608103304.16054-1-kwitos@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39380400002)(39860400002)(396003)(346002)(2980300002)(36092001)(199004)(189003)(8936002)(246002)(51416003)(36756003)(8676002)(305945005)(7636002)(50226002)(316002)(54906003)(4743002)(16586007)(42186006)(26005)(186003)(2906002)(356003)(106466001)(105596002)(336012)(26826003)(1671002)(6666003)(109986005)(1076002)(4326008)(87636003)(478600001)(47776003)(5660300001)(48376002)(50466002)(126002)(476003)(2616005)(86362001)(426003)(486006)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB2967;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT041;1:TS+/EtOlbORfAXvwfOw3GCf29BE3pr4WoVlnW4JnQF8dUql14kgJW7zA8ogJ3Ag3ZdR8pxLNEdmiobosSC8njLjVhkz4OZ6irkckFoSa5+CSA476a0eRDtt7Id3+sQZ1
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:CY4PR07MB2967;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2967;3:YhlWhJDZBqfA2Gzxc8aKyrZ5qdO4/X5ZL+8VTwq6eiTiAvjb4Ee1ShvpllbF5jNzPZECVa7RZErF+kSbQ0Tm6EDb+hpmR0R3+WDrmMIsG2Azh0ivdSrmnMiX0XBg0H/P6AOrCuLBZcwk2m4O+BqKMm1PlZEiSg2T36LsW5rBmsPkQwm8SziAKnnU5xA5oMoAMB2WeP2P3oymR8T8cctcNs7N2/Yyig8vGaDA4J//AEhKGwA8c93Y7MI+6l2+TMkmv8TdPV9q666GBHsOg8PUqb20q0c6zT4ccsCxBSeGK0VSbIjdreG1tj5mspWTya8SO23B4iwJxcYf6bI0lFdgpXtT4F+CFzf52ldQ1KsLtbc=;25:TjCDI62IpwkVucXu4k9F8HOvKkeKcw02Vef6+3CN7KZrzaIMa1ZvagMQaLTprfChAuxzQxaE/8ortgu1OYlheV63k8DXWEpGqaTCIYHp244U4gDuAk+qItHG9hKiicxS3IAQDZiRtOpOin0fsM/1lSeg6bIfjqZwypP7zJQ2IlRxTDhW8grAvyt9sPsUZlAgVzL+Bxl6Ug6adg2VpyzHJNJjx4BkJsRu8Hsrap2rGi/ixA4+OZ2btf4VNk3+MXkFuk/Pf22zraSm4n/2Emlot0DEYSiTjta3BbvUHU4y2odJ+QFL2xGx2+aBN0x9CANujXvNVJGekbaJqH4bmd5MJg==
X-MS-TrafficTypeDiagnostic: CY4PR07MB2967:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2967;31:4J4hqMNpHQMjXgnfAgA47g68jDPQSlVG0beA/PiRCwe0QXUvlwWnKlQy00FB4h6EITE2RlCgLsnrK23BCMhIpdvnDalpmBWiUmtJb6BFrDJhV+un9t4pD4kJbcvqMB3J/wjjX1s0/ZjhVelBRvvmOQeCps4UhFSNx46yVJes/asm3PXYmf+klAoWueW9/W8IoIZ9lWti4IIonWWcvXnZuQLO27xbu/E88OixHnNi3DY=;20:5D0H1BZOdN+os5dX+skqhpmQD8JQoltiQrPibMuRMsYYAqOkf8vmwxalW2O0sBanDZMqh5dN4TjmyLHvQVHnXT8kxXgYXvAS1iwyXQ2/KYNxx6Wp0UaPeb1Q4ywrf0YJZThI5SIetEZlAINdsLhC3mrY4a15z546rnXQiWXnjCRRBKErUCeH/gMZ3O0yMEd+NO+c6fFrFz8EwEGznjegDkvr7+9e7DDFlMgiChqcrH0IT6V55WfGMRGwPdngb12aXOvWK3YAtfA1hgezf1tkHmFg6upLAo1O9+yKRnjmzIHJTSZu4ZiUqDHhB/vM6rtO36bT4jQny5DPw7vafDS7IfK4jh/miJFsNjASQHBcfom/9ivokywxwL09YEhPJgXVcOYmq8NMZp5vdLHK/1hlqV93f5IhrsfdfmUSehiEhUFHQ3bENj4saR9lxnMu0dq00dhQgSM/6PtL8lidQ6XAMK6To0cKzijFylRxstpQLb02XcTywBAGNeBxNO92BukA
X-Microsoft-Antispam-PRVS: <CY4PR07MB2967705D38A5B107E9624559C37B0@CY4PR07MB2967.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93003095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY4PR07MB2967;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB2967;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2967;4:F4zDBMVuyP1X3z0sK6Kz8EPObKVZ45RZWm4Hbuh585dIlAtp9AgksQvcUdp9sK0PNdwbCfp40BcBi8QqqzFCtXYMcAsQ0z9uIEZ9nAyK6DrbPPyfi83SAuW4FX6U8ZIzl6ytiLxzOBHxNlcksL+SOycQNiR5tW2PW1s/IaSjM8IdxFF9knaYzvv736kHSDlimICpyujjgwrOCOp+uREdD3U5McofVELvNGX2Fjtdj9TZvDxzapXUvpxRQ7DLW27qDNQr8Ixx79H1eHZf8hzdJA==
X-Forefront-PRVS: 06973FFAD3
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB2967;23:nvgZ7h3OBQLwpdoygdwOGybYXX9oQzOGJHxB9njZW?=
 =?us-ascii?Q?XfyXr/4/d7sTuv3fzbILlT8J3eNukK/jaTbopPVrnQzRaowBSgIyJfJtu3g3?=
 =?us-ascii?Q?jD9Sx5QrElzIbgAIGCO1zGHjoX30wqCyI9/Kc2ip9w3S1MYlDslMPtyHORpb?=
 =?us-ascii?Q?XmSKsB4+UJiiykW6KnyCAps8tpm6VulBAjBbCaPrq+mlgSi09fiLU9BtA5NZ?=
 =?us-ascii?Q?5hBkNEmKchgwGHakvkzbCqXEy8IDIiylxrQZUPNAXsjZgfGkoCdTHc3xa+iP?=
 =?us-ascii?Q?TntCetqhDRlszzFO8N/cWsZBxR4Aij/fbggR7bKCNC+tXOadaXEVzB6YNXA1?=
 =?us-ascii?Q?9u0R1gP8qKuPInvXmXZ70hCi+iB1DVZKvB2tf+5e0+e/KQIwLwkM+Fx+/Gu5?=
 =?us-ascii?Q?uiNmaocmLRTEer6hT4RcqYIuzVtmTllyyMpDeGptqIHlXCbZEnpnttLSnkW+?=
 =?us-ascii?Q?1CShlq7wWdzUSgBhCFrNT/7xNtOHccsk4opRUBmCjc0a4EvbYQkLfr9MADTq?=
 =?us-ascii?Q?ELWb9L59Th7IxNeFCP17wntId2VaiY0MJ8VNZh0Z7cARXmhDbUUR7XP2Uc/Q?=
 =?us-ascii?Q?1isu7OcBV9GEq8apu4iJNY5OtOAQaXWK55YGOfxwZsOnuprB9ZFJzlua2+Wy?=
 =?us-ascii?Q?rdsWjhRWJ19twNmukK7xk0hqOmEehADPzGB8thKTTLUc1Qbr/cc87Ko78Wvk?=
 =?us-ascii?Q?fKuIKwdyr/PLt0aASt3977vEdCk5BkdZ6a6vwqc5/8JGognhQ9UN6KvAMhhK?=
 =?us-ascii?Q?woXKHoapaU3xD+O387k5ntSoqy78HFrXzOzU2rZYKzgCn7/LtSaJFSsovCmM?=
 =?us-ascii?Q?H2WKiIflukQKAntY+qQpGklhrrauVKUT37blNKNPvKzzs3UF1gmSI1TMPn11?=
 =?us-ascii?Q?FS8PtCMRfDUhKlanWG19TN7OU87j1W48byuUE2Qbqw9n+04BqGm5/yOyPMgk?=
 =?us-ascii?Q?1COcJ8fOKJCALZIYRpSwbpTfIGuPHI8UbbN00qPL9/gSbeLZZKmnBaPXJwuW?=
 =?us-ascii?Q?TqVtNXeW2sxUcsWgNtLd0kkiaNseEqg5tmXvG1LgEDrgC1ka0KE03Jfjx08t?=
 =?us-ascii?Q?jiZmORs+6qo72an31MuqfG8A9FL?=
X-Microsoft-Antispam-Message-Info: H+G5vKldwM3uSv7f4F2q9dMjSIDH3ilKFhmr9KcLf5NJfD6AEo908gQEvy6oQRBAZ3u3zwLIz7L2WhMBrbVrIDNn1a/jLgEi7t92FZnNkBlPet8wPqu/+9CVbbWezns2Z9nKxQgkKC+/+qNG1SWV9CZH2Y4HMWU5ziSI3lWn51aLqTMzd+eV0+TNXJX43xCKT4KPdqKKviWZWJvcR+cOQG/+eZB2aTFBxE6P8wOE0SN0DCpRWy/b066yTn9/NqDg
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2967;6:HP8IqbBNCdAw55+8D0i+N5/Hp0RvUhFBH7NtONPghr1CD2yO8NcQCiWVFIbD3RGb8JnD+2BGdNFmxDFpznz9FstIPXUpSuQhoPPDWArqQhhhF3AURd48ZiN/45osXNIJdoGS2SUo7KycCULn1Sk9x4Djw/MeIEv1U7zaQnHCgEBoylKOVmnKK3TxxkscfMXrmPP+I6UJlr0r65WYbYSQshah9xuZmhVmyxEM0OYWhncs69VVDCEEFX7s8cn5OgeMqH5fj4fRBa1lt/d4FUhbIsZp20sRT6uny/dfJKUI50c+kno3Otyd+1uD2AiaCfiwq+Dywng2xnM0LN/DrbGG7vK77+8f2Ze8zDlcuSO2h3PooHUKZbBUHufX9atgwlcghBgCCvpiA6TSeaIG6ScVjG9+OdRFHKdrW8eTl5OJf20i4i9RUX/6cuHW+1Bbb1vHG8IhbQLMgTZtsWJHzAWJtQ==;5:rBnEQp//7CpRPYNV70Hi5935RLAFcht0/1Dgtl2znpA72ltjgKEgEgczLoxGrs0o0Mnc5CGZcJo0DHnUDdMtkzPSEv0pyr0E8mee3tYzs8TBp0xoT0vZIrXedJAvdwp3UyPW4boYOPhkwXnQzpVgpqdggDSVfTCL74Mvcu7Cpq4=;24:FvZ/i00BI7AiyCIEnqxOKmGArUJbcGVGHlPIeeIVGB2fLS5MQNUqPKHEpozQVjs1JlV7R+3lHt56K/M2nic2Cbb/W9HXOoej/zOy4hzGPb8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2967;7:1bDoFTeQYU+M5MbMdKJgdvb/o6UKtdpeNK20zLjioLPz76wsTw2CNMns57IbyEhMfQYiVE3TlS4dGG6z/yLjOpjP/TH+uOC3w+a9NYl+g2DXfx2eJovHfj97EB7wjeBWfomI4dLK5PXDo5FSR0FvRgtPv4u5BGGNdWGuCILAUPpe6a0Nj2LImm+HwXnBMXr1dJ9mPO5Zqt3A/IhYfcU6K6fSSW6wOZMdm8zcvKoY3BiDW02qM9gX1FHY79sdiv3m;20:AwjgJ8tiWuEqCdRqgwN4HCTVwupz2Ny2BOe1RjCsIaf5qxUfz+3cRRTKxzInM4SEiEz3dCfIKPlLL3HCRpPCfoi2jicsyyi9RNKAH4+SgbQjhUeQ6apCByxH1XVIjMBlsU90ZRzwVRazf9WZUgW73uYKUCvRG8w/nLk7kaq1aKkWO8+DxOqF73g38Qp7hEWtjnVeVkCEIIsrnN95HFLiONqgZ5jhgACWeRvPq7wRCFJlmwK9JcYD8JYa/VID3Hkt
X-MS-Office365-Filtering-Correlation-Id: 0dd65f50-7fec-45ff-eca5-08d5cd2b4759
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2018 10:33:30.4344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd65f50-7fec-45ff-eca5-08d5cd2b4759
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB2967
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main goal is to provide Cadence DPHY support for CSI2RX driver.
It is implemented basing on the DSITX DPHY solution.

Krzysztof Witos (2):
  csirx updated doc for csirx with dphy supported
  added support for csirx dphy

 .../devicetree/bindings/media/cdns,csi2rx.txt      |  32 +-
 drivers/media/platform/cadence/cdns-csi2rx.c       | 342 +++++++++++++++++++--
 2 files changed, 341 insertions(+), 33 deletions(-)

-- 
2.15.0
