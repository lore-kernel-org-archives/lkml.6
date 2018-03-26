Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1713507-1522091171-2-11079585854854798546
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522091169; b=lPxuU3Ha+yNIVyi8c+re9NBZWjfbIe5Vuw/JNwBxrnTgoEV
    eElRZ42UP+VI8HvbuXhMtO8RutiOJDhW9/5UomKsFUw2+iu7HctfE5usTignwjsY
    /sjBCdI+o7UCGRaDQTkB/RR87kgKGE9WeLz2LYZsF3o/WfjoJCRoubccpGKJ8y4Z
    BJD8pteHHBkueP4Z4soIubRjxODyc2lCtMoVqkJx1cOdBNJYXNbRMeo5ccg5j51T
    hX7AZcMlH+DxCDfqHZThRHSC9kPDJGPTcCWrLEyDBvTErARCih442eCcD8nmF9VD
    K0NTUjHKmTUB6n9B0IqdrWMAYWpHl5JMf3WW9Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:reply-to:cc
    :content-type:content-transfer-encoding:sender; s=arctest; t=
    1522091169; bh=G6sv6lI+SS2MSetK1ZWorK84iylTDasC96WPu8PxOqw=; b=T
    Qflx9y7BGc/fud4uRzBCvbhYWgk1hnGO6OJRB317FawrE6kpc8rLGIxAGSm3/Nzi
    UDEc1FthNp7Zh1yv6oy9UahovCtGS+HVJntNLQmNX3Mj27cYTFljB+P6suJMNg1U
    orEeAqMo/gkLt+gQpSk727aCx427SyY6ywCNQVf3efW6BSYYVCwCcTrhXnwhQwgj
    z869KOMu3vV0tDxFnZgiRPlNv2PHRbdeSbpZ6MlO+IQWEkTIMv9cgWXvG3VDmiuL
    XKsEinDTxrhdDvPE137iNtpGzxm1+Np4B6oyv+ekaO7I6faE/owIjfvL9ESAF20t
    EXcqKQvPtZAoP59A5YnXg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=QkwIuRXx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=QkwIuRXx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCuTtRQig/PCmd5qdy2D37grbCqYWZeHw/DtOOm2kLdYnpHaSoqdpj91etVdXXLocYdk65m8iNFathdlghBdf+TsoQ8CvcR3ZqisBQ+mkpbrrZEO0dFs
    yIWf1NSspAgSXvkFrg6aigaz18zYTabt4xsyPf+36kpvLsBY6f0wV1vXec+2aS5xrAUEFSl4S7e+UHp0rYYE/kfIn1z44KmwApnjWAVdsg5oTUWOV+JXLyWh
    QXUX0z1uLnwD1LxZMEbqMA==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=TRjyw0CnJloA:10 a=P4uAHAV8DOQA:10 a=JMP4OFuIcRoA:10 a=SJl39FfINJoA:10
    a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10 a=dw2S5ISiLjYA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=8AirrxEcAAAA:8 a=DDOyTI_5AAAA:8 a=UUrtKTILZhJQHLSs-BsA:9
    a=z8ll1zxNpZmocxR0:21 a=cdRY1HcAnmOPZpnV:21 a=CjuIK1q_8ugA:10
    a=ST-jHhOKWsTCqRlWije3:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=roy.pledge@nxp.com;
From: Roy Pledge <roy.pledge@nxp.com>
To: devel@driverdev.osuosl.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/4] drivers/staging/fsl-mc: Use memremap for DPIO cache
 enabled area
