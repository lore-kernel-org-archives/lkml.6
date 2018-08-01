Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C30FC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61CF20862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="RJD1NJsu";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="EXmNMVJU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C61CF20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388642AbeHBA2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 20:28:30 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58164 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732372AbeHBA0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 20:26:51 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w71MbYRm009539;
        Wed, 1 Aug 2018 15:38:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=CEOKcUFZGpGhEHi3JMHvbEOG9CE3U4TfGlKXBGbmyJI=;
 b=RJD1NJsuJs/cYxxpj3E6lkrMDC1wkiVIXGmG4fAIxSnoJSx9XtC53CyujiX4fj7DFkxD
 Gg3MsXl21pQuU5kfg98sl8gioRq5mKQZIhQN0lQemxsW1ZsdX3l4eLvEpDXo5qqDfS/e
 vr/1Fk51HSRjlF7F1rxjPpS5HrCeAkEz+7M= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2kkfcvh9pr-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 01 Aug 2018 15:38:27 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.33) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 1 Aug 2018 18:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEOKcUFZGpGhEHi3JMHvbEOG9CE3U4TfGlKXBGbmyJI=;
 b=EXmNMVJU3BXFPcMAn8uH65Ydc7+iTqQzRYhpw2MweCKkkx6EM4swdsw/MuTVUp2KefYUo03ElB1HVwW80oVqJPVbva02iotiZMO+0QkkQ12L78yq+/3BApWzt3i7xISK6m/wCUxGtYYs46jjotCW5n6v1aVEgt/zCJKC/AncKBc=
Received: from castle.thefacebook.com (2620:10d:c090:200::5:7cca) by
 SN1PR15MB0176.namprd15.prod.outlook.com (2a01:111:e400:58cf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Wed, 1 Aug
 2018 22:38:23 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v6 bpf-next 09/14] bpf: sync bpf.h to tools/
