Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1378361-1521812679-2-6507971598959443330
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521812678; b=JUK31GM7Y4xP60Ig3jPeHwXEzppdqCKvxFfXG+QDXSlqxEA
    Z3TopniM9MQSXwpItT4V73i9JhDZIV1m4iZ0ZghOCo96L1UNH+k1BPBXz31G0Faj
    z80Eaf7eWrk317p7LRWThend56eDBQSBcF3RkTl3yHJ4ky5qOPCJe0e6bG/ejGpT
    b44S2HJa/UFsld0tySaVwV2D8NQGpMVYp9F6ztlViwnCOYVwx7RhPiLyaXpM1xJI
    IAl63FmV+EkxSaZTT6lsfehAJGDldTFQ+SHX8cvQEU0EzdBaqPBAE6x4CMnU2Asz
    kBCMzz+fBwroKhxVKTq6QDl1veWG7AUNFbFb9Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521812678; bh=x
    z0fZp7OM0Bv1k+XW10DvDols8EYBzX0L2sOa9Ytahs=; b=E9tCrxwbAwZI/3Fqx
    F7ju9oaa8eBL/9jhUzAM5jv32VyqJxi/12ih4vE4Y/86BVStv7w36hVaEjN0ZTaq
    4NBNVbnGK4+sjvQHbT5OzaaA1t4HVK7K4ifYkG3UChrEpKRMpIpJDP22e671iIMR
    g1dwzHcz4FqC/VVcvoopUeDf5E7jxso7aVqdl/PWkl5H82hMkrXGTfPFzTJp0Hpv
    +cjlpPvOosxp5ElqRUScbzPDNo87Z8w9ht+TPqViEBGFfLOYszsgSOkoDIrIZv1F
    WEUjgu2YsxdZ6RDCGcL83xcOCd3ibdueGBFySx6Ojml7+rkwSC6nApzSJfAP/iZL
    CL1Zg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=cjdfg0cr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=cjdfg0cr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
Subject: [PATCH 0/9] staging: fsl-dpaa2/eth: Cleanup
Date: Fri, 23 Mar 2018 08:44:04 -0500
Message-Id: <20180323134413.1532-1-ruxandra.radulescu@nxp.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: BN6PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:405:39::27) To AM5PR0402MB2690.eurprd04.prod.outlook.com
 (2603:10a6:203:97::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b0c5f873-1b74-43cb-c7ba-08d590c431ec
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:AM5PR0402MB2690;
X-Microsoft-Exchange-Diagnostics: 1; AM5PR0402MB2690;
 3:94ONOylwdAJKSiKj0VUlBOVGWXTpe4ctQpYMUBXqaQpsgZ/c1555p03CKaft5X/hwxBnX2T0InolWtaxwZTgHnDlf0EY0XhbnQpxNtFG48GIAThkD22qeNQk44vD12ZEOJ97z6nBykmR4uYAuBItTmwHvc+0BykmuRqT9/JS2ED2fVC7y4gj1D7+BWfww3RwgDUUOXYEj78brgArvpWAVZdQ7YLXE4vG/eUhrDEMflXFWZQNUAZsijn9jq2EJeGg;
 25:rH2Nbf1iZiCnTKgipgW/N5iKEt9vkD/GA7CKi3KsNevRwWy4j7W6p8+Z3bndeAKFljrERYCAaj95lqMucel4u9Xs0x7M7S26602O2HpojLolYOnZ3YDJ790YrxKpqJLSpV9cWFTOSTzr17+qBd19ZdO+890MBhiMEtUn7mW1m3WY/cfnJWEj6n6qu2wLFdGCimVhuB3NMmWA96qBIqGTFs1yCdW3vq22Tr0ZFblhDUkK3bqVvc8Z9oNhUtO/AlvWihQP/I8rUf6xif+C2Osis+juRLR+JeHzr88RVTeb/d0VDyi+xXWzcKvRMTSG9M93YW9Xy+51L5HfEAHdnliOTg==;
 31:TBb+pPxfanS6bu9YwhxYCoLCBq5q0ZkGGKTtsmLlem34F+TaH3yXPf9IQ/VZ0bYz2ryuZ4i7/U1wWrVU4cJ2EUmOY6rLUXJUWRbVyBYIEWxF5xQFXqJ0LhSEdaz1pjt3LjH22iTx4zPAHRW8FcBaYetjrNV0PPzpAytBIwwr+lt/azK2wA/YUDlNh5Tl/nq3GfnISgfgGOIhv38+aM+1Ymf8vsI//YFr4S7KjNctJGI=
X-MS-TrafficTypeDiagnostic: AM5PR0402MB2690:
X-Microsoft-Exchange-Diagnostics: 1; AM5PR0402MB2690;
 20:u6XJg0XmAQK7uOqmkVB+ZXeK3QggxfQ6oOJLy+07EdAMoVF80RsDfhAc2nrZ+lBRW1xI1r1H911vnO3XKAmzEdpz+rsmc12k5rbo58iFlkgPUCeS8datysiMQYHUxXgShqsACNoPgarBQtdT5geMyiNyUeav5yq4IywuN8+HoLUx22JdmUif7iiNo+pS31t30viv8OwfRXQqI6y6R34C5Fvk3kFEA3ax3LtTLuvlPx1/tA1D9HTJXDrCRYpW2jaVqDw5+J/gBTOyD8kobQYsq9zpRb+eOgtbRyMEw4JGN3aCgoCn8Z+zen4kjp+xoqt3D7JrFsF3pRa4vqJZ8SQHOqXfS51WxgXT50gTvqBoa6tCfn3YznFHoveaa6FDEtrrID8ML+SDJCHK5kkJr2jSlaghi/Ce5/iKmHH5CTfDYF9/XE6lqRuYxhZOu+n1S2eiWYJ66UfDkW4NXDvJB+7KoQsJuWvh6HxFwA5GWkqlplGtPVMQBLNHH+fIUB1tFG0m;
 4:K2BSlgLT18jU8/HoXbLxH9J9xuH+IeEm6DZebhsV8FqCL1YYa8fW2OX3fM+0RbOLMKrCGLy4+SD3ew+l5iv/Tyh/UK3MY4RxsqlAIy19QkqmcJriWUvtxUdpuOLBu0H86AyL4BcP183O2GQHpzU1EVwd3q5kG3DsZ96Aqje0wfeaJPtzxf3g94kiWficQ4QTO7REtij26yq3blzCRIRG125tySbMTdf82Wr0+s7QCcSN6m3brHEAkBcrQtmTJQZZiwDSQIcqI8+fvL+cGK3byA==
X-Microsoft-Antispam-PRVS: <AM5PR0402MB2690EC86EC4DA95D6268471094A80@AM5PR0402MB2690.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);
 SRVR:AM5PR0402MB2690; BCL:0; PCL:0; RULEID:; SRVR:AM5PR0402MB2690;
