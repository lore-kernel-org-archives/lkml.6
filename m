Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E2FC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0855B2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="eMliHR+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0855B2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbeGYNDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 09:03:25 -0400
Received: from mail-sn1nam02on0059.outbound.protection.outlook.com ([104.47.36.59]:43823
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729004AbeGYNDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 09:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CI+yd8z+AYImdMYrguqkwXIxDPONFpkkpdR9fwOHIUg=;
 b=eMliHR+sdS4dbDGza8b2oBCTfN6lt8Y9lN2R2YYrqz2NHZAOBIeBJK4LIUXNkRwmQ7UpOiXsTStePpaxrPgk7WR1vJXqCSO7U2c6Dt3TS32T3faMHPpnZFrLYKpdqaSlQPgn6Ad7Mk6OVbKU0x1vQIhqwK3cKFDYyDzt+riPsnw=
Received: from MWHPR0201CA0092.namprd02.prod.outlook.com
 (2603:10b6:301:75::33) by BY2PR0201MB1909.namprd02.prod.outlook.com
 (2a01:111:e400:58b6::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Wed, 25 Jul
 2018 11:52:00 +0000
Received: from CY1NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by MWHPR0201CA0092.outlook.office365.com
 (2603:10b6:301:75::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Wed, 25 Jul 2018 11:51:59 +0000
Authentication-Results: spf=temperror (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=temperror action=none
 header.from=xilinx.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of xilinx.com: DNS Timeout)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT029.mail.protection.outlook.com (10.152.75.143) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.995.12
 via Frontend Transport; Wed, 25 Jul 2018 11:51:55 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fiIKh-0007iM-3F; Wed, 25 Jul 2018 04:51:55 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fiIKc-0006dG-0H; Wed, 25 Jul 2018 04:51:50 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6PBpd18008014;
        Wed, 25 Jul 2018 04:51:39 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fiIKR-0006Z3-0d; Wed, 25 Jul 2018 04:51:39 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 2B87760504; Wed, 25 Jul 2018 17:21:38 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <v.anuragkumar@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH 3/8] usb: dwc3: make controller clear transfer resources after complete
Date:   Wed, 25 Jul 2018 17:21:26 +0530
Message-ID: <1532519491-19502-4-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1532519491-19502-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1532519491-19502-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(376002)(346002)(2980300002)(189003)(199004)(50466002)(186003)(106466001)(356003)(36756003)(50226002)(426003)(11346002)(63350400001)(305945005)(63370400001)(446003)(48376002)(63266004)(51416003)(81156014)(81166006)(76176011)(336012)(8676002)(126002)(486006)(476003)(2616005)(36386004)(2906002)(26005)(90966002)(103686004)(39060400002)(4326008)(478600001)(107886003)(6266002)(316002)(8936002)(54906003)(16586007)(110136005)(106002)(6666003)(5660300001)(47776003)(52956003)(42186006)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR0201MB1909;H:xsj-pvapsmtpgw01;FPR:;SPF:TempError;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT029;1:zrSQ+KjcsF5on7ESeKcE79Gownt0S2gOmRaNQ5V8sBWKNCoPPeQM4AapnrMyp2QpUq0jh2n9x5BStVSczG7TnYnv3FynUgvBZUwWRMYO/uovE3BnJon/DbCO/4L6xALE
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b18d479-4ff0-4ca3-1359-08d5f2250666
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BY2PR0201MB1909;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1909;3:Y7xoe66Dt520iuFqKeDobf6nP6s7Ri/BZhS7s2VG44QizwKlBHTsUDpNYHmeX/oqRPAOwI1ScaSgPp2RfJx4yJigwLeQEKywfyCgWzdnR6FILqQ4MTmnjPKX8ptLx/Psqsn4UPt2X1pW/7aAhsTclUVwNzAnN4lstEc4j/XSj4ynh7uXvKOh3vMeZwj9bL/p2zUWzwO2jARRg+VGvDBoScZBNzNel3yyhAZTam6BvoEoUS2hn6tMRXg0IMAkRaGvcoLniYbmUZrCzYMgCkEgFbzPY8EyIZgiO4nLj7r/bvOOrB+eptvXbBO4qlzQk0TIRhFRmJv6Ic9GJg5pPWqV2Il24DR902o/BE1tmLg4Y4g=;25:GoDLpc5M4b/MpEKs4aDTL53mIqbZmAJWbNbs9tCDfUkBVI3ik7pjb+xGRH6tIWUseQnHWNPimdTxVfZeAGVQa44KkDfOeAaP0Q1E/SBrEbONViHDGfWWAH1nlFeAOrjIPq/D+Y2xBiltVYAvbIKftntBXprscLn0H93LngHjoEBOIPpa/s9iJH8xc+Fq54SJD8uUzvV9BOW5rkHAa61gow3egC8BXzfq/gkeNOefaAuQwhhQwFjJBDguGyxSz7E+VdbkEi/hxQDqZ+tKp8waEwvxKm4Fpx43vZ8/ORXY9TJ5/Uhx/WtkGQtz7F1Yj2yUdQ2H1+lQZnAglCTsnWCzqSOttFBGpPrzby2v8XVJ1Gw=
X-MS-TrafficTypeDiagnostic: BY2PR0201MB1909:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1909;31:VBH/n7SIZPiBKbZYXlk0tLkFaLxw2PSaDHeWxkAx3kDzmF4j7Qrm+kn6GqD3Oom4hwlnS79ZdcNNHPeTA1orXOP1/J4YmErKgi8xzcHMxKLEaAD0+uGD4CkhSnPZP3uLT815hch8hBBv9pgTxWX9KUME5XxM2jbZhhBBMsPTjasjmqgPMRooXOThAtJitcEdF7u3xdoi6XJDm6Zprc3O4gUWV0jdlm1OG8a20+oZtrE=;20:HIf/2oX39aApeA3i2Dl+Bt00LfNHHLT/RSOP+BVBhBZkEJdBDXLxISw+svAvmhNPzWwBGq2iCur61LAE9I5Rjhl5J+ICzbD1r675hHL2pZcqfKqj5RZNVW1PSPOsKRRb7LVaA32L4+J1/JM47wpC7DXCkCYVaWIbIO5yBRobYt1ZT0VYLErAXXep/5irvY0YAeFVJb0qmXz7mCVN4Hnx22SI5i8dukbYWe6tKSXNhn4abaH3BHcDhvKJf/qywa4hHj6x3E1y6UEQYgCjpI/iMnB0ASr/WS4v2+tq/rABPv472dmHhq00HMyJa2wQiVntSQ1U+VRyLBPDQLjILl45ckXuTJybaXY1SseXc3nhsEOsRVbMmsFeoeYhz6ocv5iuzDqNO/twBy9Qx+ISG68K0Mb5+nPfQ4TT9aMc09f9CE+4CGwrAuieYgK+/aJq9ftITUf9kz9ANYFH6rTzqqfqoRyx0HMK60OtPoXHPX7uiOmHjLwleJB6H87gvNd7m0Xv
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR0201MB190929EDF56BFCFC74153A62A7540@BY2PR0201MB1909.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BY2PR0201MB1909;BCL:0;PCL:0;RULEID:;SRVR:BY2PR0201MB1909;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1909;4:It3aIgZetz9/cEyV2P7EOMiyysw6W2CoWccJT1o6yGUf5zR9M2FFimE0r85QaHPv3qL+Z1RLofKzC60rWllG4XT+AOnRvp4WC+BfGntkvCLUfxNeXgkvsux37XaR19hUby8Nh1ArUqZi7UBuJKyOaT73Nth6fBc9O5XwyH8u3C6qckFRofksvvFE/kAs4gnAgbGb0LCN5qWy6ZIPSwAb+89tTPXRXVFc7pT4T7H1rGq62V1YQcQ0DZrmMs1kzWgkSosLjhEW4XPLoa81AUcEq2WbIASrPs+Bevk8E4oTkU9IhkKnUdm55uBJbTWHNdsI
X-Forefront-PRVS: 0744CFB5E8
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR0201MB1909;23:pdQGbrhDneVnNs15kA1EttFmQzVc8W7Qf5d6Q4C?=
 =?us-ascii?Q?NJzYCLha/J0oF+xNi3JpR/HnwKBUMzdzEWSH1pVDro+kSRv4trCxvNw3AY1W?=
 =?us-ascii?Q?YH1pbYEru3gGipPVVsREqIqNERNXQpHKtOO0xWtq8S4JggBlxGKI99U9JB4y?=
 =?us-ascii?Q?GongndHNcz5jBtC3lqHaZsD0Djo9z0PyzETjW4c4MtSNklja9SThORgFzgx+?=
 =?us-ascii?Q?qUZAXm9vykxZn7luoBNcE6wK+DQs6fVO4kgwHBaF1g4B0H8/+XnZ5K/9ST52?=
 =?us-ascii?Q?J4v0YLDsy8GmgBDmivLaQ5PdH6Cg/JG8DixkLzZVDSmXibWa4DUnxp5ckkpY?=
 =?us-ascii?Q?syCTPdVaxqccj/PJ3+RM+dhbyCcyqcwe7z51dPnkZB+PdCyLNMkB65j/G1Ob?=
 =?us-ascii?Q?/h7LdtMPQ+Qe2tDWQj1dZD8D3HtOQBxB0S82XxuHyxRBC4ijEBtJnXSVrX7G?=
 =?us-ascii?Q?InXmzLNvy70aPzw/yn1l4825iJnB7K8STID/Qvl2NkexFzVR4lHMmkitfQlR?=
 =?us-ascii?Q?3dORaLr5h369lb6vnPoBenXy7HrBExH8Cp0WMCcZt30xJ/oFLBV9cCg2B1S5?=
 =?us-ascii?Q?A4ta6Hvx5eSpz2rtR43BC6V9hqssDOQD3eIeceFgJwn8Qe5pmlCmB6PBKz5C?=
 =?us-ascii?Q?UCITFPdwzqvn1S5jBMxV0458r5diqjIupzhMHbfisLk+hGF7A/c8qmDRmpgk?=
 =?us-ascii?Q?2lzfuu9UY4JOSv1pBYL6eG+eJqV0WNmwPScrTfTMLcKeGWrsImhV4Dljcz6t?=
 =?us-ascii?Q?Wxp4ZuswiYfv1/2RJCXl8IuVjRUYvTlXR59vOPBUmAUk4NW8p2tzyUOGsOK+?=
 =?us-ascii?Q?XHj4vKcd0aXn146NSVoJLNHon9hUc6dyobSNnEA84PkwfefoIeuAFErcIH1Y?=
 =?us-ascii?Q?MOyaK2UazBlhIY6OlkqfxoqmW0+66d0yiUyBt/qvrwN0QUBOV0WcH/vQnBxA?=
 =?us-ascii?Q?u96F+CpnjoGQydvINfhRugspSsbFeMepaUBoRKu4TW9T4n7sIznwqRd/Gl2Z?=
 =?us-ascii?Q?6kzt/vmvNfINeBZg53/EiARlH3Cpj2X8PKfhkTeYt8Mp4jr1a+EWfO40zo05?=
 =?us-ascii?Q?uYCElj9KoWBQ3YzqAK/G7O4nBTZJrFiN/0PTI2FOYa/eKelNSEdUvBWpvgpa?=
 =?us-ascii?Q?BC9UOTGG+SjHn2lVgmjxSgw42ODCPwa5C/SgQlcFHDcHHX1xIu5KviaDakj3?=
 =?us-ascii?Q?Xr7DX4Wflws3chkdaPiE1SwJkheBX+3GhwxJL?=
X-Microsoft-Antispam-Message-Info: TsiSDOkuVYz8OcuRb/90vWDXGn/+E9DdKcmaHAEs0rZaIbKYcLTwzjJfXe1bjv2u/Rr/6yOGmqlk66Uy7VYsbB30RXl1KHB3QkZ2B6G0rxJpMibOpCDzJ6SK/xX40AEUcKpFAAlpuvvAR4gwptVMOxsKJcfkhZZwfdaT2tYD1i0kP53LzxFZybot3BlSgAEoGo41CG7DB7Nf+038jHCUraaPOF+3PkeVhP3NVVhNwLH+65mUIVjgaYUBM70nvaZ+0/F6emwrw4sBGo4jbSMCc7pf29LZsjOR4hzLtjbklG6TCjX6SBx0LjEogsSZYZcqTWUjbvzluI/SC7mzHybYKrXJ8YhNUeuE7IZerwaUji8=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1909;6:8s3V67H0rrg6bTXzsr+B7W3ThmqpmsSx2gL/+NsWzbYdPKUr1dx+xJvWem3C7NfaphPDshmpZZ1is4cwhnO+CmZEJTc+MsZAZw/2sdiCj2PF/aosgd/+nLMLOjOBuZqZcf8D+jcPT9O+sdK9LiFc7jUF/X4YoPmpTRdKgeDuKWpVXIMS/hCJR2LXdN08uV0lc5SIAE+kfycklj0sNweHp9au/Bo2KRqOp18ymOBEvBQdRDN8slb9nw0fiK5X26ccBYwu7XQWr4mCVhHZtLbnyVLNWQ4mLa1w8Ib5/26fGBSEtA6lyzvSoDGXTvaxA0ujSHKsS+hV5iqrkvpj7IAA0Yj4D1XOqtxy/oHa5n33JYRR7V1F9AHvthn++Y6njc1ThkEO5VJxQia9K6erS/VMTPheSWvFviPCEUIus/heqvRf9Qe3iFwlvu3wqXbeZt7HBLAVuxLNi2TvyLi5viECPA==;5:JkQCCTbstFtjt+brW1KcFwTpvBm5KS3/tCh1z0sVB7T7cI/la7S4HL6WyA1/4RLuDaPMrSE/Dl+yz/pjb6PdJoZB9s54304LLFrw/8H2mD4sXbd0Qi5nCHoVY9EAOCccAkVWGDPmBJuaPpPEpNsH2/pCcz6dL+qunmT4dU19YsY=;7:ulX6NSamqWbs57k+3irOjIk5IybSa4Oi08Klsq6QT4YcaishfrRX5MLIKnrLW53jXLLC97R+jwVajDSE7HrCkL1vNBs+mLei1ffCVg1AGB53AzgcG15UfTJWgSdsq5JiWXP3USQPIC0YHn6n68SyIs827ihtpmmWXaTOgiJCPkKdl2RrqZ/Yn8gRYVFv3cpHjyzajOxYvZo5IiXGdvGEOEqgz0dqWcDSckDc5jYY47NdFOmXCNR6uWrGhKMzNfMC
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2018 11:51:55.8316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b18d479-4ff0-4ca3-1359-08d5f2250666
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0201MB1909
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To start transfer with another stream id, controller needs to free
previously allocated transfer resource. This will be automatically
done by the controller at the time of XferComplete Event. This
patch updates the code to issue XferComplete event once all transfers
are done by setting LST bit in the ctrl field of the last TRB.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 drivers/usb/dwc3/gadget.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index efc6e13..b3e9e7f 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -571,7 +571,8 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
 
 	if (usb_ss_max_streams(comp_desc) && usb_endpoint_xfer_bulk(desc)) {
 		params.param1 |= DWC3_DEPCFG_STREAM_CAPABLE
-			| DWC3_DEPCFG_STREAM_EVENT_EN;
+			| DWC3_DEPCFG_STREAM_EVENT_EN
+			| DWC3_DEPCFG_XFER_COMPLETE_EN;
 		dep->stream_capable = true;
 	}
 
@@ -999,6 +1000,15 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 	if (chain)
 		trb->ctrl |= DWC3_TRB_CTRL_CHN;
 
+	/*
+	 * To issue start transfer on another stream, controller need to free
+	 * previously acquired transfer resource. Setting the LST bit in
+	 * last TRB makes the controller clear transfer resource for that
+	 * endpoint, allowing to start another stream on that endpoint.
+	 */
+	else if (dep->stream_capable)
+		trb->ctrl |= DWC3_TRB_CTRL_LST;
+
 	if (usb_endpoint_xfer_bulk(dep->endpoint.desc) && dep->stream_capable)
 		trb->ctrl |= DWC3_TRB_CTRL_SID_SOFN(stream_id);
 
@@ -2268,7 +2278,7 @@ static int dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
 	if (event->status & DEPEVT_STATUS_SHORT && !chain)
 		return 1;
 
-	if (event->status & DEPEVT_STATUS_IOC)
+	if (event->status & (DEPEVT_STATUS_IOC | DEPEVT_STATUS_LST))
 		return 1;
 
 	return 0;
@@ -2457,6 +2467,10 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 	}
 
 	switch (event->endpoint_event) {
+	case DWC3_DEPEVT_XFERCOMPLETE:
+		if (!dep->stream_capable)
+			break;
+		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
 	case DWC3_DEPEVT_XFERINPROGRESS:
 		dwc3_gadget_endpoint_transfer_in_progress(dep, event);
 		break;
@@ -2472,7 +2486,6 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 		}
 		break;
 	case DWC3_DEPEVT_STREAMEVT:
-	case DWC3_DEPEVT_XFERCOMPLETE:
 	case DWC3_DEPEVT_RXTXFIFOEVT:
 		break;
 	}
-- 
2.1.1

