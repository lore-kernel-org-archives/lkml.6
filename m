Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752104AbeB1G5T (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 01:57:19 -0500
Received: from mail-sn1nam01on0069.outbound.protection.outlook.com ([104.47.32.69]:27200
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751717AbeB1G5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 01:57:17 -0500
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=permerror action=none
 header.from=amd.com;
From: Monk Liu <Monk.Liu@amd.com>
To: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: Monk Liu <Monk.Liu@amd.com>
Subject: [PATCH] dma-buf/reservation: shouldn't kfree staged when slot available
Date: Wed, 28 Feb 2018 14:44:02 +0800
Message-ID: <1519800242-2442-1-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(346002)(39380400002)(2980300002)(428003)(199004)(189003)(36756003)(53416004)(48376002)(50466002)(104016004)(5660300001)(86362001)(53936002)(51416003)(7696005)(72206003)(478600001)(110136005)(105586002)(97736004)(16586007)(305945005)(356003)(316002)(4326008)(2906002)(106466001)(1857600001)(8676002)(59450400001)(8936002)(50226002)(186003)(81156014)(81166006)(68736007)(47776003)(26005)(77096007)(336011)(6666003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0106;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT040;1:MaVIe5DD2EuBnN4p8lQs12RS0yiAvtkWwZymjsgkbancESP9GvOeZtpv2Qo9FPODnFz5m2YL+Eu/YgN24zVcaRNAsZpOY03w/LcsZIuvUri5fqJfxXnI2bwi/ycdPdgs
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fe96f90-f5e6-49d8-58b5-08d57e787f3c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060);SRVR:CY1PR12MB0106;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0106;3:AS+M6srNLdAKI0am/fRQWRzp0VmCqQwg9p4SuksxV6KjEPUWWeL7OuGJZxCGOPxjKl0KCdqTycA7kuwed/VSQmZsIqy58AQex1ai66H+J9qXbzevxqEuLrwC9bI4EpZMErJIFNKPQNInoSePvhx5p8LTVJ5LHXkOn79t2OPfdPwicp7rxg/nFOdhxVom+o1qpdR5RgmbZhRMgo1/Mb36Ow7IIsBXgT/pGMNRB+kYlRyTKf5bEDgIDHuxEssRhdPf2JqTkgaGlEF3hAQN9HX/HgfIR+0LT6YSQPiMzUbd91x9pMlUYsLD1SFOA4qnS9kuLdIPj2UHHyqmUav+gRpJG0eRLn9QlKuILE6KDW/N0RM=;25:Ztzap6OMg1SX54zp1+HTyFQ3uz6T//iQACjNVRWWsVmNFhcEXAqGD87HugcGeKlXa0GMnlfT+jhnNQEBoRNRBqO3NwyQztxIGV02eUsaPwDNwz2tYeMjDjhLpyNlMi2Vlif2kZrkRoDc0f/IHjT3XmG8aja9w8Cn+g6VxMcL9otYgfWsZZzUcN7Mm+nTqmoHvHl5k+riAd1ZgbWM2VN7gMwQVPfxCe7gTRUsBT8TjDXh61SaRaSPSMyD2KxyLnIGfQifP9vEKSzEu7fl8Xrl8zW2DjJXB+dfKHTup1LdOlK441CbkqjiA7vcj9HTTz1/w9f/smGyx+dYK6o9+n76Rg==
X-MS-TrafficTypeDiagnostic: CY1PR12MB0106:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0106;31:In7MG5EeGJnZh4cp8AJubFm3yV7S6RPgUKuyTwyyVq8EF1Q90lqEbR8FhsHN10AKLmsRcxQzbfskcs4oYBGvsWbMfVH5LI0iJ3NHIGFvoOnaDga6bLDSeTFi1ZumKi08N2vk+M3wpRhGey1+q9qiFuX3ySab+9j1Jv4cBd/GT7P4Pq0DhRVWJdJjn+FYTvoB7Bs3z2FmYzGXjNOoFlAHhS3GA1kJawDhHySOsMmbHAk=;20:rcq2IgU/LgjeN6+vCRK9Tkz8sQq4QXOwa/iR8ymT2cr1cUZ4jGtfizKM3dAh9T5ZQ83vvjuMPyz++WOrq2/sr68f/EhEQNTEEekEU2pwJHMqnaoRRZkEVhAtZYjQOUMhg3UFOQ41XM4iwzCZRP0GDHLxTCO3k34RRoE+xcmHcl7M5szKI1JQj2bZcEW1rovKfCHrnRIik7gPXqP98gBOtNUZZqIKoK4UweBHephB6uGzcmZI12rQe/dWsenRPk6mD5wdq1pY/Y2b7akDM3DmCZ1pPNU3v/+bIiufdtmWGArGwQFQqAxclqj4kEhNTC7Ya/rqwecmN+D1KfgcsbxAJamKEqeJMlHPV7tVqopL3CaCrQwR9JYBcvzGDYLGDhFyPbbEuIRFtN+7O9092aTIYh/ukGe8Tib6PZzO3HQ6F/DM8boxnJW7kkhRTa/Tkn0DMXVBLv1viSGK9QD1HF53V2MWbEe/mN18llFTXEUvJ/POR/fHq5j+iOIT5cXw4Uzz
X-Microsoft-Antispam-PRVS: <CY1PR12MB01067AA3D262E99EAC3B4BE484C70@CY1PR12MB0106.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231220)(944501161)(52105095)(93006095)(93003095)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:CY1PR12MB0106;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0106;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0106;4:Af7xt6q7ta3xgq4gJWV2CC/5HZLzT+1ftDkpSzxdGkWik+kzWuBgBLAd6xXhhT0wxQhfAPqItX/Lew3ra9PKZ/ST/hkpmRMqOBalmjsJc5NfKOgZl1aU+b/yp5Lo2YomwobOGUqc0mAQQGDoC1+oN/NBjqQtO7XDp4W8WriTt9n2jtLRn3HcYPVzpjR3vN2bwQ7g4QROpxcf46MOqGIcXzg3qQxZMwdmgqVG1gXuBzdDD8F5IserSuafcfQG3oun7Xg+EseRr3eBam2ung5u9dG3IcAUWQQseVPbYzO0nCBVjfDbFsZlnP9+iJBzU2cFy4MptyWsSVPohz+J/lyP3LN34hoB+fJ0HVnaBjVngNQ=
X-Forefront-PRVS: 0597911EE1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR12MB0106;23:fccTMSb2vY9j+JzDPp1KHBHAriD1GPw9phr71hzvi?=
 =?us-ascii?Q?4s16CWGOT9G4iqo45S5vI8xt6qmhhP2TKRq2GIiyl65tofTHVF8jqGoN2bN8?=
 =?us-ascii?Q?xTSa+l/OPwWT1yonXLQ9FH22xAyfRHSTBnFzgUSPxlq10lLTsHtOCNVHappw?=
 =?us-ascii?Q?t8WFPxzjJmpS9h8jKoh9Bu/JovWCfvedmHrJzI+/ZxBjH/lIY23qbqgV/8A8?=
 =?us-ascii?Q?bJCcpfW/xrMLaLZnQ/7VoPemFlDfIs8tsjPee2YGOPbRb4N1wuNIhntcUdxT?=
 =?us-ascii?Q?kjgbQdpVFzxkq4eDTF3giVkc9/SE3UWMORQM7mCJHb3Xu9zUlXR+VLqVx0al?=
 =?us-ascii?Q?jXjPyXbB4XuVkVgddw+pK6+XENRbwbJ2xL4Mt+Aoa21tbbpJ0+lBMTDtQIux?=
 =?us-ascii?Q?Bb541+n174prSwn18uel3DJBbgTVrr3b47TAwpVh2rUaEvCpAasOB7RqGO4o?=
 =?us-ascii?Q?61zj/f6mva6ERvsAZDJw8J6SKuTFEsLNanEJDdowSDBxKrQeI14mtiHXfs5J?=
 =?us-ascii?Q?tVMwKbBeVogFkBycQdriYiq4ohlti43qrR3Xo0pPkb9Kag8MEsaaLais6npw?=
 =?us-ascii?Q?LVPLbHgyspJQSLQvaLPaFpBBx487r38ButFVIFBLMVIzRv2K1M01oKMNoJRR?=
 =?us-ascii?Q?Q9IsDa7cU18i/HeDu+wtOQHS5AnNWD0LStJume4ikqALKYEsVsjXm2Ab7AB3?=
 =?us-ascii?Q?6Pv2htQLvEmNtgv1oM1mVolT3GrueeSxZZi/1SqnWSttZPZjhRerZzO/Bk+j?=
 =?us-ascii?Q?RzFKkm/e+OL/iXU839/jefu75rcnfOdJ5WzOmqqaKTPkyJR5G9Xl3qXiXuye?=
 =?us-ascii?Q?zER55BV2eTYUdpFn85k30ARQ2A6l1iPcZwxe11priCROnPGIu76DnKR/FeDL?=
 =?us-ascii?Q?8359FjlIS0OfHTdI3w6qvDinjjPOaeg+K0OF6FBGGjGEOiqFUIs9EFtTI3Mx?=
 =?us-ascii?Q?PIPF5P36uXSkBeoDivwYfeXTWZkg+w9bSnqAS4pe3DCweJ8EIObvffewEruF?=
 =?us-ascii?Q?6Gx2R8QCVEIAqoz2dbyMqlimeEtLF5C1lI8l0QfTRztSD0SyRgAFSr76YgSH?=
 =?us-ascii?Q?ro5EGM=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0106;6:Y2N46v875SE45Fc/A/eKe2WGPwXfTfOLNDdt71RutaOybIPVjvgHxFDBYR/XD8lKj2zp8iKtgMvTYJhXQ3PsTVEkXbiccSdn3Xcrx/ukJqm3chqFOiNNUmQdJNDbRsiEIAX/Q4kJQnhTq7/7HYwUTWaT0XUiCuBmDMzkeFLySxiT0BSZK0UASqNa1/8vZdPa34Nnd275LrGqokTSTN/rU2snmCoRpIF1HLiii2/UbCaHKEvNosKUxW0qk8d56oU6TlyKJVEGjjAOdl7wYTwysbHOh3MPj2UbVUBersjCr9LjaQgjEatNCkE8AuJVUbFd6CdJwzQMF6P5nQLjLjOO9fy0ca2UN3tNlFpbIHO+Dtg=;5:jhmDVbD8oB0WjD0Rrxq/X84oZNrbLKWpdKEPzgm0+mi4KCr8mDkyBi/t8UUii4YEs/pUanlqV10dJa0V6+DPuBYYs7KUoPXyIf9ee/radoUSmevDTAK7xOjqouSbXDQKuT5dYpxfdWR4gPVxq4P1wikTApO3bTsWIpc9SIAvxQQ=;24:86NpDdGOl3EbNjcA2FT8jWkwjr3Silc/wpbR7uA1/wN6EJfHI6jZTGfJow1yg3StOitX3qJAPK9Ihtcb8sryC1l0AQwB1yq/hpar9fSMASg=;7:s7Ov7Ig1zO4BvNpL8xZAAG4AlJVIcPnSgkMR3RG+0hccUDleHcOoSYEEnkrvcrahbtB03UtMGtqfSXO0CM+3DBA6AKUOKP/gih43EuvISLdZH0RTXMR+56OeGGJcTWcAs3+63M0Eb1Hr8KpOblXX0KnBA9Qj2MeFCpxb9uu1aVCl8KY0fohRZQ2p4OHfQ1NvuQM1XfTwi1RNRK8lKeyPE4v9KXQ5PjiItXFUIzo/ZM2Ss/aoCV41wIjHZSerQZQY
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0106;20:kKk/P6aK0vfmRRv37V1XJoIpdIzQ1UmgZj2zeg1/3g05NV8eYtYCX8T6y+2rJRvLeiVcInaUK3MhrnbsXbey34IjL7fbW/p3v9jz9vBGB56t8lEGd2ZjKBi8epixk4Uq5cObEzNJzZ+VpmF6V8camV44Ky49KE6EruGrWHQUvS+mZF8a9SAjYxonJ//7TwfgNKIjrWyroHma8BGsGYdIzjZxSHJcw6NUrSFzA6yYS/A3ffgVAzZAbqI2bV+cyPBy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2018 06:57:13.6598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe96f90-f5e6-49d8-58b5-08d57e787f3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0106
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

under below scenario the obj->fence would refer to a wild pointer:

1,call reservation_object_reserved_shared
2,call reservation_object_add_shared_fence
3,call reservation_object_reserved_shared
4,call reservation_object_add_shared_fence

in step 1, staged is allocated,

in step 2, code path will go reservation_object_add_shared_replace()
and obj->fence would be assigned as staged (through RCU_INIT_POINTER)

in step 3, obj->staged will be freed(by simple kfree),
which make obj->fence point to a wild pointer...

in step 4, code path will go reservation_object_add_shared_inplace()
and inside it the @fobj (which equals to @obj->staged, set by above steps)
is already a wild pointer

should remov the kfree on staged in reservation_object_reserve_shared()

Change-Id: If7c01f1b4be3d3d8a81efa90216841f79ab1fc1c
Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/dma-buf/reservation.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/dma-buf/reservation.c b/drivers/dma-buf/reservation.c
index 375de41..b473ccc 100644
--- a/drivers/dma-buf/reservation.c
+++ b/drivers/dma-buf/reservation.c
@@ -74,12 +74,9 @@ int reservation_object_reserve_shared(struct reservation_object *obj)
 	old = reservation_object_get_list(obj);
 
 	if (old && old->shared_max) {
-		if (old->shared_count < old->shared_max) {
-			/* perform an in-place update */
-			kfree(obj->staged);
-			obj->staged = NULL;
+		if (old->shared_count < old->shared_max)
 			return 0;
-		} else
+		else
 			max = old->shared_max * 2;
 	} else
 		max = 4;
-- 
2.7.4
