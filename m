Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF5AC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA14206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFA14206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbeJBVJu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:09:50 -0400
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:32913 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbeJBVJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:09:49 -0400
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g9t1613g.houston.hpe.com (Postfix) with ESMTPS id 52F4461533
        for <linux-kernel@vger.kernel.org>; Tue,  2 Oct 2018 14:26:10 +0000 (UTC)
Received: from G1W8108.americas.hpqcorp.net (g1w8108.austin.hp.com [16.193.72.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g9t5009.houston.hpe.com (Postfix) with ESMTPS id 69AD55C;
        Tue,  2 Oct 2018 14:26:09 +0000 (UTC)
Received: from G9W8456.americas.hpqcorp.net (2002:10d8:a15f::10d8:a15f) by
 G1W8108.americas.hpqcorp.net (2002:10c1:483c::10c1:483c) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Tue, 2 Oct 2018 14:26:09 +0000
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (15.241.52.13) by
 G9W8456.americas.hpqcorp.net (16.216.161.95) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Tue, 2 Oct 2018 14:26:08 +0000
Received: from DF4PR8401MB1132.NAMPRD84.PROD.OUTLOOK.COM (10.169.92.23) by
 DF4PR8401MB0588.NAMPRD84.PROD.OUTLOOK.COM (10.169.84.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.18; Tue, 2 Oct 2018 14:26:07 +0000
Received: from DF4PR8401MB1132.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::3d63:bee4:df41:5948]) by DF4PR8401MB1132.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::3d63:bee4:df41:5948%4]) with mapi id 15.20.1185.024; Tue, 2 Oct 2018
 14:26:07 +0000
From:   "Travis, Mike" <mike.travis@hpe.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        "Hedi Berriche" <hedi@sgi.com>,
        "Anderson, Russ" <russ.anderson@hpe.com>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        Borislav Petkov <bp@alien8.de>,
        "Kate Stewart" <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ram Pai <linuxram@us.ibm.com>,
        "Gross, Juergen" <JGross@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Sinan Kaya <okaya@codeaurora.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] Fix community TSC ADJUST breakage causing TSC failure
Thread-Topic: [PATCH 0/2] Fix community TSC ADJUST breakage causing TSC
 failure
Thread-Index: AQHUWhihZ10vNublLE+vDif+ksnMI6UMA4CA
Date:   Tue, 2 Oct 2018 14:26:07 +0000
Message-ID: <3351341c-6288-ac68-b4f6-b5794078f63c@hpe.com>
References: <20181002012204.297193336@stormcage.americas.sgi.com>
 <alpine.DEB.2.21.1810020823550.32062@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1810020823550.32062@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM5PR10CA0007.namprd10.prod.outlook.com (2603:10b6:4:2::17)
 To DF4PR8401MB1132.NAMPRD84.PROD.OUTLOOK.COM (2a01:111:e400:7610::23)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [73.222.225.80]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DF4PR8401MB0588;6:GKC9lqnrVCYmXJc++jk31wZcQTRta/j9r7k0t16cSCTaCWMMhEVSt8u/yMiQjwYZIAywSvbw5qwGOaguofcka3MHdCCQeuoSy5JC6VOpqR0l1FJyFu/K7xF1h1GWcwkc/rqvyd9v+hFmpJFHmo7Ey6lX8R7V4jTvU4BIqc8Jdj485oz07SKsSKzEOpA0ygfdocioDNuRiuFkNOy4k0D+JGyDpzBKwrkiDjr6bxqwrWWNdKt+4oVGMZzA0khmkjIUU4fStENpsUMfC0/rKD29+bUJYAS1rCzvRdlyIOKnwlQvwtXTJIl7LjCD8ahb3PAY/g265d4pT2w88k2EaoodyxHQvCsCBsnoHLrf78ex+BZDoCSUGAVM1zTwzdLa+HofSwqhnoM1Wmj2KQw+i/y4nwJliqil16fj59TqK0DemArl9MnCwe1Sz223VAN5ReW57utnYySzDnz/c6CSUtGVCw==;5:hBWLQztN+UQyeQoLH7x7EF26ha8tuFehWnlTFqiiUsOZzNu2S4zZO8CrqazvI6bJ8RXm7BUsLycH4hPEOFd8uiu//JGW3XwlIVyQcmkVxAD33sFQiOHTBgOaPUq7LEBQXE+OWtWu56bUilt7zXo+iSwUCwqUfT7A0GP0+k7zxSA=;7:sUSJv/YBoxaix81PwKkm9h95NBGhWR7fKI9oSLG6lkT5JWAzHdPnkwLmTeOkucwMxgoxSL5uzKHMrvDi2Lp+GIX0l8T/P+6BX4nkkud3hcbC0LJybMXCcvDFHSEGzpDMX/BmS2KEeq/ANPsi86ckTKrl3eCr+FBnMbw++ol4Ng5Q7mqUfCoZMl0s61fgB7spGS+lKh4prk2ctzjiJ6MyBU/FeHS6v6ZahVVMLUjUrv6s4vFnU2+G6cQXoE4VXlV5
