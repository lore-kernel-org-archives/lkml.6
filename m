Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1378361-1521812686-2-9532694494565354520
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521812686; b=Hd5UsnvXcwkecNFHENuPrphw+FCWgDd1oea7zb0CrVTv/5e
    Q9yXfzYtXuyiCLrpidKvnAbkhKesr1soUvB37uGGl6McCfUihPB5vpf9z0BxQXxt
    m5U7XTTBv8LPLUSdqj3SRIpmwyU/2fidlT+Izw+ivzoPAFCMh65fMopdzFVyjgY9
    +ShSqSxVjNiE0BusU/k1S7/kcu7ZvCq6hB8sLwaV/PhwAazT+RAWqeRF0lsh6SWM
    UrPsa1P5XDb7H9ij18qB3VhF3or0CA+gjHPL4M7FrzV4lEGL1Gz/9IOLY7hVl6KI
    67890RQ1CfVjeSgkaSpANytfJsoFbnwGpk2fcIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521812686; bh=u
    3VnWKmiaCaqXc9+0hbpBgPLok+imBGY5ftsr/WkbAw=; b=g+S+jThs8biI/0rFs
    r+uJ4g/bzvVtKbd72k3nlDxbuuzrh2YGqRqw2osgdQrcbFNh4REZpHk8D+IJnxBH
    tRNKWNYnR5hDJxIG78Y33Tsp0/FJevE06xm46UIf/YI0GkqMUcSEVnemou7nZlEz
    w/7reFUmnZeHFdcQ7+BtNqvApDBb+AeVEYuRwVo4SdsOmiWXZUMtheJksKy8t7HD
    0memLqL7/KNtfpUeTAYMO9VI3eu0K41J+UdxJrrp/LixM7/JZAvIjGc5AdZUHFC9
    JcgDjgUH/aVFeKshypuSmAGl9tJZMXZ9Ex5XgxZp1BcijhFB8CgFoFc94YH8DmdX
    YX0jA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=sOlSJnA7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=sOlSJnA7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com;
From: Ioana Radulescu <ruxandra.radulescu@nxp.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 4/9] staging: fsl-dpaa2/eth: Remove packed attribute
Date: Fri, 23 Mar 2018 08:44:08 -0500
Message-Id: <20180323134413.1532-5-ruxandra.radulescu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4dde98cd-fd11-4345-0473-08d590c43537
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:AM5PR0402MB2690;
X-Microsoft-Exchange-Diagnostics: 1; AM5PR0402MB2690;
 3:GnnRhnmIaQeW6e/VlWH84aUWjVAkEk/d61tj/DfIm1ljX7GpGAuezfbShFfQLAsIpVrrYxMYucG28W4+NJjTOKenaK/8O3Iei3SZ11jEOQs7xB4VXyvW6JKIpaCaXmbc0kBH7ZQzFOeljoBo5uhuemG07nijNjkC8kw+KAeEcydvrtGUvWpyYpv8Dxrb7QDT9VAh+onz2yEvKvFbBbbXt/sOuaG6BuqLTsYoLwCVoiA8TGAmPc0PvVbXwdPuNn0I;
 25:GnYAflkN0/UWYzGSGYv9BZvvHg9Z8u8EwV/4CjrzI7O8qPoH3fCBYZ2QYaedF3Xjx69/rbsouvWTBMAiplKK0v8VMspCIAbZPFYT8UXzb74DwKq/WRDbjc+mIPQ5LqIYMk3UaIMFKsdt8C7pG/cRNlR/WzCRzYXA0kzRmbnyrc4L6d/wSnK5E0MMk/tBI3+eI79F8SnTpI6N0pMNw8Aiq9Lw0Gh6ToYmOHsGfokUFh9zrnv2JO5bbj67AF3+/AbdQE9vU7n8tzGZPL9G9SH7Aq0V0s0vzXgs9v/sBshbtLDeXFS2OKhRigpzgAT6cvhbJ2AkZJeBIkA/jVUOGg9a3Q==;
 31:8Qf+pLm+XQfCqNN+QSOp4tcnUYWvyUXaB4zf/LNPlpesmJBLTnvnREzsQLBUSys/UGrIMId9HU4olw6EjZ6ek3j37PAyuQ/n3slY3Hs62Mrwa+OrcF0jAxv2wQiCyKpoiRVHVKyA5qm8muxj8mDlKBBL/q6T24ZsyXwN30u9boyc6im6IVOiHgMbOhpw5jJfPJf7uR3UMJTIsnYJik2EzpLXRoHOh8+E8Uc99cYcacY=
