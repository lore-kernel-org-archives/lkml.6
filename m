Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4770C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A7920862
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="TihCaJg3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A7920862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbeGaJQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 05:16:30 -0400
Received: from mail-bn3nam01on0061.outbound.protection.outlook.com ([104.47.33.61]:4400
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727015AbeGaJQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 05:16:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCVv4YYwyt5OBXS7IgIU9wGcUvFRpxMDBDRahZA4fuQ=;
 b=TihCaJg3Qln2+hcvO6LA8Ly7NvVzCOZ+/pov6E0wrbmXkjFMUcyyZn01x/jiS8L9jE4TCN/qQXNnEI0NQUD8RWJ4zkbDzO1Jph9kaGwc35rJsoqixWzeaGZ/8Yb6d3zYEuz8UL5bCd6mOji4wdWIxql51JgNVMDuK180mP/rsWw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Kamlakant.Patel@cavium.com; 
Received: from kamlakant--T110-II (111.93.218.67) by
 DM5PR07MB3564.namprd07.prod.outlook.com (2603:10b6:4:68::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.21; Tue, 31 Jul 2018 07:37:26 +0000
Date:   Tue, 31 Jul 2018 13:07:06 +0530
From:   Kamlakant Patel <kpatel@caviumnetworks.com>
To:     Corey Minyard <minyard@acm.org>
Cc:     Kamlakant Patel <kamlakant.patel@cavium.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        George Cherian <george.cherian@cavium.com>,
        jayachandran.nair@cavium.com
Subject: Re: [PATCH v3] ipmi: update ssif max_xmit_msg_size limit for
 multi-part messages
Message-ID: <20180731073704.GA13184@kamlakant--T110-II>
References: <1532947868-21907-1-git-send-email-kamlakant.patel@cavium.com>
 <28921428-369d-4892-6bc2-b7e3f418c920@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28921428-369d-4892-6bc2-b7e3f418c920@acm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: BM1PR0101CA0018.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:18::28) To DM5PR07MB3564.namprd07.prod.outlook.com
 (2603:10b6:4:68::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 762b8735-9bf5-44df-ad0e-08d5f6b877d5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM5PR07MB3564;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3564;3:zl9Wg0Af+mAQJAEs4XEpzObYWjEwWVMHHcDr7Cgb7heN0NNPRc7Oxxav2+YiKgl1c2kPJUS7QGxYTROna2ZKgu8HyqokHH8jNGOQDuLsoIrew7Wmvye+ha3fT7gKyx/Sxov1/riIAG9HpLppIcTkqeTyxOJBdj9y/+jDjk1BqoUKHtxE0pXqONdtEivE6TxYSYxtFETuOL917hafMXqWWuJwz3itofKkSkmhe+Hfggow1udLHFUqND/KuOV09r1o;25:k9lXsS5B1CW4cUqhb8OqQGkjPrj2783jLhrfJCmpTu5LjcnvzLNTg55of22DydwZ1RfKEgfHXiIr9lFw7slvd2qtRV3c3GsfxilOQYKT1vkKJEz8TfsP/LYaiE85gfK1T5kAFYF6VXeBxm3wier5p1Ci1cQpCgVFUR22ZOxgIa6WH7iG1rkKxM6zsAaA4RekojheQEtetcJYJQ9Jo+DiYZ22JkvKbeu2Q8kK4ViJg8UCuz7iFzWrMBPtIWfrINE4I0V2lPvo1BwqZpIOQuhXTy0hGIHAcBchrTMTYCmvMb5H+om4w6i5TPCUegMz2MTWV/Z1qVDNRf4KTKAw7ZjoBw==;31:HbQvcp6H64EIqrR5v3iQyay0oJS6FHTL9IS2LTMArnR/RNgUgM2aPRWtVRUFFapg9l7JXU2hO6JLDV6kXDl0KsDZrnHffhiCS6VZRspDrHFtbctoahpkz52y9Ru5+69qSryfvD1hw7mvKtjeBiBFp9Dp5s9q9XMmAWDKQAkPpkBWaESUGwBfqz3iPoXs1AxEcYAWcfvRXt/+erLEEF7FaJK8kxNxM/teQezV3s5dc9w=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3564:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3564;20:kzpFcVlrCufzqvOQGpUlPJRokRmbDvlL7JOJYiaKcHC9aYnMOh4/2I/V3xVX8EQc3xHnQdJAgmeCqN3qY/M7yKd3N/2rjkzwkJMjzOcEDMFn02nKTP8KLVJL/2IjE2dipkO4kRHrXv9Nvec99nxNdXbzNSCmQzLVlMcRMzPLuiE4BfLKLjbLTX7+pF79ukZP6d2MTzbeHfrZo2k2HEwcQPZzpMHqP698Ps8RaGKX3v1jDiVencDHKLbJm4RWtUYKIYSGObFUe/HJUfwbEos2lkbeX55PUE2rNseTonPAKf+tnRlOwRs9L4xRvru4kVbuVDT0Kenrnn9UgR8rrxAHspd2wp/lfTDd+pY9wlWZ/PsyrJA+8c8CquaVecBCesOCxZ/LCZeoe0pmAoXPdhJKE3Wz/EFea6tH3sedXKQWjM2pY0K9GLvyIgHtlknQwzQkOaFveoC9UkbqSAgfhFfaGESwbLeoyuaiwBGISmqHp/UE9f66KjBjja3U8pB2tQgABQ125ixHEAcluPK7dcFgU1jCQLtrln+MJqloU2VeJ6fY3fnaeTa+5aPpVu9P83Cobc0ULjAcSoeZQ2mL3SY6Jty70R+YT1miJJF0jagAKoQ=;4:ID6ssY9/S97eeDFhMpZEWPT/Fuz2PLkDnWKh8l0XS7btEa5T2FHduGM6rQKtE0oPS7nUYbInJiFpQC0+6GUF0JCAkMXgzurIIpS1Ys8L2e1xspsv5YnhJpbJyXfBAMnKJRhlwgp+73hr7Jjv+NkS7JsEAtkTlhtyLQV0bP9f4s8utY7ZqqmV5G9iynpRdHbdLxa3qOryvwR7U2MjW8ddtW1are4LkGy5CiZM0T4nBOeeMmZ1XiRQmMlBb2t+sJSPACi3xrcCrx+hhtLBLTM/rg==
X-Microsoft-Antispam-PRVS: <DM5PR07MB35644D02EA5A8E2C63C055C6882E0@DM5PR07MB3564.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM5PR07MB3564;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3564;
X-Forefront-PRVS: 0750463DC9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(346002)(396003)(376002)(199004)(189003)(229853002)(4326008)(486006)(476003)(446003)(11346002)(81166006)(8676002)(8936002)(53936002)(50466002)(81156014)(25786009)(956004)(42882007)(6916009)(47776003)(66066001)(9686003)(55016002)(107886003)(6666003)(97736004)(5660300001)(33716001)(14444005)(105586002)(186003)(386003)(72206003)(16526019)(6496006)(106356001)(53546011)(2906002)(16586007)(316002)(478600001)(54906003)(305945005)(23726003)(33896004)(6116002)(68736007)(52116002)(1076002)(3846002)(15650500001)(76176011)(6246003)(33656002)(26005)(5009440100003)(58126008)(551934003)(7736002)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3564;H:kamlakant--T110-II;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3564;23:r+4WD2meb48CM+ItnT6bcZNdpfwmLuCrg5oqqw5Om?=
 =?us-ascii?Q?Kwedoe13K1CRJJ6maVhXHjoiUXjMYDXh5+6krh+IJSjBclfZwm6q5lZFh+FH?=
 =?us-ascii?Q?bSlqFLQ8JmkLc6hkVbOu8ZdG75a8CWOnb9+rwCATroBgIExQrktYsAEFN7pP?=
 =?us-ascii?Q?a4PDbjt2IQWev4S384s/BIkcXt96GBFdlOJ5smb817Q3+2h08RS2xhNWXTJG?=
 =?us-ascii?Q?xYuSCk5SeN1mLs2kekOR1ttr8/PN3ZymAn/G1scU0mahi30hANmAxPq6dhXf?=
 =?us-ascii?Q?gaJPAULdwBcSkC8FPeqSx2FAORcAM0MnEB+L/zY/ofN1hYB4nLgrzex93n1q?=
 =?us-ascii?Q?CXYejv+d04DLcRfW0NHw2Nd2lLDcBrXhmqJIEO0dj8SeWODqZ4MJ75nsEBxJ?=
 =?us-ascii?Q?8ZLRgFgPPBuUWigv/klqthxOcgXQcSjtFSSU0rxLSGfxkNdtw0EPulkyC5E7?=
 =?us-ascii?Q?Pur8HkWgNOONb8XfCr4yy6lhA0yK79kM4lTWi3y91tnWlnwyD0dp/ep7bHvK?=
 =?us-ascii?Q?m6hKWSpRS/YxR3pmsiofhGLntwkW05R69dwtJuQdtF8j6UtRdFJYZfWxCJ03?=
 =?us-ascii?Q?PyV0UkV7H6TFB5V/CG+s2A9srqhS2f/VBGpGt98ba03OCFXjcRp2PNrLkX5T?=
 =?us-ascii?Q?K+7/rCDu7AC3bA9p17n8Jh8kNrPqhmdzlJXlavy5ic2FJAk7+WTV7kNH0CB4?=
 =?us-ascii?Q?7L9qPmkrGURL9TrRVlcbPb+kc8VJwD6J02MjbCf46L9zkIB77Hi9GMiGBg0Q?=
 =?us-ascii?Q?CXcK/6ATbDp9g04h1ThxfULEadnRcPNVlvlcwByhx2jK0Br2PfKwSta+0ide?=
 =?us-ascii?Q?DmK9baFVU2F9uSD0HqDmTNuKdhd1lrZHaO+NV8P//wgTN+/ELQJFo72sN319?=
 =?us-ascii?Q?AOejLO6YSx3o1h5pO4GVbf8HMDqRaoEgouPj6J/2rknzCvpDcs5YUB75Ii1k?=
 =?us-ascii?Q?nTDDxRd+5YhUUS/Vby5SqwLBs7Gp8h/GfjX84x03MMh6wpaRARrq44FeQzuV?=
 =?us-ascii?Q?fowBTrnL6/sl7GGq5g7YLR+6nAQxtvCOmVykDtg7O737TOV77l2eUJ/7Q4+c?=
 =?us-ascii?Q?KMvIYnEfrH6n341IAxyKLWCoJYMrz4stJMqYYpfRJKrQ33NSeiXID8Mh0+qG?=
 =?us-ascii?Q?6UNBo9IbYzAwH/1UQjfiM8XpTPKUeH8dsMOU2dqPYfVix5N+euyU13yvBe3U?=
 =?us-ascii?Q?x0dv6s/Js1gwv0jt/36u+Aqs20LG845JqPHDcHZEej0Y4WdT5opMB9oPhpDr?=
 =?us-ascii?Q?uQbUa/zUSNtJHxAKfjumbz/eq1uHfOsR2JoAxijUTezMu4Cg9mmUWZE+UhJ1?=
 =?us-ascii?Q?6epqou3MLrK2akUnvrgcH63EdRPhD6Ze6n5+Is82xVU3NCyldfMnCBHnbyn2?=
 =?us-ascii?Q?3ugTdXRrs6+uLVmFhlO/Vznt1Kb5i22l6hVBpVv/j88oNT0XHyQvviBLCwG4?=
 =?us-ascii?Q?1Rl73rrIW8tLveTrbKd8bxMTqE19rs=3D?=
X-Microsoft-Antispam-Message-Info: /25u4sc2WZiLX/RLgG3wZ58j3Pyr9BAcPzGWb04msQdg2F25DHgL/a6OPv7GIWuxuQ7T7bArvZYMeoP2dF6t53qVWCkPBOIeybGHesGXR9hw8tN+aX53W5lUazBIjOTXBc2FEojEMmGICNxYemH3Js0oD15BbZkGmKiTcfremJp3M2qOC1MGzzDLVlQcrkL/7eoYmNi5MsOID32RcxfZXtK7HrXXwRPWpQi5djfuvLqxZkt7PJJDpuQ1aCCut0/P1yVQrrVUsmJ/T5t3KYeMXLv+nzbzOanoh0XlO1bg4oVkKsMbQwK3MGFU+lpDmeGKBjhm38P7HlEpcD4iXV9y1j3IuUWKmGZUJsDQpcOd298=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3564;6:2LZOcYKozxeFHYIUoOfVKRDfNTNVMn6i+SSeKm3XJMtYWp+Kufk4hM/hv9GO+r91MQEqj7GUHCENEkD0ti9a37VCh/ZjPn5jYv4ru7D3IpFca9kSxm6fJOO4WdscXs31/xNgEqHdXILE4oE+YQgD4jMwl/UK5Hnc/1k47tLDxepiL0LuGK7aHl0zPMgsSFxPKwueDeyiu8llCXPvI50Qq6XmRWNvuctUJOxJE9kBr6d/nkeX8eSJh4Sq6Z4TpKr8lS0dloRpLVRyTGYlPMtvrummFIvygkOL3zN6QSkL+3oLoFZLwwl7AAISV2dt6KDxvAHDWlMAQRju5OvWKpPZWhHjnq8kfkAUKRzu253hqs/nPaf3YzO7Kt4wFqCQGUCGexQ1iZPL4azsIhHglwHk7jvzdxU7iWCYmbYEB7A4e8TniTpKTdeBu4lhmQLK1nB3jjyQuxxWI83srBarlKoEjw==;5:jLX6vmapDyiKrgUl/QYWFEFpxJwK/7UJKbWOe41spJobFNqTXhN+ONY/HFFLe9fYjTF3+pi1M9+UL9wXiC6ZvAAKTxJhFhGSdasNHu+oa5SjfbTmm1olBiJCWvwa6YNhWm1ixHMbVxjlZ3lKvcNcmfTFjJcp4yvH4MN5oXWA/0c=;24:vy+bMzrVGXyZeeSVv3fWbb/hPXERGB9zM2rOiM/5+zEDlReUsjboNyDqmJtrEZhXbQkiduePtJHc8EAZshDZeKKcfqxnzC+VYL9STD+xVZ4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3564;7:J4vQFeMsM4O7o+SSLoSTRAZ/j5YwizYMyyYGftoL9cnX2uXITZq4n25CWRUD0LZO2NBn8jh4frZrmvzgxhpLNva+i5h3qjrCOmhKweKPwVmgjIIqjizzJFi4gS7zCI2d6YzCJc6mKCAOhBOuAM5TKexBkNLqKwYqgTRoHuZPT/uLZda+GOqxQtLgIa/7qfHUPqI+ufZvRqi3qgS3SlH+rdRtg5NjJFwgMwvqYKfaMp71FkgDV9wBpmifwi23PrOb
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2018 07:37:26.0831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 762b8735-9bf5-44df-ad0e-08d5f6b877d5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3564
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 07:56:02AM -0500, Corey Minyard wrote:
Hi Corey,
> 
> On 07/30/2018 05:51 AM, Kamlakant Patel wrote:
> >Currently, by setting the xmit_msg_size to 63, the ssif driver never
> >does a SSIF_MULTI_n_PART, it falls back to only SSIF_MULTI_2_PART.
> >Due to this all IPMI commands with request size more than 63 bytes
> >will not work.
> >
> >As per IPMI spec 2.0 (section 12.15, Table 10), SSIF supports message
> >length up to 255 bytes. In a multi-part message, the first part must
> >carry 32 bytes with command 06h. All intermediate ("middle") parts must
> >carry 32 bytes with command 07h and the number of message data bytes in
> >the End transaction can range from 1 to 32 bytes with command 08h.
> >
> >Update ssif max_xmit_msg_size to handle multi-part messages up
> >to 255 bytes.
> >Enable command(08h) for End part transaction.
> 
> You don't think it's a good idea to test what the BMC is capable of
> doing, per
> the patch I sent you earlier?
I have not received the patch in unicast to me. If you have sent it to
mailing list I will search and test it. If not, could you please resend
it to me, I will test it and let you know.

Thanks,
Kamlakant Patel
> 
> -corey
> 
> >Signed-off-by: Kamlakant Patel <kamlakant.patel@cavium.com>
> >Suggested-by: Robert Richter <robert.richter@cavium.com>
> >Reported-by: Karthikeyan M <karthikeyanm@amiindia.co.in>
> >---
> >  drivers/char/ipmi/ipmi_ssif.c | 38 +++++++++++++++++++++++++++-----------
> >  1 file changed, 27 insertions(+), 11 deletions(-)
> >
> >diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
> >index 18e4650..ada59b7 100644
> >--- a/drivers/char/ipmi/ipmi_ssif.c
> >+++ b/drivers/char/ipmi/ipmi_ssif.c
> >@@ -60,6 +60,7 @@
> >  #define     SSIF_IPMI_REQUEST                       2
> >  #define     SSIF_IPMI_MULTI_PART_REQUEST_START      6
> >  #define     SSIF_IPMI_MULTI_PART_REQUEST_MIDDLE     7
> >+#define      SSIF_IPMI_MULTI_PART_REQUEST_END        8
> >  #define     SSIF_IPMI_RESPONSE                      3
> >  #define     SSIF_IPMI_MULTI_PART_RESPONSE_MIDDLE    9
> >
> >@@ -88,6 +89,8 @@
> >  #define SSIF_MSG_JIFFIES    ((SSIF_MSG_USEC * 1000) / TICK_NSEC)
> >  #define SSIF_MSG_PART_JIFFIES       ((SSIF_MSG_PART_USEC * 1000) / TICK_NSEC)
> >
> >+#define SSIF_MAX_MSG_LENGTH  255
> >+
> >  enum ssif_intf_state {
> >      SSIF_NORMAL,
> >      SSIF_GETTING_FLAGS,
> >@@ -887,28 +890,39 @@ static void msg_written_handler(struct ssif_info *ssif_info, int result,
> >               */
> >              int left;
> >              unsigned char *data_to_send;
> >+             int command;
> >
> >              ssif_inc_stat(ssif_info, sent_messages_parts);
> >
> >              left = ssif_info->multi_len - ssif_info->multi_pos;
> >-             if (left > 32)
> >-                     left = 32;
> >+
> >              /* Length byte. */
> >-             ssif_info->multi_data[ssif_info->multi_pos] = left;
> >+             ssif_info->multi_data[ssif_info->multi_pos] =
> >+                                             left > 32 ? 32 : left;
> >              data_to_send = ssif_info->multi_data + ssif_info->multi_pos;
> >-             ssif_info->multi_pos += left;
> >-             if (left < 32)
> >+             ssif_info->multi_pos += left > 32 ? 32 : left;
> >+             command = SSIF_IPMI_MULTI_PART_REQUEST_MIDDLE;
> >+             if (left <= 32) {
> >                      /*
> >                       * Write is finished.  Note that we must end
> >-                      * with a write of less than 32 bytes to
> >-                      * complete the transaction, even if it is
> >-                      * zero bytes.
> >+                      * with a write up to 32 bytes to complete the
> >+                      * transaction, even if it is zero bytes.
> >+                      * The number of message data bytes in the End
> >+                      * transaction can range from 1 to 32 bytes.
> >+                      * As per IPMI spec 2.0(section 12.15,Table 12-10),
> >+                      * the BMC Multi-part Write commands are:
> >+                      * Start-first part     - 06h
> >+                      * Middle-part(s)       - 07h
> >+                      * End-part             - 08h
> >+                      * Update command for END part transaction.
> >                       */
> >                      ssif_info->multi_data = NULL;
> >+                     command = SSIF_IPMI_MULTI_PART_REQUEST_END;
> >+             }
> >
> >              rv = ssif_i2c_send(ssif_info, msg_written_handler,
> >                                I2C_SMBUS_WRITE,
> >-                               SSIF_IPMI_MULTI_PART_REQUEST_MIDDLE,
> >+                               command,
> >                                data_to_send,
> >                                I2C_SMBUS_BLOCK_DATA);
> >              if (rv < 0) {
> >@@ -1499,9 +1513,11 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
> >                       * start and the next message is always going
> >                       * to be 1-31 bytes in length.  Not ideal, but
> >                       * it should work.
> >+                      * As per IPMI spec 2.0, SSIF interface supports
> >+                      * message size up to 255 bytes.
> >                       */
> >-                     if (ssif_info->max_xmit_msg_size > 63)
> >-                             ssif_info->max_xmit_msg_size = 63;
> >+                     if (ssif_info->max_xmit_msg_size > SSIF_MAX_MSG_LENGTH)
> >+                             ssif_info->max_xmit_msg_size = SSIF_MAX_MSG_LENGTH;
> >                      break;
> >
> >              default:
> 
> 
