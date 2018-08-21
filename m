Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982E0C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36BD1214C4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2IbFStpi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36BD1214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbeHUUMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:12:54 -0400
Received: from mail-co1nam03on0066.outbound.protection.outlook.com ([104.47.40.66]:11680
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726851AbeHUUMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnm/MsxxNkfswXYWU4fm4/rQVeqmz26SM4bacg13LSE=;
 b=2IbFStpirJzLY64jaoTeQL9KkuXk4eqixKH0xxyWW0/gf8IIT18+U+LhfOt5+ROjwZtHqhqOGeEZOLoN6vsHOzpY6sL1+/8AYIOU/WULA/z9hfPHIoQu7vC37L0vOZZ6mNRHfQRTeoYY2n4WRykrbXosNc4EU9f0qUPbC96nEhk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
Received: from [10.236.64.67] (165.204.78.1) by
 BY2PR12MB0163.namprd12.prod.outlook.com (2a01:111:e400:585a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.13; Tue, 21 Aug
 2018 16:47:49 +0000
Subject: Re: disabling psp in bios causes errors in dmesg
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     Thomas Backlund <tmb@mageia.org>, linux-crypto@vger.kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        gary.hook@amd.com, Brijesh Singh <brijesh.singh@amd.com>
References: <3be85fc6-6323-b368-747f-b7650b3898b4@mageia.org>
 <1e514ed4-a2e1-32ec-4ec8-64134b2fdb9e@amd.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thomas.lendacky@amd.com; prefer-encrypt=mutual; keydata=
 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
 zSNqP+QUNp6BotWI
Message-ID: <e0fb68e3-e98f-4f58-6f91-c570e8e6fdf2@amd.com>
Date:   Tue, 21 Aug 2018 11:47:38 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1e514ed4-a2e1-32ec-4ec8-64134b2fdb9e@amd.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: CO1PR15CA0101.namprd15.prod.outlook.com
 (2603:10b6:101:21::21) To BY2PR12MB0163.namprd12.prod.outlook.com
 (2a01:111:e400:585a::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b1a0faf-2cab-467b-f0ed-08d60785d4e1
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BY2PR12MB0163;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0163;3:Dch33HGK9STMh736Tx8VtygGwzWCXKXvTfqLsJsGglI3tVc0ZR+dCIrJu5o8UMfwgjrXDBxoiTEC10Ijn5DxT+tNU6L3HCZ83Dn29LKRzrBINJPwoN1+AliWwCG0arzQyKq1bS9V6WEGD4AnvNqjvUe+i+ClIQ2uALM0NT1ifYszyqSmoRAlbcrIN6HvBbIMkRierL7AVrmm+MQqhrXPz3AXbAC+KhS+nRNy0j/x2j3f4CzZhVuRCK9BchAznPnV;25:bgEutv4F0NfDcqIUx13RIb+2IG2tLpqboIha6dXR1n8XJpSrYmVHiUcwk360Db+wt7oOO4yCiJKU7nmRFEZCkYq4LM7sfATJD2XZfSYFbmSKyGNP90XSiiDOHmnN0CLsxxwSUO9yu842EVlNHRX9h6HP8XT+Q0kp0hFBpJnTCLMIdemycbOVZQjES5ZefzxCkSIFbnjwrEX1nAnUyyGkLqGNlqA3MswdJJBM3iVJp0Ywn1i0zW9/qY7rSNColiOjihzMIvNea3Byo5sp8M4cYrYv8BWjbiWdmdlOodd2CWuCd/dX1lNoTir2+NP0tI/g/1lOh5LcoaghBwmYV/25LA==;31:TfQwSWQzLOPAaDWuUG5ecAxgr3p5OVMbI3SewQJm/I/uHNaXZtVBnI18FRAFNVFexITTHeiumQhT05G+7V/GizQ/fjaMRlpBl54lezSsUZw6lMk598ZX02uyfb7xX20h+Ms6gAlUPKWbYH9SrWAUlkvfzC4oMxi0wrkfgEmZyFisvTKEaSt2zSR5zA45kAVeFOOR8Dc62IssylfoG4lLtthowGJ0GwGX168ha8Im0zI=
X-MS-TrafficTypeDiagnostic: BY2PR12MB0163:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0163;20:gn5xX8lPVEFgV+WUNEgs6Ee5EUXGzeHOSb9x9+BU5K0SFU4sAvahkueLmdWz2nRSmU06rxDGdN0/tXhg3jLs3q0+QZTbrnTq6IEeweJdmmK1vm5qkQG1/b05JhkXehcPLUwVvgH7cjOD9/AO+s2bhnrJdVvKoWdOkbJ/Pz/skmpkVdXSBhhFQSlAfbAAscP/EcfwtQNf+8xf7ZvW4s0dPw7mWUN0t0njh8wSJw9aoLMJE4pp3LWxMJP2fPJeCK2FHW/4qTbqZKGlOXp5mGUJxy+2xDX2vA5rW8xTQI7/DR+OsbOM0I/uCYjh1q+oDPbQwyc45arGbAnLWL+N1jN1ffypnFVSHsScmGsjcXUsqL/o/xWr7OjcinBRXzv3J5BT9Rups3PSqrR9BftTrEQphi3OZjZnYzwDoT542sAIaNMvEHCcphW3mACvhifk8t1mRYNF+x45V3GqB8MlHMU7FFpPYsaWIrwd+jo2AvwisLlPhqABr0PtJxsRZFcPTdGG;4:lbDfHQTJp+aV8r8LwQfufdcfIi3SFV9Xi6k3IJB7Cs1TG8wP+rZ4BPPORklydRRP0zvRJrmGcpWUl58YR3aCmj6n3G3XhRjeLxpyQhwlGm91s1dnCsoktVkJI5mOj4Ir3gzP1ps85OJz/NtpQSWVB8+2xoT/PBM55POkrkE68FfV8pGD+LR3wt99Vz95gd0ZM+MpfHhGnUVs3N5RTkI+4YjVEeFTeyhsIiCA3yyRimssuS2usLdqZecLCwAlJ3D2DJ3a7AEFS4flfDqMrAaSEw==
X-Microsoft-Antispam-PRVS: <BY2PR12MB016374E9260541D0C4BFBE75EC310@BY2PR12MB0163.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:BY2PR12MB0163;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0163;
X-Forefront-PRVS: 0771670921
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(39860400002)(136003)(346002)(376002)(366004)(199004)(189003)(55674003)(54906003)(23746002)(31686004)(16576012)(50466002)(316002)(6246003)(5660300001)(58126008)(2906002)(76176011)(52116002)(2870700001)(6486002)(53936002)(6306002)(229853002)(3846002)(6116002)(72206003)(66066001)(966005)(106356001)(65956001)(47776003)(65806001)(478600001)(25786009)(97736004)(476003)(3260700006)(105586002)(2616005)(64126003)(956004)(11346002)(446003)(8676002)(7736002)(65826007)(86362001)(6666003)(305945005)(36756003)(14444005)(81156014)(4326008)(486006)(386003)(68736007)(31696002)(8936002)(81166006)(26005)(77096007)(16526019)(53546011)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0163;H:[10.236.64.67];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;BY2PR12MB0163;23:h6ZCY3BUux+lZPXT8alf7mC8w6fuUPxX6wVK5?=
 =?Windows-1252?Q?f1GztdTlg7ySBsLEawCp840x1r8Pt9NbbtPTnz7BaJAWWQWMl+zfZD/w?=
 =?Windows-1252?Q?Xt30QOeCVwFlHnP7yw7ObWWEpem172d/sU6K3ALEFA0HzIiuhEVjjIEK?=
 =?Windows-1252?Q?CrJjqdx5jlsVH0tdpeCnpQLP/cLq5sgzmiPSzUL1uEpGB/lYb8Y4kDBD?=
 =?Windows-1252?Q?Pcs1y5f7RHSrwJc/ajngpESe+ptUvuhGvgtMr95HIMqyQGNsjeBHkHL4?=
 =?Windows-1252?Q?aOBhKt2HZEffD1nCejDV4xj/UKiAKg9rR4bSCET3oq6N7kPKTEVHWQTv?=
 =?Windows-1252?Q?vdmCbwelreG6kPqNJ7PA/sImHsczC5h4XjKXVgW/iCYnmxxKkwUYewBH?=
 =?Windows-1252?Q?efhRfumJD+j3Esb4qZe5Kh34kug5RoWkUf3lmi9BkzWFagM50dg70Ot7?=
 =?Windows-1252?Q?Ijlk33SYfI0AvSgsIDgs+PQpXUEKbQicxWg9HDGq//XLTBoY7C06uSmG?=
 =?Windows-1252?Q?D0SGUuX55mrd1qQNbA8W94lK/mJLrqiiYdQ8pVnaXyGdQK94i0H4pQE4?=
 =?Windows-1252?Q?NnTRNpbH4VB+26nTpeLxjVVP5e0hfn0Fb8ySi1IU/3H13QUn8uA7KOAF?=
 =?Windows-1252?Q?zbKaVgElprx3d38oBTnapzN1NWoVKuGUx+2RSSn33/3z1l/bpWRohd91?=
 =?Windows-1252?Q?X0pYiDJ8c9vNsHyZpTZYWsgAzDtO+Iu3seftF/ohQf329j5hFQAyfIkq?=
 =?Windows-1252?Q?fl0VL9fbNheA7tBCNV0TeEqo7jbH2QePKJbAM9lknd51yz7OsE6Tc+OQ?=
 =?Windows-1252?Q?1smOzyCO/znrTBVbFXN+r7/dSNU2GFyEIkmRZ/NnGWMi4yjlzkxaMbXy?=
 =?Windows-1252?Q?GgXVEGEK/ii3aUsb4F+lhoE2dTr9zbZqENZFGILh93KhzdFze2nDN085?=
 =?Windows-1252?Q?KbKRDc1f/J/H6FLw619/SP2K1zSTGh5wWWOcyc6pwdUdtuefZKI/WNXS?=
 =?Windows-1252?Q?XLghsbTW3Y3Kb6+Byf8CkV2GQ5vRj2kj96owiAU6URGqK+PaIvxt0vEb?=
 =?Windows-1252?Q?8ENZSG6SfX9N2fqo1wE86t6094/h3lT+OIOfw/QHo9kBkYklKCXJMpOE?=
 =?Windows-1252?Q?TWHVZDt8T+8P56NkJBnkURYfWDF3km/4QtiJLwoeW/ODGwzcAck37ulV?=
 =?Windows-1252?Q?RIv7AgPaYcE1B9p+pSkFy7a+AEKd8JHeRR96eUX5CgAh2MI9RyLIqgdh?=
 =?Windows-1252?Q?Nm61ZpZZAHwqpvFDuSZZ78cMLfp//6lB2+UKnIkoY6vdULcBW1LBacZ4?=
 =?Windows-1252?Q?MBbNuWYaamW2wwFiXpLmuMZp7g4W4ZZBm+geIga6GgPShvvX5+LVLWL1?=
 =?Windows-1252?Q?zz/I9SqzKElchpy7vDOGnNa+upoSVSbPJzvwy6tXd3P24bUnKHziXXsJ?=
 =?Windows-1252?Q?54V9Q0osmFuNPbpQbHJSc8b9eCzTF4CDb917kagQZfogpJmA1DqhXp0t?=
 =?Windows-1252?Q?jcM3lYjRhTVTwAzZAFPUeT+G4rR9N+TQmZD/Zbq8XUxCZpodGDF1Kk+U?=
 =?Windows-1252?Q?FboIsQpiDVbOFsfSGbYVDm5zvBAeN14o+3PE68MwonpfrlgFWqnCchtl?=
 =?Windows-1252?Q?XoNwxPWE6WPLK+ejyi5C4o=3D?=
X-Microsoft-Antispam-Message-Info: RXJCBcwitUiU8FteNOtLDJ3qm2hQKyOcycHngnoZDempURrnxrDBk2jcOb5tLCBk7MiK8nGkj42inY/VK87p4Ev3N0OC/YvMGaLHKZ68oPw6uSJACjdOV8opJVLfOlZ1yZtPTOEdu+r3u7fifYJHI2G1Jcu0RcC4theSKlEBZRnzxorUptGm8tSMNp5Rr/tp87ylpKvrUzre+vnxK+YibQmLgc2rPlf2JOXddrhqirlSMvHvh4O1F9yUEB2q1avMMXBLj5Gt5TRSIyYpw4pL5APDepT8Azsuzw82ZjIv0dGa7vcAKestMUUfKjD8YV5kukDkLZlHAaxMO1rfYj945EDNAn/UCgKLflDWJDo6Vsw=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0163;6:qTrcKepN8Y0plUVGIjmwVrwVtaiE3+2ADe8mi6NVcqNE6wZqwyWiFJ5Frly9atWGuxrDkiegKXwjd41RAYbhyeguQ3f9Cg17XjwpaTHXOfYF3LhF17gY1aaXPzdJ02EwR6OUDTcE4PHSKC6O8yF6kbLcXfgnyQn4K3nva58bLHpwDQuRxOCo/CWKd5opjNYVAHt+m4d/SVU9ZD101IszuZoVt1nsGZigerBw4N+wVaRMDsDSzBdIKouTE391/ZXVEKnEA7rduemcX+Vyq/94wfTr1zn7dyEHL5qDJb9nmVX0muIdbop3CD7iIywyYRARnt6325/WI4kssDB1tB664lcD/l9+X4Sg2YjPP1W3r0NplOb2NIw3MqMNS6U+nvuM0vk7M0m/a4Gq8AfiWSAKLHkJsd1s0RDvmyJxeEV4ZjVObp52lLZqFryf9dGem1nxW9iE66sWEqiXrg5gcUEDwg==;5:0E4NL/z3X1rfC8eeSMJcJE0tpiUKIF+sdQ1bac+RH+XwQAEqjxA4urzSWDs/QWpj6Drz+hx7Rg4xd/gVfAKsuGBywuU9I60fQQUcZ3TU8zqkMqRc4V0Op4NycM4gP2NNuJqUDFH78xkljYsiOddzlk4VzPjm8SAtf7KwNYVXzf8=;7:Ec+tNFpwrMrWCqxC01wy1DOrQEG9iUou0ldzAQloOifSemRS8xVEbZRnGdVQjRmbMYpUABm9XMBztWAvtaUD0746czOd90Va/+0dcW7uwBeavros9OqGoE9cloN31WC1hvmyPk+LyBeY+VqdJLqDZWMzcQQe79rssE3wK1L62VvnCdyjJQNYlFTb4BOSn7TYP3CwE5UqSgGP7DrC8Y780unzLaG7tcHUQiuQ6n0vvpE2HZFa7RV186g8GjMgtXE4
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0163;20:Ib74DaUClnwHSh6ZChSQSJGjUrkKChkzJ1nDJrLTbvqlz2fqb4M7Ac3gKoGbq57a1wyFXPyFccFWwfnBspjBGfsmB+oFwiVjp2uqeFRdjJkzkRnQebhDsJ96n8u552LFXG+p94SuOLbRicM6DLzIB96wmmMdmLO6zfy6jLMFjxeqh4AOEcktacCLW9jVnBSAWt1v6yeqLLnDVWGGwhS/H71kwtKHKy4EJTT504Lb/5bRRcamQBQs5y84trQRmrIr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2018 16:47:49.6406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b1a0faf-2cab-467b-f0ed-08d60785d4e1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/2018 9:11 AM, Tom Lendacky wrote:
> On 8/10/2018 2:03 AM, Thomas Backlund wrote:
>> Hi,
>>
>> this is tested on kernel 4.17.14
>>
>> hw:
>>
>> MSI X399 GAMING PRO CARBON AC (MS-7B09) bios 1.A0
>>
>> AMD Ryzen Threadripper 1950X
>>
>>
>> Disabling psp in bios gets this in the logs:
> 
> Hmm, I'm not familiar with that BIOS option so I'm not exactly sure what
> it is doing under the covers.  Having said that, it would seem that a
> register read is indicating that SEV is supported when it is not on this
> platform.  Maybe the register read is returning all 1s, (i.e. 0xffffffff).

The register read was returning all 1s.  The issue was reported to the
BIOS team and a fix is in process, but that may take some time to move
through all the vendors.  So in the meantime, see the next comment below.

> 
> You can work around this by blacklisting the ccp driver module for now.
> In the mean time, we'll try to understand what is occurring here and
> provide a fix if we can.

A patch has been submitted which adds a command timeout and should also
resolve this issue.  Please see:
  https://marc.info/?l=linux-crypto-vger&m=153436754612783&w=2

This patch is not yet accepted and needs adjusting when being applied to
an older kernel (4.16 - 4.18).  Once accepted, versions of the patch will
be submitted to stable.

Thanks,
Tom

> 
> Thanks,
> Tom
> 
>>
>>
>> [  246.748978] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
>> this message.
>> [  246.748978] systemd-udevd   D    0   724    716 0x80000124
>> [  246.748980] Call Trace:
>> [  246.748986]  ? __schedule+0x234/0x840
>> [  246.748988]  schedule+0x28/0x80
>> [  246.748993]  __sev_do_cmd_locked+0x1f0/0x270 [ccp]
>> [  246.748996]  ? wait_woken+0x80/0x80
>> [  246.748997]  ? 0xffffffffc0683000
>> [  246.749001]  __sev_platform_init_locked+0x2f/0x80 [ccp]
>> [  246.749001]  ? mutex_lock+0xe/0x30
>> [  246.749004]  sev_platform_init+0x1d/0x30 [ccp]
>> [  246.749007]  psp_pci_init+0x40/0xe0 [ccp]
>> [  246.749008]  ? 0xffffffffc0683000
>> [  246.749011]  sp_mod_init+0x16/0x1000 [ccp]
>> [  246.749012]  do_one_initcall+0x46/0x1c3
>> [  246.749014]  ? _cond_resched+0x15/0x30
>> [  246.749017]  ? kmem_cache_alloc_trace+0x3a/0x170
>> [  246.749019]  do_init_module+0x5a/0x210
>> [  246.749020]  load_module+0x215b/0x2530
>> [  246.749021]  ? kmem_cache_alloc_node_trace+0x45/0x190
>> [  246.749024]  ? vmap_page_range_noflush+0x24d/0x320
>> [  246.749026]  ? __do_sys_init_module+0x136/0x180
>> [  246.749026]  ? _cond_resched+0x15/0x30
>> [  246.749027]  __do_sys_init_module+0x136/0x180
>> [  246.749029]  do_syscall_64+0x55/0x100
>> [  246.749031]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> [  246.749032] RIP: 0033:0x7ffb1a09018a
>> [  246.749033] RSP: 002b:00007ffe196680c8 EFLAGS: 00000246 ORIG_RAX:
>> 00000000000000af
>> [  246.749034] RAX: ffffffffffffffda RBX: 00005562bb20d080 RCX:
>> 00007ffb1a09018a
>> [  246.749034] RDX: 00007ffb1994e6f8 RSI: 0000000000029e50 RDI:
>> 00005562bba5e710
>> [  246.749035] RBP: 00007ffb1994e6f8 R08: 0000000000000004 R09:
>> 0000000000000000
>> [  246.749035] R10: 0000000000000005 R11: 0000000000000246 R12:
>> 00005562bba5e710
>> [  246.749036] R13: 0000000000020000 R14: 00005562bb1fde70 R15:
>> 00005562bb20d080
>>
>>
>> Should it not detect that its disabled and bail out ?
>>
>> -- 
>>
>> Thomas
>>
>>
