Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2699586-1518609326-2-3039867471756418222
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='RU'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518609326; b=cPFyFTNpD57c9VDyiSmI9DJV0C7BB+32saasnI3a8gnHtHx
    DGGZy6ULk+RNQb7rX9s5iADRNiALuI+ElYk52Hdpv9z49QnKYtB3mN4F0L+4LOlq
    9lSKb3CdxPBqHeKp8Ux/6HrkBhvCdy5FSjsrwZOH69mrLg6bo9LQ3hDCbAZnwsyF
    GONd3hgex8B/o78uiaFxoetMHk98GZ8VsGlch+fP8iHWkIOZyVY0Y+2xB8Jh4FeG
    nABZ+5FnpuZZOZSmnPepp5jLDUsWRGbak7tAG1k+JpNAyXpkIW/eUHCSYsyckMZI
    8EhoGGb0sJo2ZQLjH32bBJ4HUKuAIRGhdvT9A3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1518609326; bh=5uvtU5fNYFA0xjFKItKwO1sTu/m1DcPMOLAAbRG4SCQ=; b=C
    z5g7dG3I1VBWzGSl5jvQubovMxAivo4SZfi7nbyvupmvD3uLSmsVG4UP2WwHQ4Q3
    Uj7cFCKFeKUdzLfvD4vm+j1wlRaf2Wh4wFqbHZqkJYjnreBtR/+wH/2geppxESpc
    TzGt5JaAoiRulqCk+h0y9TIQ9xLPbw+9LghuB7fqXaWuLe1ok0FBRL9LvyjTAKJ6
    ZYRqIyOWNo6x7ID9dIvaFzLlbIvtnbyxmBXWOwo/218KiNmOFzzjL/C4VeNroSt/
    g68C9w1ivXZhGkJ3Ldhr/s4I2D4pLCJsKD2NUaQs0C6/K86CuKJMYuZledk1PT8z
    ImS9f+dxM6I7EK7b1NqKg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=iJGRLOHa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=virtuozzo.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=virtuozzo.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=iJGRLOHa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=virtuozzo.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=virtuozzo.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967643AbeBNLzM (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Feb 2018 06:55:12 -0500
Received: from mail-ve1eur01on0093.outbound.protection.outlook.com ([104.47.1.93]:30065
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S967544AbeBNLzK (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 14 Feb 2018 06:55:10 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
To: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>, stable@vger.kernel.org,
        Mario Limonciello <mario.limonciello@dell.com>,
        Edward O'Callaghan <quasisec@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: wmi: fix off-by-one write in wmi_dev_probe()
Date: Wed, 14 Feb 2018 14:55:24 +0300
Message-Id: <20180214115524.25522-1-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.13.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR02CA0102.eurprd02.prod.outlook.com
 (2603:10a6:7:29::31) To VI1PR08MB2831.eurprd08.prod.outlook.com
 (2603:10a6:802:19::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b45c687-2ee6-44ea-4a0b-08d573a1ca9b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:VI1PR08MB2831;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2831;3:EHKPtchEYooo50RNU3Q94I81MTlPLDBShVIq4F1IMfPysMYIcL3SsxppcK9QS2furq7gB6+VtQ7VoJfd56++3bezTSilePKHGGTgy+J1cuMp+cfXO7uol4Y28LlFkivY8BAibQOVa0s8mPnTn/FObLQmG06GlBZdgSKy2YK8pjrkYG2NSo2Q0RPLtnFBUJDJSwRj8DemzHlmd1wKTbP/kniUdimRJ2eKIG8fHfHcEZ6dvz3EtCwm4zKf4+IU+/cQ;25:zqFU3/Bb0Pldxo2GUU9elq/CgVHdQI8ul9DOIP2alre5DuWS+5kN7OG2HIEZ4U6KemyEJGB8tw4Si9x1yF9qJ2fmIpY0G98I/w9exZxoMbFtbi2yF4s2E+La8+/UgKMGblALCUkNOudR7ynXHo51LoaSN4udFSeQ7TgYNfd/CsHLBtHYHal4TlqjC5sZ8OjmIEw8J3iHKBVo/b87kPigJtlkj49htdRgD+M7eSG5CO68hYhUKmEiTOBOuIiim5XLlB+p1rA0OYSH8bGlSzNm+6xIfpUHMql77rP2QzDaEbZUM0ru5B/VBV3TyJn/1CA3NYrpG/C4GlPJ9WOD7VtEfQ==;31:KzoVu5HerQImln94g96jlEAgMa7LCr4PI/MkuN7ggcINpf7jtW0FqDD8EqFhK3lJHGMm/MM/0pXo0LRDNF4FdNp038k3hQ3Eic31awgfSuTeKWiCi4u0jNJlSfNxQbucQ/cdm1SYCQJ+dQMSCjNl1zHYmZMeQg8hdGf8AdrDioBLlHO3O7cJLMLk+BsAhkkBBOkYqWq+H0jp2MfGYy3Kf8845uQ7HkWfgGnZbKf7qgY=
X-MS-TrafficTypeDiagnostic: VI1PR08MB2831:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2831;20:E+kJqfYzpl3dqnlPyriXTm2mtBOjbVvo/74REVDPGR1+n7JVqa9iTs8B0wcNbRUP+A8UPLxsFe9YLKQ1BzVYWsXRnntC6fe0CD9wMcVahXve1nURimoxUBP9bD34aTtfSH/3Vn1nEO/u54LX1gJU3WqEUhrOHcrGqSapslXIOTFit+7we35GTzfuuFxO5URNMnb0alPr4L9i1Z5LNnyox4zAU0XhrjsPtEfR2moMd8VuS0ZM4oOPcpnD/jYI6SDaBuNwcfXZz0sRmVFsvtbs2bjtdaRiwuI3ttui65nyxEAf8iyallULb/4/+bMLqUMvw3bEsDiOGdY8m4bFx9JKmSMN59u+Aov/kZ/GqKdtsYWr/KZGCdfdn2h/gQEvy+gMFwKYiKeRPEP5+NxEq0nfkJkOJZaI6lPAbNguPiic7Ptos4WqVXbhNLZG3pbiVPB6ue73Mpf4Ekmz1SSlo96ecwVRSUuhu/QOEipnzr4xWJoLTjH8V+x5f3ynzn4QOeNG;4:aVX4FMzkMamyrt5gXUS6MASR0oXN6EtG8rxNLmKcjwS1qLoK7QflTgMaV2RRmU2vsq/YQGx2Ci4rarT9cR1K/8QIy2R98O15ukyoRt/Se7euhWoQz3R6AV8c9T9kHs1fRxNVSzuGo6sxXEdkjC3RHIrBNLA6lh9bBtAkY0BCNKer+39CLXUacZKS6joEZOGQOPmlRPG0LtnKqdCkW1hEQSDFU+fsKQFDKwCNRT7Odq6DyFlS0vS9mKhMBA+dwhpUA2p9AbxK2wkXPVSGYwD6tIxbwZk6nd0u9RoirjgoTYWK0TB7rk54jKSe/P7+YXDe
X-Microsoft-Antispam-PRVS: <VI1PR08MB2831DFBACDE2606FD48C2544B0F50@VI1PR08MB2831.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(10201501046)(93006095)(93001095)(3002001)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR08MB2831;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB2831;
X-Forefront-PRVS: 0583A86C08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(376002)(396003)(346002)(39840400004)(39380400002)(366004)(199004)(189003)(16526019)(3846002)(48376002)(86362001)(36756003)(1076002)(575784001)(81156014)(50226002)(2906002)(6486002)(59450400001)(25786009)(186003)(68736007)(1857600001)(50466002)(6116002)(76506005)(386003)(97736004)(26005)(6506007)(55236004)(8676002)(81166006)(4326008)(47776003)(54906003)(8666007)(316002)(5890100001)(110136005)(16586007)(8936002)(66066001)(305945005)(6666003)(69596002)(478600001)(52116002)(7736002)(106356001)(105586002)(51416003)(53936002)(5660300001)(6512007)(53416004);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB2831;H:localhost.sw.ru;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR08MB2831;23:Y6aVI4bivwKECT7vgnIFm3NO/cvTQmkF2FaBH9vgj?=
 =?us-ascii?Q?5JQhbh5oa+YvTZ+wJVZ3OC+GWFmo1+jG9A/nuBF/Fr+uFzjgelYXMhZfNTZF?=
 =?us-ascii?Q?Lt5iNZrsizcNlHxGDbdKnyJ0QnQvepDYfvyD17Xfp5P2yePc2LREFFI+aPKd?=
 =?us-ascii?Q?r3oRId6rOvXRmHV+7ePLKgfNJQz/mLf5qEAIqHStTQZvYnv/LcdHfeCYhJcO?=
 =?us-ascii?Q?6zUD38jY0iZPlsCTJOBYDUOuIGwVmP5qPgsryQ1AD4I5gFe9EGOe5XZk6e+R?=
 =?us-ascii?Q?rL7XjcQdFTlvKV/oXFcuRsGIStZW0LMObgfCLDz7QJ0i1u7VI7gM1I0p/3pD?=
 =?us-ascii?Q?3lujy+daQ0liQQRF0udiUSjKMVbZ0GMYpWmOoHaLFJn34LepkAC2JvFut+M2?=
 =?us-ascii?Q?r5OF3LAHQ/0K39Pw3Tbg0Z1BcqAYMm4YGNz59y+0/lMiShkpMUQ/C4jU/7vO?=
 =?us-ascii?Q?HyNIo+x0cX/UAURICq9s/LnQLmUTFbWfkNk8miIpoa227ZBTdhuTJW94CXvo?=
 =?us-ascii?Q?XFzZcjIVy61gUzJVgmGphUE1tGhyJX5vMqHfxRT8bfInwH7zCAx7iSzRt/Jq?=
 =?us-ascii?Q?PdRsdrBNZLZES55YR7x8XtnKdvGFfRgsHUdHA666Qebnw9SmQdhPUWmIAPYE?=
 =?us-ascii?Q?OcGqcljmsQtEreBE+Oa4MVeZZg2W7pQROaDslFsBd29HLZQAIu1620esymsB?=
 =?us-ascii?Q?k7VJVFGWr2RHS4VHQWxEJbIWmADHQro/LHl4l6tHNPrI0r1L6/HrrvYP87Zs?=
 =?us-ascii?Q?1KLNt5iKpXPEj2GCzluZF8NJF/+1tpuX837n6LVM247J+sIdHGHizQB4/0YL?=
 =?us-ascii?Q?4Xisio/SOvWBjlGaXfu2GPIFtTDFS40c/SZAFGh2UCtszIoJHxRItsFkZxgl?=
 =?us-ascii?Q?0D/ckbA4Ppd50txJ28sG62C8hLzl5Gx+KsrTciPnuASC/1V6LAkcRLEhjQLB?=
 =?us-ascii?Q?uDkXtJGoZEcw3hYhEEmbIOyaifGhw5OTqpyAew8xIc/ngEb0nTSlqdeX/i+c?=
 =?us-ascii?Q?HLkMSfYc6Z4L3pbzT5dl8z7XeEpBIH7izq8aWgFX9W8pynbuuDFBuab9jDdk?=
 =?us-ascii?Q?WyyknzvB/Vi65B0/9US6kPJhQ2myYyxK19gwjD25CpDrzes4MLAcnSw9EjmV?=
 =?us-ascii?Q?Ymtv1l0cAu2rvxFdvDlgyZPWPscyWF3Q9edOodNFjsAwT+9RyAe1r6UOKWN9?=
 =?us-ascii?Q?2SmsblCqyqnCLi5Jedai7+WDG9x7+0z57+FdvgSE2T8gnt4bb4sfp1yTeZ/+?=
 =?us-ascii?Q?Li1I/8Fb6jJDi0AnQZ5eBzLWTQVsIetJMRvTjIgDldfSBfQmWsr2pHbRBwT1?=
 =?us-ascii?Q?RnkmhYN5cJM3QD0P+qNh+g=3D?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2831;6:kCwgQ1ZiykGUCysBmUKNQdGZElwnEsaR08+q18UT7CfxO/rfgec7GIyTqHqrgHhyt6ttxm1klt14m00+IV1b3uimKmD6w7AN6oOqbJSPLzSioj8Brmj6kN+EPtizarEvXnx5x2YhYU0QfVGAEfMi4r1JKY32AsOEb/lxAR4pXLIRkFHc8BSrbjEjan2sluLfb7EGQrXzOid3odERg7Z3393zpBd1U+dEpIbfvMHp6gs0atylp520W8wz4lsMyMBBVQovZmiXNLqSmFGSERS05kd30MRoAHqu9SksWRgkIgzUDJMt0G1X3RIBxx5r5JJgBFYacjjReuaGfbKAi+GpB7bQmwihf8eY3pOJUiSvKr4=;5:Snv0vaWNzexeOeUMnYqZJxxRENC4XNUPWT68/cuzIgHFZAJNz6OEnnVdDdjFRSTpXEo/iYSKg11kx3EZw6ugRVQn/c4/mIXvPyowj1QKoz2yoLGsslCdibw1zPQ5hDbdREfzq7/+8ZcpuecVTrP4qmHGtv/fLAiQbqUa53n+/eo=;24:+r1bi4QkFHeze1dA9od013GYhl5kUVs46+wuloCTNXa43bFfROOT9VCPgxhr48LP8Ne3CVqvJr5WG+QC+n855Qct8ounNOqz/kJb0WRCU1s=;7:d0ZsRhtsFLz971ko6065ggYSsfrOty7Q1yI/B/A6/Dig87+kxaSm3OLPBOc6HsqH75gshPv5YfWdWeDXiC7cuBjd1SpLgtL/zYoGV1m3aYVr/PmXT0eIcPDVFmtUyUWNx5+kZ+H2s6ZKOdVBnjwMcXLrd1gAL9jeJs3e9P15FON32UE0Aai7IJIJtm7/+hoKS6TFwrwLMWiYqKnXdIP5insedKfGYD5wLuUBEOqNt9DRFETM5Y7eB1Ai2c5yqk2P
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2831;20:ys8UT2I8yJJwh2Rtzu8gQc9JK4xdAv3LU1LSX3mrT0TYilAzptIBMg8m8cLeVgdxooRtS3hY0442EO8554UE3Hc2psvvPY41B11BWxuK8XXZ5IRUYnDJWO8DMJmHVceX6nkv4F2YXSPSnADGGARjlbeRx9nRovg9dGGvQIf/eVQ=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2018 11:55:06.2177 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b45c687-2ee6-44ea-4a0b-08d573a1ca9b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2831
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

wmi_dev_probe() allocates one byte less than necessary, thus
subsequent sprintf() call writes trailing zero past the end
of the 'buf':

    BUG: KASAN: slab-out-of-bounds in vsnprintf+0xda4/0x1240
    Write of size 1 at addr ffff880423529caf by task kworker/1:1/32

    Call Trace:
     dump_stack+0xb3/0x14d
     print_address_description+0xd7/0x380
     kasan_report+0x166/0x2b0
     vsnprintf+0xda4/0x1240
     sprintf+0x9b/0xd0
     wmi_dev_probe+0x1c3/0x400
     driver_probe_device+0x5d1/0x990
     bus_for_each_drv+0x109/0x190
     __device_attach+0x217/0x360
     bus_probe_device+0x1ad/0x260
     deferred_probe_work_func+0x10f/0x5d0
     process_one_work+0xa8b/0x1dc0
     worker_thread+0x20d/0x17d0
     kthread+0x311/0x3d0
     ret_from_fork+0x3a/0x50

    Allocated by task 32:
     kasan_kmalloc+0xa0/0xd0
     __kmalloc+0x14f/0x3e0
     wmi_dev_probe+0x182/0x400
     driver_probe_device+0x5d1/0x990
     bus_for_each_drv+0x109/0x190
     __device_attach+0x217/0x360
     bus_probe_device+0x1ad/0x260
     deferred_probe_work_func+0x10f/0x5d0
     process_one_work+0xa8b/0x1dc0
     worker_thread+0x20d/0x17d0
     kthread+0x311/0x3d0
     ret_from_fork+0x3a/0x50

Increment allocation size to fix this.

Fixes: 44b6b7661132 ("platform/x86: wmi: create userspace interface for drivers")
Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: <stable@vger.kernel.org>
---
 drivers/platform/x86/wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index daa68acbc900..c0c8945603cb 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -933,7 +933,7 @@ static int wmi_dev_probe(struct device *dev)
 			goto probe_failure;
 		}
 
-		buf = kmalloc(strlen(wdriver->driver.name) + 4, GFP_KERNEL);
+		buf = kmalloc(strlen(wdriver->driver.name) + 5, GFP_KERNEL);
 		if (!buf) {
 			ret = -ENOMEM;
 			goto probe_string_failure;
-- 
2.13.6
