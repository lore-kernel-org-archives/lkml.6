Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751683AbeDXPbj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 11:31:39 -0400
Received: from mail-sn1nam02on0051.outbound.protection.outlook.com ([104.47.36.51]:49750
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750882AbeDXPbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 11:31:34 -0400
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
        <David.Panariti@amd.com>, <oleg@redhat.com>,
        <akpm@linux-foundation.org>, <ebiederm@xmission.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Subject: [PATCH 1/3] signals: Allow generation of SIGKILL to exiting task.
Date: Tue, 24 Apr 2018 11:30:34 -0400
Message-ID: <1524583836-12130-2-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(396003)(39860400002)(376002)(346002)(2980300002)(428003)(189003)(199004)(336012)(186003)(44832011)(47776003)(26005)(316002)(76176011)(8676002)(36756003)(126002)(110136005)(7696005)(356003)(54906003)(4326008)(59450400001)(81166006)(2906002)(16586007)(51416003)(81156014)(6666003)(50466002)(86362001)(48376002)(5660300001)(53416004)(486006)(426003)(53936002)(476003)(77096007)(68736007)(6346003)(11346002)(8936002)(50226002)(104016004)(105586002)(305945005)(2616005)(478600001)(72206003)(446003)(106466001)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0328;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT026;1:Pi8SG7c6KeWf/irKi15utoBCdjzBNvjQl/HEsy/KZE85S7Aptr2wO8kaCeCo/YqxdKJCDUvcyG4kCNXdaXiaVnqFCWz8vkVKRK72bY1avuvLIS6KwmBqV1EYuMtzehFC
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:CY1PR12MB0328;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0328;3:77ZD9tILatLJ5HZuA94Plv4yXAVSZ/i2BNVhU8P9v16qJ+c3plbUkC51oxXc5mMwDaH2RqzE7BsNRoAstDEgMhcwX83XPNidT00SoXr82Ia+N/61KFk70mQNqDBflsNBWGy3g1m51b1fu6DRu25NqJYpVcALE8jiu5LtEKE0ndzMpvtf6ppjYIDQ93J7JglvTOhNewL8PxVPajF+NEHe10P0W8eRChQKqjDHo6CfmfneLvAgUUN7iKxBNxtbBnpqTHnKSAghMk+n7ophpwILCCmrFZQJI8K1ZiXyoP8b/fc29wP1sDlLxrGnUuMh1C+M6un2URgWVzjhjDFUBmwKKngn25wbnoQJLB/Ua5JcM3o=;25:LNHoO3VSNgwCS/uf/sxryTzRduB9gv1aFyyvCg+S9vhXRH2S3D7n1Vc20ythPsDjukTbyGkbjwa+bIKhdbQCm/eHSyWZDy6W6wbz9J+wCZqlr9spu3rInfAN16P12BtxlGkukvPoYtuZ2xx8kpwO7tx27gnxNzG/v8eo03PtlBkFLtzvAm9E2uOsf4valbSQkXShwE2dFmLyGABOuK0wW8NP3WGT59M0r/BSwzNK3emYtSUSZN1k4tFxaiZa+RwooJAQ7QcEOE1Hna1jfkiKppaweBnJTA5QSBq8yMrfwhi9JhjayHuMRY4O8i7unhcQ26wZ0oEIlPV8M4mC57dwDw==
X-MS-TrafficTypeDiagnostic: CY1PR12MB0328:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0328;31:ycbONe0eQmq9JQl3N5YAyRdotXjvrVt+L4iDxmGFdUhraNudoVdEnDe+bkmgefFgMfgNqZv+eIWIv4vANgWhsCRY+aec+ZKQ3zreHuwDRTO86/Y8cv5qRfddaXHjE1aoUBctGNGhipzZ/slMAQwT+t2AiDOUGBBljkGziiy5Toi07fHNSfo1pPlaLxIu+5euab/h38L4mPxgQXB8BwhW6gCtvuzJBc6kcA7t/Uj01nU=;20:4ayRJ0G4V7/UK7eIgp7BGlB/O59m/uY0Yw+mVpuLkPA4tqyr8AGgMIM4JL4zk29AhGkgTjteD4I/k4zSbSRRvTaNX12k9dFStusrZS10bqEM09dCA4VV0uW3BBxfY7L0akpUoRkiTRjkKgFKq/vvMiLNDdIHhRPjqjgyN5InIpLBC2t2ja/592pROua6kidV/WDKfqLt7hanhTJkW0kgvZb3Wz7LNvJbqABHdgCOIZkDku7D8m2SeoGG4/IrZg5dJlvYRYx1b1tKLnviMkuUXwKko3r1es/73wfhgXGjW9GNE6j0TzGkoDUq58dXWrcmILCSwAv6Vkw8KZ1PgTRv9K9kgJnxx4xnMh2sYQGr6AnUJA4T+Z1F7GVnVUecqXWeTSTaNp+39bDCGuNz0/iko7AFsxOKV9pA1LinZBYtZd51IOK1EIkb/QadSUb0IYUK1/7WL2Lov7226eCIR6gBTwhbp4J5Hl+zahd6A6AQ2//mdBRPtV11287BiblSFpzs
X-Microsoft-Antispam-PRVS: <CY1PR12MB032842DA393C6F5AC7C9DE8CEA880@CY1PR12MB0328.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231232)(944501410)(52105095)(3002001)(10201501046)(93006095)(93003095)(6055026)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:CY1PR12MB0328;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0328;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0328;4:CK7zUYzkh2i9IpJMXYfEhci9gydqJ67Y3G4s2/w7wwGM/MC4X0uv3wJFLmraJ32KUhqvkDxziNeOLdIIyDZj7oetScUW6QLB8yDVhXQMwlERiMuVRXPcSS376AkdMDvloVAbvvuaRYY12LxmbGeJvRHH6aO97KPDLoZap94TxYQ9rX34IQcuHVHIUGCPbcxkqRdYm2nFiEk6reZMrg2sj668rhePkPSKZgcrYANYCWbuAcG/CleJAsATpRutR2cCs5GVtP6kDR+sEkB8sfmv/l2ExRaRv58jhqAARtAMcHl5tzqn0j8Tu1jugsgY8QFp
X-Forefront-PRVS: 0652EA5565
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR12MB0328;23:OsjwReTJMAEUFW/7UqOPKnb3eVqjstXVWPuYixsL6?=
 =?us-ascii?Q?BBMVGVhr3J3avVsGxnJmjCSHZ2j/eSGwNkT+0u0jx7Pi5U765LPt2PqUkPzF?=
 =?us-ascii?Q?KFvqd0t7xtJUkSuZqWRscx1pt5In2qRsvc5/Ii5jLu5HCrfSRk2Y96Cx1TCH?=
 =?us-ascii?Q?LG9ldtYHmDkRBTX9URa5dIdiqZoaGQ0+Si2BPbLijYr+MEZ9SqMhDx7mGHq4?=
 =?us-ascii?Q?3Symarj5iLL1pp6/CgFPzxkISE1lkZZdWJsIEBmsWh7qA7QeasMc1/zjbcVG?=
 =?us-ascii?Q?wvlRElscSywORdQcDC7VnTyKhVFX1gfm1uVTUfzsWCQzukQe9faf0ysl1mVJ?=
 =?us-ascii?Q?7ohRMKDqXtTlHT+W6v27LJYkmQMqs7orf36o+IlLPvum+rgpYZHHQpoxhx8C?=
 =?us-ascii?Q?we8p7l911Gtq1IJ5Em9YpOlYRhchCj8BiBkz8MgTfXnnbC0vK40k7jW+oybT?=
 =?us-ascii?Q?xFXhhBnSTeW39liBhKY7z4upqQf7tIwTLzALMm7dPAgifqHwQ2uCqd/ocgwh?=
 =?us-ascii?Q?hXa0s7tlb9JMiJH91zyjNzDY/MjvcT8QYamGLbbkjdyF9fnRs4kDDDq1+8tE?=
 =?us-ascii?Q?G6PCD9jeJzzVqUs7dOi954cRFzER1huXH6NSQ+EdnaEllmpOQSQp+oItTps3?=
 =?us-ascii?Q?+Yn44TLM0dCsWII/Qy7EPraWcTVs2hN059oREtnPlnKfJjNXhwiP95bLMxzv?=
 =?us-ascii?Q?opFm3726tNTSnSnf77x0scxCXdO7lPBSRswnueDWe9BNc1grbbLaaBK7G96T?=
 =?us-ascii?Q?acWsfWfWkHOVLm0gGRnPAyfaQEV+N7G9pcgaI5D9zurrGBuDtu/AlaRydon2?=
 =?us-ascii?Q?J2K+WNCI2sMp0Zvbrr0bik1r6zhpJt6d5nf4QgMMLKeC9hhPK7y91yY4vpQt?=
 =?us-ascii?Q?xlL/H1fN7/VRGwxchj7nb5ONJuJyfLJc6c+xgmzINM88Yl2vE/kbd8GVxQih?=
 =?us-ascii?Q?rEeFTs9hV1InnTaovVQnXKOw/VLuVYLkV6S09Jw9vYLlV+oDzLESGPyNxsUz?=
 =?us-ascii?Q?W6H4rz5U5+o61TqeMhan5vVwI31kqNA3uFi6/dteokgqPV97bfAIq7XAzAAb?=
 =?us-ascii?Q?w6icnH7+V5Louv8jxX5OvYTLO73ATNXggdYiTRKjuF1vacj3yF/doDFqD3U0?=
 =?us-ascii?Q?pZLNyYzO3n+S8FFH+tei9tblE4k0HqTD6bvOcZdRw/34LR7YnqIdAc6J8R90?=
 =?us-ascii?Q?tsW5ymoj5pCXh54fUtwEGHfUo94IrL2XX+hSBdF3/2YqUhoVNOdwwxDdQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: eVNgnv8fPLoYHEzaXeZX2RoHo0XgJ9OcjIpMiQ63bo+ufcDHI3esjUA2e5ihW0C2BhiueEeWPc41qv9EZWgvv6NLonFv7ziBOJOpaUsfFAX8nNgAHeJZQY28DWAPFULcld+zZJB4YrH3Db2L4FZOgjsu4mh9i77F7j/A7iMxgVDhpGaLwMV6lm2hhs4T9oHM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0328;6:o0+M/kPJKMDU9jcjB5zk5nyled3KsJYGBTMQGSgJeW++DNgtNKmOf6vQZpLD6KKmcr832g5Y+Os+ZWEcu0wCTjOc1XgtK/xoo6pDMykwfO628P4VG+f8PzSXmS3tWe7dN+Pl26Hynb4U/TOO0noQcHH3YQ5RwJcF4sC+ztuRbB/iKSE/Nrc7TmbFjdxdj4RaFpSlat3mlLP2O0z+4BNxaZ/GnlCAUGeA+6CTfeK8aDPFIsMIDal/OeN0YRTBqT4LrsgWFs1QeaUJ7enFi/MExpcJnXVNhmSjPmmojsmiczGjyylblKHPAUipsdyMHSG7lKhMolS0F7v99dC1zZV6MoE2Yw0glVUmjPUOMx0AMCDbAy7a0okVyfgx78LhULyfEmqzpaJ187MEWFtO2bsXqN02TJZhnUa+e+brX8IP+zPbGLY8S/Ep0UXt8jykvibO07taizVx9GUysJmTtiBe7Q==;5:oSwAWlnrx1TCM8YkYDrBE+k51JTwljxKzzz+238hKhTxouFTEZ8/xwTubRnSCJq4GD/HpbUktO3s9h8cN/r16ZE2PNt9BUmbuGxcXa8Mb4E7sySou4mOk/cJpwtq7/tEcLFrNj8MuFk9tH9IF9t5AnSvdKGc+9V0karASIWSltQ=;24:nOW/UeTixhSyE1uze4XzZkF6aZHOv4znXSbMIwkQirHhf/YIkI9lJo2c9YPBXCSXQGgYjmsEsk5nF5+m8GweZKSkLdB2RjCHbZ1TqrBLfqU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0328;7:aWKcT4fhIPbElWL8ACKI3Db9/hTlVkC6h+skddovFp/V5jgMR8z6+sWGH7wHLmeMKOljwihndsav+ghS4gs4gnOYI1H9EDUeUt2D2Sskk6VUBdqjAENalWpiF/tqN+aLQtX7W4RuWomM/rJO2H/OzBep3OQESN5/UTKpWjT49Nf9EKtboMudpOJu2JQMKrUdRU8695uVdgyj6DecAr+0WqwENPrDyTQqVLu5M4w0iFf4hx51gaae6A3Ey7CPA8g6;20:/kP7LXDg3gY9E26Sh30xn5BaL0AzgfvsIpZP2yjBlld/ku1Rlpl/3+mS1b5yh+NWEejH43uMdya3aKL9HY8aE2WPjOGGRRPV5qw3AiXl0fGU1oOC8JKM+S9GPJxkzkwurIoRyUXm3azrZ2q3Pc7f01+5G70G2DPuikRz+cbK/B5j13hW8lxiVUFVjEM8oKe/MIDwKmlxBI0rhoMCpfQPO/fgnkl6jGBUZmCHYjzQkUDZEfw5zkVumjMbtRXQV8/5
X-MS-Office365-Filtering-Correlation-Id: 294f4c28-1ffb-4022-f3a0-08d5a9f874fb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 15:31:31.9633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 294f4c28-1ffb-4022-f3a0-08d5a9f874fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0328
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently calling wait_event_killable as part of exiting process
will stall forever since SIGKILL generation is suppresed by PF_EXITING.

In our partilaur case AMDGPU driver wants to flush all GPU jobs in
flight before shutting down. But if some job hangs the pipe we still want to
be able to kill it and avoid a process in D state.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 kernel/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index c6e4c83..c49c706 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -886,10 +886,10 @@ static inline int wants_signal(int sig, struct task_struct *p)
 {
 	if (sigismember(&p->blocked, sig))
 		return 0;
-	if (p->flags & PF_EXITING)
-		return 0;
 	if (sig == SIGKILL)
 		return 1;
+	if (p->flags & PF_EXITING)
+		return 0;
 	if (task_is_stopped_or_traced(p))
 		return 0;
 	return task_curr(p) || !signal_pending(p);
-- 
2.7.4
