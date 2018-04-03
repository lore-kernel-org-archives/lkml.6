Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-376387-1522725579-2-3213042734195018696
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522725579; b=BrJLG+8rIoCfXnH3kIdV7SbMfbmEtaBJMv29MSmxKGVxvKJODf
    YxNTJJ8HhbUbXC5NWEHp4eGaxew4N9dSp2cwnddSA18wIXJX2Mt6QtldggpucgQ2
    I5/bx4WWRq5QXf+8SCx2T+h0tNHCd3df5CNRajtzcZ7ayiFQ3lZDWtHwpy63Bka2
    sCx206h/8PI+gp2IPy2NHh4bUNiIezdZ4Xm6GHLdKNJxS2RUW9Ob93JfNERJYf1X
    biBZhjOXydSf0/OgbVexTj6AXcuuDr1HWJ6anFXhUiVvv0IhKjGnJbbrq88ASQ01
    cd2PT+/5EMjEfLnfHU8KY+oXoaLxxq1W3loQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1522725579; bh=IkZsyCM4Wx1S495zx+80gZPXvibLG/PaioZkGGXoQwU=; b=
    Bds1Npu+XA3hYIKCwnqutocESSOctYbgLzRDyMtYOWicoKGB9aGooVEOCNcKZ0mi
    6HdS03+FI//BoySAPlnxf+Df3ApLbayn670pmCcEzua6jSOHAb4ABlHRFD0Ny75y
    U9nU06YTlMh/5IJpooswKfOGabEfTqIvmdzGYJQ/e8w4EcpfEMTMrAZzxoMthV76
    cyop5jPoTCFLqbmQr/gRXz/NLYDfD5gKJz6CrSUzIj6jLEWJbnl5eubJn0DUs8L7
    No+jVZPXyS620robwMcLs+csNmZkX1CGxv57qpATEYget19RDguxbUm9e8so6NLf
    l5qJFs3gzTm8vG5Nkcb+qg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EAWg17IG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EAWg17IG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAQfc7w4AZb5L2EbUVtXhPS5wxunABA7P9/BxaillmbHRt+uq3dv6jMU2teqEmdGGNL4UOzGrps84n7vxZ+VnX38A262FGRHZ48AsflIMsKLzVuiqyss
    tJvKNGfM47eQfkUvl4jMUPfYfqn1+tuqEQf/S5StGb/6bw9yrT8vHQIFyNEbDHseJJ9SBUGHdAKhu6Q5dIe7rMuh+PPcYbJApgbUO8P+hsspgyr7gU4btQuF
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=iLNU1ar6AAAA:8 a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8
    a=QyXUC8HyAAAA:8 a=UqCG9HQmAAAA:8 a=NEAV23lmAAAA:8 a=GrmH1iKyaitNw4wqGAYA:9
    a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751538AbeDCDTg (ORCPT <rfc822;greg@kroah.com>);
        Mon, 2 Apr 2018 23:19:36 -0400
