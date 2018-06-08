Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id eN/iOY1bGltpagAAmS7hNA
	; Fri, 08 Jun 2018 10:33:55 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1756F607E4; Fri,  8 Jun 2018 10:33:55 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="CQT09QXs"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 17CF8601C3;
	Fri,  8 Jun 2018 10:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 17CF8601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752825AbeFHKdv (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 06:33:51 -0400
Received: from mail-sn1nam01on0052.outbound.protection.outlook.com ([104.47.32.52]:47902
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752674AbeFHKdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 06:33:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beQX2tzcUx9dUE+f18AGWpD7PrjOtIT9GAfdfyU36q4=;
 b=CQT09QXsZJ/Z8uUIfmbGH4EZUk4JwumqnjPS+P+hAIJwJ2hCAePeMSIMboiW7hcHsXxqMlW7NZba0S6T8oe3a6GzcmPoxpFqLGMcxLo5vqE+x5lMaXQldkQgild0dHN7jkJwNkt9/Ou0bM/eYQb+adNl/xEBsNqkUSH4E1G3Zm4=
Received: from DM5PR07CA0025.namprd07.prod.outlook.com (2603:10b6:3:16::11) by
 BN6PR07MB2963.namprd07.prod.outlook.com (2603:10b6:404:42::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.15; Fri, 8 Jun 2018 10:33:38 +0000
Received: from CO1NAM05FT027.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::208) by DM5PR07CA0025.outlook.office365.com
 (2603:10b6:3:16::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.841.17 via Frontend
 Transport; Fri, 8 Jun 2018 10:33:38 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=fail action=none header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 CO1NAM05FT027.mail.protection.outlook.com (10.152.96.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.841.6 via Frontend Transport; Fri, 8 Jun 2018 10:33:38 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w58AXYL3028417
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 8 Jun 2018 03:33:36 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 8 Jun 2018 12:33:47 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Fri, 8 Jun 2018 12:33:46 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w58AXXT5017099;
        Fri, 8 Jun 2018 11:33:33 +0100
Received: (from kwitos@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w58AXXFe017096;
        Fri, 8 Jun 2018 11:33:33 +0100
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
Subject: [PATCH 2/2] added support for csirx dphy
Date: Fri, 8 Jun 2018 11:33:04 +0100
Message-ID: <20180608103304.16054-3-kwitos@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180608103304.16054-1-kwitos@cadence.com>
References: <20180608103304.16054-1-kwitos@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(376002)(396003)(346002)(2980300002)(189003)(199004)(36092001)(305945005)(105596002)(109986005)(26826003)(106466001)(6666003)(47776003)(246002)(7636002)(8676002)(356003)(478600001)(87636003)(50226002)(8936002)(446003)(11346002)(486006)(186003)(336012)(42186006)(16586007)(316002)(4326008)(54906003)(426003)(126002)(476003)(2616005)(2906002)(50466002)(5890100001)(51416003)(76176011)(48376002)(26005)(59450400001)(1076002)(5660300001)(86362001)(575784001)(1671002)(36756003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB2963;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT027;1:uaAd/n6d5n8iVz0H/WyqgUGO4U7BhSNujNOJNvI0otKcECy8N6DpT5DcK/GuS9Z/ez9q8R3G3AoDDx/bRX8+uT/mFFTd3QZcTR+zI5ravOB5eGID03SWczNfUrFI116E
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BN6PR07MB2963;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2963;3:xUzfS4e+PIWK+MgcnRcJ71pdtQPX99dLtxvOlLCAfuPuzTZFmFsWdf4C4aLYRJGOd0jjrc23f/kMA6uyYNvdK9oozK/q6p3S3LVNJy3RpPgApsDwOHufQNliLZGPJAlspdFaK08E7+ax7dlKas1mr2adjlOC6Lf3nOpZcLkVcv4vMbfSkGt4BDx1zPrmbm5qfqJHvSW9Zjm9Nu9eYW97GkWmbI4l3zeZz51KmYyIYjBENFTNNVZ+s7TA3bsh3hROnZMQ/9Lr1MfmnvdECy2FUW4uIRup/WLlM8w3j9TRLvFW78PvTz4Hcw/flB+wIgp8VXX0vAkdfQq8DJEYS+Nb0iPwQ6oNMjwwC5L+qG4aMTc=;25:Q+qNwJPtdhSo+vtuYoi3+UNFIopdJ3QBcA8ZmytCsTqL596uWzyOliwlFkL+Lopy4/8msUBRyjL9PqosRmmbapIrXxnW8TK3cyMXPf3/wDDrITnP9H2xw8IawR5oN2bB3gAXoS/U9oxsoCOOxgegkdEYzR1xwkFSdS5j8ZKG3iYKf87z/sre+TkUp+yCoYHnzxywa27PsZv1sueJhZJEooXbNG3mW6toiII87PT6+3rbWZZrJfPWwEs0CR2jeWLUpelHScHmIcnRQroY8FMm8P+OlHzzdWFyOECF8vmhXbTaav8cDELoEA99dM2glu1AyGxRndp/+l9i7mkOvhu8GA==
X-MS-TrafficTypeDiagnostic: BN6PR07MB2963:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2963;31:UNRmXqanTWhLK0KnnM/2iHxbVGorMSanX8O8Ru8xcD9i1G0shAa+eTRE6BJIEuq8RKfXz/e28DoEx6aPoR33DXITzSSdyooc2VN1aOO67AyZlm7N53QpHAS0urCPhpE+m3+fZBb1fJkiiCuS3hMtjTQAbcixZRXH2ViSuW5hYWysJaMLQCSIPZIUpKykAO9h2hQhhln4iU3+7NWSK4clR1NxqklT6K43zUvcxaPUsZE=;20:EKcRGDkiGb+JjYQCag0UTwgVr69iNVRsSIUIGlkeeBrbl3IyU0vVAattyGyYz4tbhfjdnkzDUi9Sg/Ta7MtQbXdayvU/5aWYmMdma8GtOE9OAfeuw/kCJ0VZxHSRyJOXomkOufRyHwQZ5FzRlHjiiQR+80U5f2SPpdXRb0tA/tAHg7Zk36+Jy1a4njDeqxyuB034KJewhL05bLEf8SOsyvRZkbe8ACUeazslxjtj7KT8UNN5WF0LCoS2A+O7Qa7sm5UMtaigPHwmrjK8GegXZC1TH4gEeFpxF+pZLVfYtdJL0pWIkwO4pwo6G6aYZtUN/SBUndh1GBjutI06hD94rP/ZlmIje/6sLMa/SCFM3nWq2o063YNj/IEQijowlD+tJMwcCOTPb+C1mZpCkTsTkyMx3DPA7BYVj/tXkIjYdMYE7V6QuHsW0vvnRx3WLRjlv5D/5lafrecQ6qC84okFXUaDU9oImHr/wvjO+uyt6MngaT9ZPGPoe98zqIitPmuc
X-Microsoft-Antispam-PRVS: <BN6PR07MB29636F795F3EA9013AFB9036C37B0@BN6PR07MB2963.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93003095)(3231254)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BN6PR07MB2963;BCL:0;PCL:0;RULEID:;SRVR:BN6PR07MB2963;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2963;4:+zgxqLv1hrQrLMkmpcvkz11n9qvkKJI2FUgaH9EK+SW+uWZ9FCcvdLiiQAkQzofXkLL7kczVTsX3ixpYatyNMTpP0C+fEy/ENCiG7ImqvVKT3GYLLqgOLj1dBFl5DIJIFt++/Jz5JHEVGL4ZsI4SyqTNWJaqvFj5Tmcw7JxqpYrI+/ctE6RArXBWLiquOSes763NF5PUPouIJgJ2K0CNl7z53wPcWJHx9h3A3qQHbNpi8lBmOSpmjm8yp+Locc4eNuXimtRz1NYmccXEzdB6yaUsuocL+SC2CvX+tGkVWKjadCfQPdeClRTU3pm/PXLb
X-Forefront-PRVS: 06973FFAD3
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR07MB2963;23:yDo3QyM6Ol5uET/G3blKfj4ORJN1eoChErshLX9IJ?=
 =?us-ascii?Q?gso8zhQUj3sO/IJ8WjCUnIWalf1f5KNJkz9AC2BFrL42+iZfv+QnhO6R8G2s?=
 =?us-ascii?Q?jXhtOorQ8haSIaI9tx/R+WK+t4KrcL4Ijo8JAMV4hxfVfGvSwMO/8RZMLCht?=
 =?us-ascii?Q?K1xNMiyOehL5gKztl5Os4piDFgyqqDXl+SdCtpA3UQMnwNm89DlefqRLzq3Z?=
 =?us-ascii?Q?MO1qVjQdp+JyAMjH3qptnS8QrZpIGSrSKIHa7hU3FnPHWH7ethQrtlIGMgt9?=
 =?us-ascii?Q?9GSJFp16FWQpG769gZo5pG5WyT6tcGUdRC9Rlm831mIBiXIy3VcaURcyPGhR?=
 =?us-ascii?Q?kdU34pa3LLynYarqaDzP84N+qzlFtiOB775KY3HXR//enef1NDnj0VzMCv6y?=
 =?us-ascii?Q?7KJGeeeWf4GRPH2t2pKiLdVN65/Ywfh7wL5tm8IeppDK/NSKKiYM0uMSlOIU?=
 =?us-ascii?Q?NDMKMYQfOAKTmI+jZYd9zRCdIbJvu+IjuaLYgtZgMbhQqjzqruZ6t0NNO6+r?=
 =?us-ascii?Q?X3d8+sZ/xZyQXGogJ/n6fLGVUTvue18RcR5avPIakPKZy6I1p6sDdlcOr8hU?=
 =?us-ascii?Q?GrQy+SM71o3+L64umZrB+gLZ0iGsAkkgKtbPy2CZMFFyYZMf4GgxSU0hrnR7?=
 =?us-ascii?Q?p4NB1rAigUxWg9vN6ckXdDHSTE73/yRn0kRF0ezqMQc6TjtFSF5SxYLDu481?=
 =?us-ascii?Q?mktyQKNQxomVNZ/0MpawyN1G58G0hUIBrf2Gc6mOn77Mqm4mhTxFHX6SMZ8J?=
 =?us-ascii?Q?BHeps7UBMg+dJyEJ/5CgOEZNV5WhM1NXhl6Uv12av6lJoLIIScBW4sZM6KyH?=
 =?us-ascii?Q?+Os5S67LFNqagcnOyYhTn5GTaOJGEcetn+4pNl+c+QH4sTBoh7L00WHzDJLC?=
 =?us-ascii?Q?A4PCdEfF0kJC0fYEbOrw0FogIfSvDZsTrIHHrBxL5j8vb4v2ByFx0rFheP46?=
 =?us-ascii?Q?7A5a+qg3JWF/u93AdLWd80W7/9tId/m9oaS3SsxMz8cjsz58OkYEIOZh3BRc?=
 =?us-ascii?Q?F7jh7PDscq6MkTr5r3xBopViQWdab/LY0iK4PdJuOxyb2dNk4lr0GuJ9Z5e8?=
 =?us-ascii?Q?u/rs7HQYyJTxRLqc2vd2fpKguutfRMVNKIqgimKFqL8utpcpU0y7KgVTXiXO?=
 =?us-ascii?Q?gKqNIDH1Z2nX6T59LZfmDI1vFPzuAF2cJDW80DS7jgVrQQxzYKNoVWczQYFv?=
 =?us-ascii?Q?E0X1wZp+gYVSnmN9JSvhKXKWPlNBxH0RywI?=
X-Microsoft-Antispam-Message-Info: pDtlRdRmxLPxzhHB6CjXUiSCl6w7Xw+G/KGdqj46NPXu+EbH+Q1nXBXzP9dA+OaJ4yZjLDIuKM07w7iwdunP36QS2KGstT4TxnVMqaKVAbkwx60IDY1PjUGDtwXRUc3fBgB3zAQVV0mE5yA0kSatC2L3V32Rc3+8QFzALPkuRJk/y6z0hMwyVGdTUaFTeJ775o4vhPxeAAO1kpJCBeAxQ5ao/mMo7fN1UEA29gPfivDlNNzO9wX4puqBSCmZ+GJf
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2963;6:h/U99JewydsAfoorU8czyevsWGk4Uqf0Q0lQ+HAC+ndHXN/8QyM3FpjtdNQ9XLf+eCmDU/9s5GhTTezy8VF9D1q4gQ5wKK1xceAYjCz72IdySEH5D8cMJ49c5eCDyuBciCh6njQV1R2AmkcBbKDMmPs5SZgixsWW+YUhxe3W5aHtOKdNdigKncoPW7korX11bHo43W/IcYyYwoVDZd9rjegpN+U84d+sklh++KvjgItmPsJfz7lQMBmMc9ukYsgOnHYKJ0MB3lXVl2evo+oOCkwM2HWjypqNlrjX6xrEsoHyqyEj8oNGWq6UyeLUZ7B+ER33vw1duEnYOqVy1c1qXn+diIf0gOxdWBgXlGVPZg+tzd1ZylVXdTmo5d/+SdbiV43urrBBPurjp0xYxktesFOXyWH6Is4tpXfsI6NUgM7HiOoSlCgo7e1lhawnHBHwDMFcSWJ4qziiX2CE1XUd+g==;5:2CnkIpRYMydNM1ycL8j/ycB8J4cQiEHv2Y+BxLWhTUr8J5jXuqarr19W7HZKHfUKBalFfAHDCV7AvyalHyXk5XJ4f3i+H9+to2PyTa+2y/bZMFJ+7pVr+kHAhnLPwj8VGzRUWrM2apjNwc7+i/M4kNcyBwargk29/9x2Ep+6LQI=;24:E1+fZadMPDYtg4kdVFdGMEYjlQvIbFnILzG3a96TGy2idRLGZI1bSarJzf9eGqSh1D/sRByHTICAq1w2WqE64h3405tJGVUUg+TzLbYG1nI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2963;7:pybAlFZvc5KYkRq+C/xBXRssf10PyXLkkPuswjmbZMh7638R9EzNNyBBwQ+/SITfgQO6P5moVlFdBH2s2gvdqquOEat6bgmrovYTE0Bn8xelgEqR/L+Ylj7Pc+9TxuddpU1GHh4Ie8V29uej3mAs74Xkz3TJcLWOrOrWSXDj04dbVWykN4lHtYWlPrTqjja9I5x1CrQH7svCaFFoSO/4jbL/Ij0R6C6rOaKoX95bddU+Ui++7etwV0pqIvELWGMw;20:YGveGshXeqxER29VRpFdBICH8S8zuofeTgGhrCWdObbUFpvMC2FFHhyW+RCh+W1ACPtGPcTEdVNYUILu4v/0/OsBQ5cBwKUd4AZRQokbKYwufvmM22cuUGpJyWryq1mAyUtvOsIPANoGuwWNMu+aAd69xXDO02HZn1Agql7ph9JTjuFo5O2SxpSGzAlLrle9Ty7lz1YXBJjqulURvvkUwGvhsrnUEnaC5HyVHCtc2SW/az/iZ726fOuykjeuRay+
X-MS-Office365-Filtering-Correlation-Id: b7b25e1a-907d-4482-4ed5-08d5cd2b4bdf
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2018 10:33:38.0350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b25e1a-907d-4482-4ed5-08d5cd2b4bdf
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB2963
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Krzysztof Witos <kwitos@cadence.com>
---
 drivers/media/platform/cadence/cdns-csi2rx.c | 342 ++++++++++++++++++++++++---
 1 file changed, 313 insertions(+), 29 deletions(-)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index a0f02916006b..9251ea6015f0 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -2,14 +2,16 @@
 /*
  * Driver for Cadence MIPI-CSI2 RX Controller v1.3
  *
- * Copyright (C) 2017 Cadence Design Systems Inc.
+ * Copyright (C) 2017,2018 Cadence Design Systems Inc.
  */
 
 #include <linux/clk.h>
+#include <linux/iopoll.h>
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_graph.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
@@ -44,6 +46,33 @@
 #define CSI2RX_LANES_MAX	4
 #define CSI2RX_STREAMS_MAX	4
 
+/* DPHY registers */
+#define DPHY_PMA_CMN(reg)       (reg)
+#define DPHY_PMA_LCLK(reg)      (0x100 + (reg))
+#define DPHY_PMA_LDATA(lane, reg)   (0x200 + ((lane) * 0x100) + (reg))
+#define DPHY_PMA_RCLK(reg)      (0x600 + (reg))
+#define DPHY_PMA_RDATA(lane, reg)   (0x700 + ((lane) * 0x100) + (reg))
+#define DPHY_PCS(reg)           (0xb00 + (reg))
+
+#define DPHY_CMN_SSM            DPHY_PMA_CMN(0x20)
+#define DPHY_CMN_SSM_EN         BIT(0)
+#define DPHY_CMN_RX_MODE_EN     BIT(10)
+
+#define DPHY_CMN_PWM            DPHY_PMA_CMN(0x40)
+#define DPHY_CMN_PWM_DIV(x)     ((x) << 20)
+#define DPHY_CMN_PWM_LOW(x)     ((x) << 10)
+#define DPHY_CMN_PWM_HIGH(x)        (x)
+
+#define DPHY_CMN_PLL_CFG	DPHY_PMA_CMN(0xE8)
+#define PLL_LOCKED		BIT(2)
+
+#define DPHY_PSM_CFG            DPHY_PCS(0x4)
+#define DPHY_PSM_CFG_FROM_REG       BIT(0)
+#define DPHY_PSM_CLK_DIV(x)     ((x) << 1)
+
+#define DPHY_BAND_CTRL          DPHY_PCS(0x0)
+#define DPHY_BAND_LEFT_VAL(x)	(x)
+
 enum csi2rx_pads {
 	CSI2RX_PAD_SINK,
 	CSI2RX_PAD_SOURCE_STREAM0,
@@ -67,7 +96,7 @@ struct csi2rx_priv {
 	struct clk			*sys_clk;
 	struct clk			*p_clk;
 	struct clk			*pixel_clk[CSI2RX_STREAMS_MAX];
-	struct phy			*dphy;
+	struct clk			*hs_clk;
 
 	u8				lanes[CSI2RX_LANES_MAX];
 	u8				num_lanes;
@@ -83,8 +112,175 @@ struct csi2rx_priv {
 	struct v4l2_async_subdev	asd;
 	struct v4l2_subdev		*source_subdev;
 	int				source_pad;
+	struct cdns_dphy		*dphy;
+};
+
+struct cdns_dphy_cfg {
+	unsigned int nlanes;
+};
+
+struct cdns_dphy;
+
+enum cdns_dphy_clk_lane_cfg {
+	DPHY_CLK_CFG_LEFT_DRIVES_ALL = 0,
+	DPHY_CLK_CFG_LEFT_DRIVES_RIGHT = 1,
+	DPHY_CLK_CFG_LEFT_DRIVES_LEFT = 2,
+	DPHY_CLK_CFG_RIGHT_DRIVES_ALL = 3
+};
+
+struct cdns_dphy_ops {
+	int (*probe)(struct cdns_dphy *dphy);
+	void (*remove)(struct cdns_dphy *dphy);
+	void (*set_psm_div)(struct cdns_dphy *dphy, u8 div);
+	void (*set_pll_cfg)(struct cdns_dphy *dphy);
+	void (*set_clk_lane_cfg)(struct cdns_dphy *dphy,
+		enum cdns_dphy_clk_lane_cfg cfg);
+	void (*is_pll_locked)(struct cdns_dphy *dphy);
+	void (*set_band_ctrl)(struct cdns_dphy *dphy, u8 value);
+};
+
+struct cdns_dphy {
+	struct cdns_dphy_cfg cfg;
+	void __iomem *regs;
+	struct clk *psm_clk;
+	const struct cdns_dphy_ops *ops;
 };
 
+static int cdns_dphy_set_band_ctrl(struct cdns_dphy *dphy,
+	struct csi2rx_priv *csirx)
+{
+	u8 band_value;
+	u32 hs_freq_mhz = clk_get_rate(csirx->hs_clk);
+
+	if (hs_freq_mhz >= 80 && hs_freq_mhz < 100)
+		band_value = 0;
+	else if (hs_freq_mhz >= 100 && hs_freq_mhz < 120)
+		band_value = 1;
+	else if (hs_freq_mhz >= 120 && hs_freq_mhz < 160)
+		band_value = 2;
+	else if (hs_freq_mhz >= 160 && hs_freq_mhz < 200)
+		band_value = 3;
+	else if (hs_freq_mhz >= 200 && hs_freq_mhz < 240)
+		band_value = 4;
+	else if (hs_freq_mhz >= 240 && hs_freq_mhz < 280)
+		band_value = 5;
+	else if (hs_freq_mhz >= 280 && hs_freq_mhz < 320)
+		band_value = 6;
+	else if (hs_freq_mhz >= 320 && hs_freq_mhz < 360)
+		band_value = 7;
+	else if (hs_freq_mhz >= 360 && hs_freq_mhz < 400)
+		band_value = 8;
+	else if (hs_freq_mhz >= 400 && hs_freq_mhz < 480)
+		band_value = 9;
+	else if (hs_freq_mhz >= 480 && hs_freq_mhz < 560)
+		band_value = 10;
+	else if (hs_freq_mhz >= 560 && hs_freq_mhz < 640)
+		band_value = 11;
+	else if (hs_freq_mhz >= 640 && hs_freq_mhz < 720)
+		band_value = 12;
+	else if (hs_freq_mhz >= 720 && hs_freq_mhz < 800)
+		band_value = 13;
+	else if (hs_freq_mhz >= 800 && hs_freq_mhz < 880)
+		band_value = 14;
+	else if (hs_freq_mhz >= 880 && hs_freq_mhz < 1040)
+		band_value = 15;
+	else if (hs_freq_mhz >= 1040 && hs_freq_mhz < 1200)
+		band_value = 16;
+	else if (hs_freq_mhz >= 1200 && hs_freq_mhz < 1350)
+		band_value = 17;
+	else if (hs_freq_mhz >= 1350 && hs_freq_mhz < 1500)
+		band_value = 18;
+	else if (hs_freq_mhz >= 1500 && hs_freq_mhz < 1750)
+		band_value = 19;
+	else if (hs_freq_mhz >= 1750 && hs_freq_mhz < 2000)
+		band_value = 20;
+	else if (hs_freq_mhz >= 2000 && hs_freq_mhz < 2250)
+		band_value = 21;
+	else if (hs_freq_mhz >= 2250 && hs_freq_mhz <= 2500)
+		band_value = 22;
+	else
+		return -EINVAL;
+
+	if (dphy->ops->set_band_ctrl)
+		dphy->ops->set_band_ctrl(dphy, band_value);
+
+	return 0;
+}
+
+static int cdns_dphy_setup_psm(struct cdns_dphy *dphy)
+{
+	unsigned long psm_clk_hz = clk_get_rate(dphy->psm_clk);
+	unsigned long psm_div;
+
+	if (!psm_clk_hz || psm_clk_hz > 100000000)
+		return -EINVAL;
+
+	psm_div = DIV_ROUND_CLOSEST(psm_clk_hz, 1000000);
+	if (dphy->ops->set_psm_div)
+		dphy->ops->set_psm_div(dphy, psm_div);
+
+	return 0;
+}
+
+static void cdns_dphy_set_clk_lane_cfg(struct cdns_dphy *dphy,
+	enum cdns_dphy_clk_lane_cfg cfg)
+{
+	if (dphy->ops->set_clk_lane_cfg)
+		dphy->ops->set_clk_lane_cfg(dphy, cfg);
+}
+
+static void cdns_dphy_set_pll_cfg(struct cdns_dphy *dphy)
+{
+	if (dphy->ops->set_pll_cfg)
+		dphy->ops->set_pll_cfg(dphy);
+}
+
+static void cdns_dphy_is_pll_locked(struct cdns_dphy *dphy)
+{
+	if (dphy->ops->is_pll_locked)
+		dphy->ops->is_pll_locked(dphy);
+}
+
+static void cdns_csirx_dphy_init(struct csi2rx_priv *csi2rx,
+	const struct cdns_dphy_cfg *dphy_cfg)
+{
+
+	/*
+	 * Configure the band control settings.
+	 */
+	cdns_dphy_set_band_ctrl(csi2rx->dphy, csi2rx);
+
+	/*
+	 * Configure the internal PSM clk divider so that the DPHY has a
+	 * 1MHz clk (or something close).
+	 */
+	WARN_ON_ONCE(cdns_dphy_setup_psm(csi2rx->dphy));
+
+	/*
+	 * Configure attach clk lanes to data lanes: the DPHY has 2 clk lanes
+	 * and 8 data lanes, each clk lane can be attache different set of
+	 * data lanes. The 2 groups are named 'left' and 'right', so here we
+	 * just say that we want the 'left' clk lane to drive the 'left' data
+	 * lanes.
+	 */
+	cdns_dphy_set_clk_lane_cfg(csi2rx->dphy,
+		DPHY_CLK_CFG_LEFT_DRIVES_LEFT);
+
+	/*
+	 * Configure the DPHY PLL that will be used to generate the TX byte
+	 * clk.
+	 */
+	cdns_dphy_set_pll_cfg(csi2rx->dphy);
+
+	/*  Start RX state machine. */
+	writel(DPHY_CMN_SSM_EN | DPHY_CMN_RX_MODE_EN,
+		csi2rx->dphy->regs + DPHY_CMN_SSM);
+
+	/* Checking if PLL is locked */
+	cdns_dphy_is_pll_locked(csi2rx->dphy);
+
+}
+
 static inline
 struct csi2rx_priv *v4l2_subdev_to_csi2rx(struct v4l2_subdev *subdev)
 {
@@ -103,6 +299,7 @@ static void csi2rx_reset(struct csi2rx_priv *csi2rx)
 
 static int csi2rx_start(struct csi2rx_priv *csi2rx)
 {
+	struct cdns_dphy_cfg dphy_cfg;
 	unsigned int i;
 	unsigned long lanes_used = 0;
 	u32 reg;
@@ -135,6 +332,8 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
 
 	writel(reg, csi2rx->base + CSI2RX_STATIC_CFG_REG);
 
+	cdns_csirx_dphy_init(csi2rx, &dphy_cfg);
+
 	ret = v4l2_subdev_call(csi2rx->source_subdev, video, s_stream, true);
 	if (ret)
 		goto err_disable_pclk;
@@ -300,19 +499,10 @@ static int csi2rx_get_resources(struct csi2rx_priv *csi2rx,
 		return PTR_ERR(csi2rx->p_clk);
 	}
 
-	csi2rx->dphy = devm_phy_optional_get(&pdev->dev, "dphy");
-	if (IS_ERR(csi2rx->dphy)) {
-		dev_err(&pdev->dev, "Couldn't get external D-PHY\n");
-		return PTR_ERR(csi2rx->dphy);
-	}
-
-	/*
-	 * FIXME: Once we'll have external D-PHY support, the check
-	 * will need to be removed.
-	 */
-	if (csi2rx->dphy) {
-		dev_err(&pdev->dev, "External D-PHY not supported yet\n");
-		return -EINVAL;
+	csi2rx->hs_clk = devm_clk_get(&pdev->dev, "hs_clk");
+	if (IS_ERR(csi2rx->hs_clk)) {
+		dev_err(&pdev->dev, "Couldn't get hs clock\n");
+		return PTR_ERR(csi2rx->hs_clk);
 	}
 
 	clk_prepare_enable(csi2rx->p_clk);
@@ -333,17 +523,6 @@ static int csi2rx_get_resources(struct csi2rx_priv *csi2rx,
 		return -EINVAL;
 	}
 
-	csi2rx->has_internal_dphy = dev_cfg & BIT(3) ? true : false;
-
-	/*
-	 * FIXME: Once we'll have internal D-PHY support, the check
-	 * will need to be removed.
-	 */
-	if (csi2rx->has_internal_dphy) {
-		dev_err(&pdev->dev, "Internal D-PHY not supported yet\n");
-		return -EINVAL;
-	}
-
 	for (i = 0; i < csi2rx->max_streams; i++) {
 		char clk_name[16];
 
@@ -412,6 +591,107 @@ static int csi2rx_parse_dt(struct csi2rx_priv *csi2rx)
 						   &csi2rx->notifier);
 }
 
+static void cdns_dphy_ref_set_pll_cfg(struct cdns_dphy *dphy)
+{
+	writel(DPHY_CMN_PWM_HIGH(6) | DPHY_CMN_PWM_LOW(0x101) |
+		DPHY_CMN_PWM_DIV(0x8),
+		dphy->regs + DPHY_CMN_PWM);
+}
+
+static void cdns_dphy_ref_set_band_ctrl(struct cdns_dphy *dphy, u8 value)
+{
+	writel(DPHY_BAND_LEFT_VAL(value),
+		dphy->regs + DPHY_BAND_CTRL);
+}
+
+static void cdns_dphy_ref_set_psm_div(struct cdns_dphy *dphy, u8 div)
+{
+	writel(DPHY_PSM_CFG_FROM_REG | DPHY_PSM_CLK_DIV(div),
+		dphy->regs + DPHY_PSM_CFG);
+}
+
+static void cdns_dphy_ref_is_pll_locked(struct cdns_dphy *dphy)
+{
+	u32 status;
+
+	WARN_ON_ONCE(readl_poll_timeout(dphy->regs + DPHY_CMN_PLL_CFG, status,
+					status & PLL_LOCKED, 100, 100));
+}
+
+/*
+ * This is the reference implementation of DPHY hooks. Specific integration of
+ * this IP may have to re-implement some of them depending on how they decided
+ * to wire things in the SoC.
+ */
+static const struct cdns_dphy_ops ref_dphy_ops = {
+	.set_pll_cfg = cdns_dphy_ref_set_pll_cfg,
+	.set_psm_div = cdns_dphy_ref_set_psm_div,
+	.set_band_ctrl = cdns_dphy_ref_set_band_ctrl,
+	.is_pll_locked = cdns_dphy_ref_is_pll_locked
+};
+
+static const struct of_device_id cdns_dphy_of_match[] = {
+	{ .compatible = "cdns,dphy", .data = &ref_dphy_ops },
+	{ /* sentinel */ },
+};
+
+static struct cdns_dphy *cdns_dphy_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *match;
+	struct cdns_dphy *dphy;
+	struct of_phandle_args args;
+	struct resource res;
+	int ret;
+
+	ret = of_parse_phandle_with_args(pdev->dev.of_node, "phys",
+		"#phy-cells", 0, &args);
+	if (ret)
+		return ERR_PTR(-ENOENT);
+
+	match = of_match_node(cdns_dphy_of_match, args.np);
+	if (!match || !match->data)
+		return ERR_PTR(-EINVAL);
+
+	dphy = devm_kzalloc(&pdev->dev, sizeof(*dphy), GFP_KERNEL);
+	if (!dphy)
+		return ERR_PTR(-ENOMEM);
+
+	dphy->ops = match->data;
+
+	ret = of_address_to_resource(args.np, 0, &res);
+	if (ret)
+		return ERR_PTR(ret);
+
+	dphy->regs = devm_ioremap_resource(&pdev->dev, &res);
+	if (IS_ERR(dphy->regs))
+		return ERR_CAST(dphy->regs);
+
+	dphy->psm_clk = of_clk_get_by_name(args.np, "psm");
+	if (IS_ERR(dphy->psm_clk))
+		return ERR_CAST(dphy->psm_clk);
+
+	if (dphy->ops->probe) {
+		ret = dphy->ops->probe(dphy);
+	if (ret)
+		goto err_put_psm_clk;
+	}
+
+	return dphy;
+
+err_put_psm_clk:
+	clk_put(dphy->psm_clk);
+
+	return ERR_PTR(ret);
+}
+
+static void cdns_dphy_remove(struct cdns_dphy *dphy)
+{
+	if (dphy->ops->remove)
+		dphy->ops->remove(dphy);
+
+	clk_put(dphy->psm_clk);
+}
+
 static int csi2rx_probe(struct platform_device *pdev)
 {
 	struct csi2rx_priv *csi2rx;
@@ -455,10 +735,13 @@ static int csi2rx_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_free_priv;
 
+	csi2rx->dphy = cdns_dphy_probe(pdev);
+	if (IS_ERR(csi2rx->dphy))
+		return PTR_ERR(csi2rx->dphy);
+
 	dev_info(&pdev->dev,
-		 "Probed CSI2RX with %u/%u lanes, %u streams, %s D-PHY\n",
-		 csi2rx->num_lanes, csi2rx->max_lanes, csi2rx->max_streams,
-		 csi2rx->has_internal_dphy ? "internal" : "no");
+		 "Probed CSI2RX with %u/%u lanes, %u streams\n",
+		 csi2rx->num_lanes, csi2rx->max_lanes, csi2rx->max_streams);
 
 	return 0;
 
@@ -472,6 +755,7 @@ static int csi2rx_remove(struct platform_device *pdev)
 	struct csi2rx_priv *csi2rx = platform_get_drvdata(pdev);
 
 	v4l2_async_unregister_subdev(&csi2rx->subdev);
+	cdns_dphy_remove(csi2rx->dphy);
 	kfree(csi2rx);
 
 	return 0;
-- 
2.15.0
