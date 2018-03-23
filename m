Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751837AbeCWATZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 20:19:25 -0400
Received: from mail-by2nam03on0082.outbound.protection.outlook.com ([104.47.42.82]:16063
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751669AbeCWATX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 20:19:23 -0400
From: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To: Borislav Petkov <bp@suse.de>
CC: Tony Luck <tony.luck@intel.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v2 0/8] Decode IA32/X64 CPER
Thread-Topic: [PATCH v2 0/8] Decode IA32/X64 CPER
Thread-Index: AQHTrzmGNIT5DEMr+0GLgvlHp3HCk6O5geyAgABgJNCAACPSgIAARNAQgAEAeICAIc3PcA==
Date: Fri, 23 Mar 2018 00:19:20 +0000
Message-ID: <DM5PR12MB1916C801C1340FB36B01DFF4F8A80@DM5PR12MB1916.namprd12.prod.outlook.com>
References: <20180226193904.20532-1-Yazen.Ghannam@amd.com>
 <20180228084321.GA2969@pd.tnic>
 <DM5PR12MB1916B6CA08F0D423B3635EDDF8C70@DM5PR12MB1916.namprd12.prod.outlook.com>
 <20180228163539.GC2969@pd.tnic>
 <DM5PR12MB19169CD3BC3BAE3230C1DCA3F8C70@DM5PR12MB1916.namprd12.prod.outlook.com>
 <20180301115953.GA5040@pd.tnic>
In-Reply-To: <20180301115953.GA5040@pd.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
x-originating-ip: [165.204.84.17]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2406;7:H2fuFKN3vsCBaYW5ptFnhDOOTwrQ8Jo01H+ezjJvUkcbK/F92bU6E2pRgF6W0tysaUB6gKqsr99TvshK6sWYJXmAH02YrTMhuRjqtqiqDFlaykXUdC16OSz3K8E33Gto9LdKmTuxYPto9OV+mle9rPTKc0ntMX3mjyBdjnhJRyj0U1kvlD3DfM0hWrYCWObZytNqYfaytCZiklfWF6ttffxlokplPpXeYBbONZ+QZxSoh5exikbz9M3c8jYKRAtt;20:AmjiqZcSghZzf8NkMO6sfBgYHrGcbvc8gcAObMBkbuEhyPLQ1HUhQhSHj1G0evwpLTzjTk9yvmJK/5BCydbKLl9TrG2xM9gtvS48hcCp7MngdCnihMO3SiNr9leDdjUiiM2POSXOGjE3uXVnJiNyBenga7qcLOEmpt7QSOsU6WMcbvaZ9lREY2xldcDYyaZD+igwsYidmVbGBSeYZbBcbb7c0D/DKQTzFZcFohCF8Z772xi/g0We9GXOWQuBXmmn
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7d2151c6-2eb8-4b8e-b798-08d59053b8fb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2406;
x-ms-traffictypediagnostic: DM5PR12MB2406:
x-microsoft-antispam-prvs: <DM5PR12MB240623BFF1A2B146A688D47AF8A80@DM5PR12MB2406.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR12MB2406;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2406;
x-forefront-prvs: 0620CADDF3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(396003)(366004)(39380400002)(199004)(189003)(13464003)(7736002)(25786009)(305945005)(86362001)(74316002)(97736004)(76176011)(7696005)(2906002)(81156014)(14454004)(3280700002)(99286004)(3846002)(8936002)(446003)(106356001)(53936002)(5660300001)(5250100002)(2900100001)(6916009)(66066001)(53546011)(6506007)(478600001)(6246003)(55016002)(8676002)(105586002)(229853002)(68736007)(6436002)(54906003)(6116002)(93886005)(33656002)(26005)(9686003)(4326008)(102836004)(3660700001)(81166006)(316002)(72206003)(186003)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2406;H:DM5PR12MB1916.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: +eNJ3UydFZO8eS1Pty8RyAV3VyvrMWJgBRkGXYxkU3vfTK+pMI6GyleFd0JyCc0+k3LAomDqvkzjpFb7LIR6jIox2OdUbrQmeAcEToUQrXzpH4cLcpMACJBpckpIo+hPeFFPiEF5gfiz16KcuXgtszmFfuGqB5dIAqMaJ8iM7mK4Cj6LQxwrJi40gtRzLYjtRCXabS5L076YrgBbhJOkyUDVpq3BatJiZU1xGvA0M7w+iPk+VrYCeG+zNiE+PtCZgbFUTL3s4+g0Z/irkTK/89TcEfuXAgokC+f1I19P7HI7vyERwQMxSzTBZKVoTxUaa/9ILuKeexCufSUHBMO1xA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d2151c6-2eb8-4b8e-b798-08d59053b8fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2018 00:19:20.2670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2406
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2N0JUDI007891

> -----Original Message-----
> From: Borislav Petkov <bp@suse.de>
> Sent: Thursday, March 1, 2018 7:00 AM
> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Cc: Tony Luck <tony.luck@intel.com>; linux-efi@vger.kernel.org; linux-
> kernel@vger.kernel.org; ard.biesheuvel@linaro.org; x86@kernel.org
> Subject: Re: [PATCH v2 0/8] Decode IA32/X64 CPER
> 
> On Wed, Feb 28, 2018 at 08:58:15PM +0000, Ghannam, Yazen wrote:
> > 1) We keep this set mostly as-is. This would be our fallback if we don't have
> > anything better.
> 
> Yes, sounds good. We try to decode it as MCE and if we cannot, we dump
> the raw CPER record.
> 
> > 2) I add the MCA decoding to this set. I was thinking to do this in a separate
> > set but maybe it's better to do it all together.
> 
> I'm fine if you do it separately, as long as you do it so that we have
> user-friendly decoding in the end.
> 

I wanted to add the MCA decoding to this set but I got caught up with something
else and haven't had time to do it.

Is it alright if I go ahead and just send the v3 of this set without the MCA decoding?
I was hoping this could be accepted in the next merge window. And if that's still
possible I'd like to have some CPER decoding sooner rather than nothing.

Thanks,
Yazen
