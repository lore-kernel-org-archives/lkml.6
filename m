Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09201ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F3521532
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Y79RRmat"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F3521532
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390309AbeIUUqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 16:46:11 -0400
Received: from mail-eopbgr720119.outbound.protection.outlook.com ([40.107.72.119]:31820
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727392AbeIUUqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 16:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fnk7NlYoJH6BS7iJLzqysAkNkqXUKK7hZ5phmbw1wj0=;
 b=Y79RRmat8ywF5yYc120C4hzpYvYvVlRoqRGpoG/YZI0wRvdUWtbIGT+j3kOMhL0xqiDjINcmJOLf/Waunjo4swYnagrPYJCtoadiujFXeZ+ISA7QzdVLu5NAYyDeEi4p1nazBcNAo4J9Oe7ATCVvCFJ4E6r0sxc54ybObyIxrs8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Fri, 21 Sep 2018 14:56:54 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Fri, 21 Sep 2018
 14:56:54 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
CC:     Song Qiang <songqiang1304521@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v6 1/2] iio: proximity: Add driver support for ST's
 VL53L0X ToF ranging sensor.
Thread-Topic: [PATCH v6 1/2] iio: proximity: Add driver support for ST's
 VL53L0X ToF ranging sensor.
Thread-Index: AQHUUErFdRcR/Rbme0KsaP7mPS15JKT42umAgAH7KYA=
Date:   Fri, 21 Sep 2018 14:56:54 +0000
Message-ID: <20180921145651.GS3821@sasha-vm>
References: <20180918082422.13050-1-songqiang1304521@gmail.com>
 <CY4PR21MB07761FEA1CDDC87FBE5568B4FB1C0@CY4PR21MB0776.namprd21.prod.outlook.com>
 <20180920094139.000065fe@huawei.com>