X-Forefront-PRVS: 0620CADDF3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(346002)(366004)(39380400002)(39860400002)(199004)(189003)(50466002)(25786009)(6512007)(6916009)(6666003)(7736002)(305945005)(5660300001)(386003)(6506007)(81156014)(6116002)(3846002)(8676002)(16526019)(51416003)(50226002)(1076002)(2906002)(36756003)(81166006)(186003)(66066001)(86362001)(8936002)(52116002)(4326008)(316002)(53936002)(68736007)(47776003)(26005)(48376002)(2361001)(478600001)(6486002)(105586002)(2351001)(106356001)(97736004)(16586007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM5PR0402MB2690; H:rhuath.am.freescale.net;
 FPR:; SPF:None; PTR:InfoNoRecords; A:1; MX:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM5PR0402MB2690;
 23:XznyUpLLP26L2vJYGofKw8XWP3rb0jUWNmq0tKD?=
 =?us-ascii?Q?IjkAN2EwMVAakv7Vt8ZW8A5zilQ2tDkZcsVUGMng+l2PVR3h/7aPCb7jdZeP?=
 =?us-ascii?Q?/ECG+Nx+yhlXJ/Yqb3TI3d0D7/AcKVbIceOXQEPKFfC8jVitUgI1/9LXX62M?=
 =?us-ascii?Q?MyP0TL7RP2joCMeBlGAMBdDnQvLx+4Kf7B2aB9YCZwhC2hOjgp2FgDZfmrIc?=
 =?us-ascii?Q?1uhyF7BYRUXfVLifhBaPTZZuCVS2zSLQ0bnvEDT1EKUGWZnne/rXv0g/I2oW?=
 =?us-ascii?Q?OAaTWWG0sufFqZTTsFShAlUOJMmYbMlnH4eRPlUXfTjm0gAMyCuZJbudxp2m?=
 =?us-ascii?Q?8+pc3wijQt1DVRL3+mrCuFqfskTgt1WlJqmQx06tsscFeCse0wx7ZtEPmNjc?=
 =?us-ascii?Q?9AtliE/4qU5T4ypvczNaraAcJA596Ctg/3SUnqpxrYOF4SrRqdN8UkEv1dbP?=
 =?us-ascii?Q?s7RR6b0xGqHNPgT8G/IQn1+0XSoCWOnYbE3tPmp2xWTP+Z8qqqMtmhFp3KHc?=
 =?us-ascii?Q?sk7JydnO82Pxw2b8TGH8y74U5DcjAiICI904ioVe357DDz4uOeWGkle1hyOm?=
 =?us-ascii?Q?EIBCJ5hBakfr355MGPGvxcu6X1LAfg1WHR9ueBCr2PRV1I43t9zf6BrrHbY2?=
 =?us-ascii?Q?JmwGusDvmxq1e9E0J31+Th64l6c5tCa9GQ48CoX7SAPzv9c3fc8LfTRwl3dO?=
 =?us-ascii?Q?APTv6trzVoRz6NwXg1ZiLPIZkL9HURsq+Dso3ASUlSbA2QppPtDq2etCM573?=
 =?us-ascii?Q?y+ZXrIExOqS6CrFzYctFgQIdmpdPRBvj8nGbpN5JzNNdgdNYVKcpSvzAvkDP?=
 =?us-ascii?Q?a51HbZIiCjg1DTN9Jkgt+OMGMHGMsr2ibNFO9gec88U3pL8bz+5Ea9ud2stM?=
 =?us-ascii?Q?fkqziwRYCnhzDYhm6hMDdrWayvOctX75w2KZ5lfsgoOCDANmO2Q+cD9+KZDC?=
 =?us-ascii?Q?KazN4Ud0SV2Sh7PL5dEh1ULoaN824SvkqHntZqCzW41ykb1iRbZkhLUx11nm?=
 =?us-ascii?Q?g5osHopGccSZh6w9fet2m35gFRblXdsP7xp8smeMMKO/j56eEm1tEJ85oMNd?=
 =?us-ascii?Q?qkVEWPF32FS5CZJwllbThIsAUjlsxZtVbyyBDZTxmzdkwZEHHhGPBK0FVaNp?=
 =?us-ascii?Q?fUbsGRrssoAo=3D?=
X-Microsoft-Antispam-Message-Info: jE8Cm3DN39pP5vZ8kWYxVrIzmcNceJXRo8aSzAFwr429gYpu1dO1S5S/rxL2IYBPc2d9DeMmJUikIAp5jVfQoyf1ToeqLmg3Pr8ovyfrrHy69xrid3D/PAi0U4GnSwvcfJdZ1iVXgjhSQxV4yKitXMwFXZ1NKHfMGZ+ttRpNN9g9KnsjPnDePlfGTC9dtUiq
X-Microsoft-Exchange-Diagnostics: 1; AM5PR0402MB2690;
 6:sCehb3OWVddvtrtFuW0QqJ291nE3lK/SkBLqD8YiwhR2gRDMnaOaCUfXeDLihC2rHoObfPaXYomBDm9///z+ou+Hyijn9oDpIS+Yt+moFYbSY4I50KW2oP6pNQuO6McbvjXsxIdkSt+mwjLYB04cfQpElXd2f2lVBmOet0+coMUK0hyPqd9ifRKkvpRdoSoLQkWgoQWm5QpgjUiTZkp2ot3+sptjqOkARYRrJpVeabbnpa0P1PK9Dqk9FFFiS8xLE/2TC5h1hsX/DQ9reU09XgSMvwOh6yCyjm4EJV6BvBzVNgHloLz115jVWbpVaOPJZ4dxSfeBkUklHCUo+k7yj6DIaABSiPG7hXSvzsRUdEPA3AmU+hCa8d+yAEW3UzJ4DiPeXy+F8IJyrF7X6ooI/9RwmzaSvH0zZZOqpzAnTQ/AMSmqv08uvXpbmbexPXSLhmMF5AL6Thf93WcTBoSZkg==;
 5:Sfiyw5AvzRgjrC9FdLwjWZoyIemBVReCBCeonvIpbTVyacpaoJGi5VrP/mz4uNlps5WjB0EOUv5MIYq9BIeWgM0CKXtT0bz3kD2sz2lndX3QmfflgKq0UwID8onngyeAxLsM270wkVjv6L6IsRYtsYwxdy70taHcDrWXJTL8IBY=;
 24:p53PhxdzgQ0kM0ZVZqVnlUoWA7JqXrkBSKf0ZjQ8eWztXZN0HHmG/pfsfvx8pxXOFzWuYtLc3ReJWT9TGMxZO4+eTW9+bXOaWBLlT8znUiw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1; AM5PR0402MB2690;
 7:gMs0+pRiHFRbxKLE3WKHedJd+91BAruLcVcs0W/0pn7Ull8oo0ush+QVyn+4Kk+Eik6InRUFEBaD0qoGctPt2ztF1JH4ASV8/gTQs2Rbux0468JxDqO8BT20AbEGA+W8dPLGKRCU/uVxQ6Zn8AYDy+zaufcp0uIOx4k+ztkeDbUVfLfWyaVV0P/7AXpzVjYyddgmlpMblW+ymw+fpf2mVCjxfrosjsygL4sgFqDNOqM7lTQFORrdij30dveRjK6A
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 13:44:25.9086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c5f873-1b74-43cb-c7ba-08d590c431ec
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

A set of cleanup patches with limited functional impact.

Ioana Radulescu (9):
  staging: fsl-dpaa2/eth: Use generic irq handler
  staging: fsl-dpaa2/eth: Move print message
  staging: fsl-dpaa2/eth: Remove unused field
  staging: fsl-dpaa2/eth: Remove packed attribute
  staging: fsl-dpaa2/eth: Add DPNI version check
  staging: fsl-dpaa2/eth: Change link settings on the fly
  staging: fsl-dpaa2/eth: Cleanup TX frame freeing code
  staging: fsl-dpaa2/eth: Fix SGT allocation
  staging: fsl-dpaa2/eth: Change max number of Tx queues

 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c     | 47 ++++++++++++----------
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h     | 11 ++---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c | 31 +++++++-------
 3 files changed, 46 insertions(+), 43 deletions(-)

-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
