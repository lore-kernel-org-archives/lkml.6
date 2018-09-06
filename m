Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09B0C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C7F020844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="G7ny2IfO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C7F020844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbeIFRkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:40:15 -0400
Received: from mail-bn3nam01on0125.outbound.protection.outlook.com ([104.47.33.125]:19773
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727126AbeIFRkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:40:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qjg9YVaDXTrfvoKr4QYeQY2i0Y0eU2eHFP3SgN3aGqM=;
 b=G7ny2IfOSpy7ZFCDcTfB++6jiMdGCiAAbCUEp6T/dtt3vn6JuZktPHCRdWLj/1YBwPSbIONiQT4sn4Owl4HDvqw66gGtuEHkgUeuZ8p0maGquaZP14pryW9B3WqtsWCE2E5jmjFBZuJdso7fW+IBA/ZJ8Sr0NG4dkOLhCF21r/8=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0172.namprd21.prod.outlook.com (10.173.173.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Thu, 6 Sep 2018 13:04:47 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5%4]) with mapi id 15.20.1143.000; Thu, 6 Sep 2018
 13:04:47 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 00/29] mm: remove bootmem allocator
Thread-Topic: [RFC PATCH 00/29] mm: remove bootmem allocator
Thread-Index: AQHUReIw2MoI2x7MUU6paseDjWKrjA==
Date:   Thu, 6 Sep 2018 13:04:47 +0000
Message-ID: <46ae5e64-7b1a-afab-bfef-d00183a7ef76@microsoft.com>
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180906091538.GN14951@dhcp22.suse.cz>
In-Reply-To: <20180906091538.GN14951@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0172;6:E1FpjgZWiR0oPfR751YtxitlLSdjHCtgCFR2ZOZUNW85zJnTxAAK5KzULlBdO3jzjquROFgma0HieDf+CGdrBKu0e/qMlgZLVY4RRopLU5gUk19RCNtPL6TUnQKDdcpTsuQOnx7kVQBObj6cQ8SosKMx8/24QqvAzGjRrXZ0jwC9Qq6c5uhAwRBRdgvmKwukL+xsUyBUPCyE0UsJY11+An+g17CA4W3x0bPA/J2hjsTQUBtVRhUeEpS+X9xTqPH4tFiElZIHU2kdotWkCXGWYarTRU02xyYOFvBfr+XnfVr/fL6nOYOhho64hH6OikhirfhnTcOSLoOOIj+0Ijb1zMGmUC0X2SKqXQGBAEeOnGLE3xXGzI9n/beO2td6gMLYX+wfZnZeVqF3DPXlcldpHxaNZ/6XT6O/iKIzVRufNGRDmztOX4GzEo95i4UDjwBxsZb83Sw9ZjLOhmZHo0qapw==;5:cVW28S4KMl02v3I3m4nKPZQ14D7yi0945cVHPcba5CVJXCVrYTPyfaewr/G+4sTJtHyeSoAVL0hTy/3JKPN98HcnIPCMsQCHAkL/xkeqAzl+MgyGH1phLVfOCcE9LXfXztrJwKwrEvyvngs70NDSQatHhpeBixeKAM8KrXqfl7Q=;7:0JuuvHa2QIdPw6Ur5Ps96fArrS/0IEYrKhyxEpKl//U2ADyx8t2pHUHXXdMOUfZ6BmlALzpJ2rq91/jQtav32tbonCLSeZE3eWNIYl8269QtHMPrUKPUXhzoT76aMibZGeiiWdHJUZS3Ze7i+PRoF4G9Dj96xfI4LeIKrdILhO0jcGkWHpdOVZiwV0QDOD8UgWPleNuhVww41chLTbtMrhbsxZhPolEJjBTkJfYxza9sscg191FM1Q99EZQCnlzn
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 55cc0b2e-abf5-4d29-023b-08d613f952f0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0172;
x-ms-traffictypediagnostic: DM5PR21MB0172:
x-microsoft-antispam-prvs: <DM5PR21MB0172DEE05A4AC7EA7E2A8F8A9D010@DM5PR21MB0172.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:DM5PR21MB0172;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0172;
x-forefront-prvs: 0787459938
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(376002)(396003)(39860400002)(199004)(189003)(6346003)(110136005)(10290500003)(6512007)(53936002)(53546011)(102836004)(86362001)(106356001)(186003)(3846002)(5250100002)(2906002)(26005)(105586002)(76176011)(81156014)(81166006)(97736004)(99286004)(36756003)(68736007)(6116002)(6486002)(86612001)(8936002)(25786009)(31696002)(217873002)(5660300001)(4326008)(10090500001)(14444005)(256004)(446003)(66066001)(7416002)(305945005)(6506007)(486006)(11346002)(54906003)(72206003)(6436002)(316002)(22452003)(478600001)(7736002)(229853002)(6246003)(8676002)(476003)(31686004)(2900100001)(14454004)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0172;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-message-info: wbqgnwR3/e9jOekJoZ6pypLVadoC4bzTuAaHck02GXAgbFfYwgdkIcgt+J+BF4m35VuBDwgxXeWUjdbWYJ2RciV2FwILRbbDq5b6+LQQHn/yXEtXMfRYO0T3BW/itfTBQSblVKWfs7LlE5PSGv1FMhRzsL7/0ftHBkv/d48sDrVEyAl50FbQYr10xmlShfxKaDZkscPU1LNXaSNy+0ZRTzKkwS44UVtNghZnggfs1ovdJ98RAwmQa+CnDnzaiYz4IEUDF/OWQ8lE6FT8IYT2rxTPkvG+RBOH5+eH9jt7Z2jo0y8cDDLCvja28OP80pCFJMECrpFnTL/wUo54dYAKY/yqbx+QtiVMUpbMb8br/R4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE60A3F419A86E4BAE1017317C1A50CB@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55cc0b2e-abf5-4d29-023b-08d613f952f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2018 13:04:47.7499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDkvNi8xOCA1OjE1IEFNLCBNaWNoYWwgSG9ja28gd3JvdGU6DQo+IE9uIFdlZCAwNS0w
OS0xOCAxODo1OToxNSwgTWlrZSBSYXBvcG9ydCB3cm90ZToNCj4gWy4uLl0NCj4+ICAzMjUgZmls
ZXMgY2hhbmdlZCwgODQ2IGluc2VydGlvbnMoKyksIDI0NzggZGVsZXRpb25zKC0pDQo+PiAgZGVs
ZXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvbGludXgvYm9vdG1lbS5oDQo+PiAgZGVsZXRlIG1vZGUg
MTAwNjQ0IG1tL2Jvb3RtZW0uYw0KPj4gIGRlbGV0ZSBtb2RlIDEwMDY0NCBtbS9ub2Jvb3RtZW0u
Yw0KPiANCj4gVGhpcyBpcyByZWFsbHkgaW1wcmVzc2l2ZSEgVGhhbmtzIGEgbG90IGZvciB3b3Jr
aW5nIG9uIHRoaXMuIEkgd2lzaCB3ZQ0KPiBjb3VsZCBzaW1wbGlmeSB0aGUgbWVtYmxvY2sgQVBJ
IGFzIHdlbGwuIFRoZXJlIGFyZSBqdXN0IHRvbyBtYW55IHB1YmxpYw0KPiBmdW5jdGlvbnMgd2l0
aCBzdWJ0bHkgZGlmZmVyZW50IHNlbWFudGljIGFuZCBiYXJlbHkgYW55IHVzZWZ1bA0KPiBkb2N1
bWVudGF0aW9uLg0KPiANCj4gQnV0IGV2ZW4gdGhpcyBpcyBhIGdyZWF0IHN0ZXAgZm9yd2FyZCEN
Cg0KVGhpcyBpcyBhIGdyZWF0IHNpbXBsaWZpY2F0aW9uIG9mIGJvb3QgcHJvY2Vzcy4gVGhhbmsg
eW91IE1pa2UhDQoNCkkgYWdyZWUsIHdpdGggTWljaGFsIGluIHRoZSBmdXR1cmUsIG9uY2Ugbm9i
b290bWVtIGtlcm5lbCBzdGFiYWxpemVzDQphZnRlciB0aGlzIGVmZm9ydCwgd2Ugc2hvdWxkIHN0
YXJ0IHNpbXBsaWZ5aW5nIG1lbWJsb2NrIGFsbG9jYXRvciBBUEk6DQppdCB3b24ndCBiZSBhcyBi
aWcgZWZmb3J0IGFzIHRoaXMgb25lLCBhcyBJIHRoaW5rLCB0aGF0IGNhbiBiZSBkb25lIGluDQpp
bmNyZW1lbnRhbCBwaGFzZXMsIGJ1dCBpdCB3aWxsIGhlbHAgdG8gbWFrZSBlYXJseSBib290IG11
Y2ggbW9yZSBzdGFibGUNCmFuZCB1bmlmb3JtIGFjcm9zcyBhcmNoZXMuDQoNClRoYW5rIHlvdSwN
ClBhdmVs
