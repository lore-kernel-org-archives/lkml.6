Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752447AbeC3TXQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 15:23:16 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36202 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752069AbeC3TXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 15:23:13 -0400
From: Nick Terrell <terrelln@fb.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Kernel Team <Kernel-team@fb.com>, Chris Mason <clm@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Geliang Tang <geliangtang@gmail.com>
Subject: Re: [RESEND PATCH] crypto: Add zstd support
Thread-Topic: [RESEND PATCH] crypto: Add zstd support
Thread-Index: AQHTwWccFi06nKjRkE6KKlwSZjTSzqPbqsUAgA1nsICAACPKgA==
Date: Fri, 30 Mar 2018 19:23:06 +0000
Message-ID: <992742B1-A16C-4DFF-95BB-6FF09F7CCA4C@fb.com>
References: <20180321224929.3076350-1-terrelln@fb.com>
 <20180322043230.GD3181@jagdpanzerIV>
 <20180330171459.GB27856@gondor.apana.org.au>
In-Reply-To: <20180330171459.GB27856@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::6:900f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR15MB1351;7:bwzFLC4O4ayc5bkXxMwK883fJTNnSGwQJSAj1xRPHYgruGBUI52UIbqPoorTHrQQRnLRcPr04qbulaz6b0MLShBu+2vULpMBPa5aZ5JuQW0I3Nu5roeXUzeTlepxQF58M8wAYSNsxDURWvDnNk20Mqxcx8NBIKAPZ/Ae8KZtBFrVnke2ibUl5lbUWmf3Y+sRKBXPtNUWtuYHfrvtbGF0o2gIrrMK7JPtnEMC5HJySs5hdMiWGPNcMS7E4cqSLVfr;20:4tDoE+4th1Z2aOkyUzrtiOaxhrvBheyyUSCQWJN7IvSPFDXuV/GxSc/QF8DW8Zx4pu2rRT6NXK0HlJ5s9mhlhG0h4Uw9jpw+qxUOmyKJs474jHUt44Vln56/vMXBXrYTcoC2LEuEct2af0DlPZNKIsUiL6IKLbSNXrttUyVOoYc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 23059bec-c910-4618-e9a8-08d59673aa0c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1351;
x-ms-traffictypediagnostic: CY4PR15MB1351:
x-microsoft-antispam-prvs: <CY4PR15MB1351EA89C05EE51C04342BADABA10@CY4PR15MB1351.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(10436049006162)(85827821059158)(67672495146484)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231221)(11241501184)(944501327)(52105095)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:CY4PR15MB1351;BCL:0;PCL:0;RULEID:;SRVR:CY4PR15MB1351;
x-forefront-prvs: 06274D1C43
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(346002)(376002)(396003)(199004)(189003)(86362001)(53546011)(186003)(5250100002)(8676002)(81166006)(5660300001)(486005)(36756003)(82746002)(575784001)(4326008)(54906003)(316002)(81156014)(486005)(8936002)(6246003)(2616005)(102836004)(6486002)(83716003)(6506007)(25786009)(97736004)(106356001)(76176011)(476003)(478600001)(7736002)(229853002)(6306002)(6116002)(2900100001)(6512007)(39060400002)(105586002)(6916009)(966005)(6436002)(305945005)(33656002)(14454004)(2906002)(446003)(46003)(11346002)(3280700002)(3660700001)(53936002)(68736007)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1351;H:CY4PR15MB1543.namprd15.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: /OhU00BpvS6Au+E+YznkYuJCsXPUlo6Q/lSt/EicPziXHinZ0FjaoiNzgzFpz6Y8TNeQdrCEXyNhK/ZAUW6oBrOcms8c8IMeZ+6Dgek9aaWzML41xIPnBP5G7a/DPvz8twU/bY3b3XRMVbFi26syiTPJ9xQYdO/0mQ40ccgp9nrOM3mF9sg+XJsQAJ09snA/NAyQy+qgq4kU08H9zSSHsY+7MCoa6g47jTS8FUneJvozQTR71U6qWbgeJrLQee8HdqZMUP2Ao5C1RL/W2V9GhVnfWwoE1o7o5anw4hgmajbpLSGSN/oNKnJbH4t2MI1eRKKGQdDeppDR6gSDii4jETRJsCZbgqCvmRozszwuf+FyXPCOZLd5WbxbWKZej0brVmFLZpWr3mmwfqLZOL+A6XS2GLixKd8dzI0HC6jhjmw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8082CBCA03CD0A478EFAABDE9CEB2431@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 23059bec-c910-4618-e9a8-08d59673aa0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2018 19:23:06.0077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1351
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-30_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2UJNKkC028330

> On Mar 30, 2018, at 10:14 AM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> 
> On Thu, Mar 22, 2018 at 01:32:30PM +0900, Sergey Senozhatsky wrote:
>> On (03/21/18 15:49), Nick Terrell wrote:
>>> depends on CONFIG_CRYPTO_ZSTD, which isn't defined until this patch is in
>> 
>> Yikes! How come I missed that... :)
>> 
>>> [0] lkml.kernel.org/r/9c9416b2dff19f05fb4c35879aaa83d11ff72c92.1521626182.git.geliangtang@gmail.com
>> 
>> Signed-off-by: Nick Terrell <terrelln@fb.com> ?
> 
> Please resend with sign-off.

Sorry about that, resent as http://lkml.kernel.org/r/20180330191453.3535287-1-terrelln@fb.com.

> 
> Thanks,
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: https://urldefense.proofpoint.com/v2/url?u=http-3A__gondor.apana.org.au_-7Eherbert_&d=DwIBAg&c=5VD0RTtNlTh3ycd41b3MUw&r=HQM5IQdWOB8WaMoii2dYTw&m=9TJPOvcdtkpIjIAGJJ6-7fzehxatF48hBoFlxI0lAw8&s=79UWdDJu7MxUVoJ2mEANx31Yj5EYfAyJl8noCeBv-4c&e=
> PGP Key: https://urldefense.proofpoint.com/v2/url?u=http-3A__gondor.apana.org.au_-7Eherbert_pubkey.txt&d=DwIBAg&c=5VD0RTtNlTh3ycd41b3MUw&r=HQM5IQdWOB8WaMoii2dYTw&m=9TJPOvcdtkpIjIAGJJ6-7fzehxatF48hBoFlxI0lAw8&s=9Pll03qIuCxGGfTX0v5TkbxRUh7p76X1keoDqWC49UA&e=
