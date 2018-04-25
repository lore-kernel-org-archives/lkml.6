Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751846AbeDYJBg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 05:01:36 -0400
Received: from mail-co1nam03on0048.outbound.protection.outlook.com ([104.47.40.48]:58525
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751705AbeDYJBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 05:01:30 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ganapatrao.Kulkarni@cavium.com;
From: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
To: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: Will.Deacon@arm.com, mark.rutland@arm.com, jnair@caviumnetworks.com,
        Robert.Richter@cavium.com, Vadim.Lomovtsev@cavium.com,
        Jan.Glauber@cavium.com, gklkml16@gmail.com
Subject: [PATCH v4 0/2] Add ThunderX2 SoC Performance Monitoring Unit driver
Date: Wed, 25 Apr 2018 14:30:45 +0530
Message-Id: <20180425090047.6485-1-ganapatrao.kulkarni@cavium.com>
X-Mailer: git-send-email 2.9.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: PN1PR01CA0108.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00::24)
 To CO2PR0701MB743.namprd07.prod.outlook.com (2a01:111:e400:142f::17)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO2PR0701MB743;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0701MB743;3:cxkXPTXFKiqo2sZjkaEFn+3GrN4GljW8PcW7iKkknD1iR+ta1LFP74/ExC2UJIDNJfB2I2Ov6ObbV6GqI+SsqCBNhp+9NGcWcArBXSp8RdC2rSUISe3K93AhkgvSs7o6vXEB7FMQm1Tf8LSQh1ymb0NtrFrksBR4LWiFP9GAwlxFJHZ5zJGHmNq61pIQdCjsCbyIroPqYha61/qx2vgU+yqKwKVXyEL2UsaXgnDolfBLmJCBrXbzPPCZSPAzoFEV;25:TPas76dhWoo8Jnod2fu9TRGcQAmDGn7UiBWXw6O0SRBYs3tBsxvz67BFrmfDZn9i1p9K8RzWuqr0pPEtLHT6W8DiRREMblZYnqHNd5Thg7jOFmqray6BQrRItpgccky5MKWVHj3ZTNGoe0LsesVNNZfinfeqBoseS6iFsvhFPrFT1zd0+k2oZM75Ck6grhMLQn1a/P8PFZBxJQgzqx2qZU/OFFWbW218qmdHUiWODnrstKPadwm+XT3YoFjtr04OKyEN7ZEu9zWk1JfgpMYvSb5N9KAvrSz8XdcpWZdoJvOGCLgTYoNyBh7EaPyXL0IL7+DQ9T2JeNpHVy0Vwctjqw==;31:JJR01/obO4IRM0GoDWyurG+axfU1ZLs3E/a2EtgtpM5qhrV8f+bFvfRGE/51xkXG6hAWNSO5lFmTe72huUzyPMywR/OR+g94BqAzUqRHPFB2jYWvcnJGSqpN4cDYRZ5ZRiOAMSHL6oJhxCWwKvCHR+A/OqtFDkomfXtcqJbieBaQzj40ofdik6HkM4Il1U2gxS9ferZ2rAxflfuPQlwMJCr68sikV5lQ7zhXBT7z7xY=