Date:   Wed, 1 Aug 2018 15:37:35 -0700
Message-ID: <20180801223740.11252-10-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180801223740.11252-1-guro@fb.com>
References: <20180801223740.11252-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::5:7cca]
X-ClientProxiedBy: MWHPR1601CA0016.namprd16.prod.outlook.com
 (2603:10b6:300:da::26) To SN1PR15MB0176.namprd15.prod.outlook.com
 (2a01:111:e400:58cf::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c697d25b-dd59-4f47-d7ed-08d5f7ff7d84
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0176;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;3:TFcIAv+nOOt+9h46qrrn8rqeS9/e9c5S1GW/u5LpoFlNqfnH/sAMmk0+3KR/4DG8gt2Jy1lMoKz1zIkl2H6xY+x5To4RjrKwo7keeotSkv1RrpWiGUbDsc0aeV8QPY6nOIq9d/DTuvVtA3vDlvSJMuiNw7WGqoce7XeqxkBOFR3dxHd6DrXpJiQ2PVykNqxjlZBInDKx40BxUl7gtl8lLHFeS8bS90K5Wjs0zP6ZMpbsjbI4Ecuotv0Hs44B/ycV;25:CfX5b1LMUGU3jcxzIwsDm9ewotjEgEpdrpHXbqavTE9zd8SuAyIx/aDFLjiqqV3YZcyYWlyntTRtyd88lDGKFkM8dA8S8iXvALDAij81rRYow/a5Wt0rd2rU8JlQnr/TynOTtfyqiUcmEEZBXS5OVSijUt4J3vy+9/1wXrvtbCcE49DU/GRxM5FHAb3N3Dt3hqCvgJKvHW0kyxVfkb61YyX0nOTwQQfms/MBy2RyL6f0PNcT33Jc+BY2h9i/M0eFKFs20yel9NMbwtTOm6IUa3okXJyDPvN8rFiqWGxmbmnFSfj8NBZ22ZOoxLpmx+kCTJXWY+N2VGcA/P2E3j3KAA==;31:ItkhZyHFvcSi6gQu94CTn44Xv1MOM2pDFvKnrTvOY6PJZmmWdaU1P+eEjNmKlqf/6jg2hYGCO+C55kUXehAJL7PuSUv3Jwg8zmmhutpcd3gqR6zeTixAeVZcUMb4Jci8xj2UEZwnIhxkOJUUxEaa+9CMPIEAzjedaLB4ggGyKw1AIUZBDarysVCE/kHt4HcaCBOBJOLJB7/A2LisHhlaErPhkGiCOS3ga7YbcUDeOPE=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0176:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;20:ImojBh00J9dXYSN8MxStd/KSaQ6hN6kX+2P0UW6SFbEGuFIop8DGi9n7ZKIIbosy9zeeBMDl4crQLEEoMURNv0no0LW3VDM7d28Wr0JqG4x7uViYHvsqdGTLhF/36mAhTn7Zb8ElYD7gvRz2shjP32/iKk7DRtVz/5sQf4Qp91w/dPdQNonn1WUoaoAig47wVrta0u/gWc4prmh5dQGlJD6wX6zLnoqcXadgCXymxUCwD6bd1G1FYx+l44kFg0YcnriYXNKpg35IDQnjQfSWQnA6iFEnZNqZPX39f5rggCkFasy8MOResIR4P3p1S6X2DFQXtUaoHDGeQlEVzAb7GzuxR6YxmZ7NR0dhQga/qnyOJMsGoJUdCLBAT2PPjMg+071P5PE0CLTaA235hDK/elnEoJZvmnH+loI/ykqlDwxjSvs1SbtpvWBj+PhQTfHs1NoG5PdnHxBSXuQAgkhJ8TNiPXreSQY+ZXUkNnZ+iE3JODAYMbOqEAq4ipMZLfMn;4:ulmBs+yIu+A1fNWXMJk8hjGCA60fFgplffPjCysLko6zEaROHWJuS1A3jEuoHW0BAsB9Iw9qannU98cRobuqa7U8QgtYN26d2+mviuurWpNOHme8l9kStZBNYHRGMGSoTgaVMTRnSj/Cn0AOlc5phQLMUTFuLC6FyQGzoMtXrrS0F5WIerMRIi1woeD3utg56bYYHejmg3RFqnjHUnVHuzFpkI9C1dLzzRqeeLDbftSjtpWGSQlJvXDDURUBD2pZxN26OwCaUS/ku6LYt48hEdZ0oiuZqy4eu4zCFxtRviJiM2DmVWkp66655N3pEhVu
X-Microsoft-Antispam-PRVS: <SN1PR15MB017603DF62FC84185FD20F79BE2D0@SN1PR15MB0176.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(11241501184)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR15MB0176;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0176;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(346002)(396003)(136003)(199004)(189003)(11346002)(6486002)(6512007)(50226002)(6916009)(2361001)(5660300001)(53416004)(68736007)(6666003)(386003)(106356001)(6506007)(76176011)(105586002)(52116002)(51416003)(86362001)(36756003)(486006)(2616005)(8936002)(81166006)(16586007)(54906003)(478600001)(50466002)(316002)(81156014)(6116002)(2351001)(69596002)(7736002)(1076002)(52396003)(14444005)(5024004)(16526019)(46003)(8676002)(4326008)(476003)(97736004)(47776003)(305945005)(446003)(186003)(2906002)(48376002)(25786009)(53936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0176;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0176;23:1wRvkboxaw1Qxs4kS7z6qqaz7HpMep4lIG/6L1yG8?=
 =?us-ascii?Q?rgbQ/O8aiqMtrklTFdKIpRkwKzd3dsqmbFCDhKpl2eSEkVEzTPfxVJHxBYp4?=
 =?us-ascii?Q?6XTX6kuMM25YkpLThSmH9l1kllEqAuLkJHk5IsiQit5USG69Z3SZTF4GpQKC?=
 =?us-ascii?Q?HdYQnRDP8pdcPNoK8W3Ap/X1OyIVE17fpkyUSJkou3FgC2cEX++Qm0slakLD?=
 =?us-ascii?Q?aWHsrEFDj6U2WGvqocmE/RPBD1OA9wVcoeLpxNmRrEfaz7qmR+WEBqpAK6lI?=
 =?us-ascii?Q?jvvVoCts0MiTgwuA9uOAYLpU9W06lwpK/LpgEQuQhyCL4LQX+oE2Cq6Rqgcq?=
 =?us-ascii?Q?P1oOQzMVEq5YZ50w4lQ97Ax2zSGahRQJN3463l/S6HrdwD9RR/j/68GJgP6U?=
 =?us-ascii?Q?QDSM3Bm+eu1KGa/svUgCVhJV16XDO0twolmXNBSy8hBqHq10Czq6QFXJWuSl?=
 =?us-ascii?Q?gp3SkzmELN6wuIRvZQFci04eqJQBMDqLRHioI8Bp8blfyDVRGQ/ZeO1UulLk?=
 =?us-ascii?Q?G/VgDdZ0/Z0sEC3ub0mKASSha29H7vy0dbW20jKArBAtA4e4eh2HWKDdeOX1?=
 =?us-ascii?Q?087JF2poAKLJUB6OAe5RpveKvcUod9b5SlF3JqeMDcrNWPEmLqDqIzTNYbX0?=
 =?us-ascii?Q?4jcY+69M5lBKiSzBlg7HdNpV70KOO6l6XeC5rnxVEMGHPBzm/u149KSBf6+K?=
 =?us-ascii?Q?oRiLzah8wxgyFJREASDBjo0cPB77M4rSWM0s+0V9ZzbfcXepHCnZ0vFAslKz?=
 =?us-ascii?Q?joTdYsTEQwxOgWa5NYKk7UGGji4USPkNn+aK2AMby+7K4jdlbkIjkwceXDlt?=
 =?us-ascii?Q?eDP32l3QK3JQ+PZ95JJIeXEUSRyxf0AT++96V0X9tD860+TYdlZEq2BqRNUo?=
 =?us-ascii?Q?vN3ppwBXa8fO5yPG7AJKG9zL9cg+sodRsCHhfzAuf/i/HkSttUc3GivThHeR?=
 =?us-ascii?Q?D7vjs78tH/uh8gRPfOr6axoYELNQo5e6lCSYys9dqTDJHglP3K1MoBJzu4H2?=
 =?us-ascii?Q?MPWh7NwkY0GXHSbnVXM8zuDfY1OSsNUKtj0O6EAlu/lP1Da8NADLTKzEYqsl?=
 =?us-ascii?Q?KmNUc4qZa9/Tg8Sd9XMDzz1QMgVVjqrPPswFp6nG7YZy7jLCIdzbzvuNSlzq?=
 =?us-ascii?Q?G/IG25biP101rHIqQbuoCaSEWZ4OlFdm34MYPKx1HYikbNikguaL+ZOnz8NK?=
 =?us-ascii?Q?AKlp20Qwfh9ha6lEwsLza7OD5Q6Yc5amsxS41MR2b14MCqs2SMyiqnAD2MY+?=
 =?us-ascii?Q?cKO534ehtnSshLAF8ejmX9barOB5bRqLLxIgJ9Drd6Tp1KSV8cgyA40yhdes?=
 =?us-ascii?Q?AfGNEY1yao3K/AFzfI2qy8=3D?=
X-Microsoft-Antispam-Message-Info: xNBRPjlrGSJgXRluau7L7FBU4RuOCaAlWpV+3MbX4a9CtRIpXuMC5FxuACvH/TWgVci4PqsteYiy35glfI2Pls2aRHd6RDpW7QZeaHRLdL7FNzh6t5oJqV8DLVQRV2Rl7587BCpb4DFjVCBT1SaCUj5SWwywVAgcQaTALc9mwlbfK1wsqQFjgE815s46+H1G3qu5s9NtmoZzhaWWjbjHqHK31lw8Tbp6i5vPQqevsj1C+cmF5YLyaEyR7aQlfZVjhhuqwnX6Achq9NAyM5z0nw0ZQFqOekskFMUmVvQyBodq8t01YOaTho5xfDfG1NpPPaaKaENsSdvVcPr8SeS087ZPHEIxx7KI1TW75lCY//8=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;6:/GDBKVVX/09bFKWeCfHtW89pysvJkdhN2XUWOcDwcpUjPVlBsaVmxg7m2HO6vgjvV5pdnkZIoYm6BbeAdUPQykek1MERxdIFdN66yoIH4uCJPAHyQb7zLzT8K1Q+9bLhFRNx8wDWmSLF2mU9L8elSuSI+mpIdXZWhGrTkgPFtyp9h4QRi2iJFb0YyinUoNVx+qy5ngzRTIOAyOkAwIFcYqyUrRA9bwgUl7Ahf/Kknqf657kkZiPqby3elX32ApkwEkqSz/0Ei2vYDYkBrlrF/0i85YtjExUMyYitSghqnszosnE/EEijnP1548J9O0XoXIkJZ7J0yIbaNGcvZR/cVvi+ozIg/rFOebbX0wf2v1BSsZ9yGDDKerNhDoALZx6CaXqk7HilkW0kyI8jv5hCryepWgYJGs3WTONvGFeAniJpr4gJLYIguOEkqa0x9WC1BR6beVF81q18ky04zgX8cA==;5:M8Qu9vrbRHmxk7fRx+gKyeByiEhjSQMg8LDU/OeWml460DeCqqLDAAJz8W1Tn55EssGJRiIKb4O6rrDT9xoYoUltPCh+F1b0idRRxEdFOEL7zjJXzvM/4fiQK8e13Qtb4JrXHYRnTJVB7B3cmMFij5NRFSRt0M1Nx5GlcuNsaX4=;7:cYdCV81DAA/pe+psZHA4HbDSjj903bTr5xNkZB9p5U0c8oMMxZ4O4SNDUQA0N3P3XejvAUiWfLzo/QZq0Z/w+2NWs47ovdeqz10YARtPKx5X3J9OLxfRR4HE6GsnYIz4qzezwsLXFhKdA0uR0uBzRt424JRULE+gwllp6tHLSoQIKiRaEMDShDpIeTskxHLhOAecy0YEP61+vUxYJm6qsZRPb/7qqP8KzJbZQfa7t4+EY9CEVN8lK3z8LJrK3M74
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;20:vPLnJUobvLfVjyrXysQ4K1LV7KGOIF6Ht/V6sX1Fr/g3/95F0zV/wtXzG3QSfVCIxL9OTplvDJ1Zm9uUNpn2M667dkjjIOtXx7q/xDpnwSnTaHIdf6bGyVNJW0Mr1Fsi9BQV0dDk0N4WzTTOZqzSgmDTGFTLNEb5KdsPtgXJ38g=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 22:38:23.0465 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c697d25b-dd59-4f47-d7ed-08d5f7ff7d84
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR15MB0176
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-01_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sync cgroup storage related changes:
1) new BPF_MAP_TYPE_CGROUP_STORAGE map type
2) struct bpf_cgroup_sotrage_key definition
3) get_local_storage() helper

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 tools/include/uapi/linux/bpf.h | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 0ebaaf7f3568..dd5758dc35d3 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -75,6 +75,11 @@ struct bpf_lpm_trie_key {
 	__u8	data[0];	/* Arbitrary size */
 };
 
