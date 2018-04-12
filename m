Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752821AbeDLOmq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 10:42:46 -0400
Received: from mail-db5eur01on0083.outbound.protection.outlook.com ([104.47.2.83]:44690
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752355AbeDLOmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 10:42:45 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com;
From: Ayan Kumar Halder <ayan.halder@arm.com>
To: ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        linux@armlinux.org.uk, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        alexandru-cosmin.gheorghe@arm.com
Cc: nd@arm.com
Subject: [PATCH] tda998x: Check ref count before invoking drm_connector_cleanup in unbind
Date: Thu, 12 Apr 2018 15:42:32 +0100
Message-Id: <1523544152-15241-1-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: AM6PR0502CA0013.eurprd05.prod.outlook.com
 (2603:10a6:209:1::26) To AM0PR08MB3026.eurprd08.prod.outlook.com
 (2603:10a6:208:5c::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3026;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3026;3:U7Rh/zInovWu0Dk1rrqzhfMH2wgX51MCOGsED654t3xz7zjyqR0bUDURdISan2aFrWE7MfRjfmFbu0w0DD/CRUJwjreeTpU4OUztgrvTB2CxcQ/5NSlm74PSmewJBs27+1v63wVviw1b2MR8cdFzcaJJNw4c6Ugnv0fyrtIRJno7wUTZ4hc2/nnVFcVMUTQxPUY5N16DvvnHuncf7w8l9Va3e3bPB1PkCzlbtlr8aADU2DnRvBFbSJ6xFQ3Ztb78;25:49pJ0CcRvaGFkuCmbk6YkXT6zRrc3/b4aFRkAKGkO71uHZzrpb018lMtmFQfbCV60aj76hl0ZcxK57v1NJVsGk6G07JeUeNwI5TEA8wu6thryMC8LnCKgkFRAKT0oJ0X3mRK5t3KVnJeJ2wUQwquiBZaOhQvaBvG1RUxT1AAe6hoyEb/VgCQoq4uFnO2Pdf8SSEMojANQscpAYcDdNA8ZivsV2yJIt5zfGuRDJsozo6HvA8xuC/S75Usu/G/SjOv16uP0CP0WAoYeLPSZ1e5HWEHgiFBcfksomFUrdris48dCkOIgwTwM2HNeyN7oX7uEc8KxYM+wRJ+BerZIlr9yw==;31:1y8w0Fz+uFIM3cgcqZib6QBq1SoJNKnRtVWgHctQdR+672iY/r5F4jpTUYxbX0Gn4xh+rbTWFJst5xTr9DHTHvLNzrf8KQiA3ZnWWUrk4WTZYlklYq92BQv4KArD0WeFJGC+znfaVYmvgmvZwE9PvT3Jay3AJS2VXKxhy6ew/TlDoLLXPdQ1TsPE8+l3vhEFs9OfVca7rQjiWZ0CznIZIQ2v1V51ILkRI87Yo7i5XaQ=
X-MS-TrafficTypeDiagnostic: AM0PR08MB3026:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3026;20:d4MUO8kRGV30mk3tWIB5fTcFjFAfQEJ4cw7FqLHU6S+FdUN9PZxGXtiiJfTLCCrsfDY/tPcjPIfZi2voKCSbovOyUC6iyxR+VmNdMhyq58y/WJet8XwDVY8/v7x9hyWERJNtTrqhBjrqnLDSjQWj9ZA9nvKQSSfQPkjvkLvttnU=;4:PZmAoj1bB5YYxWwjMbJr7cf3quJx8dAHjTTTsENXFWEtVTNEhZsrAoV3kbcBp3YyNKsunWXavrKEvmo1OkaK1IW5USpUNukYXhBnFuLXUIxwKU5vnPmlskRMOOT0iOfc+TXNkFH095p9+qllbqa+7wQaa/l4U7r1xvteT/Oy1k+DZrBjPM5MHO3euFqRxsnyex4ujXfVK3DQmSRY9KMUtxbiMU3ZdyNWYLQA8tZoLdTAiP2rMHGR4b95rdhFky6/GXIbzWPmZ8QqvnwoaNLEmfbsLAyvPFx1Wueajo/6VvVSRfxmSlhYPBENBtOCtKhn
X-Microsoft-Antispam-PRVS: <AM0PR08MB30268F3A1B064E8485615E79E4BC0@AM0PR08MB3026.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM0PR08MB3026;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3026;
X-Forefront-PRVS: 06400060E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39380400002)(376002)(39840400004)(396003)(189003)(199004)(72206003)(8676002)(52116002)(2906002)(26005)(4326008)(51416003)(25786009)(316002)(7696005)(16586007)(386003)(53936002)(106356001)(478600001)(8936002)(81156014)(6636002)(6666003)(50226002)(81166006)(6486002)(68736007)(3846002)(486006)(36756003)(86362001)(97736004)(5660300001)(1857600001)(47776003)(7736002)(956004)(50466002)(105586002)(48376002)(6116002)(16526019)(476003)(66066001)(2616005)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3026;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR08MB3026;23:qh9569PzRqDkl/AHqfHNJG2DVcLUubCcyheJ/85s0?=
 =?us-ascii?Q?xmxJPoIgWY1hBVqyyCTU/hxRo82AEPjGpEPlBTU6Y9EIUwDu2BqmQAYrb8ev?=
 =?us-ascii?Q?/8/eYlQY1jF9VTZ7eYmnDvCzG/ksuxwc0+0NBWy6oSbUnA5F4gOifcuquMsW?=
 =?us-ascii?Q?mrec6jhFiMLdXuRv0uoyjKG7jyFuTS/JlycJRRi4wJOKB2GXxUJjTtdkEYUu?=
 =?us-ascii?Q?C8/T6eRQoC362sMY12XF+lQA2RbvwdlRhvLR6RWwsmz3kfRLfyCZq8/wkS8J?=
 =?us-ascii?Q?jvUUvBUYr6U2kUxwevxQrX8vVsLOEQbbkVJdqMpgvIppkDfQ1jvPJwV9Np8Q?=
 =?us-ascii?Q?ro9kovuu+5HCsEIWIgVac7oD9xQ3h0Yv/3aLbV0xihWh1sEHb0kPmC4YuDuZ?=
 =?us-ascii?Q?cy0yY3nJizHQTcTYliin4/K3+i9p/8VsA+S50VfAyT+xBXdom5ABuMWPGxBb?=
 =?us-ascii?Q?SwfI8/Mf07DUotnvAaYHqgdMQtXv4ulRQl3JAwF6CC68Yd6wY0vJcBo7+8JM?=
 =?us-ascii?Q?94CrEtuh4ckknGtw+XIHAC2fVhoCx89kOUNcRp0+k9zMsSeqeX+xZJWgzQpS?=
 =?us-ascii?Q?EBJ+Cf8VEiGADP+3au80FlK/Jk8/diz7ZfhQKQVmEm/mBTWWurdNZPHtfx9j?=
 =?us-ascii?Q?znr5WslhoIjH6I6l1fxAMXXHKcCHV48BGEuzqGXIH1DJb+tBfCb4bBDIgoND?=
 =?us-ascii?Q?JBLzOjdR1xSfvy03J3D3m637VRhSsTxusvBhSvqPZ88GNT3N5duEowXN7tUE?=
 =?us-ascii?Q?jOh7RfBnHQEv0jvatzvAtXBBdoSd+caJsNFZPI04feLpxgInOQFeAaATw2+x?=
 =?us-ascii?Q?IL00UV5y5GvETmoZ4QzZmazPgcA11y1iZzOhoVBrNLC8NkAZ3xlYPKCFs1z6?=
 =?us-ascii?Q?eFaC2TjBoIJosB+GM5p4X7wZPTNdO/TAuOL32+VF1rOt2Bn34dgUwZ+RCWaH?=
 =?us-ascii?Q?HBwk5liG9b6+PFTil3gaC+7PL4OScCMUgor8l5XqUwzK2jyW5zTgFgJbKuJo?=
 =?us-ascii?Q?1LWe9JlF5mkAAm0RtIIvKt7i39rwlcwyHAvntGcRpKlu4ngLznPvyXep/nHr?=
 =?us-ascii?Q?1WU2VlmbeXeVQktFl2dH4o/OJB2TZOZhRnDbkkB2g2GkUIaSOQQY5IW3L9uw?=
 =?us-ascii?Q?RZkQTl5D2q5baDEv3ewMB9JdvRgYNZF?=
X-Microsoft-Antispam-Message-Info: jm9cXDI52dxAF+Di0Arp4POIlTXV8BE6JSHZvU2hRlWyNF19+Z4CS31YQa8nivscck+kU8ynI/xPOe2x7UUxnZozZDt1BnwKGM3UmijXZfqPzUWXCbMZ3CxJnabNcPY7Pcnf0Htxy6crS/z16UOU1+GDm/YocDBcXYnQ+D1ouKzP19/AZp0ZUA7VrTRGNw7B
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3026;6:LFio5e4rGuSeG8pY1OKeihEVOnHnXbptKfIUtXRDgVVS5edVjN3nq9hx/XqWtq/dvjwkKlvmn1iahWyK1FR7O3w/y0dEovBWLZlg0yEggpQC1r/cpsTQXZsfGQQR5wrPK+8GvHGElxdprJ3gp361QeU7L2rtJdUqdabFbkm/eRKb0fZtugwoIU6zQa+Gc3IzKCIqYXvRCOoZubaWChpSClyKZACvrkFNsvUrXtzJMMZvyQr94bTgkMM+bqeXcnskq2yk6asMqZT+E3jzmLEwYvuH3DWF2Us/WqaGwXdc/20lScsLROSjibTildL41Q6U6TnJ+/as2jWW5rwLFf3IadjL13xNp2PpQjehTqcsctEh/WLReNEA0B93wqZBqjTY//gWvTkWXrQMV50SKPVKCmyQ0nJhDvfcXNBJK5dRmuOzAi4OapSvx1waEGhxeY8YlBVKk9j/8W7Av0daFpqJvw==;5:bsLT0Cy/McuJrtmGpZndedAd0ttuxavULWvOZEcsXlW0d/Hbv9tdPozrzYiyJFuduM46bypfLnXoJmIvxMa/t7rih5KDhciY1RcH4kbwcWB7Zj4aGRWVa3zJXuSkQ8LzVamT2eV57Feb0/2p8mEXB7vXKwI44wA0Fvqjxkpw3Ys=;24:gycik3sflrVLMLfouwg5VKboCMp6TlofL2hiRNZM9WBRgjBYXM005HpKMfT3pwRVMB2hpUysK4tGIkly9kP6Lijfzji2A3G139N9qcaivWs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3026;7:1zGf2eMlkELDk8JTAgLenaZVvOoxAB0q3sl8m0MiOfJxByIF/XGgXJxdg0c7PPNRiulx27TYbSWrO6YJTV+4wN0/vPWh66DSb14XdTrqp5khUTy5M5wJN/V8A+osaXumApgB1NiTbByf1jLb2YApuEnte5RB9SYHP569w4BReOXcZ/XPiqMWkKGAhIK/GtkuBDlAz+I9O4Ipaat3QfcelsmEpPgbBe0td2AB4SfgssVdntuxmOQ6biSzkpW5Fni5
X-MS-Office365-Filtering-Correlation-Id: 130f9a7b-9fbb-4c4b-bcbe-08d5a083a5b0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2018 14:42:42.1276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 130f9a7b-9fbb-4c4b-bcbe-08d5a083a5b0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3026
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a situation when the reference count of the drm connector is greater than 1,
the unbind function should not invoke drm_connector_cleanup as this will lead
to an inconsistent state where the drm_crtc_state->connector_mask still has
a bitmask referring to the stale connector. Later, when drm driver invokes
drm_atomic_helper_shutdown() which invokes ---> drm_atomic_helper_disable_all()
 ---> drm_atomic_commit() --> drm_atomic_check_only() -->
drm_atomic_helper_check() --> drm_atomic_helper_check_modeset(). This returns
an error due to enabled/connectors mismatch.

In such a scenario, one should just return from _unbind() and let the drm driver
subsequently invoke drm_atomic_helper_shutdown. This will reset the
drm_crtc_state->connector_mask and will shutdown the crtcs. It will also decrement
the reference count of the connectors to 1. Subsequently, drm_mode_config_cleanup
will get invoked which will do the following :-

1. Decrement the reference count for each of the connectors. Thus the ref count
will reach 0 and drm_connector_funcs->destroy() gets called. Thus,
tda998x_connector_destroy() gets invoked which calls drm_connector_cleanup

2. Invokes the destroy callback for each encoder. Thus tda998x_encoder_destroy()
gets invoked.

Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 9e67a7b..8ad1cc7 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1709,6 +1709,9 @@ static void tda998x_unbind(struct device *dev, struct device *master,
 {
 	struct tda998x_priv *priv = dev_get_drvdata(dev);
 
+	if (kref_read(&priv->connector.base.refcount) > 1)
+		return;
+
 	drm_connector_cleanup(&priv->connector);
 	drm_encoder_cleanup(&priv->encoder);
 	tda998x_destroy(priv);
-- 
2.7.4