x-ms-office365-filtering-correlation-id: 2864ac1a-18f8-4972-345a-08d62872fdc4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DF4PR8401MB0588;
x-ms-traffictypediagnostic: DF4PR8401MB0588:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mike.travis@hpe.com; 
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-microsoft-antispam-prvs: <DF4PR8401MB0588FCA1BBD6D2D7D06BAF8BE7E80@DF4PR8401MB0588.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:DF4PR8401MB0588;BCL:0;PCL:0;RULEID:;SRVR:DF4PR8401MB0588;
x-forefront-prvs: 0813C68E65
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(136003)(346002)(376002)(189003)(199004)(97736004)(6916009)(4326008)(476003)(486006)(31686004)(2616005)(446003)(6506007)(386003)(53546011)(316002)(2906002)(11346002)(5250100002)(256004)(217873002)(6246003)(2900100001)(25786009)(36756003)(5660300001)(54906003)(7736002)(68736007)(8676002)(81156014)(53936002)(105586002)(305945005)(71190400001)(71200400001)(26005)(7416002)(31696002)(186003)(86362001)(106356001)(102836004)(8936002)(81166006)(66066001)(52116002)(14454004)(6116002)(3846002)(6512007)(99286004)(76176011)(6486002)(6436002)(229853002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:DF4PR8401MB0588;H:DF4PR8401MB1132.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: a5ZULNiuE5o7Wo4zwZ9zMfiEX7/Ep6YQskMReopcS1wLEUBLyP1Uuts0uc3sn9LREnva0/fhqYI9n7NYXjo4hZKt9OKVbSheqBgRK2PawLSXRc7/cJIw76pn4Ccq30r/TBkS51fzkNvJOfa3l01G7iH3N7mf9SENUwwbczEP0QFRcj/PzDaOJ4ZC5M37Qnq+YCMMDQpYtaHm52iWAbd2h6aDECAhtlisZp/GtmQYhdVQE3KAszrIHvdsgARDbz/Hnl8lraFHqgWd/H7dFxdQsDDj6zcSOU86RED5ZLUNffTrmF1tjAYi+tylPaC6lXyTdqexBDTBFaqqzZz9KCwv+HA98Nj7WSJA+g66CODTP9U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <E96189D36C41744AB5FBDEFBB8CB8CFD@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2864ac1a-18f8-4972-345a-08d62872fdc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2018 14:26:07.1818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DF4PR8401MB0588
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/1/2018 11:24 PM, Thomas Gleixner wrote:
> On Mon, 1 Oct 2018, Mike Travis wrote:
> 
> I'm not sure what a 'community TSC adjust breakage' means.
> 

I probably should have cleaned that up.  The title is from our internal 
bug report and we target where the earliest place where the fix should 
be applied.  "Community" is shorthand for the Linux Community Kernel (as 
opposed to internal or distro specific problems).