+struct bpf_cgroup_storage_key {
+	__u64	cgroup_inode_id;	/* cgroup inode id */
+	__u32	attach_type;		/* program attach type */
+};
+
 /* BPF syscall commands, see bpf(2) man-page for details. */
 enum bpf_cmd {
 	BPF_MAP_CREATE,
@@ -120,6 +125,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_CPUMAP,
 	BPF_MAP_TYPE_XSKMAP,
 	BPF_MAP_TYPE_SOCKHASH,
+	BPF_MAP_TYPE_CGROUP_STORAGE,
 };
 
 enum bpf_prog_type {
@@ -2089,6 +2095,24 @@ union bpf_attr {
  * 	Return
  * 		A 64-bit integer containing the current cgroup id based
  * 		on the cgroup within which the current task is running.
+ *
+ * void* get_local_storage(void *map, u64 flags)
+ *	Description
+ *		Get the pointer to the local storage area.
+ *		The type and the size of the local storage is defined
+ *		by the *map* argument.
+ *		The *flags* meaning is specific for each map type,
+ *		and has to be 0 for cgroup local storage.
+ *
+ *		Depending on the bpf program type, a local storage area
+ *		can be shared between multiple instances of the bpf program,
+ *		running simultaneously.
+ *
+ *		A user should care about the synchronization by himself.
+ *		For example, by using the BPF_STX_XADD instruction to alter
+ *		the shared data.
+ *	Return
+ *		Pointer to the local storage area.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -2171,7 +2195,8 @@ union bpf_attr {
 	FN(rc_repeat),			\
 	FN(rc_keydown),			\
 	FN(skb_cgroup_id),		\
-	FN(get_current_cgroup_id),
+	FN(get_current_cgroup_id),	\
+	FN(get_local_storage),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
-- 
2.14.4

