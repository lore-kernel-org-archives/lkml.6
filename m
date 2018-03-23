Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1378361-1521812692-4-5813489879244036825
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521812691; b=KS6AQQ7ASueJyHyj2ndbDBkAnyeUaaXPB1vHM8kEpwesb2Z
    8KxblxpvQ0kzyXAKk0xjtp4R2z0284Vc4Zb06e0QaXs0Cg+0yryQh7rxnopcOU/K
    YcNe3yufL3jtKcIX7WiNA4HJAATeAh8YMXJVVCWrgMPKCXCXt/89AWHRW4fgQRg0
    TzlZ67QNii8VzX/E3UowZzO6zQ/8ifazj3mjQJ9Rg7OrKFTER6+AyGkQc8zg9UwE
    uSo1j/kplTsNpzluwLZl2glEyynFfYBZU/Gfl2oVJnbr4nxjmlgiFnd9Vvk3GMi6
    /M0oXizF4+gu5vpZByzrIOmgHr8QABVD3exEEIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521812691; bh=w
    sSrb53qVB5M94eB2vtOTXXOrEagW4myqfYJGkW4Beo=; b=cyCILMf2/v2j/76bO
    ghSFfU1+Jh/T6ah/UmFW8a1PF2OV3GnEkMynFqnUFp+bK6JFwTXGmg7EWz0OjY38
    u5sMd8E7MI7FWH49jhCVdz+1MLOhDFcbI3/clu0ITdx0lMIbZoQV7G0ERNvdaFjm
    z6AfSyBSI3QUphpVmtvN50urt0Q3GRjL9Zfxp6/JFHthNOtyHaNxDemsisQOd8MF
    ou8T6AJ+MxgPjg2Skatv08SY54EvRw7sEIBhU6Nw3nOfLi4pN/2dtSktrkkN9lcG
    Ao+u9/ny7fRF1vttf5ayDEvoPseYV1rm9FWyLzkhm+HoSYiwJ7WWbZzyXMw9hpV1
    CZOQA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=qLIw2Mku x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=qLIw2Mku x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com;
