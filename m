Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F116C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A033920855
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="MWIIHzue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A033920855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754887AbeFYJNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:13:35 -0400
Received: from mail-db5eur01on0058.outbound.protection.outlook.com ([104.47.2.58]:27132
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754449AbeFYJNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:13:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnhQgr5tJz8d3nto6Xdo/iTxY0gLPWqULCCiZAq6xkY=;
 b=MWIIHzue/Vshc4kMTuAA1CjbixxJ7BVlKYhqaJEPayBbc2w8x3lwEQW8TK3ksoTyDdTwniXGkZ2lH8EQ6fc1aAkEklFCOGBMOYzNs1vzaxS8moDoNmLGB/9Bi6hltZAeG0GTdgU/o2eKQh7on1CwJ++fP4IrDjkKdB97pqmE4V4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=petrm@mellanox.com; 
Received: from dev-r-vrt-156.mtr.labs.mlnx (37.142.13.130) by
 VI1PR05MB4189.eurprd05.prod.outlook.com (2603:10a6:803:4e::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.21; Mon, 25 Jun 2018 09:13:27 +0000
From:   Petr Machata <petrm@mellanox.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, jiri@mellanox.com,
        ilias.apalodimas@linaro.org, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH RFT] net: dsa: Allow configuring CPU port VLANs
References: <20180624153339.13572-1-f.fainelli@gmail.com>
Date:   Mon, 25 Jun 2018 12:13:10 +0300
In-Reply-To: <20180624153339.13572-1-f.fainelli@gmail.com> (Florian Fainelli's
        message of "Sun, 24 Jun 2018 08:33:39 -0700")
Message-ID: <wih4lhrgrfd.fsf@dev-r-vrt-156.mtr.labs.mlnx>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [37.142.13.130]
X-ClientProxiedBy: VI1P194CA0013.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:800:be::23) To VI1PR05MB4189.eurprd05.prod.outlook.com
 (2603:10a6:803:4e::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc46ba8e-8866-4bb1-9ed0-08d5da7bea60
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR05MB4189;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4189;3:EanZS0tUj/O313yWEp+jmjsxyXtxvrKvjLgSSS6wwkM8hEQz5GDdgSDtbgKaxn9SCrvPRGW23p8AGqNz2P7t2IwYyYbL09Xc4Z8PI4z0H+hEurG8KHyrx/HUKBFl8Acd8FNX4Pl/sIxaCqFxXzvVEGkKSW2EGzwOhYZcemK3+hpNvKakCpeWCYN7SDWxDkas57x4tTYZ4pBJr231MmpVYlEPCIa/jCwgup1Zhn971H40IdQy3Lby5GNofrSHRhMq;25:B13Tt5VZLm3/YqQ+eI0hpt4UlgOenEaK1FYwnF1ZXG0/RWheeP0ePJz0/HoUPJgvks5gT2yBx8WOeDL13lKOAJsSXFWAQQ69NN5/W37xRftcIMRM9H8Huf9rYX4ZZDNlx+vrOMcJFW+ITX5gZ1XWdug0RHUOohMnsuu3oxGMKmI1kdliE5WQAQNSQ/zZWGVrt/2IBdPOoyfMP4LahBpukTGJrEGWBON86QYtANVoxe68pc3r1CkMU+FP3n7jDN2KrA+DkdN9VZ3N2ql63/2m3ji4mYApB5Ses0JUpGXoi7/JONRQa2Q+fUxejQUtD/cBkHLWiKhvvd/cq2WvG1sFPQ==;31:TfcE2alM/Zm8r3PlLomev1kyV5NRf9T/ImBxUjwVmJNL6bXIREsKU9HqKMZ3gk4ib7mUaTN3tXYWull5SQ/lfELVusnN2BICRggASl4n+IeOjKgXPxdkG+3eflX3ZgTFFo78xSLs9WpHWM11Nc7rRxJ+LJrPoZ2dtpeBYnZUFJFS+oL4mYsjrOflk4/owdNh+Ofg4GzuPKNw46jopyH2dJI7rhpa+XViVkRUWkvizMg=
X-MS-TrafficTypeDiagnostic: VI1PR05MB4189:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4189;20:5nmt5AwBioSGTtwG9lub+koVwzSj1kIy/emWzBg4i5xX9GCT3Or/IzpUmdTxHeUtlrfbx22x4zEzwl8TjJeERbiyd4cQU3viFKPwW3jxpPTA0yTibkKPfoE5sLtOepQ5NLdKtI6PkfeG/5sbjKIZFqmMPGr+XFstC5Zxiqi4n8AzuwIUzkWJdlKFmVrHcAy/NqkwaeTY30yhx/hM1nw5jUXIouB3PbU35n1t5w4MdXf/fpJ8Edm03rkASPx+dgekuDkygJViLUAqAyPJbPrZjYDN4+IkerAHQkTi4bv0xDAmt+G7RnmlnVnGKv6sITg13G3tn8UayLhRA6eGft6236drOKf9t1hEnwyWvJN4Dgot7Pn0B2vN3LzzPYuwuI2K8olH91FMQT1WbCaWpewwSkRMwHugBPj+CGjcUGWRblLMaEW0QnuTdQBzd3bvepR37VZGvf5lVqKzVeE6T+/eiXm+J5YLktvM7XlvLWUrQ/nVXg1OthWLKxqVgl89ZofT;4:rmSrxQly3lfbh8puwe56BKrOUoPe/4ori26Dvn0XMNxg3agPpB2BtMaNAvNIddl+FZF6R8gPXQDUNW4jWFLkxCw0vy71bN06R6VzrIBj4z+Qe4KazGgFH9fh4Ij+NaQHK7NSGfte/SZMB6JnKE7M51WnYsK8bEi8MJAT1P5EW7vTjTnlFrPG2lAjO8YiB6DSpgf3YrLxRAQf9TmfMnizXz8m+sFUOx/ZyW2cS5+PtE79xHKxL0iHtoze1DXSJg1MclVC0jmUiFzDy9PpG1UrJEWFKKuyROfGWiwVCPA2UpdVJFTvnm9+6ddj10kX7ooc
X-Microsoft-Antispam-PRVS: <VI1PR05MB41895221186279F9FEDF8BFCDB4A0@VI1PR05MB4189.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:VI1PR05MB4189;BCL:0;PCL:0;RULEID:;SRVR:VI1PR05MB4189;
X-Forefront-PRVS: 0714841678
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(366004)(346002)(396003)(39860400002)(199004)(189003)(53936002)(58126008)(51416003)(54906003)(7696005)(52116002)(39060400002)(9686003)(5660300001)(6246003)(305945005)(55016002)(3846002)(76176011)(86362001)(7736002)(6116002)(97736004)(4326008)(486006)(8676002)(186003)(229853002)(476003)(446003)(68736007)(386003)(16526019)(48376002)(478600001)(50466002)(6506007)(47776003)(956004)(316002)(16586007)(66066001)(25786009)(2906002)(26005)(81166006)(81156014)(11346002)(106356001)(105586002)(8936002)(6916009)(6666003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4189;H:dev-r-vrt-156.mtr.labs.mlnx;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR05MB4189;23:T2n4LYPsZPiYM6dr6Lz1e3pTG3EYpltwhANV5PBnG?=
 =?us-ascii?Q?GVd+lwYdIu+tkD5hVTr1Vzg0DBpa6GtmE9uW/G1+Xsi6Bn5LxA56+dgmA5E2?=
 =?us-ascii?Q?mN10D0hri8+Tqb+6xBsCpDGx6OBgQPtVJKcd4PFDYDe5qAD3Kfc95ucearhB?=
 =?us-ascii?Q?ipi3d8zPoS0JwfHFXn69/xcZdFleEi5x6l99T5aHn/JXLPCjdVs8W9uPlyAV?=
 =?us-ascii?Q?W/mPMHRHtcGnAKnTwjiSLUAdv5nWTBXpmJ16JMkzBpMKAce6daKU0kPWtTYE?=
 =?us-ascii?Q?Z0LMaHgg4XkuBlvSDx6c6DM6s91qWfjQ1cR9FDZySzi9WF2T4fKps1RSzY9C?=
 =?us-ascii?Q?rBBVv90xi/JiQytsByWO/L/URenEfwfCTeZtijDm0HL7Mr423kixdb5M21uE?=
 =?us-ascii?Q?9F3r95sqCPeyl/r4768ZXVSRM5J8xMoqc8mzukRSoltU3lLtwMvBHSJdhATF?=
 =?us-ascii?Q?rvIhjQ6mB88HfU2I/PhSd0Rr8LhkRgGz9cCzfYZycRM8cHYGhrQwhJyffIzf?=
 =?us-ascii?Q?/8GteW7KwgQy9Qo06MnGZE2h/R5Jp0vvdyprPtfrMaYyYI43G82/iKI9gkCd?=
 =?us-ascii?Q?ETas8VGj7JwFb5UtRpmDTMrkHXErQa9jCJ6HdtnGNvgcPUEIqfV9UO1zngTl?=
 =?us-ascii?Q?KjNvb26MCNksXkRlg/xGCNJuSCgTGwwVIlqagD4uczgRqik9ehHD8fzPifZG?=
 =?us-ascii?Q?mSgEUBTiWQjzTne/tTXQhh3cg1OR7KZarTQ+3zsRFGVwcwRNcNFtgwH8/5Bq?=
 =?us-ascii?Q?BTrKSzQLoUzS90yd+TxlaCpKCc7GD0DcEFuJxCAEkShl4VdAphCmtdpU2ARc?=
 =?us-ascii?Q?it8iwojGO8nSn/q5AGXRyqoHytczZZ9hDpG/1VUbnTJ4h5Z1iOy5NWHYCCO8?=
 =?us-ascii?Q?Vdthfr0IS/D/AMBlbBwUvb5mytNVj+zqJx/551MmrBG093A3bxahCWZU97bH?=
 =?us-ascii?Q?4jUe5kUQXQ5hgRBMF+atyFZwBFNwxpKEoGbk5grE3IV9Yr73LHdNe8NKemwU?=
 =?us-ascii?Q?bzCbTAhdKc6ObLyVtaf6GwqhXO194Qd06PgiNTaDc4gK6PGAuW76C8UbWpxL?=
 =?us-ascii?Q?UbTBvSqszgE9viGJ95cRJkE485E5PDyz3a/GnZbVlqm3xaCJO+9HZ/OdGQW9?=
 =?us-ascii?Q?iNakpkFk21CUZONiDRxgJcecuGqCBmzWnJk/6sCnCp+YlUAHAfDYNnJH9rxG?=
 =?us-ascii?Q?pNv8ttlWZYksMA+9HsptQsTVjtYz5nlLnwx2peVU69bwjoxl3rPsp0vgnCl7?=
 =?us-ascii?Q?pHcMtsrz707/q8r8nw=3D?=
X-Microsoft-Antispam-Message-Info: uAs+jkkHzn+ZYbbqIIDvFmCtcb0Gc/VmJ9ec0gp1jPXl90aQF53G/yksqYKxLx6+SUyLcfrD4LD7idbaLXMuZ5FIfTPZlW+MyqVHc3eHFkg2CRrDlLGjvmvjGNFobnWYJDMDEw5pbKaz5kxdzZZ71RRQ5ouKBpkZjEDIEvscbCTWqVipEzBaS2GUWTh+qh/9k/Ij6MSH/HBQkV25hpI0i6AMKvT/Nysok8dktoc8s/d6xfhP71FHQaXDaPMesKv99x8PQbTWaF8yHauaXnzfC4PJHgsocfKMb68YMgAd4pwtVsIoRX79mtpPv3W8WWHeanpLYCiPfUZkUpyfpKC2RUJTCuX53PnFViAE0Fs9Yoc=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4189;6:HSIbqJNpsJsaX1tvEJbHgH66wZbQQYHmkJ8qtuFWPx/J8P80iHjHiIKreNzds2X/qakpmjJaeiTIoz0lxLtwWzvqoiIXA0pRcCnDLdoOv36JNEZwQxfBrLEDk+2Y/D2kF4eHUkmFr0ADmT6GWRR5KdgJkqg+VdWyeBc/fWXFNC5tNa0wuydJBXZW9qzGaeYh4bifu99rUwI+oMDJipr5/jftj13HkVgozDLhSPKtOynYHRmd7ynLagQAqysbm+Zm7SognhSXjuhqsGI3iNtiinSgRinQ2CPHDDhgfLypInoVPuCjsNhUTJFQHutbEgu7FhgAyUbaWMJLq38baeEMIjGUdmwz/vOkqsVGzT/AQR/AsXrF+F0L5uocMjOZ4ayZJgrSctwv1SX6na7KMgVn95il2M3pUVGJdGzn3KO0XNsKpJr4knh8ATZ71tbWQsol7B48NEHcUNuflpkgiPGIUw==;5:oC2V4zMaT49/TTfeudBAE7nvOVEkFI9jMyqUHNPRK3NmKM2Sx47nbm6Eju8hmATwGOo54DkSnPHoLAUAGey5M7GLRIf4U0iHwf02Fym6BNefgvJcGcNeoNdPgakq7r22wIBj1+n75/UgVOf7R72Gec1BuFrB/HRox/cUFzldHPw=;24:Dy6a2jBlZytVA1s4zrEZwscait2CwUiJHV+KsMewbny1/zHYyh/jBVOGSAOAYyKPjrdQ/Re7GWQrlk4FWmwZ+0zAuUoacs3ipe7FIwbHRNU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4189;7:Phfvyx+Lr4Hscr6FUKn9+a0cQaqyVm1vNUByVqg+jaC6DaqFKTcRGbJ6T5l005e2TjQTrNOq5OJjuZ4eJckCmeOpLxE+M5hgCZuRV2Ky25q5Gcac/1fcQ28wnxv+bJodVc1oShq/TNXvH5A8lbI/RCE1eRLf83ad9qEZ0UaNuu1U+BrpdN9pMx/mGv0Mu3Dqg0AwScHpcXBk938hM4+npkkpy9BXtByGMLI3BY1wMN83UlUd8n/nUMQzT3y1b0Y9
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2018 09:13:27.8326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc46ba8e-8866-4bb1-9ed0-08d5da7bea60
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4189
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Fainelli <f.fainelli@gmail.com> writes:

>  	if (netif_is_bridge_master(vlan->obj.orig_dev))
> -		return -EOPNOTSUPP;
> +		info.port = dp->cpu_dp->index;

The condition above will trigger also when a VLAN is added on a member
port, and there's no other port with that VLAN. In that case the VLAN
comes without the BRIDGE_VLAN_INFO_BRENTRY flag. In mlxsw we have this
to get the bridge VLANs:

	if (netif_is_bridge_master(orig_dev)) {
		[...]
		if ((vlan->flags & BRIDGE_VLAN_INFO_BRENTRY) &&
		[...]

This doesn't appear to be done in DSA unless I'm missing something.

Thanks,
Petr
