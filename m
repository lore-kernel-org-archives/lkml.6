Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751985AbeCTH4h (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 03:56:37 -0400
Received: from mail-cys01nam02on0070.outbound.protection.outlook.com ([104.47.37.70]:43872
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751524AbeCTH4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 03:56:35 -0400
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>
CC: <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH v2] crypto: doc - clarify hash callbacks state machine
Date: Tue, 20 Mar 2018 09:56:12 +0200
Message-ID: <20180320075612.22719-1-horia.geanta@nxp.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180305103945.3517-1-horia.geanta@nxp.com>
References: <20180305103945.3517-1-horia.geanta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131660061923510352;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39380400002)(346002)(39860400002)(396003)(2980300002)(1110001)(1109001)(339900001)(199004)(189003)(336012)(498600001)(85426001)(77096007)(54906003)(105606002)(110136005)(97736004)(68736007)(26826003)(76176011)(104016004)(26005)(316002)(59450400001)(356003)(305945005)(50466002)(86362001)(966005)(23676004)(2906002)(5820100001)(8936002)(1076002)(2950100002)(6666003)(81166006)(2870700001)(5660300001)(81156014)(53936002)(450100002)(4326008)(36756003)(106466001)(50226002)(8676002)(6306002)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR03MB348;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD013;1:tbkRgldIi3WNdgcbBJVYHuZvtOYPvpSmlT9m5lWEiBx9FCdNNAAQpslxTFNqBiip7RW3XnO0a8/1CFgbCamBvyWA0l+04tP8I/0vj7duOEzmjs6L4abnPxqKWbKLcLw3
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45988dc6-e3d3-47a2-8850-08d58e381885
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:BY2PR03MB348;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB348;3:9rKoaIxmwrnsNfU8XEy7afGITonOqtSK7Qhyz59Eixji43bMnIPLWKPI9hQLUlUc0Ww9nuirF5YTpSCIiYhxf+Q1uTG8mH6o7Ig4yXSpp1MGVMkicB2hZPdo95DAWivoqnCxsGhi92DF0WjoIidiIfxjdkNvJYaRfgzl/wBpZbQqhOFJUqtdLLt1YR0BMa/mWe8zm3JHeL6bUE9kVAzj/I4X7MXTWrYi4dYpSy/K8nQAKVYLPSvFgg2GIIq1edGxXWYIGLjqQkyp73EaPSH5MXeWYtxqIV7l/kIIf0cczI2RZNAn5EYHDDfTtB9fKc+bgBi0fFyYX+SebQPqGkkLs1BbJdMl6FnJaBaWoP/g1+0=;25:B8RFd1QAnbKwhoU3agjnCKb3J2rXSqprT4xutXkxqjjVBFmZOvTVTlv0RbTLXWMfmPZ5JDUBD9bp1TgPi6I4osNfaJm50gOJEYg3xUB994A0fXCcv0ZPzPo3UlnhU/Wf+Jpu6cu66cfnux8VheZ5/n6hgjXHw6A71B54Dye+jtTe4bCD7Afx6C2dRJbwv71lzcGdVAvdMgY9Ne61bQA1dHykhqZ7KZ5UCFRVFdpJVxxYqgmJ25fdpt0F+muJF+58lejcq0edRjUmftwdU6XGWZLD63S6i+DyRHIgUKMOvqfcjoboImbM8ugh2cqH5KnixOCoG71I8E695hQGalGnYg==
X-MS-TrafficTypeDiagnostic: BY2PR03MB348:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB348;31:IXYt5wyMu8nJ5/BSrw/fvSm7VF1b68fY2TSds8YPhV4fCaFvN6zx06QVwsmu5RVT7DOt+HTvekHAyGYwtXF9+0Nnj0oiusp7hcSDbtHC/iHQNMlOS4fsFlUUp4vooPLrXY6LUHRX6DvmbStzzsKTCRi48GWdXICNTMllch/XhjtOTLcsw5wWBEMLxqymqoC5QgHnIAnqAWeLqOv8mKUleFliqKBhvZI0tpzr4KSPn7M=;4:fmwX2XKY4gzoOled1GSSCQjA6367DeAgu11ihiZOZEU30qAh8GV7B5yagsL4D2+QKcAbh2s0vI9Axt3+vGM1jErYKPFyISGXFqKPnX6//CxbE4ZA+SBoGbSiNPQz9tri90tY3b1aHvtayEppBDJlSPVYt2b8CHslQHZZSXQj63ZIs5vDkQWrYcY1IMJH+UeRj5TBnqgR2oWA/U3pAwziMuDqzPZHUF9nw3yadcPluqHYKx7YK/GeLHRgTYbrFW6yIHEOqLiFihhzOgePaZmrcsW2R6n7XaVwVLvIccp3+4h0I0v8UXG5rPxqHq59Ng7fjoJR+eXPwmOHTf0fyMm4UpQvHxB9ZYgT4HZ64jaqrbQ=
X-Microsoft-Antispam-PRVS: <BY2PR03MB3484BFAAB846F0459DE1A2B98AB0@BY2PR03MB348.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(42068640409301);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501244)(52105095)(93006095)(93001095)(10201501046)(6055026)(6096035)(20161123563025)(20161123565025)(20161123556025)(20161123559100)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123561025)(201708071742011);SRVR:BY2PR03MB348;BCL:0;PCL:0;RULEID:(400006);SRVR:BY2PR03MB348;
X-Forefront-PRVS: 061725F016
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjAzTUIzNDg7MjM6elgwbXpYMUhVMExOK3Y0K3Fhb3c4S2IwYW9u?=
 =?utf-8?B?UFJ5YmsvVjA2VnNNLzgrVzZCUE9qUnk1TFBxRDVjOVRiZzlEdkdYclJKekd4?=
 =?utf-8?B?c1pmaHdQdzFvc2xqSWtZdmhsQVN1Wmh1UTFNSUNNUmhaamRjZ25QTG9VdjZM?=
 =?utf-8?B?UDRLd1poT3lzMHRLS1J3NlE1dnZ5RE9RZnJENE84MlFrUFc1eWdodVpnVms0?=
 =?utf-8?B?MnMyc2NkV1d4VzluNEVENGYvMVFsK1pvRlJVWkp4NW1heHZlRnBPaEJaUWkw?=
 =?utf-8?B?OXdvZGJnSEdqbDJTdk9YMndTM3N3L3JLVGVzVlNJcWFkVWNlaU1XaC9qKzdY?=
 =?utf-8?B?Y25vNURIL1FheFRteVlkVkJrcVVHVDlqdEpXRnRxUU44dENIU2kwOXJCK2Jo?=
 =?utf-8?B?MTQwME5OczFrTUNaQ0pGY204SnpGYnZ3V3RZTWlLMDkveHh6RGhVOThpT09W?=
 =?utf-8?B?NmVvNk9pckFabUdHREZvL1B6K2RDRUl4U0Y3elpFSkhHSXlRZVRRNWZoOTNH?=
 =?utf-8?B?UkdBaVhVMTNDaTVZSzFGOGJLdGNIdWRJdis1cmlXeWtJV1hHWHd5SFdMdGhq?=
 =?utf-8?B?d1UyQk5qbGxCRkdXM3ltK1o3TlZ2enhGRjdYWWpITC9SMTlLaUFqTEtwL3lB?=
 =?utf-8?B?QjBCbUd1WW5IY3JyelBETDVZVzNjNGhtN2cyc2lpaFdxT3RqNkhIVkl3NjNV?=
 =?utf-8?B?bDRWU01NbWx5Ly9JdVZzOHpIQllZV2w4ZjQwTjlFT29KK2FPZGhramYxbGpi?=
 =?utf-8?B?V053M3V6QStXM0VZNTFLSThZaSttaDR2MGpEZ1JJNEllRnJMQ2lXd010bk02?=
 =?utf-8?B?MG1iVWdSUTJDWGtLWEZRTzVUbk9jTHFQRXNGamNrYU9oY1ViaFlxdHpaNWFX?=
 =?utf-8?B?SzlDV0llRUJIQkdPb1FHTkZRYUwyZldaRVR1eDYzTzBCNXRHZzBXK2phWFlQ?=
 =?utf-8?B?MGFGb1pmeGYzNVVHMi85UGZUNGFtUThidElKdHZvRE9hNXJnV1pPSHpqRWg3?=
 =?utf-8?B?YU5NSFV3ZEljRVhzL1lObUE2RGtmS2RhZURXVzg5eEc1d2hWbTVMS1UrTS9Y?=
 =?utf-8?B?RFBTWVExRmdGUFptK0FZWjU0QTI0VUh4M1pXY09XWExYYXVBREorNXpRd3No?=
 =?utf-8?B?S3MzRWxoVWQwQlFrOUhjcnJrVUJlMDV4UExnUzlkeXNhbFFuQ0x1Wk9NTDhX?=
 =?utf-8?B?a0xjalY2UFQyN3FrSlA1NGFYSmpPQUlyMjRPMUloWUo4WUMwK3IrLytpd3pL?=
 =?utf-8?B?cjMzZC9ybllNTE5Za0lRK3NkWjREV0ZiNHRyZ1BoaG9jZ3JPR2hBNVNGYVli?=
 =?utf-8?B?NGlzYXcwazY5eGs2UTNUUElyMGZvQzBoYkNvQ1dDcld3SHU3RXV5ZVRDcDFI?=
 =?utf-8?B?Nk02d3hoTVlZQ1NqQ2dtSWlBNUxZV2haeUQ3R2U2QkJCQzN1WC84MmdsbmNl?=
 =?utf-8?B?eDZlQnhLUzl0aU12MWxKZjN4a1lqbWYxY0FVVnIraEFvYkl5RlBHeUFkR2lO?=
 =?utf-8?B?ZzFKSXF5K2hDaWlyTkVXeGFyQzNpbERueENvVU1NajBzbWFSQkZjWDI3TmRk?=
 =?utf-8?B?U1ljZEs5UXZoa2tmVERDZEFNU1hZWlIzcGtJTkhLSUtVWTdmNjk0Q3R6VGtv?=
 =?utf-8?Q?NA9leR4xKIFARRRyCDN?=
