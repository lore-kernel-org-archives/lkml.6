Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A76AC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 00:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F295920989
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 00:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XNbTSSae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F295920989
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbeIXGy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 02:54:59 -0400
Received: from mail-sn1nam02on0094.outbound.protection.outlook.com ([104.47.36.94]:48864
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726837AbeIXGy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 02:54:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPpijXw7kUInJNk+naVle7/zVzYjTH2x7L/RrbIjrNw=;
 b=XNbTSSaeMhI/JsxLew7S1QqYB+kEH9ejOQwwI2FgTrCCBNrTqiNZrvvPBtS9sejiDH277stDuQ9mbEgTnN/RdjvpGcSgiQTstMQUMJuueYeiaC5UCHAIp3CchupJphyFlmJx+u4as1kdCw7hC4nPgl5Nfnv5EkxCSQi5/v3AGXw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0167.namprd21.prod.outlook.com (10.173.192.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 00:55:19 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 00:55:19 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     Vinod <vkoul@kernel.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH AUTOSEL 4.9 30/34] dmaengine: hsu: Support
 dmaengine_terminate_sync()
Thread-Topic: [PATCH AUTOSEL 4.9 30/34] dmaengine: hsu: Support
 dmaengine_terminate_sync()
Thread-Index: AQHUTJRIpph3kYc59ku51ss3QKOG0KT4W3GAgAZN5wA=
Date:   Mon, 24 Sep 2018 00:55:18 +0000
Message-ID: <20180924005514.GU3821@sasha-vm>
References: <20180915013422.180023-1-alexander.levin@microsoft.com>
 <20180915013422.180023-30-alexander.levin@microsoft.com>
 <20180920003851.GA2350@vkoul-mobl>
In-Reply-To: <20180920003851.GA2350@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0167;6:5mwD8i8sGPeFRSxgbt3au1AoBNzWZEuK8N5L6VUE5QDiMmR5+InrttbZ8kNgHeXnNy4k/hFwC57o1QKT24tDDEI+s/cyi3L1PBjSHluk8QIMPEl80AeB0hvAL6q4PlFuyFpu03OwsE6LCvcLACjPqOrknC3PKmQXRSSF5JJ7T6Lah6JfHLKYZ9eNvcDH6rZ1SUqucL4HO/nhcaT9q/TM6+LhykM2PZQ9vsLRu3ruermWXjZmVKe/FTydDMGbHu8P4TRYA/JCJ/afkNgRgyf/3NCLAK/0SpIdzZ37lm8gAt7nfnE+ANU+geKs6doRop5Vbet0qPyz0JJhhR6/bN3CtJv7CBVdWKcb3u2jWvee0RL1nFt3hynroqK01E8pojxtSPQov6TrOn8zQhZiGPS3WA2XV7Hy1KtmwVnqT+2Y7pW9WBc+Hkl/iwk4Ul411J6c18uizxqCRhuNT1jtnWq7Mw==;5:NAits20gG0LWqGOMAhDVEwv1i3UJMvOW9AJeQuNq7zJ2KnZI/jAdD7T+mU/6P8BntqqmDZR/Osfr+m97S4NOX39BKodcWGj/EhxPhsurXO9ggMoxP+TV3j8kNlV2zzaaXreZHFXeQl/2rfLFXE2Hd0eW+YgyENPF/vTNm8IxRPA=;7:GLRS7sp076L3gvE6KQx/3lZLbZmp2GQSHdauZKya+730T7blIPC1iQsqRpDSEqVEiB7F71M1Up7Qs+Z6zt8T3HCuEsNe2G/ESl7XlM5ibIZPlFdriDo/WFGqa4W3AfZ7YeLdJYctyMSK4TsF0c8sEJXYIhZ9WZGUhEwdqPTwNSxSSnQx5D7YccMiiMYdL9Yco0Rd1DRlOAykAfaK8WJ7CKsIv02kDtWQpv6zIvr+eK2kAqxLbm96gW3WLQppMpEY
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 85fa4da4-c38c-4262-2ef3-08d621b86642
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0167;
x-ms-traffictypediagnostic: CY4PR21MB0167:
x-microsoft-antispam-prvs: <CY4PR21MB0167FD82A59AE8F914736018FB170@CY4PR21MB0167.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(20558992708506)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149054)(150027)(6041310)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0167;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0167;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(366004)(396003)(39860400002)(376002)(346002)(189003)(199004)(106356001)(105586002)(6246003)(99286004)(6116002)(2900100001)(33656002)(3846002)(7736002)(305945005)(1076002)(2906002)(4326008)(54906003)(102836004)(6346003)(10090500001)(6916009)(186003)(66066001)(6436002)(26005)(22452003)(53936002)(33716001)(5660300001)(316002)(6512007)(9686003)(76176011)(229853002)(33896004)(486006)(446003)(11346002)(476003)(68736007)(6486002)(6506007)(71200400001)(71190400001)(97736004)(217873002)(14454004)(25786009)(81166006)(10290500003)(5250100002)(8936002)(8676002)(81156014)(72206003)(86362001)(86612001)(478600001)(14444005)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0167;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 1bu9bxRyixN72uC0G+47v/+33HW4xo1N4kCed4c6zJDKRY1medg2J2JOC18LaB5z52t80APEqreL6GM3ahGhgH8R7iKWFErnZhyteQu0chVsFpqKrOKGAQR6JXDleO0k+sZQS3VDak/R87rKXlFAqSvqERtcNRBTWZDfAxvUuS5qB+MrvxRLYn6aKxsFFROQygwp/DLK4IxWT9iV7HeUBPfifLFX3XWsqy4jZvG4pqF7WX52gmhXw1ZcCE8fIDBHPigqTqey9BYQSxjn92SKELEo3vDdQf2zZgfobN5HnStx6Q2DY2UEj+LVkjrTHPmRw47a/C6F1bCNeIFxWUSVqavmF05wI9dNDYoIOlFArUI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2282951F1B829545A91E8405DB2010CC@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85fa4da4-c38c-4262-2ef3-08d621b86642
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 00:55:19.1785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 05:38:51PM -0700, Vinod wrote:
>On 15-09-18, 01:34, Sasha Levin wrote:
>> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>
>> [ Upstream commit 2abc66cd499aa16876e45c6438788902f7d1ce22 ]
>>
>> It appears that the driver misses the support of dmaengine_terminate_syn=
c().
>> Since many of callers expects this behaviour implement the new
>> device_synchronize() callback to allow proper synchronization when stopp=
ing
>> a channel.
>
>This adds missing support for an optional call, but I am not aware of
>any reports of breakage due to missing this patch. Do you want to carry
>this for stable?

I guess that using the word "expect" in the commit log suggested to me
that this wasn't optional.

I'll drop it, thanks!=
