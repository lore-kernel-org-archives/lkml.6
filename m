Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB5EC5AE5E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ABB220449
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="bHxSb7YY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbfARW5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 17:57:11 -0500
Received: from mail-eopbgr50061.outbound.protection.outlook.com ([40.107.5.61]:8064
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729792AbfARW5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 17:57:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFKfT7QxZ5XU5SgcjqaYBFHKCpnu7hwJVikiYMqgD4A=;
 b=bHxSb7YYd9A2hlhk/7AbQcIMcpMaA2ag6FfBdCiIAAJnOcNlxxt4s8h4HrLMEkiYjnAxHsAbn29uTQYPnq2BgUT7CRYutTupkAyfbeEubTZwsTrsVVtd1WwYMjEuc4RIQQsijUY6+gpkYCdKUYzvW0mFNoT5jlwtyzBLr2anlFw=
Received: from VI1PR05MB4607.eurprd05.prod.outlook.com (20.176.3.140) by
 VI1PR05MB5181.eurprd05.prod.outlook.com (20.178.11.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Fri, 18 Jan 2019 22:57:05 +0000
Received: from VI1PR05MB4607.eurprd05.prod.outlook.com
 ([fe80::c87:33e8:75b2:c4c1]) by VI1PR05MB4607.eurprd05.prod.outlook.com
 ([fe80::c87:33e8:75b2:c4c1%4]) with mapi id 15.20.1537.018; Fri, 18 Jan 2019
 22:57:05 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] clang-format: Update .clang-format with the latest for_each
 macro list
Thread-Topic: [PATCH] clang-format: Update .clang-format with the latest
 for_each macro list
Thread-Index: AQHUr4Eh70TZu0hTXUGviIikMXZ6KQ==
Date:   Fri, 18 Jan 2019 22:57:04 +0000
Message-ID: <20190118225658.GA28312@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR10CA0067.namprd10.prod.outlook.com
 (2603:10b6:300:2c::29) To VI1PR05MB4607.eurprd05.prod.outlook.com
 (2603:10a6:802:5f::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [174.3.196.123]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR05MB5181;6:SqUN+iyIhpoKmugr9o0FBQlrQxmLdf/nXVWIN1RbfVqYm0zSiUG0Ml5G0ihu7x6NW53/0B0RSBdepqB4d5NWO5i/YGIDOW7v/a089ab6pD9C/0jnso2+1MoZE/IiFZcWWliUP6QurWHc3kpDOaOw26qBDm2st/HiXemSALgEpcHNzFvl7g+yLIbsF7uIfoveoak/dNgdkco84BpLdlFC0VI5VqbEBirVsvb6mzfIAJAX+tMTDO2VReYqSP+wvYaTcAsT1bKc+77Mh57k+o3PT7ARMOG8zxVqC8cB7r80PaihinBq7MMes+vyXfKbLmC3C4mIh9zLFceVGOtmwdd0oidgQuMWiZwyrH1plU6FJyhiNYXRtaye3tkibmsNAphKtJvmxVTJnMKNEHdethkBdos5nGq/f2tl78pyuKPkOJ8wc+QGFTi8T8+/RHrYt1keG8IkpU+IhD/T5BaNmWZy9Q==;5:oqVxfJscZ3CVGjD6nfcJqgOITIF5N3Mo+c//Qq2/+E/9SyRohvpz0eH1/Zme5QQSLZT00Po2TuCjksuc9WFqsj0SDIFqjFYXkebolhrC4XAsXUesKiwJz9CdpJdEymwAMeOYEi05zizYj9M9LbB66lepWdISpA3Z9b3ciMJW4NQ4WQCjMErTEdtO0pxiMj5Xf0cNaQu7dw6KB6UFU3XpuA==;7:J7h6N6qRKfrOjE4w/pI7tB1IVMfZ2+6Qt0mjkRluzkqYYg6RM6cJLrRYzN4vcJh4OvNhXykf32y5hOzLxNrd/3xuuNrcI1Pl82LGt+ijI548amFbDTL1NiXXcwIn8J0MO4Dszwiyiwdtv1CwE5hrzQ==
x-ms-office365-filtering-correlation-id: c1787ede-8ff2-4f98-6ff9-08d67d9843cd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR05MB5181;
x-ms-traffictypediagnostic: VI1PR05MB5181:
x-microsoft-antispam-prvs: <VI1PR05MB51814C2CB5FDD7CCAB2C12ABCF9C0@VI1PR05MB5181.eurprd05.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(366004)(39860400002)(199004)(189003)(8936002)(6116002)(86362001)(105586002)(106356001)(3846002)(8676002)(25786009)(14444005)(26005)(33656002)(81156014)(386003)(256004)(6512007)(53936002)(102836004)(81166006)(186003)(9686003)(6506007)(110136005)(6436002)(476003)(316002)(5660300001)(66066001)(33896004)(52116002)(478600001)(486006)(14454004)(68736007)(71200400001)(2906002)(1076003)(97736004)(2501003)(71190400001)(7736002)(36756003)(6486002)(99286004)(305945005)(39060400002)(142923001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5181;H:VI1PR05MB4607.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fdnya2xrTbKaCnn2s1ApXHwSWHKp8MQs4gANcOivPcQT2ZLPthllPp6Gw/JtTtSNVSFBMs7SNArBUZmFp8cHUbYP8hKskR1kx+h70IFEAQppxdGbp9sPi1v0n6k9a+LMw3/ejS3KInziq1h5Lby3ancQFXYxXr8oOZfCnJ9vLnX5c5eZ1YIYECSCt9QvZ3lptjh90iK53TvLSvUSYGVJnJVCHeVVwHYSsvJBZU1sccilrLnF+hXlZraQKZrEuqDUuhqCWDgnOlbwLluCR/XFdNez8G6ATmT7OHJhMMVSKyt+IIl7XxnBifUf1n9+lHc2qyvUMdeGDoCMJZw3sAna3+NvXo7SEDSp4EcIPH0TLjo6GnIw+1Jem7DOalb+HYaWX7iLBXTlnMRycsw0Rn3rA01fabOF1CS07zRQ+BvlrkI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <10F792B1F875E94885CE4EF269D15DF2@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1787ede-8ff2-4f98-6ff9-08d67d9843cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 22:57:04.5531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-run the shell fragment that generated the original list. In particular
this adds the missing xarray related functions.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 .clang-format | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/.clang-format b/.clang-format
index e6080f5834a356..bc2ffb2a0b5366 100644
--- a/.clang-format
+++ b/.clang-format
@@ -72,6 +72,10 @@ ForEachMacros:
   - 'apei_estatus_for_each_section'
   - 'ata_for_each_dev'
   - 'ata_for_each_link'
+  - '__ata_qc_for_each'
+  - 'ata_qc_for_each'
+  - 'ata_qc_for_each_raw'
+  - 'ata_qc_for_each_with_internal'
   - 'ax25_for_each'
   - 'ax25_uid_for_each'
   - 'bio_for_each_integrity_vec'
@@ -85,6 +89,7 @@ ForEachMacros:
   - 'blk_queue_for_each_rl'
   - 'bond_for_each_slave'
   - 'bond_for_each_slave_rcu'
+  - 'bpf_for_each_spilled_reg'
   - 'btree_for_each_safe128'
   - 'btree_for_each_safe32'
   - 'btree_for_each_safe64'
@@ -103,6 +108,8 @@ ForEachMacros:
   - 'drm_atomic_crtc_for_each_plane'
   - 'drm_atomic_crtc_state_for_each_plane'
   - 'drm_atomic_crtc_state_for_each_plane_state'
+  - 'drm_atomic_for_each_plane_damage'
+  - 'drm_connector_for_each_possible_encoder'
   - 'drm_for_each_connector_iter'
   - 'drm_for_each_crtc'
   - 'drm_for_each_encoder'
@@ -121,11 +128,21 @@ ForEachMacros:
   - 'for_each_bio'
   - 'for_each_board_func_rsrc'
   - 'for_each_bvec'
+  - 'for_each_card_components'
+  - 'for_each_card_links'
+  - 'for_each_card_links_safe'
+  - 'for_each_card_prelinks'
+  - 'for_each_card_rtds'
+  - 'for_each_card_rtds_safe'
+  - 'for_each_cgroup_storage_type'
   - 'for_each_child_of_node'
   - 'for_each_clear_bit'
   - 'for_each_clear_bit_from'
   - 'for_each_cmsghdr'
   - 'for_each_compatible_node'
+  - 'for_each_component_dais'
+  - 'for_each_component_dais_safe'
+  - 'for_each_comp_order'
   - 'for_each_console'
   - 'for_each_cpu'
   - 'for_each_cpu_and'
@@ -133,6 +150,10 @@ ForEachMacros:
   - 'for_each_cpu_wrap'
   - 'for_each_dev_addr'
   - 'for_each_dma_cap_mask'
+  - 'for_each_dpcm_be'
+  - 'for_each_dpcm_be_rollback'
+  - 'for_each_dpcm_be_safe'
+  - 'for_each_dpcm_fe'
   - 'for_each_drhd_unit'
   - 'for_each_dss_dev'
   - 'for_each_efi_memory_desc'
@@ -149,6 +170,7 @@ ForEachMacros:
   - 'for_each_iommu'
   - 'for_each_ip_tunnel_rcu'
   - 'for_each_irq_nr'
+  - 'for_each_link_codecs'
   - 'for_each_lru'
   - 'for_each_matching_node'
   - 'for_each_matching_node_and_match'
@@ -160,6 +182,7 @@ ForEachMacros:
   - 'for_each_mem_range_rev'
   - 'for_each_migratetype_order'
   - 'for_each_msi_entry'
+  - 'for_each_msi_entry_safe'
   - 'for_each_net'
   - 'for_each_netdev'
   - 'for_each_netdev_continue'
@@ -183,12 +206,14 @@ ForEachMacros:
   - 'for_each_node_with_property'
   - 'for_each_of_allnodes'
   - 'for_each_of_allnodes_from'
+  - 'for_each_of_cpu_node'
   - 'for_each_of_pci_range'
   - 'for_each_old_connector_in_state'
   - 'for_each_old_crtc_in_state'
   - 'for_each_oldnew_connector_in_state'
   - 'for_each_oldnew_crtc_in_state'
   - 'for_each_oldnew_plane_in_state'
+  - 'for_each_oldnew_plane_in_state_reverse'
   - 'for_each_oldnew_private_obj_in_state'
   - 'for_each_old_plane_in_state'
   - 'for_each_old_private_obj_in_state'
@@ -206,14 +231,17 @@ ForEachMacros:
   - 'for_each_process'
   - 'for_each_process_thread'
   - 'for_each_property_of_node'
+  - 'for_each_registered_fb'
   - 'for_each_reserved_mem_region'
-  - 'for_each_resv_unavail_range'
+  - 'for_each_rtd_codec_dai'
+  - 'for_each_rtd_codec_dai_rollback'
   - 'for_each_rtdcom'
   - 'for_each_rtdcom_safe'
   - 'for_each_set_bit'
   - 'for_each_set_bit_from'
   - 'for_each_sg'
   - 'for_each_sg_page'
+  - 'for_each_sibling_event'
   - '__for_each_thread'
   - 'for_each_thread'
   - 'for_each_zone'
@@ -251,6 +279,8 @@ ForEachMacros:
   - 'hlist_nulls_for_each_entry_from'
   - 'hlist_nulls_for_each_entry_rcu'
   - 'hlist_nulls_for_each_entry_safe'
+  - 'i3c_bus_for_each_i2cdev'
+  - 'i3c_bus_for_each_i3cdev'
   - 'ide_host_for_each_port'
   - 'ide_port_for_each_dev'
   - 'ide_port_for_each_present_dev'
@@ -267,11 +297,14 @@ ForEachMacros:
   - 'kvm_for_each_memslot'
   - 'kvm_for_each_vcpu'
   - 'list_for_each'
+  - 'list_for_each_codec'
+  - 'list_for_each_codec_safe'
   - 'list_for_each_entry'
   - 'list_for_each_entry_continue'
   - 'list_for_each_entry_continue_rcu'
   - 'list_for_each_entry_continue_reverse'
   - 'list_for_each_entry_from'
+  - 'list_for_each_entry_from_rcu'
   - 'list_for_each_entry_from_reverse'
   - 'list_for_each_entry_lockless'
   - 'list_for_each_entry_rcu'
@@ -291,6 +324,7 @@ ForEachMacros:
   - 'media_device_for_each_intf'
   - 'media_device_for_each_link'
   - 'media_device_for_each_pad'
+  - 'nanddev_io_for_each_page'
   - 'netdev_for_each_lower_dev'
   - 'netdev_for_each_lower_private'
   - 'netdev_for_each_lower_private_rcu'
@@ -357,12 +391,14 @@ ForEachMacros:
   - 'sk_nulls_for_each'
   - 'sk_nulls_for_each_from'
   - 'sk_nulls_for_each_rcu'
+  - 'snd_array_for_each'
   - 'snd_pcm_group_for_each_entry'
   - 'snd_soc_dapm_widget_for_each_path'
   - 'snd_soc_dapm_widget_for_each_path_safe'
   - 'snd_soc_dapm_widget_for_each_sink_path'
   - 'snd_soc_dapm_widget_for_each_source_path'
   - 'tb_property_for_each'
+  - 'tcf_exts_for_each_action'
   - 'udp_portaddr_for_each_entry'
   - 'udp_portaddr_for_each_entry_rcu'
   - 'usb_hub_for_each_child'
@@ -371,6 +407,11 @@ ForEachMacros:
   - 'v4l2_m2m_for_each_dst_buf_safe'
   - 'v4l2_m2m_for_each_src_buf'
   - 'v4l2_m2m_for_each_src_buf_safe'
+  - 'virtio_device_for_each_vq'
+  - 'xa_for_each'
+  - 'xas_for_each'
+  - 'xas_for_each_conflict'
+  - 'xas_for_each_marked'
   - 'zorro_for_each_dev'
=20
 #IncludeBlocks: Preserve # Unknown to clang-format-5.0
--=20
2.20.1