In-Reply-To: <20180920094139.000065fe@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0773;6:UcO04TPUxL5xE2Sx+K84UMhayupoKwYwbLhFg87DHNQcItgLJ2gA+O0m0FjRd8AFc9ZlRO1LcczP2G1YDAgg3SV2HhQFqfhqzwLrtlF9TgevJIZ7dGwJSDfiWwbwfshX8WjWDtV2sk0PbrTeV73lz2IiUdeqrUwPVOJ2g1iiGUfvAscWifjGOrA9vqIgZszHB5LdWI4qdgkNnrwUgxKxxJ0YWyKDMabz47WNvQqReqMStjePRgyfWsSA044rntmLY/+WycK9IekhBAmFAGgMuI03o0KgtpwqNTYPMYtT85vBC5UW0RQWLzM08MotlgAzwN7Nw1Nmq575uMxWMTylmt5yZf4pB64dpBdqtfMLz1wNZCwnGVXwSWwb745HINCPdmpyMjNi6lebxHKHvZi1ks/3ENsuWepnhkQtmnG/nHBH4++hvzEoE6hP2iW6Mupn5iHMRagxzRLk+ut/N1nKOA==;5:dEw3YTfhgaWSOXuyo08aLHdE9pJOiFrmjOjiotTgW5ezwa8SlaWs3exAutAZnaVSXR3N3LDwoG+u/Y+Ggl88510Qium1eS5WY+ANvmuM2XCib6x8lEvOvMXJFFnL65bH8jIp3MJpQQtESoN+DVau2G1sfCtcVQLvDsg+l/h/Z1U=;7:4UfiFQb2AZbq6fldDqbpZJAoMnbTthZwYsOMIrziEjPZpWoZJAuGjRXVYb+bB3odPFHcTV7C8+kf8KL4/qwYsiQwgzI0Xust7aDSdIiuiVTA1RQ7v13bVX8VdJzM+b8KWBdL4t2pfLaimZLrfeTYn+1GMwPDYejLqUpNq+pyhyhJfPs4p/C+BlJSrCGjicExgEPAL7mH1OjSS/k+MhtXFybiZLNU7nzDmdOprElYjsu7ZzsNBPxBAiil0yX/8JiC
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 83497569-a618-4c8c-274c-08d61fd2786e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0773;
x-ms-traffictypediagnostic: CY4PR21MB0773:
x-microsoft-antispam-prvs: <CY4PR21MB07730DADF1B447A0C7D911C1FB120@CY4PR21MB0773.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0773;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0773;
x-forefront-prvs: 0802ADD973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(346002)(39860400002)(136003)(396003)(366004)(189003)(199004)(6346003)(22452003)(33896004)(7736002)(33656002)(76176011)(305945005)(2906002)(72206003)(3846002)(1076002)(6116002)(14454004)(54906003)(97736004)(316002)(99286004)(5660300001)(10290500003)(5250100002)(81156014)(2900100001)(81166006)(478600001)(8936002)(575784001)(86362001)(86612001)(33716001)(229853002)(6486002)(106356001)(68736007)(8676002)(186003)(4326008)(486006)(71190400001)(71200400001)(39060400002)(6916009)(11346002)(476003)(25786009)(6246003)(6436002)(53936002)(105586002)(6512007)(10090500001)(102836004)(66066001)(9686003)(256004)(26005)(6506007)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0773;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: zZX+EeyCX6egOiBq+pNUS+EjhQT0fHkfaX5tG0uvQrtscoAuXlPjlo2V8j8Rc6rqcZsBkT+OjK0ltAQsr9WoCMdd9op8fYOCLf+75xgn8NXmUEKbcZIo1UN4frTncCT9XtFb5OE1sgs1Hc4sswPQaRKgWmzZKHrc8QgYyHriyVglDFvP00wFD8TJSXlFqdPaQryiw8mbBJbIA1zSeZ6cjyIVL6PpWmGziRzl5TLR9pLqXOdRUVTD3bdPB+lKXfxAaqyiflwrYt2u4QfAw1+JtziMJEKE4zePlIbHHB3zLeGg35n3ZCao7q/bAtyqJgVT1zfGlEtb91CiwRQuHC9cZ8/d1lkYliTZlhsNywks6K8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EB11B80F5676D44DBF67ACDD1133AB32@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83497569-a618-4c8c-274c-08d61fd2786e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2018 14:56:54.2332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0773
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 09:41:39AM +0100, Jonathan Cameron wrote:
>On Wed, 19 Sep 2018 18:58:37 +0000
>Sasha Levin <Alexander.Levin@microsoft.com> wrote:
>
>> Hi,
>>
>> [This is an automated email]
>>
>> This commit has been processed because it contains a -stable tag.
>> The stable tag indicates that it's relevant for the following trees: all
>>
>> The bot has tested the following trees: v4.18.8, v4.14.70, v4.9.127, v4.=
4.156, v3.18.122,
>>
>> v4.18.8: Build OK!
>> v4.14.70: Failed to apply! Possible dependencies:
>>     22aac3eb0c46 ("MAINTAINERS: add entry for STM32 I2C driver")
>>
>> v4.9.127: Failed to apply! Possible dependencies:
>>     22aac3eb0c46 ("MAINTAINERS: add entry for STM32 I2C driver")
>>     78f839029e1d ("iio: distance: srf08: add IIO driver for us ranger")
>>
>> v4.4.156: Failed to apply! Possible dependencies:
>>     22aac3eb0c46 ("MAINTAINERS: add entry for STM32 I2C driver")
>>     78f839029e1d ("iio: distance: srf08: add IIO driver for us ranger")
>>
>> v3.18.122: Failed to apply! Possible dependencies:
>>     22aac3eb0c46 ("MAINTAINERS: add entry for STM32 I2C driver")
>>     4193c0f1d863 ("iio: driver for Semtech SX9500 proximity solution")
>>     78f839029e1d ("iio: distance: srf08: add IIO driver for us ranger")
>>
>>
>> Please let us know how to resolve this.
>>
>> --
>> Thanks,
>> Sasha
>Hi Sasha,
>
>This is a false detection.  The stable tag is in the context of the
>additions to MAINTAINERS.   I guess that is a rare enough case it's not
>worth fixing in your scripts, but thought I'd point it out incase you
>want to do so!

Hah, interesting!

I'll get it fixed, thanks!=