Date: Mon, 26 Mar 2018 15:05:31 -0400
Message-Id: <1522091134-24646-2-git-send-email-roy.pledge@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522091134-24646-1-git-send-email-roy.pledge@nxp.com>
References: <1522091134-24646-1-git-send-email-roy.pledge@nxp.com>
MIME-Version: 1.0
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: DM5PR1501CA0025.namprd15.prod.outlook.com
 (2603:10b6:4:9d::38) To AM5PR04MB2993.eurprd04.prod.outlook.com
 (2603:10a6:206:a::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c55278ea-c5b9-42c7-9d46-08d5934c9b8d
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:AM5PR04MB2993;
X-Microsoft-Exchange-Diagnostics: 1; AM5PR04MB2993;
 3:qxEIp2AwVb647U5VjmxYPAoTNf9rNff55MTgW322fYhF7N7jswXtu8AsUdpZD3fI5VSK/RfpX3a3kyhR5CKRGm7znuOBH6fg7F3P29/IPGEw9eWZ3ln0H8VAIENT/d7iIs67nlRPlwK/6hzNc8jng1ASnxsWgsMUevh5Mc6BUzC8Qw8XaFV+QExnIpOcqU5GZzyw63pGOSK5Wtsxeb4aIOPIUU/HgUivQWqUNl48+roo7OKCpeu+h64o2x14GSK7;
 25:iIhiJ1eEALCQgwWgy5ZWtjJWTGZ8VLHziOi3e11G/eszNPC0ByHgLoTUNcmo8MARUysoFIdypvfgqLMatYzPApOtvBw7S91QfwIHxI84Mfm+gfYu4rOXjv+SbV5gsaTJ8Lz8iKmIBoSnIY0luKEN+O2KXeN6NH+1EovrSCsChcTHuGSCQ+rTCQDCUUzaNGg/hwbSxJLPi4/YDVN9QF1EFFOY8GKpFp0J69mDljuEhLj03pfdOgc7J5bvRgl8YyY/cwIBYifdJ7re/UaAz7SXR/hRkg+ruehwxUOH5WrzXTAKXKGxOA/+afuPpTLM3vltqGJhnR0dllZ7mZvjl9ttoQ==;
 31:HQKAtuslWjEditQXXrX+nD+Q/jlkP2bQtpbRCC7X3BZREfcxukmxP2GhhLvzpkrGbKUQ52OCc7AfLFwBSi+0UE86zFahOlCoOxguVvxNvgMYNbyEXTB8vU/WHl0jrrOptcXHJDLpboaNJJV22yR09D+SQqtmxBWZo3kj7G90dkasSDUlP3q2kXHFBbRHuF93o8gy/ZYjZsc2A33kr80+oG09e9mDWaCB/xQ8A3xdYUE=
X-MS-TrafficTypeDiagnostic: AM5PR04MB2993:
X-Microsoft-Exchange-Diagnostics: 1; AM5PR04MB2993;
 20:iWMywpG1Ghdy6tIFYC0Z8Q/e+CdjfvfIOu8iWOCB9VZD1Uv8I8wgaTR/HFSK9X0MOFbUrjS48rqpJSdg95zVdmX7T3SYjnlTyqkl0vHFDGhvELd2FjJwIR1T3L20mXRKpg0EG92ZVSOG71I3fYYhH2/dcOyqK+RcOKm0DPT0ndK3OST5k9fXt5aCFkuLCUpaDwy/EsjLfNQuB+1kYs4bfpcgLmzZct6noa0bnDAYJsu+YKX3DwRqKUoRhlxlmTGwLpxa1a8cS1R6wRBYcY8MPvgzBzhBEgLX0jEaRPPBLBx0s31h7NKbMbhxHUCcqpcm+VRtkhrHhwNUDkBkR9b+nQFNPJgkBEUE+FSp14uAt60WLi875jeNaF5pYnjNdLbJcSSssYzQbYHrBaIHjJI9tDflXiStWqmyiDSC1KHDwJXFgUeWb2uhKRh7r5obMsaEPF/Vww6jsZhqVtHarjLKYkg8TV5WArY6DO5p6av3xO5aLg9Fm8bJWGKdcIr2RaPg;
 4:UbrESDwZq8dj1hkZ7Am24sC5hVDIk0kxk4eR7CF8GYGt/ynqZ1af3Y95hlrWmhFSyGKmUJXZKZvuO+lp0VH9v9KwllZMLcq15uK8Y6/rHJPJy4Eyzq7kZJWYeEIyinHro9J/wvLXfghkrft+ICvLfZdhB4rgPvnTmxee9GWJWwfOcrq+tbYjcJQlu1nCwhsCczDjE6sSx56HDgtdAaJqRuFDX7SHqWfH3kwKZAUSQc/g9Wcd3SbMkxZoy6Weth3PnNU5b3XgiTf2ckbJzSFmnJgaw8Ikxktp3SMfnvlMt4cLY0ueZ5XxiIFXp2N9WvyHBY87YjudyGsC884NNUFLv4Eh39h2gS5Eftgp2STJNSg=
X-Microsoft-Antispam-PRVS: <AM5PR04MB29937D8D5D97685EEE83E35686AD0@AM5PR04MB2993.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(275809806118684);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);
 SRVR:AM5PR04MB2993; BCL:0; PCL:0; RULEID:; SRVR:AM5PR04MB2993;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(979002)(366004)(39860400002)(39380400002)(376002)(396003)(346002)(189003)(199004)(106356001)(66066001)(478600001)(47776003)(6116002)(3846002)(2906002)(186003)(16526019)(26005)(68736007)(51416003)(76176011)(86362001)(6666003)(36756003)(43066004)(25786009)(6506007)(305945005)(386003)(7736002)(316002)(50466002)(16586007)(105586002)(39060400002)(5660300001)(97736004)(6512007)(3450700001)(956004)(8936002)(8676002)(53936002)(2616005)(11346002)(446003)(4326008)(48376002)(6486002)(81156014)(81166006)(52116002)(50226002)(476003)(486005)(486005)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM5PR04MB2993; H:otc-sw1.am.freescale.net; FPR:;
 SPF:None; PTR:InfoNoRecords; MX:1; A:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM5PR04MB2993;
 23:S/GkfZUdqDH+degKshCMNyVYwYaVJ1NHK1jM8tVQi?=
 =?us-ascii?Q?C8ucOW9j5hWOpcTdvjNuURVH1eMWRHj4qXxXpmj89L/jtVFH097V2vNSkqza?=
 =?us-ascii?Q?DigVDUAOdSIWwoCY248Isr0toEd4m1L20DzMh85/2xbhoLuUPXiie4f1FLGC?=
 =?us-ascii?Q?8QdI0PiWffqV8FdeNv2jniuRGQdgp9X8SyyZiuOLh9GU9x97Y3IPJKN52hDW?=
 =?us-ascii?Q?MCT6J9ldhpcw7GN/0msZ6oKoCUHG08kCkigHMlPgl1JsACh7KqWVf7QhjBg7?=
 =?us-ascii?Q?zh6TP5ELj9TJ0hkaFixtCMiboWHI6kS4RHjraD4CDyb0RIVjgeTKyyRJQhdp?=
 =?us-ascii?Q?ecRfl2NVyYLyewhKqMOliZl1graBkh/BjSyO+WQcbGvHXWAzwQOZIVP+e08u?=
 =?us-ascii?Q?wRQeL2MDYrMCptMZLZRatrwNC3rYDA9J9MsBsRrVXkrwbDUYDoPDREilc8oa?=
 =?us-ascii?Q?W93LG6sngeTXREu8jQEwqeZ93k9iL4tH5HtYeKxhF5kolXUUlMj15O3kE7Yv?=
 =?us-ascii?Q?TtnhZYGazmGvXsraUl1kXjjvj7H5oIZLm5AW834wbcbRbvR9wxOqGe2xdMKl?=
 =?us-ascii?Q?a1VqA8xdDJh1plLVBUMB4nzXLAu06iA3hO76i99Eyxs7eoeNHb0xA6lOEenh?=
 =?us-ascii?Q?30jgSF8FLW3MnD4j0y4BBIR+VkTaCe3OBKn2koFo49rL1rtRMbgNHvb00HXq?=
 =?us-ascii?Q?p9AOBYvpanDJ8mTDNpmQ0HqtTf1fLZzADhLYc9khyXUNU0YOG7YVy4TI6++z?=
 =?us-ascii?Q?HWEtcWw2GzM089SA2kjF69axOQiamzFABMj8IQAyKCMgEZySGO+PBbQYQXz2?=
 =?us-ascii?Q?hn2djiOSTcfKiTEQQWhcgwyJSsslQLFGuggih20KjeEtdkgQx0Ya0Agtxpef?=
 =?us-ascii?Q?FwtV9AyfAySbum1cKku6punNHl4FQUZtvPRhMrbX4xU/fVF/31DxFD2oL/ii?=
 =?us-ascii?Q?LvLnTz6vGy2hbA1koypAbv4LRJUuaxwQj2+GYXfDb23IHqlHEV2Y03uERA06?=
 =?us-ascii?Q?guNi52ZweKGtBYExRN3oUS3IqrZbQsxv6vq8uaPEK3QvVYzhg1AE6ECnt109?=
 =?us-ascii?Q?3KNXeXeQ5+2AZMKrr4t2WMfZs5v2WQACDyIzeGibufG3NVNPimrOWZzOcCQx?=
 =?us-ascii?Q?ApGL19w5iQ864Av3VX1RrcW9d+56uZs6n8VIFvh5k4qZHT5X2x/2dAKhsw6l?=
 =?us-ascii?Q?ISnf1m85j/yoRxf1ynotSXGQRg35Nv4z33XxkjuoKpMMDF0wLmtTvhS0hJDY?=
 =?us-ascii?Q?+eet5CQI1dO/EIIZbYfRV5P5YN9NU+hDj5671mo3a6Y5qEODG6TiZJ36t6w7?=
 =?us-ascii?Q?30aXCjjMkDNDHakyGAbmxHAdc7q1Up9wyF8UdoGDCYU?=
