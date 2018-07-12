Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97305C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1275120875
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="It8zoAeA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1275120875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732658AbeGLF7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:59:03 -0400
Received: from mail-dm3nam03on0051.outbound.protection.outlook.com ([104.47.41.51]:29792
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726896AbeGLFz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVAA/4YXm7YDcx4f9F1hFayKrZwnIgVq0eh+ZcN6Dtk=;
 b=It8zoAeA6AELFL2uBnL6z7ZxyDUC6B3sRgYOKof7EL8/B2wLqoS79pEUXuzyOjvAXwAyF5XyS9gw8TuJ+yUgNFapWEVdh9wkksHqPg2xSFqokv2ohejuir3zykOZ6Ijc4XLtFhCbQSZbPPYGg59ywQjYEB+/e9h+xqHot2iSvJ8=
Received: from CY1PR07CA0034.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::44) by DM6PR07MB4715.namprd07.prod.outlook.com
 (2603:10b6:5:a1::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.21; Thu, 12 Jul
 2018 05:47:57 +0000
Received: from CO1NAM05FT016.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::205) by CY1PR07CA0034.outlook.office365.com
 (2a01:111:e400:c60a::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.952.18 via Frontend
 Transport; Thu, 12 Jul 2018 05:47:57 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 CO1NAM05FT016.mail.protection.outlook.com (10.152.96.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.973.9 via Frontend Transport; Thu, 12 Jul 2018 05:47:57 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5lkw6032054
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 11 Jul 2018 22:47:56 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 12 Jul 2018 07:48:05 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Jul 2018 07:48:05 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5lnBp029660;
        Thu, 12 Jul 2018 06:47:49 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6C5lnCo029652;
        Thu, 12 Jul 2018 06:47:49 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 13/31] usb: usbssp: addec procedure for handlin Port Status Change events.
Date:   Thu, 12 Jul 2018 06:47:10 +0100
Message-ID: <1531374448-26532-14-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1531374448-26532-1-git-send-email-pawell@cadence.com>
References: <1531374448-26532-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(136003)(2980300002)(199004)(189003)(36092001)(45074003)(305945005)(54906003)(575784001)(86362001)(186003)(107886003)(26005)(109986005)(105596002)(106466001)(2906002)(426003)(36756003)(76176011)(5820100001)(5660300001)(2870700001)(7636002)(26826003)(23676004)(246002)(5024004)(50226002)(478600001)(1671002)(14444005)(476003)(6666003)(4720700003)(446003)(126002)(11346002)(8676002)(47776003)(87636003)(4326008)(2616005)(336012)(316002)(50466002)(486006)(356003)(8936002)(42186006)(266003)(19627235001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4715;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT016;1:AvtDCWPFDXLuj4gj4yyo04/4BnRQRpm3lPXgjw3hbGrndFuxWSQaNvNxyzxi41boB0DP77TU7vnWacDF0W4BJngJMIkZNWP+sIJmXVYjD5p5Y9b7Y9eOlX5T7Ke/BhOl
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 554e9ac5-00ae-406f-d7c1-08d5e7bb053c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(2017052603328)(7153060);SRVR:DM6PR07MB4715;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4715;3:FmxWzACQol0LT8JKd8Ky6VDbmqplz+ixb4w6+BYnZDZzGh2WxN5/999zGsTtO5ksJB62kiHrNRJAVLxmTuI+YiZsE6rRDWoGAUMAbeMm4HK9Snnwh73CBj3HlilMxmq0n/aR3eIcSHl+DZ7O9kXqgCl/VhfBhKhJjHcSw+ccipjVgaeIEbz89fkrXD2z+oyou4Q8OxE+H7dXRIF8qcnJJliIUi/mOk0uCTDnJMPl0bp5ogWbwE7shbg/06+8Asc6BhfwSqPaylF8mEq53+157qmbVc2JSvn0Gipk1vjQas987Sr3GCqVulKTEO5E8nOwGaomPXRsUYMwrLRJNtE9//ckmIURcVYOqnKhhMu2Wxc=;25:ftCrpdSQ+7uhtCgUtXAzGc1gCUFNba14KnrvQIWswB6mmo6kxJSvUYFv1mdY8DAbzF+M3t/sgLZ9zamhsr56sa5jQLp8+ivjrMzsHnmst34Mub9dayKgUG23IeJbyQulMhMp0vw/kCVnjp0c8ApNL70DJR/J/e27G9TrjWFxn0VD0jb119PmRe6gH/sfPiJbifZ2nKuuzt/ZorHT4kTwSklYrvA6+UwdazIYu2mc6bYYOcx14Jn8GMO9Kh3kY4pqRUdbJqr8U8M4pvyffK1qKEGdUIbTbwGTnd3geNKYKRZwhqUr0QXHsY8QljiiIRsrLCczsDmsCNxO5+cr8WuX4g==
X-MS-TrafficTypeDiagnostic: DM6PR07MB4715:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4715;31:GB5Uy44Lxq1v+3bBbghO+IqdicJ1WQ2Gwa3dBfaKn/R37kHLXo4NkXo12HFELbfqHlX2EtICaDEWWx8i4DI3F+q9PdYxnBxR66rZda+dokShdHEY4cWu0q2F92q96MdX8k6p79g5/q+nnuvXE5gWB9VY2mS0ZponzQAioX5QFKYiuS8kyUUvT8H26MWGrpnnjLQeXXseRdryN9/AVv7CDu90fm9d1EdIPzH6xEEf5kU=;20:TZb9tkDUcYjg+4p5kqBlr+qpbcGzTVKV21mJSOM3KsSVDwXRK4IX3zBzjZpxcXKxGONkv70hPnEWovyDZzj24wvhXkPiQh2cZ84Q/iAwvMdPlEIOqfCUY+D3AvPj33gwh3NOYApyNX4ypOF9/toGooga3SsP2IRYXXUmkebIm+IUWBqebEgeokaVxn0yDqG/k5MJ6G6kLWAhF4oZwdbQz/dB8Xda4v591OfV3qRPe8OVJTCHO9au5kDeXSONSa0QWqlhXh6RXNJWpAn04QI4f+OysAFweZBSwkd2kbooBrQEjx4Q3kYcQOPr+5XTnLaKNn9uRSSq5/Ryo8whNZmN+4XvLREmRHOUKdAH//pRKKVkeEUfYc92wHtHgH/V2mSrsGa3n4SNc+HQxpQSWgjqoV361+jhZptm3Z7SOWbUiuCHnGDst9XiXl3XUvTTaqRE4xPXxOfifQcKes6LDYvzLPbqFj5PYhl2RXzhKVDhw/JEaaQn1L/w0ty5b+qRdech
X-Microsoft-Antispam-PRVS: <DM6PR07MB471565CE709EF89D310DF778DD590@DM6PR07MB4715.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(21532816269658)(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93003095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM6PR07MB4715;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB4715;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4715;4:mdHS6nOZ1s6gDexPtzl1BTum0gXAIPJVjystn+RzO2GXBiKsuvGUiOlE0uF595dqCSGZiy+YMLUHLQhwf3GS+54IeFiPDOtrYUzC62KDsnsn707TOnrewQFg8g94zAHbZEWqXiAoWLnENXMcPqurW70KfPZBo5MYIk1XZ4qc5WPmGaAm6Qd1ZYeWKeYndY/80bfzAJLxFQkZcCDlpNybwOHt6mlFS2cCGbaAOEQ4kIHoWu6ZaWGeR0GNHBJeceMiK/ynLno8qCT+ClKnS2RB7FcTjWApjBgWtzciq/JWOeMDEyroyasB9i5XngC9uQNUhCcLo3zPqKFcPkysLOWMHY+CG1X4GThI+6BCmvfNZUY=
X-Forefront-PRVS: 0731AA2DE6
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjA3TUI0NzE1OzIzOkhHNE9odnd3RmpsMzdWRUVueDNtUW1LUi9I?=
 =?utf-8?B?V0c4TnBXb0hlTkh0bnZpNUdNcGFJbmNwT3BQcUFFS1hTaFI1STNXQzhHdzAz?=
 =?utf-8?B?d29SVkozNjlHZk02NXdhRGJ1d1JYUzB0THBRTktuUXU4MEZBMUh2ZTdRbmxD?=
 =?utf-8?B?bVJyNlBrYmFPbjFXKzZxdFJ1V0NteUhBZEpsZWlSaVJCazJJWUsyZlJCbjl0?=
 =?utf-8?B?alVZRnZKZjV3QXg3dVNpWi9idkpJek1aN1QxeHo0dGJjL2pOclJZbHRJdURj?=
 =?utf-8?B?NlFJcUJ5c3UvV05MS2FaV0xwcWxMTXFGTmJRSkQ4alhqMnFQRTZ5OWVyVUgr?=
 =?utf-8?B?NnZZemF6WmNQVHVNcmlxR0owU3pUaVhIdW5hRmRIbnRaSHI0b1N4Mk4zS1Nw?=
 =?utf-8?B?cjcrU25OTWlVSS95K0tPeklwVnBHUkk1MHllZjJ4RXJnd2tGbHcwYVJkSFFO?=
 =?utf-8?B?M2VTQWNZdEpsSjFZYWJkcWpNWUM2Z3BLRXdNUVRZWEgyN0orTkJ4bmljV3NR?=
 =?utf-8?B?bnhPV3FFTHVydWhRUnJCampFbCtPMVErUnVyWVFzZ3I4SjZ5NzNOR3owekpZ?=
 =?utf-8?B?R1ZxWWVsdDdvQnFGUVpraHR2L1RSUm8yY1I3MGVCbjJsWVZjb2J6bUkxSFk5?=
 =?utf-8?B?aVhHUFZDOStod01jdGNrdGNEOStKdDhoMlkrU0VVUjZQZlAveWwrMDFqWXk3?=
 =?utf-8?B?SWdWc1N2aVBqbG9aTmRCU1hiSHZSYlhuZGNUU21LbDZ1cGt6RXJRWnRvMTZQ?=
 =?utf-8?B?SnpWTHE5VlY4M1lRK2JWdWk3dE5sMi8rcEVnZzR6eEk2czVaWTdJbGdmMXd0?=
 =?utf-8?B?TWUrcFhGQTh4VUIzKzdROGFUVlFLUzkrMzNWaDJUOTAvZ28rTVZvUVoxL2o3?=
 =?utf-8?B?cmdnblJ1aDJ0bW54TG1GblJuL2VlalF2d2FmOGNhMEpDVVJ3bUsvM3JoVnFq?=
 =?utf-8?B?MFVTblpYNWF4NUJCdHpMd2k2Tkx1eXRNWXlRbEswOXdqWStrNVBSS1hMcml2?=
 =?utf-8?B?U2FjTU5KSmd0NVNTeUg3TC9VdXJLdytoK0tyRUdGK1E1S3A4UW8wOXBTTFlm?=
 =?utf-8?B?UXdXdm1RbVFGSHlVdXROKzI1OTRsb01SZ09yaXNjdHcyekRzK1hhaVRsdGY1?=
 =?utf-8?B?T2hxcVd0K1F4VkJxYWhHRGlOOGdRRUYxSGNWL3hlRWUzT1lQOHJqUmp5UkJI?=
 =?utf-8?B?Z25oYlJBN3RVTmtUenQxaForWVI3dmpKeXd6b3JReFl5KzhGazh3bXFZa3ZU?=
 =?utf-8?B?U3RVKy9Jc0FqVXg1SUpPZkJLRnJobXpPYUg0MThWZVZKMGlqUzdNalVvNnFi?=
 =?utf-8?B?RFExR3VkRG5tKzFlQWQxUlFIbC9DZDdlaFZYM2Y0V3JDQjA3aHhXWW0vWnJH?=
 =?utf-8?B?T0MwOW85NEdqZitUcFZUdUtleElVUHByYTNzdndwL2NvZW04Mkc1OWdwUTZy?=
 =?utf-8?B?UDMxbnVuVnAyYlY0TDg0TnZ5SUF4Ymt1ajJVMXR0NHBQN0xjNjQvWDRVR1hx?=
 =?utf-8?B?NFRoSEtyN215Umgrb2RWN1JESWZTVzdEZklac0ZjWVBnU1hMSXhCNHMvam9y?=
 =?utf-8?B?OVZPa296djFPTDVUSzV5bXlscUk1dlpUYWhWZWFnaHJ1M3Zxc3lyRGsrelFK?=
 =?utf-8?B?NDBXaUZ6L2M3aS9ETmlwUkRDQlpyWE82UjgyMXk1T1IrUTBBVlBqUW5ROHN5?=
 =?utf-8?Q?aOMWvgkI2hVtIhqrJg=3D?=
X-Microsoft-Antispam-Message-Info: kjnRrtPyqdYX60q8sI7Bit6hHu886Nnmyy8fXWeWGxu5JqRPPaSzm3gPZKSsnzcYUGsR+ydppmX4Rl0l7qsOWEQd1x0Nxu2MAJ/bHkeQv7LNtXxBXph7ZrazqvYbEVPPBsIxjnB7Aem56uneaHGMapaH70kr81sSegKT9Q96+qnuLCpW3laLlMGFxJiby4yj4AW+lVL8aINm8Wljd6zJBG00NwpJWq+4uzkDjqd+wtYfzu+rjC/1lKPQHdX4o8+ejkdiRYqTnutNkcnp9u4r9nd7MBl2Osk6ybfzu8pjrWRy6IHYQfXU8vA28OAb5MBOhS9eWJaD0s3kh0IYew253cjzazpvDESb4Spm7CacU76MnH/NgH+93mt/0UHpiR4NvW834Aq9SeHCl84aNlMSrw==
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4715;6:PX85QnJAmEclajOH+BUCnbCE5EGSw4SXnJmTtYLXuSISg7j1PbdU2QPgUTzRYFSpWRsV/5Ed1foqkcnHtv2mS6NNJF3QU/nwLOZdAgE8UXv0Pk70FhMremFgCelddUiiS0gwrb6VKHVPF/xYnbRE0fwdBAvpGaFzF5RHxlo2O1/9Y8pHIhtxuyXRwU/tdXZSILyMY1PwEAXW/+fFxb24AyP82vK7GVULipMu1m0eRr0tLwqf7oNG9+qia+IEr0lt0ppeNwoYfyp+cLAq4EZM6WqYje+M5JZIBahnlEsDYCnkC7SHNYf4S5b0pE0Ofan2mHy6phJZMSRegkjT9f2GAJE53upP/yuLO1wuVvJzPplKVZoPahg1oFIdxx3N/LvldpAtxSsaJQFUQPuVwQBICHh6plX6QUPwwK9+8ru6hZcRc8c7JW/p8cmKYN6ogI4GSquzCBFiy4b9PtfQDBnt9g==;5:nu7OFXNpSu4eNkKEV/s0jeXTHSXoVGsgolmaCF28dfwIq72KxZqdPreCkUVRhitWhoODprGHdiwPr4lgGjcoQ/p2H6PyHlcU9ryVC1OuQhXMV+OBBSKt9X9NocT0OPEx2HEp76p2XhyqMWNRmcj48SbIrsMCcneongzd7G/DAOE=;24:VszQ1beDee/15o78GwpO49eouBkgJGepzTy96dHNs+QGZ0upB0ZMy1FjXjzSF5ZRv9Tm0mQHNkeBweqH4WKB55ES0MToN6LchXkWBa6i7s4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4715;7:npFa3dE5cKBmAj7WCja9+wrd4aTbaIiUM+KFxaNWrwnslHVCUAqLC4ur0AHtPRYbkAnquzfC6VAlSjfmEqi64Az7Tjkk1znMpJfuLg4VdwdwsCR4l5g1A1dVbc9kiq9t21XYJc6icoFlwGwMM8wo5MxnJiI6pGnNhUxFLeDuyd/MebxqvHgH1TK8GL5MUX4dvlYdJvCJo4gDX5Rr2GQDNFgVy6jbWS3Yiplj1ufOE+WaviFOZ/Oot6wf3TU9hnJm;20:T+zjRW8FJot2/flBrbIkXVfN6UpjI53TkSNMveu1m6bHyUlHT0ZNCYcPaJvVRL7LF+M7wEOuBg9lyL9SkHdgOWIvrC3L2AZyMZR5p1g0kOXhSmiZParp69q0ZyTpXRy6pIRLIYlNT/Hh7/Qs9g+Y8D93k3ao4BufD0XxVjDUE1v99AsqKIxxfvNVmwnh1rVwsuSqwQBPK7mS9OjwSFoyRL/Vv9se+PKArlfO+24TrPlb6ZJA4FAL4G6yXdSRltQN
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 05:47:57.3535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 554e9ac5-00ae-406f-d7c1-08d5e7bb053c
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4715
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implement handle_port_status function and all related to
it other functions.

It is called in interrupt context from usbssp_irq function.

handle_port_status function is responsible for handling all events
related to USB port.

To correct handle some port events driver needs to add commands to
Command Ring. These commands are processed by HW. Each command
can take some time and driver need to wait for completion.
Therefor driver can’t handle all events in interrupt context and
Some of them must be deferred and will be handled in separate thread.
This additional thread will be introduced in separate patch.

Patch also introduces gadget-port.c file that contains functions related
to USB port, such as detecting port speed and setting link state.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/Makefile      |   2 +-
 drivers/usb/usbssp/gadget-if.c   |  59 +++++
 drivers/usb/usbssp/gadget-port.c | 101 ++++++++
 drivers/usb/usbssp/gadget-ring.c | 426 ++++++++++++++++++++++++++++++-
 drivers/usb/usbssp/gadget.h      |  13 +
 5 files changed, 593 insertions(+), 8 deletions(-)
 create mode 100644 drivers/usb/usbssp/gadget-port.c

diff --git a/drivers/usb/usbssp/Makefile b/drivers/usb/usbssp/Makefile
index 884352e80779..22479a6378c4 100644
--- a/drivers/usb/usbssp/Makefile
+++ b/drivers/usb/usbssp/Makefile
@@ -4,7 +4,7 @@ CFLAGS_gadget-trace.o := -I$(src)
 
 obj-$(CONFIG_USB_USBSSP_GADGET) += usbssp.o
 usbssp-y 			:=  usbssp-plat.o gadget-ring.o \
-				    gadget.o gadget-mem.o \
+				    gadget.o gadget-mem.o gadget-port.o \
 				    gadget-dbg.o
 
 ifneq ($(CONFIG_TRACING),)
diff --git a/drivers/usb/usbssp/gadget-if.c b/drivers/usb/usbssp/gadget-if.c
index c3fa3be7d494..28118c1a0250 100644
--- a/drivers/usb/usbssp/gadget-if.c
+++ b/drivers/usb/usbssp/gadget-if.c
@@ -286,3 +286,62 @@ void usbssp_gadget_free_endpoint(struct usbssp_udc *usbssp_data)
 			list_del(&ep_priv->endpoint.ep_list);
 	}
 }
+
+void usbssp_suspend_gadget(struct usbssp_udc *usbssp_data)
+{
+	if (usbssp_data->gadget_driver && usbssp_data->gadget_driver->suspend) {
+		spin_unlock(&usbssp_data->lock);
+		usbssp_data->gadget_driver->suspend(&usbssp_data->gadget);
+		spin_lock(&usbssp_data->lock);
+	}
+}
+
+void usbssp_resume_gadget(struct usbssp_udc *usbssp_data)
+{
+	if (usbssp_data->gadget_driver && usbssp_data->gadget_driver->resume) {
+		spin_unlock(&usbssp_data->lock);
+		usbssp_data->gadget_driver->resume(&usbssp_data->gadget);
+		spin_lock(&usbssp_data->lock);
+	}
+}
+
+static void usbssp_reset_gadget(struct usbssp_udc *usbssp_data)
+{
+	if (!usbssp_data->gadget_driver)
+		return;
+
+	if (usbssp_data->gadget.speed != USB_SPEED_UNKNOWN) {
+		spin_unlock(&usbssp_data->lock);
+		usb_gadget_udc_reset(&usbssp_data->gadget,
+				usbssp_data->gadget_driver);
+		spin_lock(&usbssp_data->lock);
+	}
+}
+void usbssp_gadget_reset_interrupt(struct usbssp_udc *usbssp_data)
+{
+	usbssp_reset_gadget(usbssp_data);
+	switch (usbssp_data->gadget.speed) {
+	case USB_SPEED_SUPER_PLUS:
+		usbssp_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
+		usbssp_data->gadget.ep0->maxpacket = 512;
+		break;
+	case USB_SPEED_SUPER:
+		usbssp_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
+		usbssp_data->gadget.ep0->maxpacket = 512;
+		break;
+	case USB_SPEED_HIGH:
+		usbssp_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(64);
+		usbssp_data->gadget.ep0->maxpacket = 64;
+		break;
+	case USB_SPEED_FULL:
+		usbssp_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(64);
+		usbssp_data->gadget.ep0->maxpacket = 64;
+		break;
+	case USB_SPEED_LOW:
+		usbssp_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(8);
+		usbssp_data->gadget.ep0->maxpacket = 8;
+		break;
+	default:
+		break;
+	}
+}
diff --git a/drivers/usb/usbssp/gadget-port.c b/drivers/usb/usbssp/gadget-port.c
new file mode 100644
index 000000000000..c9c8aae369ba
--- /dev/null
+++ b/drivers/usb/usbssp/gadget-port.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * USBSSP device controller driver
+ *
+ * Copyright (C) 2018 Cadence.
+ *
+ * Author: Pawel Laszczak
+ *
+ * A lot of code based on Linux XHCI driver.
+ * Origin: Copyright (C) 2008 Intel Corp
+ */
+
+#include <linux/slab.h>
+#include <asm/unaligned.h>
+
+#include "gadget-trace.h"
+#include "gadget.h"
+
+unsigned int usbssp_port_speed(unsigned int port_status)
+{
+	/*Detect gadget speed*/
+	if (DEV_SUPERSPEEDPLUS(port_status))
+		return USB_SPEED_SUPER_PLUS;
+	else if (DEV_SUPERSPEED(port_status))
+		return USB_SPEED_SUPER;
+	else if (DEV_HIGHSPEED(port_status))
+		return USB_SPEED_HIGH;
+	else if (DEV_FULLSPEED(port_status))
+		return USB_SPEED_FULL;
+	else if (DEV_LOWSPEED(port_status))
+		return USB_SPEED_LOW;
+
+	/*if device is detached  then speed will be USB_SPEED_UNKNOWN*/
+	return USB_SPEED_UNKNOWN;
+}
+
+/*
+ * These bits are Read Only (RO) and should be saved and written to the
+ * registers: 0, 3, 10:13, 30
+ * connect status, over-current status and port speed.
+ * connect status and port speed are also sticky - meaning they're in
+ * the AUX well and they aren't changed by a hot and warm.
+ */
+#define	USBSSP_PORT_RO	(PORT_CONNECT | PORT_OC | DEV_SPEED_MASK)
+
+/*
+ * These bits are RW; writing a 0 clears the bit, writing a 1 sets the bit:
+ * bits 5:8, 9, 14:15, 25:27
+ * link state, port power, port indicator state, "wake on" enable state
+ */
+#define USBSSP_PORT_RWS	(PORT_PLS_MASK | PORT_POWER | PORT_WKCONN_E | \
+			PORT_WKDISC_E | PORT_WKOC_E)
+
+/*
+ * Given a port state, this function returns a value that would result in the
+ * port being in the same state, if the value was written to the port status
+ * control register.
+ * Save Read Only (RO) bits and save read/write bits where
+ * writing a 0 clears the bit and writing a 1 sets the bit (RWS).
+ * For all other types (RW1S, RW1CS, RW, and RZ), writing a '0' has no effect.
+ */
+u32 usbssp_port_state_to_neutral(u32 state)
+{
+	/* Save read-only status and port state */
+	return (state & USBSSP_PORT_RO) | (state & USBSSP_PORT_RWS);
+}
+__le32 __iomem *usbssp_get_port_io_addr(struct usbssp_udc *usbssp_data)
+{
+	if (usbssp_data->port_major_revision == 0x03)
+		return usbssp_data->usb3_ports;
+	else
+		return usbssp_data->usb2_ports;
+}
+
+void usbssp_set_link_state(struct usbssp_udc *usbssp_data,
+			   __le32 __iomem *port_regs,
+			   u32 link_state)
+{
+	u32 temp;
+
+	temp = readl(port_regs);
+	temp = usbssp_port_state_to_neutral(temp);
+	temp &= ~PORT_PLS_MASK;
+	temp |= PORT_LINK_STROBE | link_state;
+	writel(temp, port_regs);
+}
+
+/* Test and clear port RWC bit */
+void usbssp_test_and_clear_bit(struct usbssp_udc *usbssp_data,
+			       __le32 __iomem *port_regs,
+			       u32 port_bit)
+{
+	u32 temp;
+
+	temp = readl(port_regs);
+	if (temp & port_bit) {
+		temp = usbssp_port_state_to_neutral(temp);
+		temp |= port_bit;
+		writel(temp, port_regs);
+	}
+}
diff --git a/drivers/usb/usbssp/gadget-ring.c b/drivers/usb/usbssp/gadget-ring.c
index e2fb81259ca1..46d43f3933f7 100644
--- a/drivers/usb/usbssp/gadget-ring.c
+++ b/drivers/usb/usbssp/gadget-ring.c
@@ -101,6 +101,11 @@ static bool link_trb_toggles_cycle(union usbssp_trb *trb)
 {
 	return le32_to_cpu(trb->link.control) & LINK_TOGGLE;
 }