X-Microsoft-Antispam-Message-Info: +x+Gy9UkIbqIcwFOHaB5+mivA8eqoPr7Z2PpqdLLXVB51ECQZOK2NuTBOzKW7SM8jh7f+BPcxuUY7HFgI5PnUBm5Ka/Xz/ACJnpNyIx5VmFEmjWAIObqDpJUG0zmDHc9I5bS1jBZSak+eTi+ZX/Mioo7PYunANQUEqgm3TZA/J/eiP+A/tsTxy46wifA5G7f
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB348;6:88uRtKuosyuPgzV1/70K3iUnb7K2s0EWYydA9yC99wc35XPosqJkK/RzW9kCYNjjMNLMVkj9UL9UIXbdfVDD3VUWkSsiyiKKlAn4e0Ekki1YN0OW3rRrwNmL7it3jjcIg7tzlwD9Ki/DyR87e8AGymhUG0TqL0CfVEoAPKo1awS6orzk5tBPCJFhDuz+kGvTpQRTHgGHmGcZ55KZ7o3tvsUKpCMWrvWmSctWtHs/k21qF7nhzTYmUEN40Kv7zuslbp6kDKmm1Dc3jWitRTqDoaduS8x6ttqNMhjdHocP6df6PO8bzGPksQCj7nRjeVOmTIpO1CMqXodG+7dJUSKe+PipicFvaJlDiNHImd6wXf0=;5:Jh1pVu0Tn03BwwOUz0CLqPt/SkCetNmvs5oq4kxjjwMQeEVV2WhM/zcsZjtMFw/XXtfVyL4di0CxGpJZqGrYTdrQ0Jyp+ZAuwZgoM0LHmQ3Edd7HHAWFwzziCYftyNlKKFEX4BpiTdTGD3eBhkuJXj4QiMGqd42KxtUr7VaYD/w=;24:qGftqpUwA5T7BHHygTTdOpredAegKYxwq38bLTN8uTcYCI8/T4juHp98tHTKm/jMabO1FW4/vgEfvR+397KKuQpW/bXRxW1g7ijaJYMEbus=;7:85pGa5M55ww5182KOzV3nHThMk7t/CPW+entD/vXCGjXVN5xidu+3b4yUK0l+h3RaNmME2IjNy8Maxk+MxM24kbRSRsC3SAmKVPJTYtxcY7z0u4zE0fGXUVEtHFoUAgQFn2dQNyp9s34F8ZYeNW34fdDJ73+xK+WD6S3QMCSAZ3Vdgif07jeUcPKp49AVyDI0wXQA+9U+eq8ke27pj+4cEc0Jbs1Lef6oI+KxftpUsc/pZEhzwqOICIUyjL8EGZa
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2018 07:56:32.1794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45988dc6-e3d3-47a2-8850-08d58e381885
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR03MB348
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a note that it is perfectly legal to "abandon" a request object:
- call .init() and then (as many times) .update()
- _not_ call any of .final(), .finup() or .export() at any point in
  future

Link: https://lkml.kernel.org/r/20180222114741.GA27631@gondor.apana.org.au
Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
---
 Documentation/crypto/devel-algos.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/crypto/devel-algos.rst b/Documentation/crypto/devel-algos.rst
index 66f50d32dcec..c45c6f400dbd 100644
--- a/Documentation/crypto/devel-algos.rst
+++ b/Documentation/crypto/devel-algos.rst
@@ -236,6 +236,14 @@ when used from another part of the kernel.
                                |
                                '---------------> HASH2
 
+Note that it is perfectly legal to "abandon" a request object:
+- call .init() and then (as many times) .update()
+- _not_ call any of .final(), .finup() or .export() at any point in future
+
+In other words implementations should mind the resource allocation and clean-up.
+No resources related to request objects should remain allocated after a call
+to .init() or .update(), since there might be no chance to free them.
+
 
 Specifics Of Asynchronous HASH Transformation
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- 
2.16.2