X-MS-TrafficTypeDiagnostic: AM5PR0402MB2690:
X-Microsoft-Exchange-Diagnostics: 1; AM5PR0402MB2690;
 20:s+JvEGvnQc5SlD5G2CbJKgC6d6KACE+B7t/U6lEpNriHO3CgPsP7sYc+9Ii/UKQWoydcD4LReL4O867DQvrboQRyW7y7X8+s2Ufocyse+c+lGpf+lD27iP++pT23DJdKfLi89lfevlLT3G0oe/ieCoOxfc/qYnySqGLb3xOR1OUZ6b3MiUJ5S2LnsWnZWZpRlACtZoOw7znMDPSFXn3EItOfUhSfe7DxcLN+ofCcWFlTCyeUwCmMBhbXAVAKJL5bLoxDOd7U8XRpZ/0yNdW1ik7CKboqiEQTb29sQZ5YNqYEf8ENC/7uVzGxpzUkrN7EKd0PVloTeu+0YQmCGIBvAv6+yDJmdIcTGYbOHS0pHiRD05lxHhr7C6bC+5lZbim2M1eYduOKpD5Qf2C4utZtgcKXHLm3Obz57IGBuE6Qo7Ua+MP/QidxQfJHtN+CHDFA23yW9pzcAmK9uK9WI1sXZ8x5hFhJsakZRPP0ymvOWZHwnrDbeucAWOYZ62BqNEdS;
 4:v6Z3iuisy0xBjo9tN9t8rdq8W4fvUYbgqKon1AQW3ay6Sd4DXmNEnsSOHFtEEiu3bs3BS4+xnG4hFmglmowPMQ3EqMrRx8539ZPB9jjUys+Rk4ik+Go7+ThrSK0YlooXhr0W8ENje3DpPqEVshLr6TY6eBZAnruBm9FvR13mXbxBlYpBMOy1bleVFuR7AACKHcYgj4HG1OoyQReq0qFj512rS8t/Aght6fK9B7gGYL/fxcKA/WMT2rUedTFuZCc+5yvytgPf8f62SmVhVGw5np2sBOJ/Ba3CANSEa02UfmPl9iqxmvEF0AMJJig4OGcO
X-Microsoft-Antispam-PRVS: <AM5PR0402MB269073D04249CDCF7B88E6AE94A80@AM5PR0402MB2690.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);
 SRVR:AM5PR0402MB2690; BCL:0; PCL:0; RULEID:; SRVR:AM5PR0402MB2690;