X-Microsoft-Antispam-Message-Info: dF7pne9q1oTak9S2Xbvo9ePIQ5xMJ711uK3m5nNE7oY1S895xJTVrULSIygHUjzV0zkXrzGjuuVsjFimDMApfpZygml6JVJHuEoGo8DzMvOZ6yvTOjfrv4YhC7VKe4hsBlzvKDdiuHDRSAxpsbJR3sky8BtpJoNHJ8Zh+AjJIRNT2uezMWxYHg6TihTm8T9f
X-Microsoft-Exchange-Diagnostics: 1; AM5PR04MB2993;
 6:T1YCTfvMkOWCTQ1fUZbE/CtdMN6Hru2sCrn/rX4TOXFLPJnplSXCc9t2FTFkLspA8sBohrGp+Vt8L6xHZbtgXA4LxzMyliqVdruLgO6jU488rdadyP1b3A3oKvkzE/xVFqPcc09An5T4pTCvYSH2fnJl6gVc5+NyE9qg57dKOPQb4Hgi/6o5K0jGAl1hogCUNHizkyX/CrIi+mYL4r9g3OE0atgbw7+GyMQ8b39xfk8UF4PHqMBFLv1IQx+3ssp5RzisEiUA4s5aa0yFpKLePgt2ptyscISh9fzRbsyJzZO2iamBBZaHwSLlSDUimoHqIiCX3vygkBOLYyR0B3w+wraKFq69fM/2JD0Fzosvk4iUSAgt4sTwbjxdzPigy50OG3T/csACt2oe5y4RLc3oNYWM1zL97uOEPyLu9dv2/3XYi8nek49H7E5fDw3qGWmVK1E0ctDd0NeK0Z8rzoriqQ==;
 5:7WUTfz0W8VicubC6Qb3MKBQhm7CvS5tZNOx+A8g+sJEeHRAe6PgJwZA5Ont0Tl+7ba8cn4EKUsWvp/l41grVkpqHmxrTiumMF3d0v1B7xj+kX6PS9xcfbBlELAZGGDnFIWtuEaIpW81NraVTR/QJxyYw7z7E6UjnjWweNG9T168=;
 24:zVibXCDkN8G/dqx7xkt9pQZbenjSfqX2sqGzS7EQdseM/ddEGRxAb2OMjj73QN7aHGL+qoFvCrla7MA4Gy4oJDc9JH4L/WtThETWhJgwMlk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1; AM5PR04MB2993;
 7:URjeDDd5mW28ZoO/T1wzYHLiaW2OtCmyYKToP9JMAVQbamq7vAvyTrNaH6NT5If5zLfyN0/QtfaMnNT5clC5hRl+Sh9WHNsn/DmR0bFxiNUQ2Mv5bVeZdRXlwKDAnDWEbefFIbSEOeX8m1Xop6y6HgMY+5LG4pI7IHPmUsLh/KJB1CqWzJoSjOsgW5ceJY2VaynNB9CzpOXWRihyg4r7IeTdpZQTe8aZR0Jh9V0LgsfHapQqLJc/Ou40TTZ2++BR
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 19:05:55.1580 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c55278ea-c5b9-42c7-9d46-08d5934c9b8d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB2993
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Reply-To: roy.pledge@nxp.com
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, horia.geanta@nxp.com,
 linux-kernel@vger.kernel.org, leoyang.li@nxp.com, stuyoder@gmail.com,
 catalin.marinas@arm.com, Roy Pledge <roy.pledge@nxp.com>,
 laurentiu.tudor@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Change the mapping of the QBMan cache enabled area from using ioremap_wc()
