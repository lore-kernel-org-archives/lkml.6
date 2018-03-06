Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1039939-1520361132-2-2908619481487641806
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520361131; b=nKzNdr41KVn2s7O6nh+GY6+JaEYrgK7LA6gjjTMcyRL0pws
    CZaDqGhWQ09OJPIsl+HV9EI7Zw9uYUZtUuNad385XTZbPVvDXn/ZxfgkUG3DT7uU
    MpQZwCJ7MbpumLY+vuNrtEM7QynWF+X9HYcrjCHIJNuaaIwkiGuBvV8FUn5JmZKG
    HcHexq3KTENbTMAqx3OfVfwtL4C3uoh26tlbKFy2Kc7GeSoZipnuVIOwfmg8kisE
    O1PeQJvesHaf3XtYqMaRbg7GbROg4RcsZPjY/7eHKRSf14hRhIcOghBH2r1K91Qq
    lDaQISEP2rfNss+qWZWiUUVnm/mK/M6Pfy70DBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520361131; bh=0
    iW3WsujGbPjdvexayyX/i1FI1XqIMz8bd73bFu+fsg=; b=CK+fsnvx93zRRF4XW
    JNegfeab/ip2j19ywm3XSr1BbLOEKkJhbGftR4QFpP4bFccH4ZaD10HO0rbEcz5l
    Bvs5eVjD8vV7sV0DlAexvTzhdMRTQxiRDflfTJ70+Il6mM5fUkglXW02Y46OHO/E
    OPRwOjre+jJqtQI6ST1aPnKjs1NvGFZTkGVxKBGvqgCrV9mvBg3lx1oxFQQZNASz
    Jp8oC9OUOqW7GxqH5aJUZjgxXAjAc31o9iq4OGby4sjF52w/Hq1RicmLYePC8ICd
    TiT1xx6o0wQ6tNacoQPDfyHZsMxULrBS1qv6j+zZoLOri85uS3UI5oAgdA5qS35E
    2Jd7A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=kbL8Zq3g x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=kbL8Zq3g x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Ruxandra Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 5/5] staging: fsl-mc/dpio: Remove dead code
Thread-Topic: [PATCH 5/5] staging: fsl-mc/dpio: Remove dead code
Thread-Index: AQHTtXK/7j/diRM2fE+1O51KvE+TEqPDhzvw
Date: Tue, 6 Mar 2018 18:32:00 +0000
Message-ID: <HE1PR0402MB2700B47AD54FBA257C64932394D90@HE1PR0402MB2700.eurprd04.prod.outlook.com>
References: <20180306174348.26095-1-ruxandra.radulescu@nxp.com>
 <20180306174348.26095-6-ruxandra.radulescu@nxp.com>
In-Reply-To: <20180306174348.26095-6-ruxandra.radulescu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com;
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; HE1PR0402MB3403;
 7:Eh0X5rHEpLm1TObKjKFWFGbpoMGFSCmCYeZ92bBfvFPqd8sIPdjMBvJDu2j5iAEd5ceq4PTdbnxp2JV4JcIrgtPfIa0ySy2RZSWh5gDfMp3Yusy4M5zdbU0LeIGFzsTJ1VD6vvzRY6Zs1cFmCNYaB1S471xOxvSByVGzwhRJ4/QshD5XAI9EbeVmSM/kvLTLVGyAuGe3WxIqDw79pDeO/jS+BUO3Mjv04XXAl0uKLr7WbKJLAE7ds0RpUMDx+WCl
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI; SCL:-1; SFV:NSPM;
 SFS:(10009020)(376002)(366004)(39860400002)(346002)(39380400002)(396003)(13464003)(199004)(189003)(53936002)(6436002)(6246003)(6916009)(74316002)(186003)(4326008)(86362001)(105586002)(2950100002)(14454004)(99286004)(5660300001)(97736004)(26005)(3280700002)(2906002)(316002)(66066001)(9686003)(7696005)(55016002)(5640700003)(76176011)(54906003)(8676002)(6116002)(1730700003)(68736007)(2900100001)(81166006)(81156014)(3846002)(8936002)(102836004)(53546011)(33656002)(478600001)(6506007)(3660700001)(2501003)(229853002)(5250100002)(305945005)(2351001)(25786009)(106356001)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR0402MB3403;
 H:HE1PR0402MB2700.eurprd04.prod.outlook.com; FPR:; SPF:None; PTR:InfoNoRecords;
 A:1; MX:1; LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3feaab4e-45cb-4670-764e-08d583908cc3
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:HE1PR0402MB3403;
x-ms-traffictypediagnostic: HE1PR0402MB3403:
x-microsoft-antispam-prvs: <HE1PR0402MB340327FE8D9B641C6484CE0D94D90@HE1PR0402MB3403.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(6041288)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);
 SRVR:HE1PR0402MB3403; BCL:0; PCL:0; RULEID:; SRVR:HE1PR0402MB3403;
x-forefront-prvs: 06036BD506
x-microsoft-antispam-message-info: +ZUWIyyb73FL43PkUUWWNkm3Vy1wx6CrXOZAJ4JsLZNWAOzfLiSPffk0IE2SkqwuT5oe6dBJkH4CxRhWdAfAbXaDJp/xw8yx6aXeSDDMHQg1CcdgokeImfiFlsYlm+7XiTvYsmPoqw0EQ3Dj77Y35YYon3Yj6+GdvhzfEH+WGb/w3AtUUY83hqxKt9SbS5/hv8zxqK+jSGDupHnR2b4eSkHaKAweYbOLgNNexUnEbnJ+Tgsiy5dfPCZ3vckaDkzdyhEdIB7Hutyb3pUOPgWFj20NH/DJ5X48AskHcufxjVZ64iqBEnYpyGw/R2ulFwkls5cte+lYbY1fZrMM7B9Chw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3feaab4e-45cb-4670-764e-08d583908cc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2018 18:32:00.1223 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3403
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
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 Roy Pledge <roy.pledge@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> -----Original Message-----
> From: Ruxandra Ioana Ciocoi Radulescu
> Sent: Tuesday, March 6, 2018 7:44 PM
> To: gregkh@linuxfoundation.org
> Cc: devel@driverdev.osuosl.org; linux-kernel@vger.kernel.org; Roy Pledge
> <roy.pledge@nxp.com>; Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Subject: [PATCH 5/5] staging: fsl-mc/dpio: Remove dead code
> 
> Function qbman_pull_desc_set_token() is not used at all, so remove it.
> 
> Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
> ---
>  drivers/staging/fsl-mc/bus/dpio/qbman-portal.c | 5 -----
>  1 file changed, 5 deletions(-)
 
Hi Greg,

Please ignore this patch, I've just noticed you already applied another
patch with the same content a couple of hours ago.

Thanks,
Ioana
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