X-MS-TrafficTypeDiagnostic: CO2PR0701MB743:
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0701MB743;20:kDlkYPXJ/gjzeD7X4sji2E1zd4KwFCcBws09uqGRtE9snhaNsOP5g1U+mKsFvMkLbl+lqG6LbHEjuYClb2R8CpZUjd0GNNsQXdnlnjFNDxjkWwtgpvPcJqXqlUHVMdtOQMjrSzSYcbFKoanrqselGzWx+8E/7j8LFGcsdNyNNh6gcBAv0bXmEIG6NAkgYu7pjPstJpirySgRxiXhg+wlklQL3etk3GQFkQHN3ROxUrqzoJZwdKoYq8JhxG/Xavmb5nV+eYsCpByJDMdRqOUnXDMNP8rhlpujfoYABpBI+zNiUCu98ddQfMsx6rmamd79u5WO7rkb5BgyNPH18CyOBZ5cRXZYJ0sUj6isyU7QL0ERiDLcAlhKsOIrj+PDWfvMQDQsGNPul4KCEgCBH4lZkye0J19wbaCcgOOiFuB+Smv2BIQvymDPkyZ8IkOWaaP+n1hcIl50JRvjy2Ross0BDsjbvPtuZB7d3urrq1ER2CvcRCoqFJCOGRXJqopQbpNC;4:ZWMPbrW8ddk+qWwN5FbD0vwtU+ivH+Q89G1OsD3nk+mb1O6RJBtWmmde4Fcba/TthaAvPOUSDqYeWkE6yBImb5vNMlrOJD7amhQX773eI0gwtpnMaUUXlAafsU2R1LusdT7hm/B+/3VsTVU9lBivHpYSv6axrICvUULrAMZIQ+7WzidQg2BpDZU23SqQg+5RiXaxxYt57wVHkhxBu8urgyb76gc4NBhtwP6OjPm39PGKbTcTQkjINoP05i6Y4pHhOq75XzUqKoVw3dKsW3O56Uk36P6WsIRtOv8n5yByvgkoVAzpj3Q9NdNCWOEDCUdX
X-Microsoft-Antispam-PRVS: <CO2PR0701MB743E35B0CF3D82FB6FA7C74838F0@CO2PR0701MB743.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72170088055959);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231232)(944501410)(52105095)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:CO2PR0701MB743;BCL:0;PCL:0;RULEID:;SRVR:CO2PR0701MB743;
X-Forefront-PRVS: 06530126A4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(346002)(376002)(39860400002)(366004)(199004)(189003)(8936002)(50226002)(7736002)(1076002)(2616005)(966005)(81156014)(478600001)(72206003)(5660300001)(316002)(5009440100003)(81166006)(6666003)(3846002)(305945005)(105586002)(6512007)(50466002)(66066001)(68736007)(6486002)(7696005)(6116002)(59450400001)(2906002)(97736004)(4326008)(25786009)(386003)(476003)(47776003)(86362001)(8676002)(106356001)(956004)(53936002)(44832011)(52116002)(6306002)(6506007)(486006)(26005)(16586007)(48376002)(186003)(39060400002)(51416003)(16526019)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR0701MB743;H:mypc.cavium.com.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO2PR0701MB743;23:bf18J2w22lRKzHeUNIi7mjjysolR0lQV5InvAJ/9?=
 =?us-ascii?Q?9PJsUeFIOKpkr55mz8cDKgenEFUnbmgyXKIligjwCqaffepjKCjP7oRfSwZb?=
 =?us-ascii?Q?dUbKqVCWDLLVF+/ApsGj3JPYRSL0XcywafWC6eBaL/oy50tvM0jTvaBE/pM6?=
 =?us-ascii?Q?+JXP7pECe+jotWpcIyN/2atvgtLMVd/ZyweRP4ItsTv5Zo/tm8jkfdGJqU7p?=
 =?us-ascii?Q?1AWHzHoHQ+GdfbsYjDccq7rFjy3QTh+Wv1RDmmgsEqXKtnPhz2o3AH71sUZ9?=
 =?us-ascii?Q?b4bDCEe4jIMLEJ4ljk1loYwwdTbTTHCWrL/UDBwHxq4Aq66uOFClGd8Dudiv?=
 =?us-ascii?Q?BSbGkz4uZIqV4tgtd9MhhgxF503iSqwSHjl4dL1TPoeLLXU6fMwmUG5bQAhw?=
 =?us-ascii?Q?Vetj4Uc+fPYx14t8cp3xP+wpB6w4+coLyGV59WMkZkRvBi1xJZOmGWCxJEop?=
 =?us-ascii?Q?ib0Ew4JaDlejH29azuozPT5WjGLm0f4MR0cbkT94oAoKg4eb6CZ8IOoSzQbh?=
 =?us-ascii?Q?ApF+q0xfe3+aapkWVXihXLxygYEXkEHf8QDLU+BWMQemxPSLDLKp69r6MtTm?=
 =?us-ascii?Q?/3YLN1mOn5UZyld3B9u1thJjASe5Qc7KvFzF7cQfdiZfbypxlS0/aMgPgqVJ?=
 =?us-ascii?Q?cp+tFKIo9ysViIgXoVYUIrE3WSGFElLsN0Ft5yMS2THZjYZw+aeCyn3guVUJ?=
 =?us-ascii?Q?xx+snh2sSD6lefC0oSdCQtf6YQ47eogcMUf/QoADayzeCAR29cy5K9U9s/S+?=
 =?us-ascii?Q?r75kPKrPrO1jHCJaTF2gUfXqrvYS5TfzRXLVXw9/0rlHT4M0eGbuK4HcfrFJ?=
 =?us-ascii?Q?jzt9c1uUrKflK1BG3A5FAokCBYZBElurAHCf/o3czBgi7RJxLQqGV/MbhC0H?=
 =?us-ascii?Q?pthM/mdSGM9U4niO0/OaqjY9dlpQSyHWh/zlHbdoi0dxZaasIxEyJ5fN3RuE?=
 =?us-ascii?Q?P2hCtSdyRSgU9R3twZtENTX9jxeK3Uz0bV9yXH2VUvzY3i+Ew5hY6mA2Q4VN?=
 =?us-ascii?Q?LQ7G79IskzgOSSHIGN6vTy1RPTs4AQaWrkSd97NlLlVc/xmqHeDB0y9ePutX?=
 =?us-ascii?Q?JG8tgVzakPvqt8Qe3xKW/gt8ePxE7+3wKA2Vkg+edpo8YyGNQuuw47oY5Avf?=
 =?us-ascii?Q?sxqlRGiGcVJvYYBglxRJHn0LYXMVnO6KFg0+J7HcKMaXO+QCHU2R1s0MiwvY?=
 =?us-ascii?Q?KxC3TJW2ocflJGzVVhpjkppkrOCX/l05EZLIBdD1AOAgWiwmf9k/knxuap2W?=
 =?us-ascii?Q?bKOcr8AsAmCw7d/jBwvBoftfsdK5IB6qxqQCIBE0m5ki3rkry74cJy27J+kQ?=
 =?us-ascii?Q?NKW5iaAaRaIp7Fmr9VukD/4=3D?=
