Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753037AbeCUT4l (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 15:56:41 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33316 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752637AbeCUT4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 15:56:39 -0400
From: Nick Terrell <terrelln@fb.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
CC: Maninder Singh <maninder1.s@samsung.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "ngupta@vflare.org" <ngupta@vflare.org>,
        Kees Cook <keescook@chromium.org>,
        "anton@enomsg.org" <anton@enomsg.org>,
        "ccross@android.com" <ccross@android.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pankaj.m@samsung.com" <pankaj.m@samsung.com>,
        "a.sahrawat@samsung.com" <a.sahrawat@samsung.com>,
        "v.narang@samsung.com" <v.narang@samsung.com>,
        Yann Collet <cyan@fb.com>
Subject: Re: [PATCH 0/1] cover-letter/lz4: Implement lz4 with dynamic offset
 length.
Thread-Topic: [PATCH 0/1] cover-letter/lz4: Implement lz4 with dynamic offset
 length.
Thread-Index: AQHTwO5jt8QdQWvsxEiscfHuXN/+16PbG3KA
Date: Wed, 21 Mar 2018 19:56:10 +0000
Message-ID: <1663C9A3-7DAC-4A11-894C-C99E07BEDAD2@fb.com>
References: <CGME20180321044137epcas5p221e7ee4a0b7464eaa00dad8320f0251d@epcas5p2.samsung.com>
 <1521607242-3968-1-git-send-email-maninder1.s@samsung.com>
 <20180321082628.GB2746@jagdpanzerIV>
In-Reply-To: <20180321082628.GB2746@jagdpanzerIV>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::5:3299]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR15MB1350;7:+TQyh9k8+h6rbcIkjdLlOogB8XOd88MuLcpJlMLcIA8pewy1A5n8NFePRNVTl/1Z3A/pfofKDWSPJuxYgWyqR09eIqR1bhxZkpj/rRlcumh6FyF9Inp1m/xJQ5HAzV+8SHiZEEI/RxaaczatAdKnZjiDj2Rg6kmcRbfSH3Z8Pkkrq2unEX1P2DdnUDKDFHcNPDLnmfbxlgtnlVreyvI31JdkhL3/DDb8wJy6+gwO6GtaRNASr1UlN9zE+xWXU2F1;20:NRvhTWxZ4j/u0MF7pMPQx3sVJq9qblhdJCyUt+41YFeypKarQD7cItnWQlnsmwulRJaV0ZRk78kCRPu45zKVC8Mk/U3s9Qq6e/n+YRjtdu1NsInUSUROTEbWNXmVjQ4ghhlJ/Jg6YSbRbdWMxV8taUKPfSB4C5nvSWJxHaYKWfU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(366004)(39380400002)(396003)(189003)(199004)(81166006)(83716003)(5660300001)(39060400002)(186003)(316002)(82746002)(14454004)(76176011)(5250100002)(6116002)(6486002)(36756003)(2900100001)(6512007)(6916009)(54906003)(3280700002)(106356001)(3660700001)(97736004)(7416002)(81156014)(86362001)(8676002)(2906002)(4326008)(8936002)(7736002)(33656002)(99286004)(478600001)(46003)(2950100002)(105586002)(53936002)(25786009)(305945005)(6246003)(229853002)(6506007)(6436002)(102836004)(68736007)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1350;H:CY4PR15MB1543.namprd15.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-ms-office365-filtering-correlation-id: 851569e2-8750-4d20-c585-08d58f65cb1a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1350;
x-ms-traffictypediagnostic: CY4PR15MB1350:
x-microsoft-antispam-prvs: <CY4PR15MB1350DEE1FFD9B95B7AF7DFBEABAA0@CY4PR15MB1350.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(11241501184)(944501326)(52105095)(3002001)(10201501046)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:CY4PR15MB1350;BCL:0;PCL:0;RULEID:;SRVR:CY4PR15MB1350;
x-forefront-prvs: 0618E4E7E1
x-microsoft-antispam-message-info: crRTWOjMblf2XR18o6+vCQhTvra/dTkiUNm7kjbDyVthQzlzP3nyR8N3RtZSpcxBXJvHEP7IyPc1bnaYxArc+1gcwFq6cObWyoLKeLvgedEZV8Vs3privaVmY12rVrv7JU8LDpzyO4VUQexXNdBzRfDNY64aQFMCthwkLwQcSv/j/zuEgy5cP7JZlXGUZtMrFf1VZtQUM8og1Wo0Cn5DB/Fim2KcX46VrPSjs02zkFxM/KPAuxwYLquCoPk1DPZ+qjT5uBRTpOZZwGM6/fM2XMk/tiNgvfjZ54t6X1S0E/JI8WXd6tsmRxGa8eddo7CXU22jCvxiqJdIAgi4Dv9BiQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AE61E8E61085A24C990A2A0D8471A8C7@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 851569e2-8750-4d20-c585-08d58f65cb1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2018 19:56:10.3228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1350
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-21_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2LJuojb028321

On (03/21/18 10:10), Maninder Singh wrote:
> LZ4 specification defines 2 byte offset length for 64 KB data.
> But in case of ZRAM we compress data per page and in most of
> architecture PAGE_SIZE is 4KB. So we can decide offset length based
> on actual offset value. For this we can reserve 1 bit to decide offset
> length (1 byte or 2 byte). 2 byte required only if ofsset is greater than 127,
> else 1 byte is enough.
> 
> With this new implementation new offset value can be at MAX 32 KB.
> 
> Thus we can save more memory for compressed data.
> 
> results checked with new implementation:-
> 
> comression size for same input source
> (LZ4_DYN < LZO < LZ4)
> 
> LZO
> =======
> orig_data_size: 78917632
> compr_data_size: 15894668
> mem_used_total: 17117184
> 
> LZ4
> ========
> orig_data_size: 78917632
> compr_data_size: 16310717
> mem_used_total: 17592320
> 
> LZ4_DYN
> =======
> orig_data_size: 78917632
> compr_data_size: 15520506
> mem_used_total: 16748544

This seems like a reasonable extension to the algorithm, and it looks like
LZ4_DYN is about a 5% improvement to compression ratio on your benchmark.
The biggest question I have is if it is worthwhile to maintain a separate
incompatible variant of LZ4 in the kernel without any upstream for a 5%
gain? If we do want to go forward with this, we should perform more
benchmarks.

I commented in the patch, but because the `dynOffset` variable isn't a
compile time static in LZ4_decompress_generic(), I suspect that the patch
causes a regression in decompression speed for both LZ4 and LZ4_DYN. You'll
need to re-run the benchmarks to first show that LZ4 before the patch
performs the same as LZ4 after the patch. Then re-run the LZ4 vs LZ4_DYN
benchmarks.

I would also like to see a benchmark in user-space (with the code), so we
can see the performance of LZ4 before and after the patch, as well as LZ4
vs LZ4_DYN without anything else going on. I expect the extra branches in
the decoding loop to have an impact on speed, and I would like to see how
big the impact is without noise. 

CC-ing Yann Collet, the author of LZ4
