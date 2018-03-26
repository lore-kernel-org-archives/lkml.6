Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1702535-1522091171-2-4149699037992775247
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522091168; b=tAM4wjk6Og0ETyoKOftOdY9I9dUOS75GmFoTCR3Rs423j40
    qi/nw1e7sbzZanvs2InjIHCvcLpLG4Eq/7/lTmIF8bHEDKO2j3panxTata/lk8Fc
    EhyRwmuSCGFKxxJNqW5A4huS9hhr1nR/KZtm5U506WfjTPRLzadIzHEP3GtJJipI
    5xX+VnZAgiWeWBpOKJB0eUi+CbEoUczCVWWtDOALPcbFNV5w+pZw9xe55TO2R2yf
    E92CUiqLhuf2mr4OgJ9/xZEKaFjSrv5ue39ZXuOB86WVGQlFPAf5TYjhhrukbP9S
    VdbEQF9N3ajS8wNdLiMFC8YIWl0+IetfanP7LPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:reply-to:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1522091168; bh=3
    8AiKDLBeZBYUj69yDQjmmBVy6QP0hXzxeqF7UXXat4=; b=wTGgxp2O/CFiJ4beZ
    uEr/QiPmWXwZN+Uz0qkbjX3L7A6szY1MyDc1okEt56wde+tM0vIR6DNOE3uZbe+M
    HvznDvBCCiZvNnrvjjmEdGoz/iUKAg29ew56LTbprCUSerTp0YHIDvM2pq5g68T+
    xm9IVBsPZMs19dxpxFziqoDlc+FpDqrZtdNcqGNS/oBs8xQ17z0BS4po/Yq4UNBG
    bxyoKoLjzU3RekhHnSNvL7xSNnBqgBrw6QNSVrmxI/Vg1/bt727GUmfJua379A9X
    SnoMtWH8xFOCH8P4/pEloEkPJmLyL2C/CirDkMqcctngH8rnMgnNpbFCUtYufeqS
    xvztg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=b5YUkMiv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=b5YUkMiv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNCriq1v+KKitoeHw2PeZDR+15/6Cf8YvviDRIBdJgIynCEulTV8nVf2f5dcNrPEmg5f1Yr4KZKLWhHzMqDidRWb3X0gwUb/kuJGXxDCIrbRnM+/gfeK
    scq/MLhnp7LdSW8yZTXbi9AAz9oLEhriVFFiF5LcHOE6UsHMhtCZni7wX9G91IfpOi5RgiXeC0l5VvmTLDx3AWQ1/hNnMjGY8udLYkEf7opA5EzQ2OjviDYH
    daH4omIhQAh6MuEXquP0IA==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=TRjyw0CnJloA:10 a=P4uAHAV8DOQA:10 a=8b1vOtsxA_QA:10 a=SJl39FfINJoA:10
    a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10 a=dw2S5ISiLjYA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=7f7UIQbXBLSi3w2gpXUA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=roy.pledge@nxp.com;
