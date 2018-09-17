Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EF9ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA92208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="pRgfh248"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA92208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbeIQI4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:56:36 -0400
Received: from mail-sn1nam02on0079.outbound.protection.outlook.com ([104.47.36.79]:26118
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729322AbeIQI4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cmwYGxLe8gg4jOzWNSNzOrWo3eIpy4vFF+AovXAqzg=;
 b=pRgfh248Y1WXP81Drsixp2Ry+32krFJuu0KCqUn2q27fDiOuInnaS3aV92TKTZx7JAT8LEiIgHPfJEcqFZsY77aGuvSZcfuBa/C+IDhq8fcnPzMEjvjMASa3AJEA13fv3PariRAqTvmZ/cjS2dEJvLYs1nxXlgqAyzM+MsS6cUU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 SN1PR0301MB1583.namprd03.prod.outlook.com (2a01:111:e400:5232::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.17; Mon, 17 Sep
 2018 03:31:08 +0000
Date:   Mon, 17 Sep 2018 11:27:41 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/3] dt-bindings: i2c: designware: add optional gpio
 recovery properties
Message-ID: <20180917112741.7c3d6514@xhacker.debian>
In-Reply-To: <20180917112633.252c591c@xhacker.debian>
References: <20180917112633.252c591c@xhacker.debian>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: KAWPR01CA0081.jpnprd01.prod.outlook.com
 (2603:1096:402:c::17) To SN1PR0301MB1583.namprd03.prod.outlook.com
 (2a01:111:e400:5232::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2c88991-7ec0-429b-08c2-08d61c4e032e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN1PR0301MB1583;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1583;3:mPDPau0y29rZUlJt+N8ZhA8EenMHAQsiUSspVCLLxrfNMgHLf/RG/r5xyDVDY+xm5qe/DJCnmiO+Wo4QjDcKtyphL0B/+9mj+ZKL+QOUP/PchIjnV7aN2M/hb/oeXerh/3xA12TnsMUOFiY7AW9IjuppFYAF+tIOhT2lxw6yRM+VDdhW047XhTUpAuEcZ4VaODs8iVJI9bcItUFE3NpFlJv47itQsyX0JulNAjQluAt1XhX8ZMCGO5s8MhPOZk/F;25:0Hrzt3Bv2lvK1I8HnAwY0tuqTyzZlLnlmoDP8DNNxZZlrjQrJM59+IJTdQdocycgJyrIBSxKNHEmf2EHFQ7j6OhlJg3TFgjuGISe/uLEdGIUBmUXSRh0plgR4ECWmpWkf/mfvKzBXP4Bcs/oUCOHPvXWII4ufZbQuwaaRrKsfJ0JN17mxsVl5QU3ofOGDJqGNhDs7FFqw2joscqsvLRCvhpn/o4LeUBNujMjx2NedGYTBxajsOg4LZa9f7OX/F+V8IskXXTG/PpkvtiYQV1MdefiXunhxT5NNZCRaI7XVKK88IONWMgXoc2PdIUxrYhuEoK17qUAPyBpaxyzoKfC9g==;31:1ZcZAfVZ304gLiIBw++iB1W4dTQDmicsxIM1JdkujFM29c9RuOQ2IhOVoqDhearhuUPs8KFusOSPEsLyPXQFKLSZ5bA27l4oqEJ8pqao2l3IWA+xRThMJp6mhMc6QTGsxlagyDuWepbhXyMrerLNAOhDqmNTWBVX7TIkcSZO7pQtshm5pPEkq7mWTTBcn6jm659ifS0d1+3V27NC7yS1YG36r7eSaMDWAVuAAovVMik=
X-MS-TrafficTypeDiagnostic: SN1PR0301MB1583:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1583;20:2gZ+zzX13EU5NJL8z9wlo5Df4DvPnmmusaHTQoL5f1ksPgktJZD9+wAsOyBT5HyE2TDqt/kkLJBlskjcLgKwmLSQFVbZ6lrzaDiBkLGoXyCce+qgh4z0w/PRkP67/FPROQ2bvyuqWilLIHB+scMUtpx33P8ivLG0/bkyS2RFrI/lUMFXOs32h7msvvTbUoyqfQRYQzGfbbM1XDoGAAxBTKrgnl+DSuDiPBo60dt+PqrGBGJYkY6A4+5tIRs5LOhrh+QV0k84gr/EHLphABSc3cPf0ZzV972t4ey3X6AsV0Ta0UAwg3OB5N6vKNR17J2Yrg6KUEjIS1SluhHilICddJcIyTppue/jDMdl/Gw9tLm3jhv1kd6RG/HW2bO81I1HLzwIM56sZF4bE4BKtdajNQ0ZMi9D0BJ6Su2of2YF+hI7Eu4UnqgxUxCvOYpDWiO+Psy8/rgrBg3fHV3Mg9XOcCt44DeS/4Tlca47tnAdLpcHj/fsEfMuEgpQhoBJP2tf;4:hHBiEgA+g1aPzbrJ3OM8089llxDcZkYVSck/HCuuTgOA+VbfvHF5yUbIeKRhy7FGHQGLOoXzNMkx48DSMKlNHsQdWazANQO88DrxATZq2jBgN3fGPSiXZiU3TJjdraHBcRUv89nO8kte4bL5YPAFwk1tKuMbsi5FhIcyl0Ly0fDmeFf6dkjjOxszZK5KwmgaJpqBwW3m7VOz78O0S/PH17BgOJz4Vgnh6rrc7xAYtZCwV+FrPFRs2iePviSWcFK/HAl8UAQgmsQ1im1RKB3qog==
X-Microsoft-Antispam-PRVS: <SN1PR0301MB1583CF823D4B6E268A8EA1F0ED1E0@SN1PR0301MB1583.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:SN1PR0301MB1583;BCL:0;PCL:0;RULEID:;SRVR:SN1PR0301MB1583;
X-Forefront-PRVS: 0798146F16
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39850400004)(376002)(346002)(136003)(199004)(189003)(3846002)(53936002)(6116002)(446003)(11346002)(478600001)(8676002)(68736007)(50226002)(81156014)(23726003)(8936002)(33896004)(2906002)(50466002)(97736004)(72206003)(81166006)(26005)(16526019)(4326008)(25786009)(52116002)(7696005)(76176011)(186003)(6666003)(86362001)(7736002)(47776003)(386003)(6506007)(5660300001)(956004)(66066001)(106356001)(9686003)(55016002)(230700001)(305945005)(476003)(575784001)(110136005)(54906003)(105586002)(1076002)(486006)(316002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR0301MB1583;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR0301MB1583;23:/Vz2RVQAmiwXjY2T5SWk0AbgXlURS7UzxQkleg8?=
 =?us-ascii?Q?CnWKPTHfL5+JEpTso8nmjKhitGvEMd4rteo85k5jgLkPChs/SFsBkCEre1wU?=
 =?us-ascii?Q?BT0v3QJmOhaogeuK4N7FtUWLuKwMQHCbx0KBzK9mnMX5pH1j1vJsHS6KA5bt?=
 =?us-ascii?Q?rivA6Z9oSVKNloS/jKRD7NCx6+LV0fL+5nXpxG9wcYfTEMNy5w70ci7GAHbR?=
 =?us-ascii?Q?h6CFCYLkfp0Of4hGBhkIeAV+gaiOIwG4SrV86jxl+zt2aMY+2ojzrWYQozah?=
 =?us-ascii?Q?Ov0rS0H0d5CyvEUpm4lts9bfmbK82nn4s22cdV400r/clNGGzgqHHK5nf4bK?=
 =?us-ascii?Q?j5y+F03GcrPlwc2ACr72xY/5d3xifE6gUTHKFDMcYWkgGXbuDcLTiL6N4N1z?=
 =?us-ascii?Q?5FkpeBiBibZQyBNeBrTknjjAD3tVjnQTz23Nn4huZgCAdMy/lUeD6DmRsIJU?=
 =?us-ascii?Q?7x3CHBDSsIFGzy+r6doqiSeioP5zXsxNZOa81lMrh+YPSiI16zPsZRjiWUih?=
 =?us-ascii?Q?GhR0rmQp6LolZYAsDr6pHzH/vJ4R7zpjpgz09G6TNPBNN3MvLRT5d4q3tLVU?=
 =?us-ascii?Q?y2nAvmWgaIvlqYjWU1f1xJb7Oz/kn7CoEFti3WeqzETHwhLIDKMy6YmSQqSt?=
 =?us-ascii?Q?CoXhXaYqWOOcer8xWbbiO4L11RmcGbwQYZV5ghNYBFqKKUIKYGCcq8jyjk6S?=
 =?us-ascii?Q?JsD5vpmtG/H6oQHtWDpoHfivDUmJvRcoaNBT89/mUvNkXfFf4O1wkRkOpjL+?=
 =?us-ascii?Q?XAOFSns1dJ4ovnF0WwOI1g/UbPWDUK4dBXwicBDCnQSBThRNL/DGin5HvzUk?=
 =?us-ascii?Q?w5oLL7unGWURhQsGFHFFX/bK0H8Qe2cIgv32dKRgja2TEe5xFrsoL72p/+Rj?=
 =?us-ascii?Q?/kWlbM6ZwWhWuwSxNLWQXQN/J5Gw4dkE/1EZiEr/nHFd3apWi5sjrhSiTkCt?=
 =?us-ascii?Q?3goN8vD7j3qNPsreRTZJr+1mv4J7mzIs80rt3PmVgJya+E78Ac4erYy3Og40?=
 =?us-ascii?Q?rt3b2wR0K8c56JqhooTwi3lecAodhi+1/IBX6UNkGKWp/6nTg1miZ9uAJ04U?=
 =?us-ascii?Q?sMSNnGfu4oMeHRRic8LHpAbuzNYAvrkhGoBTUvjB3VHv+KpYilZZwM/n28t/?=
 =?us-ascii?Q?/Ju8o4uCwRXDLXWhsYWeu40h8EHIGRyGp3w0zN0ZXxVcAW2JBCh47NDYS/py?=
 =?us-ascii?Q?AL4t9tIsVSuV0gmD1XCyUeMJby4KJN8xJhWgKPn7MIIimAs2VSnWZN1VBZPp?=
 =?us-ascii?Q?qaSkqpRKlPWQlCitdS+6EEd5njsQMPqbM5bVoB58q?=
X-Microsoft-Antispam-Message-Info: 2e0p0HSzftuzt+A80ZDXERUpJHEaSf+a6Bc81BSWIQQp0/CZ70K7Nh9+RGvobWy9RUlR18eESwCIlCeU54pMTKmCHNNRYEI89PTbjZ0qrGQRLi5r0GJp4qCBa6RHVlHF17u418vbv0lUnJEJHhE3boX3XrBBknn6+p9D2SiVFnV0BHM6azaa/ARmFNCw7uVwLIMLqDy4NjUlQRurgpYykVyI35XlCSIT0Exc8TyjnW45s6NOqOsaqvQ48sEctFufQCIRSld2IV5jGBswDNgtI7mkgH7BLiw5/KgIAKId7LP036PYtZfiV2oHF8M4pbin1956KG6gdGIYr2Sf2DGMD0U4t2ywCQ9N/br9yPXMLts=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1583;6:6BYu8PalkvYd7oPnBhb/OA+m7+yqc4aofF/3Ue2nOb5CEKrTYxU9mF/ajQCJc0/yCmcs0S7o3MLpXw8cNa++sezbXOzkn3AxWSiGDitUUROZCIcQZk6IQIC/LO09k2KJpDpyfpo29+uirxZ1Zvz4qoyGxDzf2wXYrDsnMxL+3C7LBmALURPAtuuuHxzAhv3+pygmGCSpZOaSQGGiXZGqNVRcOTQrzuoQ9iEXabRzYo6kv+ExWHL/t9BjXHxUPtO/swcbOzKvREKIAZHpzARWgD8lMAdHtdRwJ4K2YDh6diimxa7tmsaYB1nWPq4mzyWZrOoiFfPHH7rndMp9W7RMhQFvepBw/LBC7tKh5uYWrHgSNm+0gQwknw8cWIuoPwXHgSMlaupyumpE5ZSN0pF7a1arCKmdElWm7/wgPQ0WSA9IYjvUZPFF1khGjls6Fiet626AlDWydoGMD0FJXAlH/Q==;5:/eTVLFSrzDmam8uxJlsc62gzT/NsU4vhVWDzJ7rtH5dkPce0iaWoxe5zc6kdme9ZPvedaitwER0f8G67ncYeAY7/2BM0xgOjHA69nxl1fn8fFymcOwzBK0Ym8xD9r5UPwVb3WUNvcHOvA2rdbSwxlgIkRhIhPm053dQqfuoOLTY=;7:LRvdwo7KiJnEbih1nFHSQUVSEbTxCAaIMSLLcJLOZBGmfoh3uvKl1dHGHzTAWaXYQJ2hB2A3eQ5sVrBmnHlfGnCBmUCIEIcnGFJT6hzvpFjuLv6RR1R7q0FWBxPufxCEymubk2nV2go30SK3JHYKxxFaVArR6hY9igMat9wc+paR0mqvrqeN+byG7PRKVwrJn/NpCuHaACe5W3haWY3UJ3Kv7gdZkT1GBDlHRGSXoDU+OFwZmP0Il7X82xsGdhiB
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 03:31:08.7634 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c88991-7ec0-429b-08c2-08d61c4e032e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR0301MB1583
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the scl-gpios and sda-gpios properties for bus recovery.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 Documentation/devicetree/bindings/i2c/i2c-designware.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-designware.txt b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
index fbb0a6d8b964..1d6a6a8061ba 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-designware.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
@@ -20,6 +20,10 @@ Optional properties :
  - i2c-sda-falling-time-ns : should contain the SDA falling time in nanoseconds.
    This value which is by default 300ns is used to compute the tHIGH period.
 
+ - scl-gpios: specify the gpio of the SCL line for gpio recovery
+
+ - sda-gpios: specify the gpio of the SDA line for gpio recovery
+
 Examples :
 
 	i2c@f0000 {
@@ -42,6 +46,8 @@ Examples :
 		i2c-sda-hold-time-ns = <300>;
 		i2c-sda-falling-time-ns = <300>;
 		i2c-scl-falling-time-ns = <300>;
+		scl-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
+		sda-gpios = <&gpio1 16 GPIO_ACTIVE_HIGH>;
 	};
 
 	i2c@1120000 {
-- 
2.19.0