X-Microsoft-Antispam-Message-Info: dtkCENkhJ1yD1174BDzkcgh8f4bJ+5WZ7Eof5G2MstuaU+JCyyUckPGsndz4vZ3qG7c0xsmhc2nqchWcryCQrso0HkAmBojqoAtT2WBJ424E4LLNXuRFgXuRw7iZL1U7Jvn4/CY444zjtWJnWQJLdgND7sGhaSR4nzrne2CefQV5ule/XgDkqY9Dzlu0l2ML
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0701MB743;6:nlG5K6LbcI6qCsVe7zd7EFSmYYBh/HSgti49cyoBe97pq365aCxhOmaq96NTXXkqiM0b/17Ct2zevbR4EBnXT5qsY0xXGjSu3t2cRowfsSVDCIMupyJT5pkzZdxlQQWMl9u/U4mnC/WTRbJYYKE3NAyS89FyrzEx7a77pLsM+JfQMtukax6gJdYeAYuHCQG0MCM8vErpzPco8d56X37Yu6L0X/ksafugFUCyLRPh2FcS03zcPZwNsAonQIEAZYsxJGXcYFuz46y7KyHWiTtxPTFEj5V2gHfACHvqlZ5/7knPr5J4n129SqC+wNMhjRT4fMrIwllYLtE7RcR+znYIlm05HflSyr1Q0kk0h6gHREGJM41mgMU4yUVRanFj9wBz6BHaal1S0+9G8HgYn6ud8WsufPYkTKpw7UfNXsyebvfxZ42iqaQtwj8XctzPGDzRfECYRm/TZgKVH7x2noy4pw==;5:cstcVH+8w8PlbHzRqW4k03gnERMFWQSV5sxGoN4lOKnn7UtPZPqfn7yCiDz1FJElkzcR/Uy/dRFH80bmFQUBH2WaFJI4WJjvBHPwyMowhCHbygHjt+VpgRaK4Cnh4x4dL9KHMNgSW0PmlaaWiyeIw0SCUOyXrjInqUD4grXC0Uc=;24:SuwsG70RGfyQ5HqeWOFO/xosAFpbTy8GbtMX03mZoOsCcuuBfmSHySTJEC0leBPq9ioPh7Uvm3/MKYFq4qAq25ci2E9VRD0PJgWl5gRf/xc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0701MB743;7:R6HRMzp+Y2X01VTl1Rtw/PsnjUKbUZ5KxMjZ7cE+qQyUy0hZahIN3bPp5qypJKDSiBomA9aZSr++PLcmUW7TeeAaGZVTARTiLBp5dd48C8IfNsbRwd+Bk0JswwbilrYoA6aiCY+VDMNTKMA4VNUdA/QVfrZKZRgRwlyA2ssmcdr3wpuwlW1+Mce+75viVEZjtBe8ZEqzCxEpE30DUsI2zyoDrGTx/Vk8pjDeeSUIMnrZwxJXYXLIiTQQ6QoIYPWE
X-MS-Office365-Filtering-Correlation-Id: e40d06ff-ba48-4fe1-2fff-08d5aa8b2084
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2018 09:01:23.2535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e40d06ff-ba48-4fe1-2fff-08d5aa8b2084
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR0701MB743
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds PMU driver for Cavium's ThunderX2 SoC UNCORE devices.
The SoC has PMU support in L3 cache controller (L3C) and in the
DDR4 Memory Controller (DMC).

v4:
     -Incroporated review comments from Mark Rutland[1]

[1] https://www.spinics.net/lists/arm-kernel/msg588563.html

v3:
     - fixed warning reported by kbuild robot

v2:
     - rebased to 4.12-rc1
     - Removed Arch VULCAN dependency.
     - update SMC call parameters as per latest firmware.

v1:
     -Initial patch

Ganapatrao Kulkarni (2):
  perf: uncore: Adding documentation for ThunderX2 pmu uncore driver
  ThunderX2: Add Cavium ThunderX2 SoC UNCORE PMU driver

 Documentation/perf/thunderx2-pmu.txt |  66 +++
 drivers/perf/Kconfig                 |   8 +
 drivers/perf/Makefile                |   1 +
 drivers/perf/thunderx2_pmu.c         | 958 +++++++++++++++++++++++++++++++++++
 4 files changed, 1033 insertions(+)
 create mode 100644 Documentation/perf/thunderx2-pmu.txt
 create mode 100644 drivers/perf/thunderx2_pmu.c

-- 
2.9.4