From: Roy Pledge <roy.pledge@nxp.com>
To: devel@driverdev.osuosl.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/4] drives/soc/fsl: Move DPIO driver out of staging
Date: Mon, 26 Mar 2018 15:05:30 -0400
Message-Id: <1522091134-24646-1-git-send-email-roy.pledge@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: DM5PR1501CA0025.namprd15.prod.outlook.com
 (2603:10b6:4:9d::38) To AM5PR04MB2993.eurprd04.prod.outlook.com
 (2603:10a6:206:a::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ff4458a2-eb0c-4693-2a58-08d5934c9998
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:AM5PR04MB2993;
X-Microsoft-Exchange-Diagnostics: 1; AM5PR04MB2993;
 3:sSIxCRm0LMDNlLAc4dBCEb4Qk83q4DDnCMqanyiY/Bz0j6x8W9jQaDH48fKDeltwHtXucx9XD+mwzdYNOocJ24l2a+K6d7H/qEg81yu4If/g5tRV1TPWbUleYrdRZobwH10Fb4wNV6w9XKlh1uDtvEP0Y3WMw/MVFw2GgVqX7lb70WHQLuBO4UhqtHcbdqu3a+9eIEs+J6Fm0EK7Nk4nDapOv3lBqoYTwdvLClXVItwjHK6bEL9PjCSSBeP6XCNO;
 25:HOmvKDb0oqiBm1/SlW8Kuu7qW6h42u8Iw3fYAsgNCgWnWUOuB5ydG9CRhiB20hWNbK4g/4DBGbJQxt6/qJnB9W7QqUzL3x7iaWvB4e+fAqNYo53p6sfJaE0bXMLvHLyPyJl1t9F96ZuKRJuKr+Ms7TeDEzqYn5nfqshctYnjJGQDX/1parJ4MfDKJPp686U/FtLtqtc/3kG/++BnNtIwmeRJullMMZU/8RAWd5x/gYqXhK1ppa4QOEy1pi58itj9OpvJDB1s3ufuuOuJPArMA2+86AByAZRla0fAoqyJLR3mYundhe8XyBmmqG9oKxJHUzZLfNeqCwEKu9bx8WdaLA==;
 31:OleIf4xWriXmYS/byt9Mtw0dmy5b5yY2ds7ecbVlttjYBN2oki3MOGxFgz63AiSA3z3GumCxgZFo5I6D7rXHHZU2/QnMcK+UkiN5mqVhi1WHaAqOo/ZDGByHC3DxEeiejltDkBYZ19elbk0C4607LioL9/jfHsQLO1Sc0k5JWKdKYwlg2I1D9T7cmYJ4s/NTrvePfw/xTIT/myvgIxkxNpz4ag41Om8PLfobQ/ryzAM=
X-MS-TrafficTypeDiagnostic: AM5PR04MB2993:
X-Microsoft-Exchange-Diagnostics: 1; AM5PR04MB2993;
 20:xetZdy37Biss4AQriTG4eMRJE7m7SJb8sq22JJ6Hp4rlTsP6NqNPSJRiSRPGw6UjAIiopoMEx1rwPJUX7bWWcnlvgADRZu0EiFn+EDTK0sZ5iHdVgOG14MiueecbnKI363/nugjXTp3mlWQaUnh0rSpnAWC5Y2Q8q0yAkUD8Vvu12jAVcbqf2Jj0OmWppx2syYoP6HQqEHW18qKojKWit3QEi/RmANivYZhJUHQo8SS0BZ0Q57B7QJtqY04u8IbAvr3pbQTAKpHfytyWaQk9E23erXkcKFIqxANXXY+NB52AAkt3agOh1+xLylm4r7O1gMB6ZFAngs51NxN8tcmPcvIVt2SetOP8GqpXsnWNUH2SrMXtlEXkutq5YFocU5lOoQ9gHON/xZK7l/NN6lfQic1VlhtQyeQC1yVWU+RdPKvdvTezGOlbfbeL4btTvNkUZwXivtAHqgPVvNRUM91xojFQDoKsUHAFfSdw0OFQLXR+R2Fuw9xMu2WhfQd++r1f;
 4:KCbDFxuM8zwJGRxFhB3KVFfJ1wAKwFaQNSJxwS0QQ0Dd378b+XIG1zyYG9q9Z1GxZoST1EUd7PWt0Bf8WR6G8JsROF1jp13X9bwUn34DWbxfFsbMJm+cOt6C5X36W0Qc0FFawnYHyzyqC23BC0CFPVNOV0JiLoUOpItLyEky1rg+8fecM7+HhPuy1ovjbuAyVzXmg8j3S5y11swV3Tem95T/iwvovEaEBXNhYCEYRgxOfnxgdK9FsRCZsS+/Fuao5t33+rGZuVK5i9hSNroufA==
X-Microsoft-Antispam-PRVS: <AM5PR04MB2993CACD097F2999BA24410A86AD0@AM5PR04MB2993.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);
 SRVR:AM5PR04MB2993; BCL:0; PCL:0; RULEID:; SRVR:AM5PR04MB2993;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(366004)(39860400002)(39380400002)(376002)(396003)(346002)(189003)(199004)(106356001)(66066001)(478600001)(47776003)(6116002)(3846002)(2906002)(186003)(16526019)(26005)(68736007)(51416003)(59450400001)(86362001)(6666003)(36756003)(43066004)(25786009)(6506007)(305945005)(386003)(7736002)(316002)(50466002)(16586007)(105586002)(39060400002)(5660300001)(97736004)(6512007)(3450700001)(956004)(8936002)(8676002)(53936002)(2616005)(4326008)(48376002)(6486002)(81156014)(81166006)(52116002)(50226002)(476003)(486005)(486005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM5PR04MB2993; H:otc-sw1.am.freescale.net; FPR:;
 SPF:None; PTR:InfoNoRecords; MX:1; A:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM5PR04MB2993;
 23:wEpNB63Z1hHFGZvSLVqwo0GZ8RX8Bf6oyHsObsD4F?=
 =?us-ascii?Q?i7u/DwTOoHaQ+0bjCbruBtodc60svIlF//fnGWk52Gb+RVp4O25eQm8BH2OJ?=
 =?us-ascii?Q?VqtOgIEVBSxFfr+UUU/fDUZJ9ZX6nDaC8cw0ZwamFlemT9w01s9IN9ickol3?=
 =?us-ascii?Q?FnAEku9FRN84BtndKnvkALm3i1iDk3EyKCNTSsv5Otyy5XorZBpBUwnL26XZ?=
 =?us-ascii?Q?xV90UCm4FVJMHAX15kiubnML/jn520PhR/GjARi2EuaI6ReAYnWLmcdkrAd/?=
 =?us-ascii?Q?4f3L9uNkxYvkrLucN/P15dElPjKbML14MPTFC15ieLO6owWLauoq7UGpBBzo?=
 =?us-ascii?Q?3hfz+v/PYTQRtWl8KCVvUCzqAV7Sv8Lv0Gu8OhIlM3HIRDdi4tiXRAMaZCpo?=
 =?us-ascii?Q?Ty4SsSZc/RRLmGKiQi+yvksIXMZvHZOYqFNl3q7XCC0pGriLh9GD2r0TJJew?=
 =?us-ascii?Q?vlioGPGOiR4vEzYlT9tthZoViObmNvwNvJRwy4bUOa6EEkx509PgpQ7tGVtF?=
 =?us-ascii?Q?VCshHG0tMoKY3eIRaAUKpoffnHKJeE9uQzSHKNGwpn89/QgjJuVvToJkmb0g?=
 =?us-ascii?Q?wS6cHAazIDcnbqnbiZC34kRyUA0Lxba3vZmBvj708FQZY0UlrHXHNOAnY1mM?=
 =?us-ascii?Q?GCUVM/80t4QI3ZTA1I4nch74XOHW56IpHML3paUGFb0CGHZVaJVskAlrEvPx?=
 =?us-ascii?Q?c0lu/uxAJ6DPAR9bMF6q6Aiz9JRF0/AWJ5AGqrmGnFQwHJjEJzRszrOxuKWT?=
 =?us-ascii?Q?GwJIIdsWr7uwsVa7Cx1fT14nMcgg0jLXC7pHaBcGHisRHzcApy1TzPY4u7Nq?=
 =?us-ascii?Q?/5xRtiyaRUKRYDqDhKBSmEjCCBG642C9QXb45e7f5768N3pKSayZqhoSrEBc?=
 =?us-ascii?Q?XEOpgwds4d2BXEvS5aE+6Etl+wiTVNTiXQais1f8tdYTtWxw3HKVmOlM9X2F?=
 =?us-ascii?Q?fKO0VwcZ+9J4eNHPcsRysBI0RK8MdwztFMl8T/KM5XXrWeXhiYtG180KVLFY?=
 =?us-ascii?Q?d6VWLJB+/Ze4EDg46ovBKJYoKGaQpvDI4HTtCYY8iz80Vs9vOPN072T2KlGQ?=
 =?us-ascii?Q?aC9kItrOyQmdIwVshrtMkGd8OYxBirFrmJYE68wNQlSJna9povTtxD5HiqEk?=
 =?us-ascii?Q?W8iQZuWIjNwvL2UjEePDcamqEydoTPNkPzjxmIv0d3B8D2z13s/ZSlOfWd5k?=
 =?us-ascii?Q?V5ku5HosgMGY2ytHlG0n1QzYfVti08UOdYoVkq3ykgwRU76G7R/3ZVcyg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: PErcs0rK1x5AqjLOCbe8oTdB56YkjTAKJwq/k56i0evf5/QPVwhfJijxLCJSwJ2euK+t0Det4GNQ+Li6BSxnRm6QyyKJQFRh5USNxl9dJxzY7gwAfZ1Pn3pILcu4gxM3A8ks4mEDyo37jlY/RyLifXS1hhoxWSWoxizVzBb0ncC/foDmpjd/NdQtDcF3bmeF
X-Microsoft-Exchange-Diagnostics: 1; AM5PR04MB2993;
 6:4V9AwZhhGnUzBJt3J20FwEwGp7H9U6bbpmpvc6/2of6xuihvlTe7KTumHMztEU/Y86c+RQl74We1p/8JkCFlak4yuvaPIedz5FVwxQfinROfk+YeC3iTnNAHQIOMMOhSM1uW0AQwXJ3OO6v8chEMOkA1rL6xvuITj1evD8C7+egxjb27g6b410Rbdjzt41h8IP0gV8J0gAS1vTmD48OsFCabHTZb0y5xeMafQjffuPB9cnCN69zZkh5yTYCi3h0Ma9/5a9QRbWfcSIFo/me2wgpEp3EWR8R2+HAQimDBROQU/b0aI3n2Y0jOq/AdaWjCRzRLl/8v1kANTOH/1DJJOPXLOKkyGQ8XteXD1GnUeE2RH/jxrp0xvxE4yECcw5xCRYC+6wMT+yVIOZ+v9IVbjqcla+WQsREtKq8I2gC5TyZ2Gcz2r8ClrJI4olqz9w/pBW42OP/UzQbatDP9x+osMg==;
 5:oWew1SZFWbLajTU7QXGfvf1YAroGpOJPPWLsLb7cDYRxWmdfbeUU0qIQHPWy09uEeWvNQbOX3uHsAL3xo+P7zboySCuOcILbeqgFISmu6GBje2r/k5JeQ7CURHpIgu9KmCHrTyU28H3HdWifhi+ze8P//neESflt8n6vkt/3sFI=;
 24:r0Niv2/a1PWnwn4ti57BculthQEs3HKAe99C+Fr+y9HDfLy0gcmLsazouZouSEANer2q3lzMpoO1YRh7X6FrSWINxBkzOgCY3q0rZlUvGcs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1; AM5PR04MB2993;
 7:mtHvUAfmAwN2VSMGgsMGop4i7pnD5fPgUyeCBCAA+0VRetnQA/c07OiGVBw25cZu8N/hl5Fb7Bz5trTLGxQr8U7OKhAJs2t75DyjrsnsECss7pHUdsMVZ3KKnF4GI94pWegD7CtuUyHk+TMmhUfFDFYqGC31uMPoZDHhUJtoqbAWKRjTGTVqO7Ses+D2te0Bqrwp2+J3iqnjuvs5BAPbp719mne7C8qeqA97c8Z9EAjaQ/ejImmB3QIR7xLCI6xJ
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 19:05:52.0398 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4458a2-eb0c-4693-2a58-08d5934c9998
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB2993
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Reply-To: roy.pledge@nxp.com
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, horia.geanta@nxp.com,
 linux-kernel@vger.kernel.org, leoyang.li@nxp.com, stuyoder@gmail.com,
 catalin.marinas@arm.com, Roy Pledge <roy.pledge@nxp.com>,
 laurentiu.tudor@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patchset moves the NXP DPIO (Datapath I/O Driver) out of the
drivers/staging directory and into the drivers/soc/fsl directory.

The DPIO driver enables access to Queue and Buffer Manager (QBMAN)
hardware on NXP DPAA2 devices. This is a prerequiset to moving the
DPAA2 Etherney driver out of staging.

Changes in v3:
	- Update caam files that use dpaa2 frame header files
	- Fix spare errors and memory leak
	- Remove empty staging/drivers/fsl-mc directory

Changes in v2:
	- Fix minor conflict in latest linux-next branch
	- Generate patch using -M


Roy Pledge (4):
  drivers/staging/fsl-mc: Use memremap for DPIO cache enabled area
  drivers/staging/fsl-mc: Fix DPIO error path issues
  staging:fsl-mc: Move DPIO from staging to drivers/soc/fsl
  drivers/staging: Remove fsl-mc driver from staging

 MAINTAINERS                                        |  2 +-
 drivers/crypto/caam/sg_sw_qm2.h                    |  2 +-
 drivers/crypto/caam/sg_sw_sec4.h                   |  2 +-
 drivers/soc/fsl/Kconfig                            | 10 +++++
 drivers/soc/fsl/Makefile                           |  1 +
 .../{staging/fsl-mc/bus => soc/fsl}/dpio/Makefile  |  0
 .../fsl-mc/bus => soc/fsl}/dpio/dpio-cmd.h         |  0
 .../fsl-mc/bus => soc/fsl}/dpio/dpio-driver.c      | 51 +++++++++++++++-------
 .../fsl-mc/bus => soc/fsl}/dpio/dpio-driver.txt    |  0
 .../fsl-mc/bus => soc/fsl}/dpio/dpio-service.c     |  2 +-
 .../{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.c    |  0
 .../{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.h    |  0
 .../fsl-mc/bus => soc/fsl}/dpio/qbman-portal.c     |  2 +-
 .../fsl-mc/bus => soc/fsl}/dpio/qbman-portal.h     |  6 +--
 drivers/staging/Kconfig                            |  2 -
 drivers/staging/Makefile                           |  1 -
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h     |  4 +-
 drivers/staging/fsl-mc/Kconfig                     |  2 -
 drivers/staging/fsl-mc/Makefile                    |  3 --
 drivers/staging/fsl-mc/bus/Kconfig                 | 16 -------
 drivers/staging/fsl-mc/bus/Makefile                |  9 ----
 .../fsl-mc/include => include/soc/fsl}/dpaa2-fd.h  |  0
 .../include => include/soc/fsl}/dpaa2-global.h     |  0
 .../fsl-mc/include => include/soc/fsl}/dpaa2-io.h  |  2 +-
 24 files changed, 58 insertions(+), 59 deletions(-)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/Makefile (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-cmd.h (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-driver.c (83%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-driver.txt (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-service.c (99%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.c (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.h (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.c (99%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.h (99%)
 delete mode 100644 drivers/staging/fsl-mc/Kconfig
 delete mode 100644 drivers/staging/fsl-mc/Makefile
 delete mode 100644 drivers/staging/fsl-mc/bus/Kconfig
 delete mode 100644 drivers/staging/fsl-mc/bus/Makefile
 rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-fd.h (100%)
 rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-global.h (100%)
 rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-io.h (99%)

--
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