Received: from mail-sn1nam02on0098.outbound.protection.outlook.com ([104.47.36.98]:61793
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750905AbeDCDTf (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 2 Apr 2018 23:19:35 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "Mario.Limonciello@dell.com" <Mario.Limonciello@dell.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "robert.moore@intel.com" <robert.moore@intel.com>,
        "erik.schmauss@intel.com" <erik.schmauss@intel.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH AUTOSEL for 4.15 050/124] ACPICA: Recognize the Windows 10
 version 1607 and 1703 OSI strings
Thread-Topic: [PATCH AUTOSEL for 4.15 050/124] ACPICA: Recognize the Windows
 10 version 1607 and 1703 OSI strings
Thread-Index: AQHTv5mjS5s9T/qcp0eNCtacHINC9KPiRbIAgAwwPgA=
Date: Tue, 3 Apr 2018 03:19:28 +0000
Message-ID: <20180403031926.GI7561@sasha-vm>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
 <20180319154645.11350-50-alexander.levin@microsoft.com>
 <9e47cad5d0144285864141c298e8c27c@ausx13mpc120.AMER.DELL.COM>
In-Reply-To: <9e47cad5d0144285864141c298e8c27c@ausx13mpc120.AMER.DELL.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:RJIzmFiSOtdn2FDYuux2FmGUqiEYWhaO1m4PhgztfzMNjGv8e8fQLHlhALL1dggeE40qd/v72XvkHDnbNZTGKAaHRc6UOGs0CxHmomNqFGci8slka3Wr48xb5hcjp/cc0td9UU5oM22TjKnAPKzXRXJvjpfNQHnYefMmbHXyPCNDVmdcrP03wY4AfLS17fY8OLkNnejnd3y/LcfJpkVFFv15kRnH4tSJTpAKsmfdBozcbPTZSwu6YFqilyrXt5rG;20:06ZBbArhoUysPh6Y8bj/6WqZW3ukb+kI4t0iPYNHhET+AzlJaj8gkfPw6agcYF8GKKtvHJjnaIOrkEZiNfQ+2e+VavkcYqGG9UBkn649zxeQngWn5MvMX1Uv9MGvaAUsNrrL0bh6mps7ISd77sl8cEMij7Vq6l85eJ28JaZxMhE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9f01613e-49ad-461a-c118-08d59911b59d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1032CD031DA6C4ACD6310569FBA50@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171)(9452136761055)(189930954265078)(219752817060721)(56004941905204)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 0631F0BC3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(13464003)(189003)(199004)(2351001)(25786009)(76176011)(86362001)(575784001)(53546011)(59450400001)(6506007)(33896004)(102836004)(22452003)(6246003)(4326008)(486005)(229853002)(53936002)(6436002)(11346002)(446003)(5640700003)(476003)(486005)(6486002)(14454004)(10290500003)(106356001)(966005)(66066001)(478600001)(316002)(8666007)(6512007)(9686003)(5660300001)(72206003)(6306002)(305945005)(6916009)(33656002)(105586002)(2900100001)(3660700001)(8676002)(81156014)(81166006)(8936002)(97736004)(6116002)(3846002)(54906003)(86612001)(68736007)(33716001)(26005)(10090500001)(186003)(1076002)(7736002)(2501003)(5250100002)(99286004)(2906002)(3280700002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Alw9VdpS/qCBo4en4fLsmN8oPDdOo7bSXzDBtrhk4HeHbWthkP8YkDDeYa2u2aJMcGAgPuZf7/gJGh8zriityb6xvCoQ2QNuNGFRRtiYx/6MHzHRG44KdfVwXLAtrSuKfvJKENdEsgJKRahzPV+HwrjrYo0RkmADSjO2SeWIpZcVSJq7BwsbNqGEi6MERtkqCCenhcRqdBC+hksokPurMwncpt/9uK0wYGxn22fsz1fSZJvXO6PhnpNZhPSf4jQfZyUYJllK5Kw5WwCai1dfQBOwKBfloFshYh9xNHKAAw3tzlbaWSqEybqYpG69IOv6tdkooboDXkNJljMrwgdQu65c4p5mt8FqGzHsKGOQxoJ5N37MOcgGzVH+vGdY2NKxpkgSEnwJOGBKzqG6TgbgLvs6d1xJXa7deo1Y0jPv/ok=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <02ACF52945AA5F40863D9782296EDC19@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f01613e-49ad-461a-c118-08d59911b59d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2018 03:19:28.1660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 09:12:03AM +0000, Mario.Limonciello@dell.com wrote:
>> -----Original Message-----
>> From: Sasha Levin [mailto:Alexander.Levin@microsoft.com]
>> Sent: Monday, March 19, 2018 10:48 AM
>> To: linux-kernel@vger.kernel.org; stable@vger.kernel.org
>> Cc: Limonciello, Mario <Mario_Limonciello@Dell.com>; Bob Moore
>> <robert.moore@intel.com>; Erik Schmauss <erik.schmauss@intel.com>; Rafae=
l J .
>> Wysocki <rafael.j.wysocki@intel.com>; Sasha Levin
>> <Alexander.Levin@microsoft.com>
>> Subject: [PATCH AUTOSEL for 4.15 050/124] ACPICA: Recognize the Windows =
10
>> version 1607 and 1703 OSI strings
>>
>> From: Mario Limonciello <mario.limonciello@dell.com>
>>
>> [ Upstream commit bc4d413a819f9d0764a80a55875a5d7e1f4efed4 ]
>>
>> ACPICA commit 35a4a3ea723b3066f575e63e5f0116f7ce65e713
>>
>> The public Microsoft document listing recognized OSI strings [1]
>> shows that these two strings were introduced.
>> version 1607 / Anniversary Update / "Redstone 1"
>> version 1703 / Creators Update / "Redstone 2"
>>
>> [1] https://na01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdo=
wnload.microsoft.com%2Fdownload%2F7%2Fe%2F7%2F7e7662cf-cbea-470b-a97e-&data=
=3D02%7C01%7CAlexander.Levin%40microsoft.com%7Cb0cf5563b7b94791931308d592f9=
ae36%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C636576523455359326&sdata=
=3D7lMyl7MXqi9L1P4YXo2PwUzTH40lX79sNvUlPwCvwDE%3D&reserved=3D0
>> ce7ce0d98dc2/winacpi_osi.docx
>>
>> Link: https://na01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fgithub.com%2Facpica%2Facpica%2Fcommit%2F35a4a3ea&data=3D02%7C01%7CAlexande=
r.Levin%40microsoft.com%7Cb0cf5563b7b94791931308d592f9ae36%7C72f988bf86f141=
af91ab2d7cd011db47%7C1%7C0%7C636576523455359326&sdata=3DUJvpvV9lxIlDCsWsLjT=
mpFJjEWFUiWUOmFu%2B5jjk800%3D&reserved=3D0
>> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
>> Signed-off-by: Bob Moore <robert.moore@intel.com>
>> Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
>> ---
>>  drivers/acpi/acpica/utosi.c | 2 ++
>>  include/acpi/actypes.h      | 2 ++
>>  2 files changed, 4 insertions(+)
>>
>> diff --git a/drivers/acpi/acpica/utosi.c b/drivers/acpi/acpica/utosi.c
>> index 3175b133c0e4..f6b8dd24b006 100644
>> --- a/drivers/acpi/acpica/utosi.c
>> +++ b/drivers/acpi/acpica/utosi.c
>> @@ -101,6 +101,8 @@ static struct acpi_interface_info
>> acpi_default_supported_interfaces[] =3D {
>>  	{"Windows 2012", NULL, 0, ACPI_OSI_WIN_8},	/* Windows 8 and Server
>> 2012 - Added 08/2012 */
>>  	{"Windows 2013", NULL, 0, ACPI_OSI_WIN_8},	/* Windows 8.1 and Server
>> 2012 R2 - Added 01/2014 */
>>  	{"Windows 2015", NULL, 0, ACPI_OSI_WIN_10},	/* Windows 10 - Added
>> 03/2015 */
>> +	{"Windows 2016", NULL, 0, ACPI_OSI_WIN_10_RS1},	/* Windows 10
>> version 1607 - Added 12/2017 */
>> +	{"Windows 2017", NULL, 0, ACPI_OSI_WIN_10_RS2},	/* Windows 10
>> version 1703 - Added 12/2017 */
>>
>>  	/* Feature Group Strings */
>>
>> diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
>> index 4f077edb9b81..bfc8a814379a 100644
>> --- a/include/acpi/actypes.h
>> +++ b/include/acpi/actypes.h
>> @@ -1299,6 +1299,8 @@ typedef enum {
>>  #define ACPI_OSI_WIN_7                  0x0B
>>  #define ACPI_OSI_WIN_8                  0x0C
>>  #define ACPI_OSI_WIN_10                 0x0D
>> +#define ACPI_OSI_WIN_10_RS1             0x0E
>> +#define ACPI_OSI_WIN_10_RS2             0x0F
>>
>>  /* Definitions of getopt */
>>
>> --
>> 2.14.1
>
>This is fine by me for 4.15, as mentioned in other email I don't think it =
should go to 4.14, 4.9 or 4.4.

Fixed it up, thanks!=
