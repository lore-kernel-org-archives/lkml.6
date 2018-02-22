Return-Path: <horia.geanta@nxp.com>
X-Google-Smtp-Source: AH8x225h199lzkdNmnxth1boGAJ3LENQTU4udXJ6SN4jCORo+8leY95cjF4QjNKH94OZgNQoWBD4
ARC-Seal: i=1; a=rsa-sha256; t=1519288258; cv=none;
        d=google.com; s=arc-20160816;
        b=P9A6BDiI0D/ZbGl5x9xpfOeY8BP0gzKwkq4TUjj/YIwn/GHQs/ChywanwWV3zYM/vO
         1H4/QG/qGT65WKSZntJfrTP4P26m8giJoV1+LaAycs7x+Xqg+pfU3SlN6H+0PnnDX4Wt
         HkiKCtubWuFwN19j4aEWzikwXuOTzOgiVfvVaG6+cH+/wa41TSJ2ZrhtKlUC90CiXiNh
         IdJh5IDptyUEAjVUqoLDiVv8dC44puGtqUcg9jzWxh21XWkZANCfewFhzZxTVIVL7iSz
         VkgvIUHwoP+xWY5MZc7luQ/PUfkeJnANNsecWWd+sdujq1RFJSqqhbnmzgtFLpojx+0c
         ajxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:references
         :message-id:date:thread-index:thread-topic:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=m6mcwnE00k9XNNYslrYwIkATy57rz6vqQGLsOoaK8YA=;
        b=pgRokUdHMI1kfXtGCWk3L0j2RSOgZLFgu/vXzJzgYfVx7k+IqsT5s3mSZ36DgKnCBV
         4MuZa4655PkUkDOmfFEm/GO6a04pxDh1G43Ynf3lQXqnEdguwoFl1h8ULCwW3dJOVsjK
         iJGtrWh3RgyZljrLhr6cyXWaJqMnr1wHo4U6/0dEJ4uxKokKW6eF9ZSHgkZVipX1Z8HD
         L/qPjlZwEvIuSfCav3vu22fhJX4PP10C2ZHz50cSCaWDeSLnrIe/q7x/2WFO3HOZ7Nug
         GoceqqM1Ol9UO6OJERi/0bvyjLz8UTlzQ+vetWhEX35zzS+HQMs4kAslavQVbYrzkEXO
         MdNw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=HKVIZQ8f;
       spf=pass (google.com: domain of horia.geanta@nxp.com designates 40.107.3.79 as permitted sender) smtp.mailfrom=horia.geanta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=HKVIZQ8f;
       spf=pass (google.com: domain of horia.geanta@nxp.com designates 40.107.3.79 as permitted sender) smtp.mailfrom=horia.geanta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: =?iso-8859-2?Q?Horia_Geant=E3?= <horia.geanta@nxp.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4.14, 4.9] crypto: talitos - fix Kernel Oops on hashing an
 empty file
Thread-Topic: [PATCH 4.14, 4.9] crypto: talitos - fix Kernel Oops on hashing
 an empty file