+
+static void inc_td_cnt(struct usbssp_request *priv_req)
+{
+	priv_req->num_tds_done++;
+}
 /*
  * See Cycle bit rules. SW is the consumer for the event ring only.
  * Don't make a ring full of link TRBs.  That would be dumb and this would loop.
@@ -219,18 +224,83 @@ static bool usbssp_mod_cmd_timer(struct usbssp_udc *usbssp_data,
 	return 0;
 }
 
-irqreturn_t usbssp_irq(int irq, void *priv)
+static void usbssp_kill_ring_requests(struct usbssp_udc *usbssp_data,
+				      struct usbssp_ring *ring)
 {
-	struct usbssp_udc *usbssp_data = (struct usbssp_udc *)priv;
-	irqreturn_t ret = IRQ_NONE;
-	unsigned long flags;
+	struct usbssp_td *cur_td;
+	struct usbssp_td *tmp;
 
-	spin_lock_irqsave(&usbssp_data->lock, flags);
+	list_for_each_entry_safe(cur_td, tmp, &ring->td_list, td_list) {
+		list_del_init(&cur_td->td_list);
+		inc_td_cnt(cur_td->priv_request);
+	}
+}
 
-	spin_unlock_irqrestore(&usbssp_data->lock, flags);
-	return ret;
+void usbssp_kill_endpoint_request(struct usbssp_udc *usbssp_data,
+		  int ep_index)
+{
+	struct usbssp_ep *ep;
+	struct usbssp_ring *ring;
+
+	ep = &usbssp_data->devs.eps[ep_index];
+	if ((ep->ep_state & EP_HAS_STREAMS) ||
+			(ep->ep_state & EP_GETTING_NO_STREAMS)) {
+		int stream_id;
+
+		for (stream_id = 0; stream_id < ep->stream_info->num_streams;
+		     stream_id++) {
+
+			ring = ep->stream_info->stream_rings[stream_id];
+			if (!ring)
+				continue;
+
+			usbssp_dbg_trace(usbssp_data,
+				trace_usbssp_dbg_cancel_request,
+				"Killing Requests for slot ID %u,"
+				"ep index %u, stream %u",
+				usbssp_data->slot_id, ep_index, stream_id + 1);
+			usbssp_kill_ring_requests(usbssp_data, ring);
+		}
+	} else {
+		ring = ep->ring;
+		if (!ring)
+			return;
+
+		usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_cancel_request,
+				"Killing Requests for slot ID %u, ep index %u",
+				usbssp_data->slot_id, ep_index);
+		usbssp_kill_ring_requests(usbssp_data, ring);
+	}
 }
 
+/*
+ * USBSSP controller died, register read returns 0xffffffff
+ * Complete pending commands, mark them ABORTED.
+ * USB requests need to be given back as gadget core might be waiting with
+ * device lock held for the Requests to finish during device disconnect,
+ * blocking device remove.
+ *
+ */
+
+void usbssp_udc_died(struct usbssp_udc *usbssp_data)
+{
+	int i;
+
+	if (usbssp_data->usbssp_state & USBSSP_STATE_DYING)
+		return;
+
+	usbssp_err(usbssp_data,
+			"USBSSP controller not responding, assume dead\n");
+	usbssp_data->usbssp_state |= USBSSP_STATE_DYING;
+
+	usbssp_cleanup_command_queue(usbssp_data);
+
+	/* return any pending requests, remove may be waiting for them */
+	for (i = 0; i < 31; i++)
+		usbssp_kill_endpoint_request(usbssp_data, i);
+}
+
+
 void usbssp_handle_command_timeout(struct work_struct *work)
 {
 	/*TODO: implements function*/
@@ -257,6 +327,177 @@ void usbssp_cleanup_command_queue(struct usbssp_udc *usbssp_data)
 		usbssp_complete_del_and_free_cmd(cur_cmd, COMP_COMMAND_ABORTED);
 }
 