From: Ioana Radulescu <ruxandra.radulescu@nxp.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 7/9] staging: fsl-dpaa2/eth: Cleanup TX frame freeing code
Date: Fri, 23 Mar 2018 08:44:11 -0500
Message-Id: <20180323134413.1532-8-ruxandra.radulescu@nxp.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180323134413.1532-1-ruxandra.radulescu@nxp.com>
References: <20180323134413.1532-1-ruxandra.radulescu@nxp.com>
MIME-Version: 1.0
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: BN6PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:405:39::27) To AM5PR0402MB2690.eurprd04.prod.outlook.com
 (2603:10a6:203:97::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ca077381-e97f-407a-b1f4-08d590c43794
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:AM5PR0402MB2690;
X-Microsoft-Exchange-Diagnostics: 1; AM5PR0402MB2690;
 3:Ulsm90vgN0mPhng1rnnypUBoung5I9qAnkC6EclXPKjocP1/A64JMPGlJ9fVxQuTZT18rbJTAM7AQaCBh/IFoFQco5+y3CtKA2+NjlPvY+PgfyrxzFg4OjHFVowSA3IWU/PHV6IYW6I4YOODjlSykiJQVvL6XwTTh7H2IDa+blbJ2qlQOFkDPeGRcGlsXuEM3uCEDSFqj14qKd5TUSKwXki+7HxBgoyR/c+vooU9w19qUUncO2JRe3bnzGcUI1DD;
 25:JbqWz2xT5r0BZ4CUZJwm7bNGx2UuqLIJvtStqqoj/OLaRdRQglKRmo6GB/6/JyaURUW1n3sErQKEAvLhuOFGb0ldKi76orSeFFgx/Vq20aQpekD+j6g7WyX5rAH9N8/OZqYjuwxzBN/tZAPz9Xs5LoQ7U8js2/a12dsQKp6aitmdvNHCeZ9x5Xsrb/So9zzc+Rjb29XguVeVg9+v0APfNC03fOCAdkDg5w4t6a/eU2HLlpfVr/C+f+Du6r8SfjAVyMih+qN45rCZS73F+07phGMjGZ+mmhzRpzbsIfA11fS0EmUlfW4NO2obozMt6+TtyMfRH3CFLItBdq13sZi5rw==;
 31:BN8vmnED918sTf2xTH1ai4q4yMu7dCEMDUdfPvW4d9/XkKpCb1Kfcm4D0rbpmPOpS1nunH8RC5uaHTa9oz+qWzSh4igFuvqRHP4GFw+59JZ0l+h7e6d5M3QJ2MyAn3ip6RTTsP8i0Cf118l82q6BBtEsCShwzPh7bt3EKadGGbhJnj4gFhYUi6t+20AK28Y4E1r1eAQXqY+tuFYNROhOPk5Rc9axdCgzT81dAVRx0ko=
X-MS-TrafficTypeDiagnostic: AM5PR0402MB2690:
X-Microsoft-Exchange-Diagnostics: 1; AM5PR0402MB2690;
 20:JKAwCr0OJdh6MBdo3LzXijWJgIRQAM3b6o0qZOc9upoI44SDQMa6Ivrdddbr5weKM/dpORBvXgpqvXI2YcKwoLAreOxnG/klZXbDf+g0hCms1PUTvPPx1bIDkU+O1jVR2ZohamWcnSHDUpveWt2aUYdfpr8AVmt1nqA4qzHkpft7plGOTRTFyIkB9F/0emVhw2ibwqmcdfeh8PcErtCBQMxCVtzkklUViOsBqijOx9TxFe8SIGNCGAnRup3tACPWgc/VfA3FUef58ZZuDWYjfhxeHH2fbxCFGatXW/OQrEBqkaggbEsUh9pF+L4FPMYZRQKQsoeIljXSL8msdE4GJOfJhPFAfZ3mCyQUObDJgX6dQfysqVYTJVUxcPIHYZaLIQQXszxJ1RpbE3WhBNMjpbfsOagpUKxPTSIp8ruUWBO10ky28H9FI1hBj1iUy/HPTcDQ9ejEHZU3lavJQDGZ6aOVggkQlUiZoS82IauLFSOQLCNx0rleOtolb3EWeWnN;
 4:+ehuOJnY92yD7SkR96HOILP2kjMhcKGWGx/tX4lMUZytBMC3CLTJyOXMZKB/3DCX2iMgCrdYWu+A2jYE9s9BOeND0DrjM4G+u4JhCqEcyHoutdEYGO9EqRxEQGs7Hcs2UZjKY/TBdTlrqKR6KlOJteixZ5fNs51dYJHB54XE1N+hT25nUeedJ5VtmuVUSvU4YAme7mO15CJEPBoPndqzFZTU1bYJvfspLXYTPYR4cA543XvnRzoW85uN/t1ZGIYVknv6Nx3Tf+SIni6MCDviHIhEZx96GkdbgDasK3JLiSGVjNX1njM6A/nEwpORo3Fb
X-Microsoft-Antispam-PRVS: <AM5PR0402MB269026EAC45D51DED937766394A80@AM5PR0402MB2690.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);
 SRVR:AM5PR0402MB2690; BCL:0; PCL:0; RULEID:; SRVR:AM5PR0402MB2690;