Thread-Index: AQHTq6vmQrsQbzwlrEqi+JH9j6b+dQ==
Date: Thu, 22 Feb 2018 08:30:56 +0000
Message-ID: <AM0PR0402MB3329F7DB21610C75674BA7AD98CD0@AM0PR0402MB3329.eurprd04.prod.outlook.com>
References: <20180222070616.A15E36CBD4@po15720vm.idsi0.si.c-s.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com;
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR0402MB3858;7:6l5NEW6AS/TmWcE6GfodepjN1aKSBnsc8sr+IA9KKNHo4ND7TnURmpjAIhG1oPr3ZFfMKEIHpb7fpLRDrL0YiEyY0NC5QJw6WpooTw1w3nbIuZW8s9hg4BmENj80x3zx/LsYtOlgaopQos2vE6ezIY6GqdMXQWKUKdkXzdo0yHS8YcJayenHkOgvLuM6j0kxvfK+ccns7/a2dvwyI2QRJDLxtOrZz55m2CF+09gedMEggkwoEoB/7NYcAuPHgtW1
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 18209a51-5620-4ff7-dfc3-08d579ce9838
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:AM0PR0402MB3858;
x-ms-traffictypediagnostic: AM0PR0402MB3858:
x-microsoft-antispam-prvs: <AM0PR0402MB38581BE1355157A41D0BBBDE98CD0@AM0PR0402MB3858.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001077)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(944501161)(93006095)(93001095)(6055026)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:AM0PR0402MB3858;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3858;
x-forefront-prvs: 059185FE08
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(346002)(376002)(39380400002)(199004)(189003)(478600001)(110136005)(8936002)(2900100001)(7696005)(2906002)(3280700002)(54906003)(59450400001)(7736002)(186003)(229853002)(81156014)(86362001)(25786009)(97736004)(4326008)(8676002)(3846002)(81166006)(14454004)(6116002)(66066001)(74316002)(6436002)(106356001)(53936002)(316002)(5660300001)(68736007)(305945005)(53546011)(55016002)(3660700001)(102836004)(6506007)(99286004)(105586002)(76176011)(33656002)(9686003)(6246003)(26005)(5250100002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3858;H:AM0PR0402MB3329.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: zbocncJUSP28nElvJh93oZUoxQpKp0AKb/4pjHQE41MKsK8ySd6CR7+c38YYTNCT9mPQQLBHVoNSX+6NReOP2QKyD7De3vRFht3b7CSTHd28tlBufyO/Le6lkIgKf9z3snYOVZQt0as2XkLCQ12Q+Jv/S6f9bumQasFU5eb4vo8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18209a51-5620-4ff7-dfc3-08d579ce9838
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2018 08:30:56.6099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3858
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593083877507457993?=
X-GMAIL-MSGID: =?utf-8?q?1593089205355049559?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2/22/2018 9:08 AM, Christophe Leroy wrote:=0A=
> Upstream 87a81dce53b1ea61acaeefa5191a0376a2d1d721=0A=
> =0A=
> Performing the hash of an empty file leads to a kernel Oops=0A=
> =0A=
> [   44.504600] Unable to handle kernel paging request for data at address=
 0x0000000c=0A=
> [   44.512819] Faulting instruction address: 0xc02d2be8=0A=
> [   44.524088] Oops: Kernel access of bad area, sig: 11 [#1]=0A=
> [   44.529171] BE PREEMPT CMPC885=0A=
> [   44.532232] CPU: 0 PID: 491 Comm: md5sum Not tainted 4.15.0-rc8-00211-=
g3a968610b6ea #81=0A=
> [   44.540814] NIP:  c02d2be8 LR: c02d2984 CTR: 00000000=0A=
> [   44.545812] REGS: c6813c90 TRAP: 0300   Not tainted  (4.15.0-rc8-00211=
-g3a968610b6ea)=0A=
> [   44.554223] MSR:  00009032 <EE,ME,IR,DR,RI>  CR: 48222822  XER: 200000=
00=0A=
> [   44.560855] DAR: 0000000c DSISR: c0000000=0A=
> [   44.560855] GPR00: c02d28fc c6813d40 c6828000 c646fa40 00000001 000000=
01 00000001 00000000=0A=
> [   44.560855] GPR08: 0000004c 00000000 c000bfcc 00000000 28222822 100280=
d4 00000000 10020008=0A=
> [   44.560855] GPR16: 00000000 00000020 00000000 00000000 10024008 000000=
00 c646f9f0 c6179a10=0A=
> [   44.560855] GPR24: 00000000 00000001 c62f0018 c6179a10 00000000 c6367a=
30 c62f0000 c646f9c0=0A=
> [   44.598542] NIP [c02d2be8] ahash_process_req+0x448/0x700=0A=
> [   44.603751] LR [c02d2984] ahash_process_req+0x1e4/0x700=0A=
> [   44.608868] Call Trace:=0A=
> [   44.611329] [c6813d40] [c02d28fc] ahash_process_req+0x15c/0x700 (unrel=
iable)=0A=
> [   44.618302] [c6813d90] [c02060c4] hash_recvmsg+0x11c/0x210=0A=
> [   44.623716] [c6813db0] [c0331354] ___sys_recvmsg+0x98/0x138=0A=
> [   44.629226] [c6813eb0] [c03332c0] __sys_recvmsg+0x40/0x84=0A=
> [   44.634562] [c6813f10] [c03336c0] SyS_socketcall+0xb8/0x1d4=0A=
> [   44.640073] [c6813f40] [c000d1ac] ret_from_syscall+0x0/0x38=0A=
> [   44.645530] Instruction dump:=0A=
> [   44.648465] 38c00001 7f63db78 4e800421 7c791b78 54690ffe 0f090000 80ff=
0190 2f870000=0A=
> [   44.656122] 40befe50 2f990001 409e0210 813f01bc <8129000c> b39e003a 7d=
29c214 913e003c=0A=
> =0A=
> This patch fixes that Oops by checking if src is NULL.=0A=
> =0A=
> Fixes: 6a1e8d14156d4 ("crypto: talitos - making mapping helpers more gene=
ric")=0A=
> Cc: <stable@vger.kernel.org>=0A=
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>=0A=
=0A=
Isn't this needed also in 4.15.y?=0A=
=0A=
Thanks,=0A=
Horia=0A=