+
+static void handle_vendor_event(struct usbssp_udc *usbssp_data,
+		union usbssp_trb *event)
+{
+	u32 trb_type;
+
+	trb_type = TRB_FIELD_TO_TYPE(le32_to_cpu(event->generic.field[3]));
+	usbssp_dbg(usbssp_data,
+		"Vendor specific event or Babble TRB type = %u\n", trb_type);
+}
+
+static void handle_port_status(struct usbssp_udc *usbssp_data,
+		union usbssp_trb *event)
+{
+	u32 port_id;
+	u32 portsc, cmd_regs;
+	int max_ports;
+	u8 major_revision;
+	__le32 __iomem *port_regs;
+
+	/* Port status change events always have a successful completion code */
+	if (GET_COMP_CODE(le32_to_cpu(event->generic.field[2])) != COMP_SUCCESS)
+		usbssp_err(usbssp_data,
+			"WARN: USBSSP returned failed port status event\n");
+
+
+	port_id = GET_PORT_ID(le32_to_cpu(event->generic.field[0]));
+	usbssp_dbg(usbssp_data,
+		"Port Status Change Event for port %d\n", port_id);
+
+	usbssp_data->devs.port_num = port_id;
+	max_ports = HCS_MAX_PORTS(usbssp_data->hcs_params1);
+
+	if ((port_id <= 0) || (port_id > max_ports)) {
+		usbssp_err(usbssp_data, "Invalid port id %d\n", port_id);
+		inc_deq(usbssp_data, usbssp_data->event_ring);
+		return;
+	}
+
+	if (!usbssp_data->port_major_revision) {
+		/* Figure out to which USB port  device is attached:
+		 * is it a USB 3.0 port or a USB 2.0/1.1 port?
+		 */
+		major_revision = usbssp_data->port_array[port_id - 1];
+
+		if (major_revision == 0) {
+			usbssp_warn(usbssp_data, "Event for port %u not in "
+					"Extended Capabilities, ignoring.\n",
+					port_id);
+			goto cleanup;
+		}
+
+		usbssp_data->port_major_revision = major_revision;
+	}
+
+	port_regs = usbssp_get_port_io_addr(usbssp_data);
+
+	portsc = readl(port_regs);
+	trace_usbssp_handle_port_status(usbssp_data->devs.port_num, portsc);
+	usbssp_data->gadget.speed = usbssp_port_speed(portsc);
+	usbssp_dbg(usbssp_data, "PORTSC info: %s\n",
+			usbssp_decode_portsc(portsc));
+
+	if ((portsc & PORT_PLC) && (portsc & PORT_PLS_MASK) == XDEV_RESUME) {
+		usbssp_dbg(usbssp_data, "port resume event for port %d\n",
+				port_id);
+		cmd_regs = readl(&usbssp_data->op_regs->command);
+		if (!(cmd_regs & CMD_RUN)) {
+			usbssp_warn(usbssp_data, "DC is not running.\n");
+			goto cleanup;
+		}
+		if (DEV_SUPERSPEED_ANY(portsc)) {
+			usbssp_dbg(usbssp_data, "remote wake SS port %d\n",
+					port_id);
+			usbssp_test_and_clear_bit(usbssp_data, port_regs,
+					PORT_PLC);
+			usbssp_set_link_state(usbssp_data, port_regs, XDEV_U0);
+			usbssp_resume_gadget(usbssp_data);
+			goto cleanup;
+		}
+	}
+
+	if ((portsc & PORT_PLC) && (portsc & PORT_PLS_MASK) == XDEV_U0 &&
+			DEV_SUPERSPEED_ANY(portsc)) {
+		usbssp_dbg(usbssp_data, "resume SS port %d\n", port_id);
+		usbssp_test_and_clear_bit(usbssp_data, port_regs, PORT_PLC);
+	}
+
+	if ((portsc & PORT_PLC) && (portsc & PORT_PLS_MASK) == XDEV_U1 &&
+			DEV_SUPERSPEED_ANY(portsc)) {
+		usbssp_dbg(usbssp_data, "suspend U1 SS port %d\n", port_id);
+		usbssp_test_and_clear_bit(usbssp_data, port_regs, PORT_PLC);
+		usbssp_suspend_gadget(usbssp_data);
+	}
+
+	if ((portsc & PORT_PLC) && ((portsc & PORT_PLS_MASK) == XDEV_U2 ||
+			(portsc & PORT_PLS_MASK) == XDEV_U3)) {
+		usbssp_dbg(usbssp_data, "resume SS port %d finished\n",
+				port_id);
+		usbssp_test_and_clear_bit(usbssp_data, port_regs, PORT_PLC);
+		usbssp_suspend_gadget(usbssp_data);
+	}
+
+	/*Attach device */
+	if ((portsc & PORT_CSC) && (portsc & PORT_CONNECT)) {
+		usbssp_dbg(usbssp_data, "Port status change: Device Attached\n");
+		usbssp_data->defered_event |= EVENT_DEV_CONNECTED;
+		queue_work(usbssp_data->bottom_irq_wq,
+				&usbssp_data->bottom_irq);
+		usbssp_test_and_clear_bit(usbssp_data, port_regs, PORT_CSC);
+	}
+
+	/*Detach  device*/
+	if ((portsc & PORT_CSC) && !(portsc & PORT_CONNECT)) {
+		usbssp_dbg(usbssp_data,
+				"Port status change: Device Deattached\n");
+		usbssp_data->defered_event |= EVENT_DEV_DISCONECTED;
+		queue_work(usbssp_data->bottom_irq_wq,
+				&usbssp_data->bottom_irq);
+		usbssp_test_and_clear_bit(usbssp_data, port_regs, PORT_CSC);
+	}
+
+	/*Port Reset Change - port is in reset state */
+	if ((portsc & PORT_RC) && (portsc & PORT_RESET)) {
+		usbssp_dbg(usbssp_data,
+			"Port status change: Port reset signaling detected\n");
+		usbssp_test_and_clear_bit(usbssp_data, port_regs, PORT_RC);
+	}
+
+	/*Port Reset Change - port is not in reset state */
+	if ((portsc & PORT_RC) && !(portsc & PORT_RESET)) {
+		usbssp_dbg(usbssp_data,
+			"Port status change: Port reset completion detected\n");
+		usbssp_gadget_reset_interrupt(usbssp_data);
+		usbssp_data->defered_event |= EVENT_USB_RESET;
+		queue_work(usbssp_data->bottom_irq_wq,
+				&usbssp_data->bottom_irq);
+		usbssp_test_and_clear_bit(usbssp_data, port_regs, PORT_RC);
+	}
+
+	/*Port Warm Reset Change*/
+	if (portsc & PORT_WRC) {
+		usbssp_dbg(usbssp_data,
+			"Port status change: Port Warm Reset detected\n");
+		usbssp_test_and_clear_bit(usbssp_data, port_regs, PORT_WRC);
+	}
+
+	/*Port Over-Curretn Change*/
+	if (portsc & PORT_OCC) {
+		usbssp_dbg(usbssp_data,
+			"Port status change: Port Over Current detected\n");
+		usbssp_test_and_clear_bit(usbssp_data, port_regs, PORT_OCC);
+	}
+
+	/*Port Configure Error Change*/
+	if (portsc & PORT_CEC) {
+		usbssp_dbg(usbssp_data,
+			"Port status change: Port Configure Error detected\n");
+		usbssp_test_and_clear_bit(usbssp_data, port_regs, PORT_CEC);
+	}
+
+	if (usbssp_data->port_major_revision == 0x02) {
+		usbssp_test_and_clear_bit(usbssp_data, port_regs,
+					PORT_PLC);
+	}
+
+cleanup:
+	/* Update event ring dequeue pointer before dropping the lock */
+	inc_deq(usbssp_data, usbssp_data->event_ring);
+}
+
 /*
  * This TD is defined by the TRBs starting at start_trb in start_seg and ending
  * at end_trb, which may be in another segment.  If the suspect DMA address is a
@@ -330,6 +571,177 @@ struct usbssp_segment *usbssp_trb_in_td(struct usbssp_udc *usbssp_data,
 	return NULL;
 }
 
+/*
+ * This function handles all events on the event ring.
+ * Function can defers handling of some events to kernel thread.
+ * Returns >0 for "possibly more events to process" (caller should call again),
+ * otherwise 0 if done.  In future, <0 returns should indicate error code.
+ */
+int usbssp_handle_event(struct usbssp_udc *usbssp_data)
+{
+	union usbssp_trb *event;
+	int update_ptrs = 1;
+	__le32 cycle_bit;
+
+	if (!usbssp_data->event_ring || !usbssp_data->event_ring->dequeue) {
+		usbssp_err(usbssp_data, "ERROR event ring not ready\n");
+		return -ENOMEM;
+	}
+
+	event = usbssp_data->event_ring->dequeue;
+
+	cycle_bit = (le32_to_cpu(event->event_cmd.flags) & TRB_CYCLE);
+	/* Does the USBSSP or Driver own the TRB? */
+	if (cycle_bit != usbssp_data->event_ring->cycle_state)
+		return 0;
+
+	trace_usbssp_handle_event(usbssp_data->event_ring, &event->generic);
+
+	/*
+	 * Barrier between reading the TRB_CYCLE (valid) flag above and any
+	 * speculative reads of the event's flags/data below.
+	 */
+	rmb();
+
+	switch ((le32_to_cpu(event->event_cmd.flags) & TRB_TYPE_BITMASK)) {
+	case TRB_TYPE(TRB_PORT_STATUS):
+		handle_port_status(usbssp_data, event);
+		update_ptrs = 0;
+		break;
+	default:
+		if ((le32_to_cpu(event->event_cmd.flags) & TRB_TYPE_BITMASK) >=
+		    TRB_TYPE(48))
+			handle_vendor_event(usbssp_data, event);
+		else
+			usbssp_warn(usbssp_data, "ERROR unknown event type %d\n",
+				TRB_FIELD_TO_TYPE(
+				le32_to_cpu(event->event_cmd.flags)));
+	}
+
+
+	/* Any of the above functions may drop and re-acquire the lock, so check
+	 * to make sure a watchdog timer didn't mark the device as
+	 * non-responsive.
+	 */
+	if (usbssp_data->usbssp_state & USBSSP_STATE_DYING) {
+		usbssp_dbg(usbssp_data, "USBSSP device dying, returning from "
+			"event handle.\n");
+		return 0;
+	}
+
+	if (update_ptrs) {
+		/* Update SW event ring dequeue pointer */
+		inc_deq(usbssp_data, usbssp_data->event_ring);
+	}
+
+	/* Are there more items on the event ring?  Caller will call us again to
+	 * check.
+	 */
+	return 1;
+}
+
+irqreturn_t usbssp_irq(int irq, void *priv)
+{
+	struct usbssp_udc *usbssp_data = (struct usbssp_udc *)priv;
+	union usbssp_trb *event_ring_deq;
+	irqreturn_t ret = IRQ_NONE;
+	unsigned long flags;
+	dma_addr_t deq;
+	u64 temp_64;
+	u32 status;
+
+	spin_lock_irqsave(&usbssp_data->lock, flags);
+
+	/* Check if the USBSSP controller generated the interrupt,
+	 * or the irq is shared
+	 */
+	status = readl(&usbssp_data->op_regs->status);
+	if (status == ~(u32)0) {
+		usbssp_udc_died(usbssp_data);
+		ret = IRQ_HANDLED;
+		goto out;
+	}
+
+	if (!(status & STS_EINT))
+		goto out;
+
+	if (status & STS_FATAL) {
+		usbssp_warn(usbssp_data, "WARNING: Device Controller Error\n");
+		usbssp_halt(usbssp_data);
+		ret = IRQ_HANDLED;
+		goto out;
+	}
+
+	/*
+	 * Clear the op reg interrupt status first,
+	 * so we can receive interrupts from other MSI-X interrupters.
+	 * Write 1 to clear the interrupt status.
+	 */
+	status |= STS_EINT;
+	writel(status, &usbssp_data->op_regs->status);
+
+	if (usbssp_data->msi_enabled) {
+		u32 irq_pending;
+
+		irq_pending = readl(&usbssp_data->ir_set->irq_pending);
+		irq_pending |= IMAN_IP;
+		writel(irq_pending, &usbssp_data->ir_set->irq_pending);
+	}
+
+	if (usbssp_data->usbssp_state & USBSSP_STATE_DYING ||
+			usbssp_data->usbssp_state & USBSSP_STATE_HALTED) {
+		usbssp_dbg(usbssp_data,
+				"USBSSP controller dying, ignoring interrupt. "
+				"Shouldn't IRQs be disabled?\n");
+		/* Clear the event handler busy flag (RW1C);
+		 * the event ring should be empty.
+		 */
+		temp_64 = usbssp_read_64(usbssp_data,
+				&usbssp_data->ir_set->erst_dequeue);
+		usbssp_write_64(usbssp_data, temp_64 | ERST_EHB,
+				&usbssp_data->ir_set->erst_dequeue);
+		ret = IRQ_HANDLED;
+		goto out;
+	}
+
+	event_ring_deq = usbssp_data->event_ring->dequeue;
+
+	while ((ret = usbssp_handle_event(usbssp_data)) == 1) {
+	}
+
+	temp_64 = usbssp_read_64(usbssp_data,
+			&usbssp_data->ir_set->erst_dequeue);
+	/* If necessary, update the HW's version of the event ring deq ptr. */
+	if (event_ring_deq != usbssp_data->event_ring->dequeue) {
+
+		deq = usbssp_trb_virt_to_dma(usbssp_data->event_ring->deq_seg,
+				usbssp_data->event_ring->dequeue);
+
+		if (deq == 0)
+			usbssp_warn(usbssp_data,
+					"WARN something wrong with SW event "
+					"ring dequeue ptr.\n");
+		/* Update USBSSP event ring dequeue pointer */
+		temp_64 &= ERST_PTR_MASK;
+		temp_64 |= ((u64) deq & (u64) ~ERST_PTR_MASK);
+	}
+
+	/* Clear the event handler busy flag (RW1C); event ring is empty. */
+	temp_64 |= ERST_EHB;
+	usbssp_write_64(usbssp_data, temp_64,
+			&usbssp_data->ir_set->erst_dequeue);
+	ret = IRQ_HANDLED;
+
+out:
+	spin_unlock_irqrestore(&usbssp_data->lock, flags);
+	return ret;
+}
+
+irqreturn_t usbssp_msi_irq(int irq, void *usbssp_data)
+{
+	return usbssp_irq(irq, usbssp_data);
+}
+
 /****		Endpoint Ring Operations	****/
 
 /*
diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
index d0ce20f35ec6..2615eb151925 100644
--- a/drivers/usb/usbssp/gadget.h
+++ b/drivers/usb/usbssp/gadget.h
@@ -1716,11 +1716,22 @@ struct usbssp_segment *usbssp_trb_in_td(struct usbssp_udc *usbssp_data,
 void usbssp_handle_command_timeout(struct work_struct *work);
 
 void usbssp_cleanup_command_queue(struct usbssp_udc *usbssp_data);
+/* USBSSP port code */
+void usbssp_set_link_state(struct usbssp_udc *usbssp_data,
+		__le32 __iomem *port_regs, u32 link_state);
+
+void usbssp_test_and_clear_bit(struct usbssp_udc *usbssp_data,
+		__le32 __iomem *port_regs, u32 port_bit);
+
 /* USBSSP gadget interface*/
+void usbssp_suspend_gadget(struct usbssp_udc *usbssp_data);
+void usbssp_resume_gadget(struct usbssp_udc *usbssp_data);
 int usbssp_gadget_init(struct usbssp_udc *usbssp_data);
 int  usbssp_gadget_exit(struct usbssp_udc *usbssp_data);
 void usbssp_gadget_free_endpoint(struct usbssp_udc *usbssp_data);
 int usbssp_gadget_init_endpoint(struct usbssp_udc *usbssp_data);
+unsigned int usbssp_port_speed(unsigned int port_status);
+void usbssp_gadget_reset_interrupt(struct usbssp_udc *usbssp_data);
 
 static inline char *usbssp_slot_state_string(u32 state)
 {
@@ -2187,4 +2198,6 @@ struct usbssp_udc;
 
 #define to_usbssp_request(r) (container_of(r, struct usbssp_request, request))
 
+__le32 __iomem *usbssp_get_port_io_addr(struct usbssp_udc *usbssp_data);
+
 #endif /* __LINUX_USBSSP_GADGET_H */
-- 
2.17.1