X-Forefront-PRVS: 0620CADDF3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(346002)(366004)(39380400002)(39860400002)(199004)(189003)(50466002)(25786009)(6512007)(6916009)(6666003)(7736002)(305945005)(5660300001)(386003)(6506007)(81156014)(6116002)(3846002)(8676002)(16526019)(51416003)(50226002)(1076002)(446003)(2906002)(36756003)(81166006)(76176011)(186003)(66066001)(86362001)(8936002)(52116002)(4326008)(316002)(53936002)(68736007)(47776003)(26005)(48376002)(2361001)(478600001)(6486002)(105586002)(2351001)(106356001)(97736004)(16586007)(11346002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM5PR0402MB2690; H:rhuath.am.freescale.net;
 FPR:; SPF:None; PTR:InfoNoRecords; A:1; MX:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM5PR0402MB2690;
 23:foeB89V/iyIyCtSRwBFC+5FUqnizJYLUzyZciFK?=
 =?us-ascii?Q?eO0Web/7WvWK3y4QLyXuOP06NUXNEuBe9WgBbTmNGQEwZ8Q6RZw156Somp+f?=
 =?us-ascii?Q?Iw1ZuZVp5vGG8o3SEFD0YywSevrmnZHgLp64K2CVcQ/pXmd47K4G7YkgRv5Z?=
 =?us-ascii?Q?ilkdUgO5FeF7YXzwDT0wIAj4FaYwCeeUBCYwDjMkshiUCmzv5d2IDy8ILdYs?=
 =?us-ascii?Q?hs7QFGp2JEbL92NooLQxfAxHC2MmolvICZ4v7KzB++CUKNyZBfF/DZN7HXww?=
 =?us-ascii?Q?/LDxyGrjPI7qq8i/WkLZtaYxvsman79EzTMboklUZi8k93aySYB2jk+gZQtt?=
 =?us-ascii?Q?MwXE8nb6iG4JjdYBcPdT/JGR8tqUQf4HZ2ZCFfqJoWjQxw8Q1pvQeDry2XTJ?=
 =?us-ascii?Q?vZplAKC64ShjjP0fe7z+IMUEtFIjs5ffDbAp5UfxywEKMRuCEJnc55wFKHV5?=
 =?us-ascii?Q?UYzGwPV2CY1lcL0w0LxQ30tHvgnD4NuVshQGAm1Oi0RJXFKrJQoxnL2amnn6?=
 =?us-ascii?Q?x8twjxU6mhu9tehDdjkJ9baXm1m5aWDZF2/uiRMa5fckdHjIqnX/ody78BgF?=
 =?us-ascii?Q?yRWABz6G3DVidyQmABsWvctvxxg+kVWZurA+blMgaWinHFrr161cPr1Xmbxm?=
 =?us-ascii?Q?iA0cYwhHYy/MOKq6ZAcrzElZvkbgrpOe2EeJ3+7lAy4wG0zG7xf4Gwxvs0rC?=
 =?us-ascii?Q?F+50IKaB3VMKxUXBMjY+3O3Mg39CaJl1FfrVYxWWDQ1cbjrs4na2ZKZSA/Le?=
 =?us-ascii?Q?EYKua0nUkaX4Bsd7VV+zS5OHBt7c9GWMMbhmKsEGiUcuaCeyEgAft9D0X112?=
 =?us-ascii?Q?VGc/tO0Si0Cjl5fid/fFvIoVPvKx/GimbecuoXKJKlsW27mjqZzXwiRTnX0f?=
 =?us-ascii?Q?9VLtVFk6FfngOZy/ekyM4ppzqWPI3r5bL3XH6l/pNPlifHi21Dxv8E9r6GWU?=
 =?us-ascii?Q?Qq78h1+9PFUjKzrk/lceKID1mkvzsI8i9pSX3gsvmE7zYeBKl5qbnpetYw0L?=
 =?us-ascii?Q?r1BCyXFtBJ3Zz6rgP3GIIlzSTwmKer8g+Qzwb0wuK+rctuPWUpw41hbhM8ku?=
 =?us-ascii?Q?LbYNoOmHhqLJeCe4+xybGToemnGJjfJiHdSAL2SAYJUCKGZ6clhAMecp6I9H?=
 =?us-ascii?Q?Gu0Bv3ctUW91tGjcRuUNJuBZqcNf83I9FNJ9eWCNVvVylpEAqzVAV1g=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: VYOf++RxZW/2w4T91teQNU9wNRJEkxJ166k2C+WdFNDMPFzGWS3aOd3USw4sQh9qIAoJL4IZFDXelbN5yCnBeRmQ1kvb6VWCamQq0FTlGAuO17/Xe3nSz+UdHmnxTEm/dbQDFlMlMDoUjPlTLWgCtBvWwENnX41sdeTGLFZmCgKyeuJgz1Vy16LShN+283jS
X-Microsoft-Exchange-Diagnostics: 1; AM5PR0402MB2690;
 6:cIdB5cxkyz8JgeNkLU5Qag117zZ1hj2L66yw7D8q7LzMvZMhDuYYZqbGGMf3zD9V2p086MZ3uMEAwt772qUdVEMmJcXE4Y5d6KxZ7wLNSwwYkWUR9vkaA0Hclqg0spm0uqi/Vj5W8hCE8jX3px4D8cMkLrzhErlGR/vU4b8ZVidH067xyfmpJbNdxAGEAah7XC7HY//E6QOfvMoO+v7cpHacAJqSIiPpHbbfhYPq1ql64KZg4wq9WCAMcZv7/bzUI1CYdyFIr7z4KxcmAVLN8H8zSgeyibnJk273/ZpEj3hBhGJ4gAkx8otJKVVrRSoT2kfgwvTpH3r46RtLUIlZpXzYfbaOUIs//Bp9MlDBprXB2t/lNCKPmXBybZ7uz3m1sL+xktzANa4HMCnLTVdIMthy0ruZ5MOyoEzCtrdkk/8Bapch5OwvASQOB8NSmfVdFkrgrPhX7zirtQAjfMFwkA==;
 5:mhs9NY6lz9awfo/YHJoSOpGMph/7n/OL6GXJjP3KNXo3Dfnx/cJfcMGU4D1aLKcNFNCIDlniNyDvOgAxpRAZ+arhJpMbpOnRnKFYRlIq8Ac6AdHdTNXZ4wRWWtpL6Ahsa1ncZcOBfLVuvkWTAyGG/nQiznysWivNX6QZwmVjYXQ=;
 24:D9DHVx9v+PK5IT4Wd3A+BRq1BZbA0pYieX8mkvqBMeRVhkoekbpx8KOIuN9JtoiEgWczuYRsdLurJ4Pcr2YmcPy/mktqVFTf3tQToZu1WCU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1; AM5PR0402MB2690;
 7:OvRLLIv92HeCWcBz27GoSpnLM9c4diZcVjgeJGNyLMMxtrmApbzBNQ5PVYpQqP2ZNVj4SfLqqlktAMgLR2HlRO8UJxmXikdmxn5cbKidcelUYFrauPweEMpXoW4CXE/kztpHkZxgtKmcZmdKtGqlnWNv39GW4qiPU/G+JqFvn5vDxJcm3ItiV9kscWk8TwnbUmKVeHyzQ0Tlyxk4Jq0EegZzqeTt3odid0NJnVpHa7+wdcxdsptznVOTAKNl8/+V
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 13:44:35.3956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca077381-e97f-407a-b1f4-08d590c43794
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2690
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
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Cleanup code in free_tx_fd() that deals with S/G frames:
- remove local variables that aren't really needed
- in the frame sw annotation area, store the actual SG table
buffer size, which is needed on free, rather then recompute
it based on number of S/G entries

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c | 17 +++++------------
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h |  2 +-
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
index f58c85a..9994922 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -406,7 +406,7 @@ static int build_sg_fd(struct dpaa2_eth_priv *priv,
 	swa->skb = skb;
 	swa->scl = scl;
 	swa->num_sg = num_sg;
-	swa->num_dma_bufs = num_dma_bufs;
+	swa->sgt_size = sgt_buf_size;
 
 	/* Separately map the SGT buffer */
 	addr = dma_map_single(dev, sgt_buf, sgt_buf_size, DMA_BIDIRECTIONAL);
@@ -489,9 +489,6 @@ static void free_tx_fd(const struct dpaa2_eth_priv *priv,
 	dma_addr_t fd_addr;
 	struct sk_buff **skbh, *skb;
 	unsigned char *buffer_start;
-	int unmap_size;
-	struct scatterlist *scl;
-	int num_sg, num_dma_bufs;
 	struct dpaa2_eth_swa *swa;
 	u8 fd_format = dpaa2_fd_get_format(fd);
 
@@ -510,18 +507,14 @@ static void free_tx_fd(const struct dpaa2_eth_priv *priv,
 	} else if (fd_format == dpaa2_fd_sg) {
 		swa = (struct dpaa2_eth_swa *)skbh;
 		skb = swa->skb;
-		scl = swa->scl;
-		num_sg = swa->num_sg;
-		num_dma_bufs = swa->num_dma_bufs;
 
 		/* Unmap the scatterlist */
-		dma_unmap_sg(dev, scl, num_sg, DMA_BIDIRECTIONAL);
-		kfree(scl);
+		dma_unmap_sg(dev, swa->scl, swa->num_sg, DMA_BIDIRECTIONAL);
+		kfree(swa->scl);
 
 		/* Unmap the SGT buffer */
-		unmap_size = priv->tx_data_offset +
-		       sizeof(struct dpaa2_sg_entry) * (1 + num_dma_bufs);
-		dma_unmap_single(dev, fd_addr, unmap_size, DMA_BIDIRECTIONAL);
+		dma_unmap_single(dev, fd_addr, swa->sgt_size,
+				 DMA_BIDIRECTIONAL);
 	} else {
 		netdev_dbg(priv->net_dev, "Invalid FD format\n");
 		return;
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
index 5ac014f..fc9a255 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
@@ -108,7 +108,7 @@ struct dpaa2_eth_swa {
 	struct sk_buff *skb;
 	struct scatterlist *scl;
 	int num_sg;
-	int num_dma_bufs;
+	int sgt_size;
 };
 
 /* Annotation valid bits in FD FRC */
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
