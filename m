Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D38C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83143208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="Rh/EJNp7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83143208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389089AbeHALuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 07:50:21 -0400
Received: from mail-eopbgr710080.outbound.protection.outlook.com ([40.107.71.80]:38048
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388818AbeHALuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 07:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VleLQuSC9BgsABPtvTwxhloHeMNwZHX3BvC7hNOKQjg=;
 b=Rh/EJNp7Bf3dh2i15K9FuIUaL9KKZJkMfMcuSzJUMTRyhFD8B+Vqa6axDbJgtaX8quO+oyTcLuAgSs73E/jUUd9StopP4rptDVxnJCgCImkYjcoXks9Hf6R9SjLMFmjBstVFg8Fr77iZNOgsECFuIZdjV7EsNC6m+LNTDiKmbaA=
Received: from MWHPR07MB3471.namprd07.prod.outlook.com (10.164.192.22) by
 MWHPR07MB3085.namprd07.prod.outlook.com (10.172.97.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.19; Wed, 1 Aug 2018 10:05:18 +0000
Received: from MWHPR07MB3471.namprd07.prod.outlook.com
 ([fe80::b53d:b12a:ba7c:7893]) by MWHPR07MB3471.namprd07.prod.outlook.com
 ([fe80::b53d:b12a:ba7c:7893%4]) with mapi id 15.20.1017.010; Wed, 1 Aug 2018
 10:05:18 +0000
From:   "Bolotin, Denis" <Denis.Bolotin@cavium.com>
To:     YueHaibing <yuehaibing@huawei.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "Elior, Ariel" <Ariel.Elior@cavium.com>,
        Dept-Eng Everest Linux L2 <Dept-EngEverestLinuxL2@cavium.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net-next] qed: Make some functions static
Thread-Topic: [PATCH net-next] qed: Make some functions static
Thread-Index: AQHUKNiTBdPDE+J77UiysFS/Lr7nxKSqq9gA
Date:   Wed, 1 Aug 2018 10:05:18 +0000
Message-ID: <MWHPR07MB34711F11A6E418F24A30B27B962D0@MWHPR07MB3471.namprd07.prod.outlook.com>
References: <20180731141230.10780-1-yuehaibing@huawei.com>
In-Reply-To: <20180731141230.10780-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Denis.Bolotin@cavium.com; 
x-originating-ip: [31.168.140.228]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR07MB3085;6:/bJ4JuC/zkUgqytAsGiPYZ7IVfVpzMMp4dHdNa3Vr7qIfqDV5Y2SLkM2pf2DuzSWmtHbATDlQt8XtIZ8bSWuzVLg1WtkLiJponTZN5yiyIb0wAw/yQIlaHW5y63gmI4f5atDKVZxiCvi3sNpt5TjPOFbARkiigu6lWcmzYiYg++Ixzmek2xkVph8BBslQs3rUO+7ohRq7UvndKFMy9CGa4Hws00RrO1zy47qEEM44SiemZ/rdB5jF015jmfBIhYl9YEMB02jQYUvgkojuaVrl9jwal6I/iqbcfruot8vAByvYzg5iN4c+962xZMf4WlgV+Gx1itQq9VhlYo3MCC7UPGP+IRbmej7ML6gcUbD3LUbp+Sya1QN1La/0XzA1si5NvnDL3fR92Bcje7IdTbyg36iTO8ITeuvCN36lgI7lTv/E9JZPDk12ctLfd91gTGiVDuco7DdEDoH7Nd10lUFlQ==;5:LfQsAF+rD2NpZlhehzxjrH0xXXNYfr8hSWGveYTDsMZ9tnuZ7+HdX1tTD1DAISD1TohmJR1nmZrP5TIz5ggUAT92X2h9yWWsUVPfsjLW4LCgCG/KOhbQnwCDWiQVXjLlCFOP1/SBSotSlJuwccn4kIKKX6RsopbQdPTMsSV8pNY=;7:MalesXx6W80Xtx4syirKyks8eK33Rhraod+Ld8OljbecBjMPIec3GpjMGTJNzoFKHI5jnI0Wy+bg6wD9gHDscWliARPbWD0esOB21XnSKhoHnEJjA1Kl1V+CT0x8iC3aAmE5GeSoA7URED57Rs0AFY39ZOIqaQBoTFyrEY1GkCAVPzak7tc9BxfnGAspk8HHKxuG79LbWLjfhttYb+JzjFtGvO1f0b2biGvKD4sVOy16nzybEPUC4nUJQMKBUiFp
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 361d10fa-cb7a-4ad7-e5dd-08d5f79648e7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR07MB3085;
x-ms-traffictypediagnostic: MWHPR07MB3085:
x-microsoft-antispam-prvs: <MWHPR07MB30856A5B0E34BFB6D6823BAC962D0@MWHPR07MB3085.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MWHPR07MB3085;BCL:0;PCL:0;RULEID:;SRVR:MWHPR07MB3085;
x-forefront-prvs: 0751474A44
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(396003)(366004)(189003)(199004)(106356001)(6116002)(3846002)(6246003)(6636002)(81166006)(110136005)(316002)(8676002)(4326008)(8936002)(229853002)(33656002)(54906003)(81156014)(2900100001)(5660300001)(478600001)(5250100002)(305945005)(99286004)(68736007)(25786009)(6436002)(53936002)(74316002)(7736002)(14454004)(66066001)(7696005)(9686003)(97736004)(55016002)(53546011)(6506007)(11346002)(256004)(14444005)(476003)(105586002)(76176011)(446003)(72206003)(486006)(86362001)(26005)(102836004)(2501003)(186003)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3085;H:MWHPR07MB3471.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: njKiqNgpBSeLigPpTfGOnQF86EflSVcFutzevLE2wAO4AxyI3aOwXyOU2/XdvUcpll6t6DFmI82LiyG9u8VyMkSi75Qb3645BetlBcprbizJeCpEBLViDRAHK7vtZ0ZOeSiFW0qArpscP7RBDwOYAYoea69Ec/H+x4TC1pYozXU46G2aiBaBtoIDgG7f5Yf5QXWp4/kOzJxSl2Oef3luf5HVttXQ+UmU8M5XryS93n1DKljpxspT/xFD/xSvh3puNssHikpbxvPVh0lzDuL1Qazqcmx0rGLkBTs9qw7w78HC7rkL72h8TUDUoVsij0jFBfjzQdEGK2PtNjHkRz97Xhg2dpN0V0OgC8l4tMLhGZk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 361d10fa-cb7a-4ad7-e5dd-08d5f79648e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2018 10:05:18.0733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: YueHaibing <yuehaibing@huawei.com>
> Sent: Tuesday, July 31, 2018 5:13 PM
> To: davem@davemloft.net; Elior, Ariel <Ariel.Elior@cavium.com>; Dept-Eng
> Everest Linux L2 <Dept-EngEverestLinuxL2@cavium.com>
> Cc: linux-kernel@vger.kernel.org; netdev@vger.kernel.org; YueHaibing
> <yuehaibing@huawei.com>
> Subject: [PATCH net-next] qed: Make some functions static
>=20
> Fixes the following sparse warning:
>=20
> drivers/net/ethernet/qlogic/qed/qed_cxt.c:1534:6: warning: symbol
> 'qed_cm_init_pf' was not declared. Should it be static?
> drivers/net/ethernet/qlogic/qed/qed_dev.c:233:4: warning: symbol
> 'qed_init_qm_get_num_tcs' was not declared. Should it be static?
> drivers/net/ethernet/qlogic/qed/qed_dev.c:238:5: warning: symbol
> 'qed_init_qm_get_num_vfs' was not declared. Should it be static?
> drivers/net/ethernet/qlogic/qed/qed_dev.c:246:5: warning: symbol
> 'qed_init_qm_get_num_pf_rls' was not declared. Should it be static?
> drivers/net/ethernet/qlogic/qed/qed_dev.c:264:5: warning: symbol
> 'qed_init_qm_get_num_vports' was not declared. Should it be static?
> drivers/net/ethernet/qlogic/qed/qed_dev.c:276:5: warning: symbol
> 'qed_init_qm_get_num_pqs' was not declared. Should it be static?
> drivers/net/ethernet/qlogic/qed/qed_mcp.c:573:5: warning: symbol
> 'qed_mcp_nvm_wr_cmd' was not declared. Should it be static?
> drivers/net/ethernet/qlogic/qed/qed_mcp.c:3012:1: warning: symbol
> '__qed_mcp_resc_lock' was not declared. Should it be static?
> drivers/net/ethernet/qlogic/qed/qed_dcbx.c:870:6: warning: symbol
> 'qed_dcbx_aen' was not declared. Should it be static?
> drivers/net/ethernet/qlogic/qed/qed_debug.c:7841:5: warning: symbol
> 'qed_dbg_nvm_image_length' was not declared. Should it be static?
> drivers/net/ethernet/qlogic/qed/qed_debug.c:7857:5: warning: symbol
> 'qed_dbg_nvm_image' was not declared. Should it be static?
> drivers/net/ethernet/qlogic/qed/qed_sriov.c:675:6: warning: symbol
> '_qed_iov_pf_sanity_check' was not declared. Should it be static?
> drivers/net/ethernet/qlogic/qed/qed_sriov.c:690:6: warning: symbol
> 'qed_iov_pf_sanity_check' was not declared. Should it be static?
> drivers/net/ethernet/qlogic/qed/qed_sriov.c:3982:6: warning: symbol
> 'qed_iov_pf_get_pending_events' was not declared. Should it be static?
> drivers/net/ethernet/qlogic/qed/qed_vf.c:172:5: warning: symbol
> '_qed_vf_pf_release' was not declared. Should it be static?
> drivers/net/ethernet/qlogic/qed/qed_rdma.c:137:5: warning: symbol
> 'qed_rdma_get_sb_id' was not declared. Should it be static?
> drivers/net/ethernet/qlogic/qed/qed_rdma.c:709:5: warning: symbol
> 'qed_rdma_stop' was not declared. Should it be static?
> drivers/net/ethernet/qlogic/qed/qed_ll2.c:161:6: warning: symbol
> 'qed_ll2b_complete_rx_packet' was not declared. Should it be static?
> drivers/net/ethernet/qlogic/qed/qed_roce.c:160:6: warning: symbol
> 'qed_roce_free_cid_pair' was not declared. Should it be static?
> drivers/net/ethernet/qlogic/qed/qed_iwarp.c:380:12: warning: symbol
> 'iwarp_state_names' was not declared. Should it be static?
> drivers/net/ethernet/qlogic/qed/qed_iwarp.c:946:1: warning: symbol
> 'qed_iwarp_parse_private_data' was not declared. Should it be static?
> drivers/net/ethernet/qlogic/qed/qed_iwarp.c:971:1: warning: symbol
> 'qed_iwarp_mpa_reply_arrived' was not declared. Should it be static?
> drivers/net/ethernet/qlogic/qed/qed_iwarp.c:2504:1: warning: symbol
> 'qed_iwarp_ll2_slowpath' was not declared. Should it be static?
> drivers/net/ethernet/qlogic/qed/qed_iwarp.c:2806:6: warning: symbol
> 'qed_iwarp_qp_in_error' was not declared. Should it be static?
> drivers/net/ethernet/qlogic/qed/qed_iwarp.c:2827:6: warning: symbol
> 'qed_iwarp_exception_received' was not declared. Should it be static?
> drivers/net/ethernet/qlogic/qed/qed_iwarp.c:2958:1: warning: symbol
> 'qed_iwarp_connect_complete' was not declared. Should it be static?
> drivers/net/ethernet/qlogic/qed/qed_iscsi.c:876:6: warning: symbol
> 'qed_iscsi_free_connection' was not declared. Should it be static?
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks
Acked-by: Denis Bolotin <Denis.Bolotin@cavium.com>

