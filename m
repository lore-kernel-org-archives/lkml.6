Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751278AbeCIHYX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 02:24:23 -0500
Received: from mail-pu1apc01on0093.outbound.protection.outlook.com ([104.47.126.93]:2512
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750913AbeCIHYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 02:24:20 -0500
From: Tianyu Lan <Tianyu.Lan@microsoft.com>
To: "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM/X86: Check input sreg values before loading vcpu
Thread-Topic: [PATCH] KVM/X86: Check input sreg values before loading vcpu
Thread-Index: AQHTr5hN8NOqe9GuWkWmcSxT1Wc7aaPGkjEAgAD91QA=
Date: Fri, 9 Mar 2018 07:24:13 +0000
Message-ID: <72e27449-c8fd-c3e3-75c1-07853c49d974@microsoft.com>
References: <1519714664-2649-1-git-send-email-Tianyu.Lan@microsoft.com>
 <20180308161536.GH12290@flask>
In-Reply-To: <20180308161536.GH12290@flask>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2P15301MB0067;7:JcPy7dC9fsBWQFxAr1eApytrLZBXm/77bB6QvAkkc+NjrDxDPNQ7REBf4QIx9ET1gW1joyOUwtEFfAIpMA0yu2RElg1K8g6aefbeiEEsfb5RPR1Xkg2325gdR1ZvYzl2YcEUGYh1eJjbPJ9E230Ds6vDR6bVZ0pgiKJUrdR2quyeOUm8J3NhydVagaFzdgOEVnWcw4AuTrYoKT1sE1Z9acjYz0eP7qr00iYeONjVgimneCdQGx1cU1jGfkfidkof;20:yQ9q8aaoLdh/2qH/FXh7CA+hqaCxK88IJP3msP2dmygbkFeKoJyOoruFSlmI7D2VFMVi0vwaWKjBJN8Uy7Z0ZYLaW9+IDlJXVDak1avV9+Lwe4Xlz9HG2TcHn43teCDv4wANMyxOEqZwcM3Rf+8cXSeL+8Yv1Zsmfs7SRjBqkYY=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e20f74b4-cb3d-48b8-75af-08d5858ec28d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:HK2P15301MB0067;
x-ms-traffictypediagnostic: HK2P15301MB0067:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com;
x-microsoft-antispam-prvs: <HK2P15301MB006784CA5990F6111980E7DE92DE0@HK2P15301MB0067.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:HK2P15301MB0067;BCL:0;PCL:0;RULEID:;SRVR:HK2P15301MB0067;
x-forefront-prvs: 0606BBEB39
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(396003)(366004)(39860400002)(346002)(51444003)(377424004)(189003)(199004)(10290500003)(10090500001)(4326008)(6246003)(72206003)(86362001)(25786009)(8676002)(53936002)(2900100001)(5250100002)(66066001)(1511001)(8936002)(81166006)(14454004)(6512007)(6436002)(106356001)(6486002)(2501003)(81156014)(305945005)(7736002)(5660300001)(99286004)(186003)(229853002)(36756003)(3660700001)(2906002)(86612001)(26005)(3280700002)(31696002)(6116002)(31686004)(102836004)(2950100002)(53546011)(6506007)(22452003)(478600001)(105586002)(59450400001)(54906003)(110136005)(3846002)(68736007)(76176011)(316002)(97736004)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2P15301MB0067;H:HK2P15301MB0065.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: rH6JweNQESsm3iRNBdXirV/eRlJ8z3I63TbsG+f/BCBMCEp573/9ixI8HDtxhm72xieBGKdD8c7CcyCnZi4nBA7TS7Y3pJtrfARvywQRvbZ7VyHIk8Qazgrp1OAQwumUKO3YJS9UeiEANwlqIUS3NJB30wKW1uJR+55YCVI6Bjq7dbHFxTWPFUlV9nBS5UZXAeWZxwXz3YshqE+zdPJzBoo2JAXDbL1f6wDCEy8VczwKAn+e9NWGoXxIaAO7gZmlP8zHAelOmdVdn6HLP4CRejkDdpDXcBf0XALhCkjilxd3zLinVXlp04Ipeohj+5NQEaqepWWk/HXnUN3s3nGyVA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <15C17D9F4D676149AD6C554F1486B608@APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e20f74b4-cb3d-48b8-75af-08d5858ec28d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2018 07:24:13.4162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2P15301MB0067
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w297OTXC013960

Hi Radim:
	Thanks for your review.

On 3/9/2018 12:15 AM, rkrcmar@redhat.com wrote:
> 2018-02-27 06:57+0000, Tianyu Lan:
>> From: Lan Tianyu <Tianyu.Lan@microsoft.com>
>>
>> This patch is to check sreg value first and then load vcpu in order
>> to avoid redundant loading/putting vcpu.
>>
>> Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
>> ---
> 
> Patch "KVM: x86: KVM_CAP_SYNC_REGS" made significant changes to the
> sregs setter, so the patch cannot be applied in current form.
> 
> I think that moving the X86_CR4_OSXSAVE check to guest_cpuid_has still
> makes sense, but avoiding the vcpu_load/put would produce worse code
> elsewhere and avoiding the load/put is not critical as any error is
> probably going to be the end for this VM.
> 

OK. I will update patch.
