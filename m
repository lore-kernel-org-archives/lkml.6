Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753024AbeC0OHX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 10:07:23 -0400
Received: from mail-by2nam03on0058.outbound.protection.outlook.com ([104.47.42.58]:25813
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752427AbeC0OHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 10:07:19 -0400
From: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To: "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH 2/2] x86/MCE: Always save MCA_{ADDR,MISC,SYND} register
 contents
Thread-Topic: [PATCH 2/2] x86/MCE: Always save MCA_{ADDR,MISC,SYND} register
 contents
Thread-Index: AQHTxTbgS6+ZvZR8h0mCmC3vV5RUb6Pi6MAAgAAGmcCAAAMJgIAABQkAgAEml5A=
Date: Tue, 27 Mar 2018 14:07:17 +0000
Message-ID: <DM5PR12MB1916415A7E4205B868F9F08AF8AC0@DM5PR12MB1916.namprd12.prod.outlook.com>
References: <20180326191526.64314-1-Yazen.Ghannam@amd.com>
 <20180326191526.64314-2-Yazen.Ghannam@amd.com>
 <20180326193526.GK25548@pd.tnic>
 <DM5PR12MB1916CB8536B257923AC76CA7F8AD0@DM5PR12MB1916.namprd12.prod.outlook.com>
 <20180326200955.GG28372@pd.tnic>
 <20180326202756.6qqqgjdjnx6ggng2@agluck-desk>
In-Reply-To: <20180326202756.6qqqgjdjnx6ggng2@agluck-desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
x-originating-ip: [2601:345:301:c593:3414:3059:320b:d027]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2438;7:+pBRkDsxH2ntG2mLtE6GzAhfmEUac5xxsvl04Hg8du07y1WVOxhpOyT/sxYbvdyEw3I1AT4XhxxhMj3JmnX6GQGnwKgV0PnUCGlYSSy+qvwbhTIvPZgVFtIj5PAJQwlkKIY0alWCWgoo5oGsabg5yvX+rpkDd9dHfJ2KMjHclPFfPTH+kmh0KLUNaFr82FfhYBQUYLPqiUwi3sjArmTpov5OEBcY9MoeuX0Mv6glIUjS5Cxt32TxXmbczRmJovZ3;20:tvnTyqj1sz2AY/k+jGTvDvNoYyrbeU+z4xOT6iJ54ICQvjVvz7/yOQYThjiATxTGH5/5+HSZ4ZW4aALCvkgpGXFIX+FutjeV+KsZhKQ/7yaEkUC/eD7CoW400kSasSCJM1qrm/EJHTSt+OzxlI07CuWnPSOYvN2+PDoIeJYZV6Nn0Q8cZDmBEzUrfLNfMfKmkCtEVp2fztFAkczMjtgU01QVfiMxPT0MAOWN7MjNEzpaAvXRNYgf2BdCqcmvM+fm
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a6c83e16-b0a2-4545-62f5-08d593ec0cc4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2438;
x-ms-traffictypediagnostic: DM5PR12MB2438:
x-microsoft-antispam-prvs: <DM5PR12MB24382B94840E5050B19442BCF8AC0@DM5PR12MB2438.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR12MB2438;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2438;
x-forefront-prvs: 0624A2429E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(346002)(39860400002)(366004)(396003)(189003)(199004)(13464003)(7696005)(46003)(72206003)(476003)(486005)(6116002)(4326008)(486005)(305945005)(11346002)(25786009)(106356001)(54906003)(7736002)(110136005)(478600001)(68736007)(5660300001)(53546011)(76176011)(6506007)(446003)(2900100001)(97736004)(3280700002)(8936002)(3660700001)(53936002)(316002)(99286004)(105586002)(2906002)(6246003)(33656002)(102836004)(5250100002)(9686003)(14454004)(81156014)(74316002)(186003)(81166006)(6436002)(8676002)(55016002)(86362001)(93886005)(229853002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2438;H:DM5PR12MB1916.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: PnWKFDEHMI4+H4xxRZggGRpUsWAZ3xDXk4w3UQzzHZP+iCMzlPFnbW1tY2HEkkt1uEoDZhZ4UCxhPCV1TCFaxFKEA3tdBV1JMO3YYRA6zO/3zY3BnNVXg3n78cSd5tw12ZdStpCEM+foofay+4rQ9Q477Mkek08Ye3rn8cjnt1tyUAgZqoAORMFouX07hrhLVjlp9m4ulnvXp54EEJSE8Hr0iB+pjBr++r4t87MUOShA9hLpy63qRfYA4IdN1/xzXJXLg6hn65pnj/QNrKwxbU+id8J/GI60+vRGUl/2ULclQDYR8cbiFLMt/vJnzAfbuEmG1qUZknNV1BbtjBs5nA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c83e16-b0a2-4545-62f5-08d593ec0cc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2018 14:07:17.7305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2438
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2RE7ihl014361

> -----Original Message-----
> From: Luck, Tony <tony.luck@intel.com>
> Sent: Monday, March 26, 2018 4:28 PM
> To: Borislav Petkov <bp@alien8.de>
> Cc: Ghannam, Yazen <Yazen.Ghannam@amd.com>; linux-
> edac@vger.kernel.org; linux-kernel@vger.kernel.org; x86@kernel.org
> Subject: Re: [PATCH 2/2] x86/MCE: Always save MCA_{ADDR,MISC,SYND}
> register contents
> 
> On Mon, Mar 26, 2018 at 10:09:55PM +0200, Borislav Petkov wrote:
> > On Mon, Mar 26, 2018 at 08:05:37PM +0000, Ghannam, Yazen wrote:
> > > Sure, I can do that. But I didn't think it was necessary because it doesn't
> hurt
> > > to read the registers whether or not the valid bits are set.
> >
> > No, this needs to be AMD-specific because it will confuse people using
> > Intel machines.
> 
> Worse than confusion it may even cause a crash on Intel. Quoting the
> Intel SDM:
> 
>   15.3.2.3 IA32_MCi_ADDR MSRs
> 
>   The IA32_MCi_ADDR MSR contains the address of the code or data memory
>   location that produced the machine- check error if the ADDRV flag in
>   the IA32_MCi_STATUS register is set (see Section 15-7, “IA32_MCi_ADDR
>   MSR”).  The IA32_MCi_ADDR register is either not implemented or
>   contains no address if the ADDRV flag in the IA32_MCi_STATUS register
>   is clear. When not implemented in the processor, all reads and writes
>   to this MSR will cause a general protection exception.
> 
> Ditto for the MISC register.  Please don't read them unless
> the ADDRV/MISCV bits are set in the corresponding STATUS
> register.
> 

Okay, then we won't do this.

On AMD, the registers are implemented if MCA is implemented. They'll just
be read-as-zero if not available for some reason.

Thanks,
Yazen