to memremap(). This allows the __iomem attribute to be removed from the
pointer (which makes sense as accesses try this as cacheable memory not
IO memory).  These changes allow sparse checks to pass.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/staging/fsl-mc/bus/dpio/dpio-driver.c  | 8 +++++---
 drivers/staging/fsl-mc/bus/dpio/qbman-portal.h | 4 ++--
 drivers/staging/fsl-mc/include/dpaa2-io.h      | 2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c b/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
index 182b384..e00f473 100644
--- a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
+++ b/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
@@ -13,6 +13,7 @@
 #include <linux/msi.h>
 #include <linux/dma-mapping.h>
 #include <linux/delay.h>
+#include <linux/io.h>
 
 #include <linux/fsl/mc.h>
 #include "../../include/dpaa2-io.h"
@@ -146,10 +147,11 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
 	 * Set the CENA regs to be the cache inhibited area of the portal to
 	 * avoid coherency issues if a user migrates to another core.
 	 */
-	desc.regs_cena = ioremap_wc(dpio_dev->regions[1].start,
-		resource_size(&dpio_dev->regions[1]));
+	desc.regs_cena = memremap(dpio_dev->regions[1].start,
+				  resource_size(&dpio_dev->regions[1]),
+				  MEMREMAP_WC);
 	desc.regs_cinh = ioremap(dpio_dev->regions[1].start,
-		resource_size(&dpio_dev->regions[1]));
+				 resource_size(&dpio_dev->regions[1]));
 
 	err = fsl_mc_allocate_irqs(dpio_dev);
 	if (err) {
diff --git a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.h b/drivers/staging/fsl-mc/bus/dpio/qbman-portal.h
index 4488a44..69db3c8 100644
--- a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.h
+++ b/drivers/staging/fsl-mc/bus/dpio/qbman-portal.h
@@ -15,7 +15,7 @@ struct qbman_swp;
 /* qbman software portal descriptor structure */
 struct qbman_swp_desc {
 	void *cena_bar; /* Cache-enabled portal base address */
-	void *cinh_bar; /* Cache-inhibited portal base address */
+	void __iomem *cinh_bar; /* Cache-inhibited portal base address */
 	u32 qman_version;
 };
 
@@ -102,7 +102,7 @@ struct qbman_release_desc {
 /* portal data structure */
 struct qbman_swp {
 	const struct qbman_swp_desc *desc;
-	void __iomem *addr_cena;
+	void *addr_cena;
 	void __iomem *addr_cinh;
 
 	/* Management commands */
diff --git a/drivers/staging/fsl-mc/include/dpaa2-io.h b/drivers/staging/fsl-mc/include/dpaa2-io.h
index f71227d..ab51e40 100644
--- a/drivers/staging/fsl-mc/include/dpaa2-io.h
+++ b/drivers/staging/fsl-mc/include/dpaa2-io.h
@@ -52,7 +52,7 @@ struct dpaa2_io_desc {
 	int has_8prio;
 	int cpu;
 	void *regs_cena;
-	void *regs_cinh;
+	void __iomem *regs_cinh;
 	int dpio_id;
 	u32 qman_version;
 };
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