X-Forefront-PRVS: 0620CADDF3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(346002)(366004)(39380400002)(39860400002)(199004)(189003)(50466002)(25786009)(6512007)(6916009)(59450400001)(6666003)(7736002)(305945005)(5660300001)(386003)(6506007)(81156014)(6116002)(3846002)(8676002)(16526019)(51416003)(50226002)(1076002)(446003)(2906002)(36756003)(81166006)(76176011)(186003)(66066001)(86362001)(8936002)(52116002)(4326008)(316002)(53936002)(68736007)(47776003)(26005)(48376002)(2361001)(478600001)(6486002)(105586002)(2351001)(106356001)(97736004)(16586007)(11346002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM5PR0402MB2690; H:rhuath.am.freescale.net;
 FPR:; SPF:None; PTR:InfoNoRecords; A:1; MX:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM5PR0402MB2690;
 23:ilbGumNwGFbpVRkNTO2+QUSoxNHGMyC8zVbnWBj?=
 =?us-ascii?Q?77kTiAu+9EiP9DrSiqJPdmrabeajXLK4GBMp7UOI7/gWyZnBZAd5SIUxW0q2?=
 =?us-ascii?Q?C81krWsPSRXDnSA696p6PUiVX5WQoKwXdUR2HWiRX6gM3EUqLP+E+eI82w2O?=
 =?us-ascii?Q?22rdL558cAKkk1mlDiHqY2NR9z8fj9GuTd9RnRMd1HCqR+S6u0aCRp//zv66?=
 =?us-ascii?Q?cI6CAYxE4k3zp86qoTSJqjQ0+pvbxMO/XqLUQY6JP8l8BU/toXEsKIVb5awT?=
 =?us-ascii?Q?WvFaNTjNimHfLaxZG+SZT/U3knPML6taUSmdqbYWOywbxdVLyODNqaxuTF2f?=
 =?us-ascii?Q?lipC7a1tokR+UAaLyGOMEtmeFkDpF3CO/iVGWb4xSd2trtMla4/syDZDjlCI?=
 =?us-ascii?Q?Ix6kfoqtm4zooV+gDW6AzflZiqxkGwnRC0M1kmflpZadyJrxFt2p11hsV9lC?=
 =?us-ascii?Q?xdXgAilSvajlk6auOucowz4GlYt3q6OJOzDxbQemWbzD2r7qmOq4La5Z8JW6?=
 =?us-ascii?Q?5BinIx71pcd0nsIt8QRDyXBZ2f5QnmCaapsUo5InbNHxEvbXOQsYE5vgz4yw?=
 =?us-ascii?Q?zy9/bjwFlb0xnsn83r8zaxe2aOMZJl8iNyyiy82zdit/ir1IJ9pH3NCgdy+p?=
 =?us-ascii?Q?lvas4aXdpFgu6os9p99SkLfQfQMlCCuIEP7oAbuEG1rLUBlohH2dHCjqDpUc?=
 =?us-ascii?Q?kO2p7BM2iu0nNBw2mpaCEOvf44cZgJ1AP4o4y80JKO55JpWYY2abSblG5xj8?=
 =?us-ascii?Q?RlKhiniRWAMPGKFYdMozIeimnC84mf2o+Y8OSuB4W8nmgRU7A8BLBFc4WUUA?=
 =?us-ascii?Q?2rEg/gCJU1zGkHLirgvlIhLxAGbAVq7C3FoK41LM+TjO8dE8n+1Fd/Qpv3Gq?=
 =?us-ascii?Q?unMR732PsNGEx9rvBYIY2AN7P6kGrsYKXnZTrJ7C568+pL32Q+D2kZWKituX?=
 =?us-ascii?Q?d231NisOe6ATpF4IF3ONMfxSm5FhQ2i6BjIJ8HCGv554/3/BpbUjNKl4W+bi?=
 =?us-ascii?Q?rqFESmNXkMVTMQTEkSQdjkNgLUvDrXz46xEdscWvMROvMqp0kJDoWh6aLRKo?=
 =?us-ascii?Q?xKG8cycapD474/PO5xSkTneJIfgWRGO6lo9S+IKHcn6+foEDn99BKDNT5dNi?=
 =?us-ascii?Q?0L+ACda4yKZ9GAk08JHSLUTN1fEwBSU0+DYSshk4LcyRRqAQS5oMwYair2Ih?=
 =?us-ascii?Q?HX3FE/vzEGfia8tk=3D?=
X-Microsoft-Antispam-Message-Info: YF02O8N/3u5NTBJj92A6ipSOHWk2CRwrc1Nj0lSfp0WWHWQ/B5bhgvArZvnxMwyWNKL/vYSS11WtnP7r/lNj8t1eavvs3gTSzVG8BDbVzlAQtJkKn8RMCX/uC+qTKzbtvr+o1XywHkUyc2UCN5q4WgSpEx6FJ1e3glJ2lqNLNMPZSQXJBndu7iTOVgnzCXWa
X-Microsoft-Exchange-Diagnostics: 1; AM5PR0402MB2690;
 6:VEf4/ofsyZ2VpycJ5lyttJi/TlUfne8NhpXGJgK74aB5+HUPkbySXWqahY56RA36rL2aiQ8o03EpjX+CQH9yc6dC60AeeTz6zpbRIE2SbUfJO3KasKAk2EO8A/pgS+Gj4MaQ7AWMAwajNjrwPjIVBCZtL/W7blUYWAg0mikTRFqOEPq44NbbvOo7VMhkgawMdaHJFCAvVsXL/Ea6O8yVbA/y4/dtXLHRzfSuoqYAaRX3LGs+WvQcjep/55VkjXZQQLDIB8KrSC3oco8yH6aRAT1RkQ4Wbq4Lz6Eur1nknb2nFKoXfsTXUBjA6c7Li4lifRl6gtAhw8vNv3XcZKPHXppyalSIsCjNEc/bl34GDUbXS56l8xXJlPf3fFviz36nyditeH9rpymS7HMHTrVg/1d5coAeGoqqnmo43vBEdnn/rIyK+1dTn0fVTRXu12xkYE0NzYjtRC7R1LqZ4E4IJQ==;
 5:fWGs9IuKnAO9Pfy6xvG5kJfmXDIdzhKLXiangLa8CkmLFWa0MjYfr+ZDLQ3O+oDf9Dubd3S0nZbervMY/DBE5VGMad+zUtSaB7XGTGHYcxmBy42J8vTV0U2PiiD/bRU9bc3ZKIAn/wqt77B1rGnYiqcdsOsX62aQ1o27277wg5Y=;
 24:0RdWu7RXxJCiROY4o3Pp6mQsfdxZUZRucEwICMvVWhNetBFxJldZuTfM4bHV0ZVntuOzwbFtyNWEEnirWqUAwBQoH3fbgHfPjzSSI0W/4TY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1; AM5PR0402MB2690;
 7:4RBhHUJCG5d1F5l31wzvgZ8e2ZZCFc5ELu4HiIQSSAWs0avCdoMWw+BUWN5c70O3p6ezdO1ZEcPTpP6dXrfUg0l0QGrYY4OiebB8u2HdXmTN4vogz/XSM+ivbKgt5eyy47AmGElzpczwHnNYSOxMgNmInE48aOBf7aVQlV/nyr/LO9tD7j7ZhYcIRSyr+d/1xGEC+cbMlZP2b4tOOI0iXe60NzLkTEV8lwwPJSZCYu/18wwSNCmCu3tw5FPyR5sl
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 13:44:31.4283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dde98cd-fd11-4345-0473-08d590c43537
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

Structure dpaa2_fas is naturally aligned, so no need to use
the __packed attribute explicitly.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
index 63ea64b..c4816e6 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
@@ -142,7 +142,7 @@ struct dpaa2_fas {
 	u8 ppid;
 	__le16 ifpid;
 	__le32 status;
-} __packed;
+};
 
 /* Frame annotation status word is located in the first 8 bytes
  * of the buffer's hardware annoatation area
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
